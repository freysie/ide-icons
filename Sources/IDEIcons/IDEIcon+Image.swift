import SwiftUI
#if os(watchOS)
import WatchKit
#endif

#if os(macOS)
let deviceScale = 1.0
#elseif os(watchOS)
let deviceScale = WKInterfaceDevice.current().screenScale
#else
let deviceScale = UIScreen.main.scale
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
  /// Returns an image object depicting an IDE icon.
  convenience init(_ icon: IDEIcon) {
#if os(macOS)
    self.init(size: icon.unscaledBounds.size, flipped: false) { bounds in
      var icon = icon
      let context = NSGraphicsContext.current!.cgContext
      let isDark = NSAppearance.currentDrawing().bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
      icon.colorScheme = isDark ? .dark : .light
      icon.drawBackground(context: context, bounds: bounds)
      icon.drawInterior(context: context, bounds: bounds)
      return true
    }
#else
    guard let cgImage = icon.cgImage else { self.init(); return }
    self.init(cgImage: cgImage, scale: deviceScale, orientation: .up)
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

/// Predefined IDE icon sizes.
public enum IDEIconSize {
  /// 16 pt.
  public static let regular = 16.0
  /// 32 pt.
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

  var fontSize: CGFloat { (size / 1.5).rounded() * deviceScale }
  //var outerRadius: CGFloat { (size < 32 ? 3 : 7) * max(1, deviceScale * 0.75) }
  var outerRadius: CGFloat { min(5, (size / 4.5).rounded(.down)) }
  var outlineWidth: CGFloat { 1 * deviceScale }
  var borderWidth: CGFloat { 1 * deviceScale }
  var unscaledBounds: CGRect { CGRectMake(0, 0, size, size) }

  /// The resulting CoreGraphics image object.
  var cgImage: CGImage? {
    guard let context = CGContext(
      data: nil,
      width: Int(size * deviceScale),
      height: Int(size * deviceScale),
      bitsPerComponent: 8,
      bytesPerRow: 0,
      space: CGColorSpace(name: CGColorSpace.genericRGBLinear)!,
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
      return nil
    }

    let bounds = CGRectMake(0, 0, size * deviceScale, size * deviceScale)

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
      context.addPath(roundedRect: bounds.insetBy(borderWidth), cornerRadius: borderRadius * 1.5)
      context.closePath()
      context.setFillColor(PlatformColor(color.simpleColor).cgColor)
      context.fillPath()

    case .simpleHighlighted:
      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(borderWidth), cornerRadius: borderRadius * 1.5)
      context.closePath()
      context.setFillColor(PlatformColor.white.cgColor)
      context.fillPath()
    }
  }

  func drawInterior(context: CGContext, bounds: CGRect) {
    // let deviceBounds = context.convertToDeviceSpace(bounds)
    // let scale = deviceBounds.size.height / bounds.size.height

    var font = PlatformFont.systemFont(ofSize: (fontSize + fontSizeAdjustment), weight: fontWeight)
#if os(macOS)
    font.fontDescriptor
      .withSymbolicTraits(.expanded)
      .withDesign(.rounded)
      .map { PlatformFont(descriptor: $0, size: font.pointSize).map { font = $0 } }
#else
    font.fontDescriptor
      .withSymbolicTraits(.expanded)
      .withDesign(.rounded)
      .map { font = PlatformFont(descriptor: $0, size: font.pointSize) }
#endif

//    guard let descriptor = systemFont.fontDescriptor.withDesign(design) else { return systemFont }
//    return NSFont(descriptor: descriptor, size: systemFont.pointSize) ?? systemFont

    var textColor = PlatformColor(.white).cgColor
    if style == .outline || color == .monochrome {
      textColor = PlatformColor(color.borderColor[colorScheme]).cgColor
    }

    if style == .simpleHighlighted {
      context.setBlendMode(.clear)
      textColor = PlatformColor.black.cgColor
    }

#if !os(macOS)
    let yOffsetAdjustment = yOffsetAdjustment * -1
#endif

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
      // paragraphStyle.minimumLineHeight = symbolFrame.height // - yOffsetAdjustment

      let attributedString = NSAttributedString(string: string, attributes: [
        .font: font,
        .paragraphStyle: paragraphStyle,
        .foregroundColor: PlatformColor(cgColor: textColor) as Any,
      ])

      //let dy = (symbolFrame.height - attributedString.size().height) / 2
      //let textFrame = symbolFrame.integral.offsetBy(dx: 0, dy: yOffsetAdjustment - dy)
      let textFrame = attributedString.size().centered(in: symbolFrame).offsetBy(dx: 0, dy: yOffsetAdjustment)

      // NSDottedFrameRect(textFrame)
      //UIRectFrame(textFrame)
      attributedString.draw(in: textFrame)

    case .systemImage(let systemName):
      // NSDottedFrameRect(symbolFrame)
      let pointSize = fontSize + fontSizeAdjustment

#if os(macOS)
      let image = NSImage(systemSymbolName: systemName, accessibilityDescription: nil)?
        .withSymbolConfiguration(
          NSImage.SymbolConfiguration(pointSize: pointSize, weight: style.symbolFontWeight, scale: .small)
            .applying(NSImage.SymbolConfiguration(paletteColors: [PlatformColor(cgColor: textColor) ?? .clear]))
        )!

      guard let image else { return }

      image.draw(
        in: image.size.centered(in: symbolFrame.insetBy(1)).offsetBy(dx: 0, dy: yOffsetAdjustment).integral,
        from: .zero,
        operation: style == .simpleHighlighted ? .destinationOut : .sourceOver,
        fraction: 1
      )
#else
      let image = UIImage(systemName: systemName)?
        .applyingSymbolConfiguration(
          UIImage.SymbolConfiguration(pointSize: pointSize, weight: style.symbolWeight, scale: .small)
            .applying(UIImage.SymbolConfiguration(paletteColors: [PlatformColor(cgColor: textColor)]))
        )

      guard let image else { return }

      image.draw(
        in: image.size.centered(in: symbolFrame.insetBy(1)).offsetBy(dx: 0, dy: yOffsetAdjustment).integral,
        blendMode: style == .simpleHighlighted ? .destinationOut : .normal,
        alpha: 1
      )
#endif
    default:
      break
    }
  }
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
