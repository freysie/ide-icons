import SwiftUI

// TODO: rename default to bordered
// TODO: add shadow style (as seen in web inspector)
// TODO: finish adding Xcode 14-inspired simple style

/// Specifies the style of an IDE icon.
///
/// ![](IDEIconStyle)
public enum IDEIconStyle: CaseIterable {
  case `default`, outline, simple
}

extension IDEIconStyle {
  var fontWeight: PlatformFont.Weight {
    switch self {
    case .simple: return .semibold
    default: return .regular // .medium?
    }
  }
}
