# IDE Icons

Icons for use in integrated development environment apps.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="Screenshots/IDEIcons~dark@2x.png?raw=true 2x, Screenshots/IDEIcons~dark@1x.png?raw=true 1x">
  <source media="(prefers-color-scheme: light)" srcset="Screenshots/IDEIcons~light@2x.png?raw=true 2x, Screenshots/IDEIcons~light@1x.png?raw=true 1x">
  <img alt="" src="Screenshots/IDEIcons~dark@1x.png?raw=true">
</picture>


## Installation

```swift
.package(url: "https://github.com/freyaariel/ide-icons.git", branch: "main")
```

```swift
import IDEIcons
```


## Overview

```swift
IDEIcon(_:color:colorScheme:style:size:)
```

```swift
Label("Property", IDEIcon("P"))
Image(IDEIcon("P"))
NSImage(IDEIcon("P"))
UIImage(IDEIcon("P"))
CGImage(IDEIcon("P"))
```


<!--## Roadmap-->
<!---->
<!--* Rethink API — perhaps just a single `IDEIcon()` function which returns a platform image object?-->

