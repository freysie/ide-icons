# IDE Icons (🚧 Work in Progress 🚧)

Icons for use in integrated development environment apps.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="/Screenshots/IDEIcons~dark@2x.png?raw=true 2x, /Screenshots/IDEIcons~dark@1x.png?raw=true 1x">
  <source media="(prefers-color-scheme: light)" srcset="/Screenshots/IDEIcons~light@2x.png?raw=true 2x, /Screenshots/IDEIcons~light@1x.png?raw=true 1x">
  <img alt="" src="/Screenshots/IDEIcons~dark@2x.png?raw=true" width="303">
</picture>


## Installation

```swift
.package(url: "https://github.com/freyaalminde/ide-icons.git", branch: "main")
```

```swift
import IDEIcons
```


## Overview

```swift
IDEIcon(_:color:colorScheme:style:size:)
IDEIcon(image:bundle:color:colorScheme:style:size:)
IDEIcon(systemImage:color:colorScheme:style:size:)
```

```swift
IDEIcon("P", color: .purple).image
IDEIcon("P", style: .outline).templateImage
Label("Property", IDEIcon("P"))
```

<!--
```swift
Image(IDEIcon("P"))
NSImage(IDEIcon("P"))
UIImage(IDEIcon("P"))
CGImage(IDEIcon("P"))
```
-->


## Roadmap

* Rethink API — perhaps just a single `IDEIcon()` function which returns a platform image object?
* Make rendering work for iOS and watchOS again

