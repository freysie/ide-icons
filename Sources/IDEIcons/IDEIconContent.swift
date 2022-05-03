import SwiftUI

/// Specifies the content of an IDE icon.
public enum IDEIconContent {
  /// Text content in the form of a string.
  case text(String)

  /// Image content.
  case image(String, bundle: Bundle?)

  /// System symbol image content.
  case systemImage(String)
}
