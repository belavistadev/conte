# Conte
Conte is a tally counter for iOS, iPadOS and macOS, written by [Thiago Campos]
and [Ivan Santiago]. It does one thing (count anything) and does it well. That's
the whole app.

[Thiago Campos]: https://thigcampos.com
[Ivan Santiago]: https://ivansantiago.net

### Pre-requisites
Working on Conte takes a few tools. Not many. Let's check them.

#### Basics
_The one you can't skip._

- [Xcode]: It sucks. We know. But we need it.

[Xcode]: https://developer.apple.com/xcode/

#### Useful
_You can live without them. You just won't want to._

- [swift-format]: Clean code, the way it should be.
- [xcbeautify]: Only needed if you want to use the `make` commands. It turns
build logs into something you'd actually read.

[swift-format]:https://github.com/swiftlang/swift-format  
[xcbeautify]: https://github.com/cpisciotta/xcbeautify

### Building
Time to see some action. To compile and run Conte from source, use [Xcode]. Or,
if you have good taste, use [GNU make].

[Xcode]: https://developer.apple.com/documentation/xcode/build-system
[GNU make]: https://www.gnu.org/software/make/

#### macOS
```sh
make build
```
One line. It just works.

#### iOS/iPadOS
```sh
make ibuild TARGET="<Your device name>"
```
I'm not really into simulating devices. So our `Makefile` only builds to physical
devices. If you'd rather simulate, Xcode's [Simulator] is right there.

[Simulator]: https://developer.apple.com/documentation/Xcode/running-your-app-on-simulated-or-physical-devices
