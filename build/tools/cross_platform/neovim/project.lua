local project = {}

local statusline = require('user.wrapper.statusline.statusline')
local colors = require("user.wrapper.statusline.colors").gruvbox

local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

local items
local has_error = false

local app_name = "e4"
local project_file = "build/tools/cross_platform/neovim/project.txt"

local debug="debug"
local release="release"

local arch_type_x86="x86"
local arch_type_x64="x64"

local notif_done
local notif_in_progress

function project.show_context_menu()
	local choices = { "Rename", "Extract Variable", "Extract Method" }
	require"contextmenu".open(choices, {
		callback = function(chosen)
			print("Final choice " .. choices[chosen])
		end })
end
function project.show_function_doc_cword()
  require('ui.popup').show("man " .. vim.call('expand','<cword>'))
end

local function on_menu_item_selected(item, new_title, index)
  local file = io.open(project_file, 'r')
  local content = {}
  for line in file:lines() do
      table.insert (content, line)
  end
  io.close(file)

  content[index] = item.text

  file = io.open(project_file, 'w')
  for index, value in ipairs(content) do
      file:write(value..'\n')
  end
  io.close(file)

  statusline.append_left({
    name = "ArchType",
    action = function()
      return "✅️ " .. string.format("%s selected", item.text)
    end,
    separator = " ",
    highlight = { guifg = colors.green, guibg = colors.bg }
  })

  vim.defer_fn(
    function()
      statusline.remove_section("ArchType")
    end,
    2000)
end

function project.select_type(new_title, types, index)
  local new_lines = {}
  for i, my_type in ipairs(types) do
    new_lines[i] = Menu.item(my_type)
  end

  local menu = Menu({
    position = { row = "5%", col = "50%" },
    size = { width = 40, height = 2 },
    relative = "editor",
    border = {
      highlight = "MyHighlightGroup",
      style = "single",
      text = {
        top = new_title,
        top_align = "center",
      },
    },
    win_options = { winblend = 10, winhighlight = "Normal:Normal" },
  },
  {
    lines = new_lines,
    max_width = 20,
    keymap = {
      focus_next  = { "j", "<Down>", "<Tab>" },
      focus_prev  = { "k", "<Up>", "<S-Tab>" },
      close       = { "<Esc>", "<C-c>" },
      submit      = { "<CR>", "<Space>" },
    },
    on_submit = function(item)
      on_menu_item_selected(item, new_title, index)
    end,
  })

  menu:mount()
  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

local function on_event(job_id, data, event)
  local lines = {""}
  if event == "stderr" then
    local error_lines = ""
    vim.list_extend(lines, data)

    for i=1, #lines
    do
      error_lines = error_lines .. "\n" .. lines[i]
    end

    if(lines[3] ~= nil) then
      vim.b._cexpr_lines = error_lines
      vim.cmd [[ :cexpr b:_cexpr_lines ]]
      vim.cmd [[ :copen ]]
      has_error = true

      statusline.update_section("BuildState", "✖️  " .. notif_done)
      vim.defer_fn(function()
        statusline.remove_section("BuildState")
      end, 2000)
    end
  end
  if event == "exit" then
    if data then
      if(not has_error) then
        statusline.update_section("BuildState", "✅️ " .. notif_done)
        vim.defer_fn(function()
          statusline.remove_section("BuildState")
        end, 2000)
        vim.cmd(':edit!')
        --vim.cmd(':source $MYVIMRC')
      end
    end
    has_error = false
  end
end

function project.async_task(command)
  statusline.append_left({
    name = "BuildState",
    action = function()
      return "🚧  " .. notif_in_progress
    end,
    separator = " ",
    highlight = { guifg = colors.fg, guibg = colors.bg }
  })

  vim.fn.jobstart(command,
    { on_stderr = on_event,
      on_stdout = on_event,
      on_exit = on_event,
      stdout_buffered = true,
      stderr_buffered = true,
    })
end

items = require("user.util.file").read_file_and_return_lines_as_table(project_file);
if items[2] == debug then
  vim.api.nvim_set_keymap('n', '<F5>', ':lua require\'dap\'.continue()<CR>', {noremap = true})
else
  vim.api.nvim_set_keymap('n', '<F5>', ':lua require("project").run()<CR>', {noremap = true})
end
vim.api.nvim_set_keymap('n', '<A-o>', ':ClangdSwitchSourceHeader<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-b>', ':lua require("project").build()<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<C-e>', ':lua require("project").clean()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<F13>', ':lua require("project").show_context_menu()<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('v', '<F13>', ':lua require("project").show_context_menu()<CR>', {noremap = true, silent=true})

require("user.plugins.m_dap").setup.cpp("lldb", string.format("${workspaceFolder}/output/%s/%s/%s", items[1], items[2], app_name))

table.insert(require('command_palette').CpMenu,
  {"project",
    { 'extract variable', ":lua require('project').extract_variable()" },
    { 'extract method', ":lua require('project').extract_method()" },
    { "cmake doc", ":lua require('project').show_cmake_doc()" },
    { "function doc", ":lua require('project').show_function_doc()" },
    { "function doc <cword>", ":lua require('project').show_function_doc_cword()" },
    { 'set arch type', ":lua require('project').select_type('Architecture', { 'x86', 'x64' }, 1)" },
    { 'set build type', ":lua require('project').select_type('BuildType', { 'debug', 'release' }, 2)" },
    { 'switch header/source (A-o)', ":ClangdSwitchSourceHeader" },
    { 'clean (C-e)', ":lua require('project').clean()" },
    { 'run (F5)', ":lua require('project').run()" },
    { 'build (C-b)', ":lua require('project').build()" },
  })

function project.build()
  notif_done = "Build"
  notif_in_progress = "Building..."

  items = require("user.util.file").read_file_and_return_lines_as_table(project_file);
  if items[2] == debug then
    vim.cmd(string.format(":call HTerminal(0.4, 200, \"nu build/tools/linux/nu/build.nu debug\")"))
  else
    vim.cmd(string.format(":call HTerminal(0.4, 200, \"nu build/tools/linux/nu/build.nu release\")"))
  end
end

function project.run()
  notif_done = "Run"
  notif_in_progress = "Running..."

  items = require("user.util.file").read_file_and_return_lines_as_table(project_file);
  if items[2] == debug then
    vim.cmd(string.format(":silent; lua require('project').async_task(\"%s\")", string.format("nu build/tools/linux/nu/run.nu debug")))
  else
    vim.cmd(string.format(":silent; lua require('project').async_task(\"%s\")", string.format("nu build/tools/linux/nu/run.nu release")))
  end
end

function project.clean()
  notif_done = "Clean"
  notif_in_progress = "Cleaning..."

  items = require("user.util.file").read_file_and_return_lines_as_table(project_file);
  if items[2] == debug then
    vim.cmd(string.format(":silent; lua require('project').async_task(\"%s\")", string.format("nu build/tools/linux/nu/clean.nu debug")))
  else
    vim.cmd(string.format(":silent; lua require('project').async_task(\"%s\")", string.format("nu build/tools/linux/nu/clean.nu release")))
  end
end

return project
