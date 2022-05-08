import SwiftUI

// TODO: add array style
// TODO: settle on API
// TODO: caching
// TODO: docs

///// Makes an icon.
//public func IDEMakeIcon() -> CGImage? { nil }

/// The blueprint for an IDE icon.
public struct IDEIcon: Hashable {
  /// The icon’s content.
  public var content: IDEIconContent
  
  /// The icon’s color.
  public var color: IDEIconColor
  
  /// The icon’s color scheme.
  public var colorScheme: ColorScheme

  /// The icon’s style.
  public var style: IDEIconStyle
  
  /// The icon’s size.
  public var size: IDEIconSize

  init(_ content: IDEIconContent, color: IDEIconColor? = nil, colorScheme: ColorScheme? = nil, style: IDEIconStyle? = nil, size: IDEIconSize? = nil) {
    self.content = content
    self.color = color ?? .purple
    self.colorScheme = colorScheme ?? .dark
    self.style = style ?? .default
    self.size = size ?? .regular
  }
  
  /// Creates a new blueprint for an IDE icon.
  public init(_ text: String, color: IDEIconColor? = nil, colorScheme: ColorScheme? = nil, style: IDEIconStyle? = nil, size: IDEIconSize? = nil) {
    self.init(.text(text), color: color, colorScheme: colorScheme, style: style, size: size)
  }
  
  /// Creates a new blueprint for an IDE icon.
  public init(image: String, bundle: Bundle? = nil, color: IDEIconColor? = nil, colorScheme: ColorScheme? = nil, style: IDEIconStyle? = nil, size: IDEIconSize? = nil) {
    self.init(.image(image, bundle: bundle), color: color, colorScheme: colorScheme, style: style, size: size)
  }
  
  /// Creates a new blueprint for an IDE icon.
  public init(systemImage: String, color: IDEIconColor? = nil, colorScheme: ColorScheme? = nil, style: IDEIconStyle? = nil, size: IDEIconSize? = nil) {
    self.init(.systemImage(systemImage), color: color, colorScheme: colorScheme, style: style, size: size)
  }
}

//extension IDEIcon: Hashable {
//  public static func == (lhs: IDEIcon, rhs: IDEIcon) -> Bool { lhs.hashValue == rhs.hashValue }
//  public func hash(into hasher: inout Hasher) {
//    content.hash(into: &hasher)
//    color.hash(into: &hasher)
//    colorScheme.hash(into: &hasher)
//    style.hash(into: &hasher)
//    size.hash(into: &hasher)
//  }
//}
