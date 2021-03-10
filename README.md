# Stonks
![Swift version](https://img.shields.io/badge/swift-5.0-orange.svg)
![Platforms](https://img.shields.io/badge/platforms-iOS%20-lightgrey.svg)

iOS Coding Challenge, 2021. Stonks

Projects uses MUX streaming API.

## Technologies Used

1. Swift 5
2. UIKit (Storyboard)


## Getting Started

```bash
$ git clone https://github.com/djalfirevic/Stonks.git
$ cd Stonks
$ open Stonks.xcodeproj
```

## How app is working

User is presented with the home page, where he is able to see a stream playing. He is presented with two tabs. Upon selecting the second tab, stream player gets minimized but the stream is still ongoing. After coming back to the first tab - the player is returned to maximized mode.

## Notes

I would go with Test-Driven Development environment, where I would continue writing tests.
I would introduce a MVVM design pattern in order to support proper unit testing.
