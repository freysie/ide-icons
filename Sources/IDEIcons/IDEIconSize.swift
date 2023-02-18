//import SwiftUI
//
//public protocol IDEIconSize { var rawValue: Int { get } }
//extension Int: IDEIconSize { public var rawValue: Int { self } }
//
///// Specifies the size of an IDE icon.
/////
///// ![](IDEIconSize)
//public enum IDEIconStandardSize: Int, CaseIterable, IDEIconSize {
//  case small = 14, regular = 16, large = 32
//}
//
//// 32/1.5
//
//extension IDEIconSize {
//  var frameSize: CGFloat { CGFloat(rawValue) }
//  var fontSize: CGFloat { (frameSize / 1.5).rounded() }
//  var outerRadius: CGFloat { rawValue <= IDEIconStandardSize.regular.rawValue ? 3 : 7 }
//  var outlineWidth: CGFloat { 1 }
//  var borderWidth: CGFloat { 1 }
//  var yOffset: CGFloat { rawValue <= IDEIconStandardSize.regular.rawValue ? 0 : -4 }
//
////#if os(macOS)
////  var frameSize: CGFloat {
////    switch self {
////    case .small: return 14
////    case .regular: return 16
////    case .large: return 32
////    }
////  }
////#else
////  var frameSize: CGFloat { 20 }
////#endif
////
////#if os(macOS)
////  var fontSize: CGFloat {
////    switch self {
////    case .small: return 9
////    case .regular: return 11
////    case .large: return 20
////    }
////  }
////#else
////  var fontSize: CGFloat { 18 }
////#endif
////
////#if os(macOS)
////  var outerRadius: CGFloat {
////    switch self {
////    case .small: return 3
////    case .regular: return 3
////    case .large: return 7
////    }
////  }
////#else
////  var outerRadius: CGFloat { 7 }
////#endif
////
////#if os(macOS)
////  var outlineWidth: CGFloat { 1 }
////#else
////  var outlineWidth: CGFloat { 1.5 }
////#endif
////
////#if os(macOS)
////  var borderWidth: CGFloat { 1 }
////#else
////  var borderWidth: CGFloat { 1.5 }
////#endif
////
////#if os(macOS)
////  var yOffset: CGFloat {
////    switch self {
////    case .small: return 0
////    case .regular: return 0
////    case .large: return -4
////    }
////  }
////#else
////  var yOffset: CGFloat { 0 }
////#endif
//
//  var unscaledBounds: CGRect { CGRect(origin: .zero, size: CGSize(width: frameSize, height: frameSize)) }
//}
