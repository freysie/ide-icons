import SwiftUI

//#if os(macOS)
//struct ImageView: NSViewRepresentable {
//  let image: NSImage
//
//  func makeNSView(context: Context) -> NSImageView {
//    .init(image: image)
//  }
//
//  func updateNSView(_ view: NSImageView, context: Context) {}
//}
//#endif

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension Label where Title == Text, Icon == Image {
  /// Creates a label with an IDE icon image and a title generated from a localized string.
  ///
  /// - Parameters:
  ///    - titleKey: A title generated from a localized string.
  ///    - ideIcon: The blueprint for the IDE icon used.
  init(_ titleKey: LocalizedStringKey, _ ideIcon: IDEIcon) {
    self.init { Text(titleKey) } icon: {
      Image(ideIcon)
    }
  }

  //    /// Creates a label with an icon image and a title generated from a string.
  //    ///
  //    /// - Parameters:
  //    ///    - title: A string used as the label's title.
  //    ///    - image: The name of the image resource to lookup.
  //    init<S>(_ title: S, image name: String) where S : StringProtocol
  //
  //    /// Creates a label with a system icon image and a title generated from a
  //    /// string.
  //    ///
  //    /// - Parameters:
  //    ///    - title: A string used as the label's title.
  //    ///    - systemImage: The name of the image resource to lookup.
  //    init<S>(_ title: S, systemImage name: String) where S : StringProtocol
}

extension CGSize {
  func centered(in rect: CGRect) -> CGRect {
    let centeredPoint = CGPoint(x: rect.minX + (rect.width - width) / 2, y: rect.minY + (rect.height - height) / 2)
    return CGRect(origin: centeredPoint, size: self)
  }
}

extension CGRect {
  func insetBy(_ factor: Double) -> CGRect {
    insetBy(dx: factor, dy: factor)
  }
}

extension CGContext {
  func addPath(roundedRect rect: CGRect, cornerRadius: CGFloat) {
    addPath(CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil))
  }
}

extension String {
  static var alphabet: [Character] {
    let aScalars = "A".unicodeScalars
    let aCode = aScalars[aScalars.startIndex].value
    return (0..<26).map { i in Character(Unicode.Scalar(aCode + i) ?? aScalars[aScalars.startIndex]) }
  }
}
