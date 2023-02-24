import SwiftUI
#if os(watchOS)
import WatchKit
#endif

// TODO: make non-macOS rendering work again

#if os(macOS)
let scale = NSScreen.main?.backingScaleFactor ?? 1
#elseif os(watchOS)
let scale = WKInterfaceDevice.current().screenScale
#else
let scale = UIScreen.main.scale
#endif

#if os(macOS)
typealias PlatformColor = NSColor
typealias PlatformFont = NSFont
typealias PlatformImage = NSImage
#else
typealias PlatformColor = UIColor
typealias PlatformFont = UIFont
typealias PlatformImage = UIImage
#endif

public extension PlatformImage {
  convenience init(_ icon: IDEIcon) {
#if os(macOS)
//    guard let cgImage = icon.cgImage else { self.init(); return }
//    self.init(cgImage: cgImage, size: icon.size.unscaledBounds.size)

    self.init(size: icon.unscaledBounds.size, flipped: false) { bounds in
      var icon = icon
      // print(bounds)
      let context = NSGraphicsContext.current!.cgContext
      let isDark = NSAppearance.currentDrawing().bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
      icon.colorScheme = isDark ? .dark : .light
      icon.drawBackground(context: context, bounds: bounds)
      icon.drawInterior(context: context, bounds: bounds)
      return true
    }
#else
    guard let cgImage = icon.cgImage else { self.init(); return }
    self.init(cgImage: cgImage, scale: 0, orientation: UIImage.Orientation.up)
#endif
  }
}

public extension Image {
  init(_ ideIcon: IDEIcon) {
#if os(macOS)
    self.init(nsImage: ideIcon.image)
#else
    self.init(uiImage: ideIcon.image)
#endif
  }
}

#if !os(macOS)
var cache = [IDEIcon: PlatformImage]()
#endif

extension IDEIcon {
  var _image: PlatformImage {
#if !os(macOS)
    if let cachedImage = cache[self] { return cachedImage }
#endif
    let image = PlatformImage(self)
#if !os(macOS)
    cache[self] = image
#endif
    return image
  }
}

public enum IDEIconSize {
  public static let small = 14.0
  public static let regular = 16.0
  public static let large = 32.0
}

public extension IDEIcon {
  /// The resulting icon image.
#if os(macOS)
  var image: NSImage { _image }
  var templateImage: NSImage { let image = _image; image.isTemplate = true; return image }
#else
  var image: UIImage { _image }
#endif

  var fontSize: CGFloat { (size / 1.5).rounded() }
  // var outerRadius: CGFloat { size < 24 ? 3 : 7 }
  var outerRadius: CGFloat { (size / 4.5).rounded(.down) }
  var outlineWidth: CGFloat { 1 }
  var borderWidth: CGFloat { 1 }
  var yOffset: CGFloat { size < IDEIconSize.large ? 0 : -3 } // FIXME: just center it, omg
  var unscaledBounds: CGRect { CGRectMake(0, 0, size, size) }

  /// The resulting CoreGraphics image object.
  var cgImage: CGImage? {
    guard let context = CGContext(
      data: nil,
      width: Int(size * scale),
      height: Int(size * scale),
      bitsPerComponent: 8,
      bytesPerRow: 0,
      space: CGColorSpace(name: CGColorSpace.genericRGBLinear)!,
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
      return nil
    }

    let bounds = CGRect(origin: .zero, size: CGSize(width: size * scale, height: size * scale))

    drawBackground(context: context, bounds: bounds)

#if os(macOS)
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: false)
    defer { NSGraphicsContext.restoreGraphicsState() }
#else
    UIGraphicsPushContext(context)
    defer { UIGraphicsPopContext() }
    
    context.translateBy(x: 0, y: bounds.height)
    context.scaleBy(x: 1, y: -1)
#endif
    
    drawInterior(context: context, bounds: bounds)

    return context.makeImage()
  }

  func drawBackground(context: CGContext, bounds: CGRect) {
    let deviceBounds = context.convertToDeviceSpace(bounds)
    let scale = deviceBounds.size.height / bounds.size.height

    let outlineRadius = outerRadius - (borderWidth + outlineWidth)
    let borderRadius = outerRadius - borderWidth

    switch style {
    case .default:
      context.beginPath()
      context.addPath(roundedRect: bounds, cornerRadius: outerRadius)
      context.closePath()
      context.setFillColor(PlatformColor(color.outlineColor[colorScheme]).cgColor)
      context.fillPath()

      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(borderWidth), cornerRadius: borderRadius)
      context.closePath()
      context.setFillColor(PlatformColor(color.borderColor[colorScheme]).cgColor)
      context.fillPath()

      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy((borderWidth + outlineWidth)), cornerRadius: outlineRadius)
      context.closePath()
      context.setFillColor(PlatformColor(color.backgroundColor[colorScheme]).cgColor)
      context.fillPath()

    case .outline:
      let lineWidth = scale >= 2 ? 1 / scale : 1
      context.setLineWidth(lineWidth)
      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(borderWidth + lineWidth / 2), cornerRadius: borderRadius)
      context.closePath()
      context.setStrokeColor(PlatformColor(color.borderColor[colorScheme]).cgColor)
      context.strokePath()

    case .simple:
      context.beginPath()
      context.addPath(roundedRect: bounds, cornerRadius: borderRadius * 1.5)
      context.closePath()
      context.setFillColor(PlatformColor(color.simpleColor).cgColor)
      context.fillPath()

    case .simpleHighlighted:
      context.beginPath()
      context.addPath(roundedRect: bounds, cornerRadius: borderRadius * 1.5)
      context.closePath()
      context.setFillColor(.white)
      context.fillPath()
    }
  }

  func drawInterior(context: CGContext, bounds: CGRect) {
    // let deviceBounds = context.convertToDeviceSpace(bounds)
    // let scale = deviceBounds.size.height / bounds.size.height

    let font = PlatformFont.systemFont(ofSize: (fontSize + fontSizeAdjustment), weight: fontWeight)

    var textColor = PlatformColor(.white).cgColor
    if style == .outline || color == .monochrome {
      textColor = PlatformColor(color.borderColor[colorScheme]).cgColor
    }

    if style == .simpleHighlighted {
      context.setBlendMode(.clear)
      textColor = .black
    }

    let symbolFrame = bounds
      .insetBy(borderWidth + outlineWidth)
      //// + style == .outline ? 0.5 : 0 ?
      //.offsetBy(dx: 0, dy: yOffset + yOffsetAdjustment) // + style == .outline ? 0.5 : 0 ?

    //NSDottedFrameRect(symbolFrame)

    switch content {
    case .text(let string):
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
//      paragraphStyle.minimumLineHeight = size - borderWidth * 2 - outlineWidth * 2
      //paragraphStyle.lineHeightMultiple = size
      // print(paragraphStyle.lineHeightMultiple)
      // paragraphStyle.minimumLineHeight = symbolFrame.height // - yOffsetAdjustment

      let attributedString = NSAttributedString(string: string, attributes: [
        .font: font,
        .paragraphStyle: paragraphStyle,
        .foregroundColor: PlatformColor(cgColor: textColor) as Any,
      ])

      let dy = (symbolFrame.height - attributedString.size().height) / 2
      let textFrame = symbolFrame.integral.offsetBy(dx: 0, dy: yOffsetAdjustment - dy)
      // NSDottedFrameRect(textFrame)
      attributedString.draw(in: textFrame)

    case .systemImage(let systemName):
      // NSDottedFrameRect(symbolFrame)

#if os(macOS)
      let image = NSImage(systemSymbolName: systemName, accessibilityDescription: nil)?
        .withSymbolConfiguration(
          NSImage.SymbolConfiguration(pointSize: fontSize + fontSizeAdjustment, weight: style.fontWeight, scale: .small)
            .applying(NSImage.SymbolConfiguration(paletteColors: [PlatformColor(cgColor: textColor) ?? .clear]))
        )!

      guard let image else { return }

      image.draw(
        in: image.size.centered(in: symbolFrame.insetBy(1)).offsetBy(dx: 0, dy: yOffsetAdjustment).integral,
        from: .zero,
        operation: style == .simpleHighlighted ? .destinationOut : .sourceOver,
        fraction: 1
      )
#endif
    default:
      break
    }
  }
}
