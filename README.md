# Particle System using Open CL and Open GL

Playing with OpenCL and OpenGL to create a particle system utilizing a collection of 3D particles. Also added two sphere barriers for the particles to bounce off of and adjusted the particles' coloring based on their velocity and proximity to the barriers. 

*NOTE*: There appear to be incompatibilities with later versions of MacOS (i.e. MacOS Mojave) and the GLUI framework. For that reason, I have provided the particles executable in this repo. In the event that you're running MacOS Mojave, skip to *Installing* and skip running `make`.

![](particles.gif)

## Getting Started

These instructions will get you a local copy of the project up and running on your machine.

### Prerequisites
*These are specifically for MacOS -- there should not be any compatibility issues for Windows or Linux OS.*

1. Install the latest version of XCode.
1. Install [homebrew](https://brew.sh/).
1. Install the latest version of `clang` that works with OpenMP:
```sh
brew install llvm
```
*OR* (if you already have it installed and just need to upgrade):
```sh
brew upgrade llvm
```
4. Install the [GLUI framework](https://lukecyca.com/2008/glui-235-framework-for-mac-os-x.html)

### Installing

```
git clone https://github.com/code-tsunami/particles
cd particles
make # skip this step if you're running MacOS Mojave
```

### Run Particle System
```sh
particles # a GUI should pop up with controls; press "Go!"
```

<!-- ## Built With

* [text](http://somelink.com) - what it was -->

## Authors

* **Sonam Kindy** - [code-tsunami](https://github.com/code-tsunami)
* **Mike Bailey** - *template code* - [mjb](http://web.engr.oregonstate.edu/~mjb/WebMjb/mjb.html)

<!-- ## Acknowledgments (Resources)

* Inspiration
* Code used
* etc. -->

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
