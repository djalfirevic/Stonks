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

I would go with Test-Driven Development environment, where I would start writing tests.
I would introduce a MVVM design pattern in order to support proper unit testing.
I took the liberty to remove `UINavigationBar` from the first screen, it was looking better without it.
Tap ![here](https://drive.google.com/file/d/1qsIjm4mLm7Qu2KL1tyPpTjKwK7W2kUq7/view?usp=sharing) to see the demo.
