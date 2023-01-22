<h4 align="center">
    <img src="assets/appconf/kindd.svg" align="center" width="100"/>
</h4>

<h4 align="center">
    <img src="https://img.shields.io/travis/LinArcX/kindd"/>  <img src="https://img.shields.io/github/tag/LinArcX/kindd.svg?colorB=green"/>  <img src="https://img.shields.io/github/repo-size/LinArcX/kindd.svg"/>  <img src="https://img.shields.io/github/languages/top/LinArcX/kindd.svg"/>
</h4>

<h1 align="center">
    <a href="https://gist.githubusercontent.com/LinArcX/4dde221ebf32b852586c65ecffdaa67f/raw/5846037655687b2e16f733eff2ca593fbce108f4/process.png"><img src="https://gist.githubusercontent.com/LinArcX/4dde221ebf32b852586c65ecffdaa67f/raw/5846037655687b2e16f733eff2ca593fbce108f4/process.png"></a>
    <br/>
    <h4 align="center">Creating a bootable USB with kindd. <a href="https://github.com/LinArcX/kindd/issues/10">[more]</a></h4>
</h1>

## Purposes
1. Provide a modern/simple/safe UI for `dd` command.
2. Create bootable USB withouth worrying!

## Installation
### Void
`sudo xbps-install -S kindd`

### Arch
Release version:
- kindd

Git version:
- kindd-git

### Build From Source
First Install these dependencies first:

#### Dependencies
build dependencies:
- git
- cmake
- pkg-config
- qt5-devel
- qt5-svg-devel
- qt5-declarative-devel
- qt5-quickcontrols2-devel

runtime dependencies:
- qt5-svg
- qt5-quickcontrols
- qt5-quickcontrols2
- qt5-graphicaleffects

Then clone and build the project:

```
git clone https://github.com/LinArcX/kindd/
chmod +x ./build/tools/linux/sh/build.sh
./build/tools/linux/sh/build.sh build_release
```

And finally, run it:

```
./build/tools/linux/sh/build.sh run_release
```

## Polkit
**kindd** uses pkexec internally. For most Desktop environments, there is a pkexec agent already installed. Like these:
- xfce-polkit
- polkit-gnome
- pantheon-agent-polki
- mate-polkit
- polkit-kde-agent

But users of windows managers(like i3, dwm, awesome, ...) should install an agent. After installing a polkit-agent, paste these lines into your wm's config file.(For instance i3 keeps it's configs here: __i3/config__):

#### Arch users
`exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &`

#### Void users
`exec --no-startup-id /usr/libexec/polkit-gnome-authentication-agent-1 &`

Hint: I don't have awesome or other windows managers. So you should change above lines according to your agent and your wm.

## Donate
- Bitcoin: `13T28Yd37qPtuxwTFPXeG9dWPahwDzWHjy`
<img src="assets/donate/Bitcoin.png" width="200" align="center" />

- Monero: `48VdRG9BNePEcrUr6Vx6sJeVz6EefGq5e2F5S9YV2eJtd5uAwjJ7Afn6YeVTWsw6XGS6mXueLywEea3fBPztUbre2Lhia7e`
<img src="assets/donate/Monero.png" align="center" />

## License
![License](https://img.shields.io/github/license/LinArcX/kindd.svg)
