<h1 align="center">
	<img width="900" src="./screenshot.png" alt="kindd">
    <br/>
    <h4 align="center">Creating bootable USB with kindd</h4>
</h1>

## Purposes
1. Provide a modern/simple/safe UI for dd command.
2. Create bootable USB withouth worring!

### Arch
- git version
`trizen -S kindd-git`

- release version
`trizen -S kindd`

### Void (WIP)
https://github.com/void-linux/void-packages/pull/14780

### Build From Source
2. Install these dependencies first:

|Dependencies||
|-----|:-----:|
|[git](https://www.archlinux.org/packages/extra/x86_64/git/)|
|[coreutils](https://www.archlinux.org/packages/core/x86_64/coreutils/)|
|[polkit](https://www.archlinux.org/packages/extra/x86_64/polkit/)|
|[qt5-base](https://www.archlinux.org/packages/extra/x86_64/qt5-base/)|
|[qt5-multimedia](https://www.archlinux.org/packages/extra/x86_64/qt5-base/)|
|[qt5-quickcontrols](https://www.archlinux.org/packages/extra/x86_64/qt5-quickcontrols/)|
|[qt5-quickcontrols2](https://www.archlinux.org/packages/extra/x86_64/qt5-quickcontrols2/)|

3. clone the repo:
    `git clone https://github.com/LinArcX/Kindd/`

4. go to cloned directory and make the project with qmake build tools:
    `cd Kindd`
    `qmake`
    `make`

5. run the application:
    `./kindd`

### Tip for Windows-manager's Users
**Kindd** uses pkexec internally. For most Desktop environments, there is a pkexec agent already installed, but users of i3(or maybe some other WMs) should install an agent. I prefer to use `polkit-gnome`. After downloading this packges, paste this line into __i3/config__ file:

#### Arch users
Just paste this line into your i3.config:
`exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &`

#### Void users
Just paste this line into your i3.config:
`exec --no-startup-id /usr/libexec/polkit-gnome-authentication-agent-1 &`

Hint: I don't have awesome or other wms. So you should put above line in your startup config according to your wm's policies.

## License
![License](https://img.shields.io/github/license/LinArcX/kindd.svg)
