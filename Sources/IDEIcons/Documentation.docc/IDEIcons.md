# ``IDEIcons``

Icons for use in integrated development environment apps.

## Overview

This framework allows you to easily insert IDE-y icons in your app.

`Image`, `Label`, `NSImage`, and `UIImage` have been extended to provide easy use of IDE icons.

```swift
Label("Easy", IDEIcon("E", color: .teal))

Image(IDEIcon("E", color: .teal))

NSImage(IDEIcon("E", color: .teal))

UIImage(IDEIcon("E", color: .teal))
```

Icons can contain text, images, or system images.

```swift
IDEIcon("T")
IDEIcon(image: "binary")
IDEIcon(image: "binary", bundle: .module)
IDEIcon(systemImage: "power")
```

Icons can have different sizes.

```swift
IDEIcon("R", size: IDEIconSize.regular)
IDEIcon("L", size: IDEIconSize.large)
IDEIcon("H", size: 96)
```

Icons come in different styles.

```swift
IDEIcon("D", style: .default)
IDEIcon("O", style: .outline)
IDEIcon("S", style: .simple)
```

## Topics

### Creating Icons

- ``IDEIcon``
- ``IDEIconContent``

### Styling Icons

- ``IDEIconColor``
- ``IDEIconSize``
- ``IDEIconStyle``
