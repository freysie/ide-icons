import SwiftUI

/// Specifies the size of an IDE icon.
///
/// ![](IDEIconSize)
public enum IDEIconSize: CaseIterable {
  case regular, large
}

extension IDEIconSize {
#if os(macOS)
  var frameSize: CGFloat { switch self { case .regular: return 16; case .large: return 32 } }
#else
  var frameSize: CGFloat { 20 }
#endif
  
#if os(macOS)
  var fontSize: CGFloat { switch self { case .regular: return 11; case .large: return 20 } }
#else
  var fontSize: CGFloat { 18 }
#endif
  
#if os(macOS)
  var outerRadius: CGFloat { switch self { case .regular: return 3; case .large: return 7 } }
#else
  var outerRadius: CGFloat { 7 }
#endif
  
#if os(macOS)
  var outlineWidth: CGFloat { 1 }
#else
  var outlineWidth: CGFloat { 1.5 }
#endif
  
#if os(macOS)
  var borderWidth: CGFloat { 1 }
#else
  var borderWidth: CGFloat { 1.5 }
#endif
  
#if os(macOS)
  var yOffset: CGFloat { switch self { case .regular: return 0; case .large: return -4 } }
#else
  var yOffset: CGFloat { 0 }
#endif
  
  var unscaledBounds: CGRect { CGRect(origin: .zero, size: CGSize(width: frameSize, height: frameSize)) }
}
