# Kindd ![Language](https://img.shields.io/github/languages/top/LinArcX/Kindd.svg?style=flat-square) ![RepoSize](https://img.shields.io/github/repo-size/LinArcX/Kindd.svg?style=flat-square) ![Latest Tag](https://img.shields.io/github/tag/LinArcX/Kindd.svg?colorB=green&style=flat-square)
A kindful dd gui written in qt quick :)

## Preview
!["gnulium"](shots/2.0.0/init.png "Kindd")

## Purposes
1. Provide a modern/simple/safe UI for dd command.
2. You can create bootable device with kindd.

##
|Landing Page|Process|Settings|
|:-----:|:-----:|:-----:|
|![](./shots/2.0.0/init.png)|![](./shots/2.0.0/process.png)|![](./shots/2.0.0/settings.png)|![](./shots/2.0.0/done.png)|
|Click image to enlarge|Click image to enlarge| Click image to enlarge| Click image to enlarge|

## Installation

### Arch
1. git version
`trizen -S kindd-git`

2. release version
`trizen -S kindd`

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
|[qt5-graphicaleffects](https://www.archlinux.org/packages/extra/x86_64/qt5-graphicaleffects/)

3. clone the repo:

    `git clone https://github.com/LinArcX/Kindd/`

4. go to cloned directory and make the project with qmake build tools:

    `cd Kindd`

    `qmake`

    `make`

5. run the application:

    `./kindd`

### Tip for Windows-manager's Users
**Kindd** uses pkexec internally. For most Desktop environments, there is a pkexec agent already installed, but users of i3(or maybe some other WMs) should install `polkit-gnome` first, and then paste this line into __i3/config__ file:

`exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &`

Hint: I don't have awesome or other wms. So you should put above line in your startup config according to your wm's policies.

## Contributing
![Open PR](https://img.shields.io/github/issues-pr-raw/LinArcX/Kindd.svg?style=flat-square) ![Closed PR](https://img.shields.io/github/issues-pr-closed/LinArcX/Kindd.svg?style=flat-square)
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D


## Bugs
![Open Issues](https://img.shields.io/github/issues-raw/LinArcX/Kindd.svg?style=flat-square) ![Issues](https://img.shields.io/github/issues-closed-raw/LinArcX/Kindd.svg?style=flat-square)

Bugs should be reported [here](https://github.com/LinArcX/Kindd/issues) on the Github issues page.


## Credits
LinArcX
Github Repo:[https://github.com/LinArcX](https://github.com/LinArcX)

E-Mail:linarcx@gmail.com

<h1 align="center">
	<img width="200" src="appconf/kindd.svg" alt="Kindd">
	<br>
	<br>
	<p>kindful + dd</p>
</h1>

## License
![License](https://img.shields.io/github/license/LinArcX/Kindd.svg?style=flat-square)

