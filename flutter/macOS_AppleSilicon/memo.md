
### install flutter on MacOS (Apple Silicon)

ref : https://docs.flutter.dev/get-started/install/macos

```
    $ sudo softwareupdate --install-rosetta --agree-to-license

    download
    https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.13.8-stable.zip

    $ cd ~/development
    $ unzip ~/Downloads/flutter_macos_arm64_3.13.8-stable.zip

    $ export PATH="$PATH:`pwd`/flutter/bin"

```