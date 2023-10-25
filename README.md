# ios17_soft_reset

Reproduction for:
1. https://github.com/flutter/flutter/issues/136980, and
2. https://github.com/realm/realm-dart/issues/1411

Running this project in debug mode on an iOS 17 device, will crash and soft-reset the device.

## Getting Started

Recreate with

```sh
flutter create . --platforms ios
flutter run
```

Ensure to use a realm ios17 device. Running on the simulator will no cause problems.

Running in release mode is not a problem:
```sh
flutter run --release
```