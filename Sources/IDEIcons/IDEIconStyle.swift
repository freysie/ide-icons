import SwiftUI

// TODO: rename default to bordered (and then outline to outlined?)?
// TODO: add shadow style (as seen in web inspector)

/// Specifies the style of an IDE icon.
///
/// ![](IDEIconStyle)
public enum IDEIconStyle: Int, CaseIterable {
  case `default`, outline, simple, simpleHighlighted

  // TODO: consider using this instead but then hashing won’t work automatically
  //  case `default`, outline, simple(isHighlighted: Bool = false)
  //
  //  public static var allCases: [IDEIconStyle] {
  //    [.default, .outline, .simple(isHighlighted: false), .simple(isHighlighted: true)]
  //  }
}

extension IDEIconStyle {
  var fontWeight: PlatformFont.Weight {
    switch self {
    case .simple: return .semibold
    default: return .regular // .medium?
    }
  }
}
