# IDE Icons

Icons for use in integrated development environment apps.

![](https://github.com/freyaariel/ide-icons/blob/main/Screenshots/IDEIcons.png?raw=true)


## Installation

```swift
.package(url: "https://github.com/freyaariel/ide-icons.git", branch: "main")
```

```swift
import IDEIcons
```


## Usage

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

