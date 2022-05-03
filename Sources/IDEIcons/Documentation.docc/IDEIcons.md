# ``IDEIcons``

Icons for use in integrated development environment apps.

## Overview

This framework allows you to easily insert IDE-like icons in your app.

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
IDEIcon(systemImage: "power")
```

Icons can have different sizes.

```swift
IDEIcon("R", size: .regular)
IDEIcon("L", size: .large)
```

Icons can have different styles.

```swift
IDEIcon("D", style: .default)
IDEIcon("O", style: .outline)
```

## Topics

### Creating Icons

- ``IDEIcon``
- ``IDEIconContent``

### Styling Icons

- ``IDEIconColor``
- ``IDEIconSize``
- ``IDEIconStyle``
