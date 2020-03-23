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
1. Provide a modern/simple/safe UI for dd command.
2. Create bootable USB withouth worring!

## Installation
### Void
`sudo xbps-install -S kindd`

### Arch
- git version

`trizen -S kindd-git`

- release version

`trizen -S kindd`

### Build From Source
First Install these dependencies first:

#### Dependencies
build dependencies:
- cmake
- pkg-config
- qt5-devel
- qt5-declarative-devel
- qt5-quickcontrols2-devel

runtime dependencies:
- qt5-svg
- qt5-quickcontrols
- qt5-quickcontrols2
- qt5-graphicaleffects
- polkit-gnome

Then clone and build the project:

```
git clone https://github.com/LinArcX/kindd/
cd kindd; mkdir build; cd build
cmake ..; make
```

And finally, run it:

`cd ..; build/kindd`

### Tip for Windows-manager's Users
**kindd** uses pkexec internally. For most Desktop environments, there is a pkexec agent already installed, but users of i3(or maybe some other WMs) should install an agent. I prefer to use `polkit-gnome`. After downloading this packges, paste this line into __i3/config__ file:

#### Arch users
Just paste this line into your i3.config:

`exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &`

#### Void users
Just paste this line into your `i3.config`:

`exec --no-startup-id /usr/libexec/polkit-gnome-authentication-agent-1 &`

Hint: I don't have awesome or other wms. So you should change above lines according to your needs.

## License
![License](https://img.shields.io/github/license/LinArcX/kindd.svg)
