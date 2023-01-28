import DynamicColor
import SwiftUI
#if os(watchOS)
import WatchKit
#endif

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

    self.init(size: icon.size.unscaledBounds.size, flipped: false) { bounds in
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

public extension IDEIcon {
  /// The resulting icon image.
#if os(macOS)
  var image: NSImage { _image }
#else
  var image: UIImage { _image }
#endif

  /// The resulting CoreGraphics image object.
  var cgImage: CGImage? {
    guard let context = CGContext(
      data: nil,
      width: Int(size.frameSize * scale),
      height: Int(size.frameSize * scale),
      bitsPerComponent: 8,
      bytesPerRow: 0,
      space: CGColorSpace(name: CGColorSpace.genericRGBLinear)!,
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
      return nil
    }

    let bounds = CGRect(origin: .zero, size: CGSize(width: size.frameSize * scale, height: size.frameSize * scale))

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
    let outlineRadius = size.outerRadius - (size.borderWidth + size.outlineWidth)
    let borderRadius = size.outerRadius - size.borderWidth

    switch style {
    case .default:
      context.beginPath()
      context.addPath(roundedRect: bounds, cornerRadius: size.outerRadius * scale)
      context.closePath()
      context.setFillColor(DynamicColor(color.outlineColor[colorScheme]).cgColor)
      context.fillPath()

      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(size.borderWidth * scale), cornerRadius: borderRadius * scale)
      context.closePath()
      context.setFillColor(DynamicColor(color.borderColor[colorScheme]).cgColor)
      context.fillPath()

      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy((size.borderWidth + size.outlineWidth) * scale), cornerRadius: outlineRadius * scale)
      context.closePath()
      context.setFillColor(DynamicColor(color.backgroundColor[colorScheme]).cgColor)
      context.fillPath()

    case .outline:
      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(size.borderWidth + 0.5), cornerRadius: borderRadius * scale)
      context.closePath()
      context.setStrokeColor(DynamicColor(color.borderColor[colorScheme]).cgColor)
      context.strokePath()

    case .simple:
      context.beginPath()
      context.addPath(roundedRect: bounds, cornerRadius: borderRadius * scale)
      context.closePath()
      context.setFillColor(DynamicColor(color.simpleColor).cgColor)
      context.fillPath()
    }
  }

  func drawInterior(context: CGContext, bounds: CGRect) {
    let font = PlatformFont.systemFont(ofSize: (size.fontSize + fontSizeAdjustment) * scale, weight: fontWeight)

    var textColor = DynamicColor(.white).cgColor
    if style == .outline || color == .monochrome {
      textColor = DynamicColor(color.borderColor[colorScheme]).cgColor
    }

    let symbolFrame = bounds
      .insetBy((size.borderWidth + size.outlineWidth) * scale)
      //// + style == .outline ? 0.5 : 0 ?
      //.offsetBy(dx: 0, dy: size.yOffset + yOffsetAdjustment) // + style == .outline ? 0.5 : 0 ?

    switch content {
    case .text(let string):
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      // paragraphStyle.minimumLineHeight = 0
      // print(paragraphStyle.lineHeightMultiple)
      // paragraphStyle.minimumLineHeight = symbolFrame.height // - yOffsetAdjustment

      let textFrame = symbolFrame.insetBy(dx: -1, dy: -1).offsetBy(dx: 0, dy: size.yOffset + yOffsetAdjustment)
      // NSDottedFrameRect(textFrame)
      string.draw(in: textFrame, withAttributes: [
        .font: font,
        .paragraphStyle: paragraphStyle,
        .foregroundColor: PlatformColor(cgColor: textColor) as Any,
      ])

    case .systemImage(let systemName):
      // NSDottedFrameRect(symbolFrame)

#if os(macOS)
      let image = NSImage(systemSymbolName: systemName, accessibilityDescription: nil)!
        .withSymbolConfiguration(
          .init(pointSize: size.fontSize + fontSizeAdjustment, weight: style.fontWeight)
            .applying(.init(paletteColors: [PlatformColor(cgColor: textColor)!]))
        )!

      image.draw(in: image.size.centered(in: symbolFrame))
#endif
    default:
      break
    }
  }
}
