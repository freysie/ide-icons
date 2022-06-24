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

var cache = [IDEIcon: PlatformImage]()

public extension IDEIcon {
  /// The resulting icon image.
#if os(macOS)
  var image: NSImage { _image }
#else
  var image: UIImage { _image }
#endif

  /// The resulting CoreGraphics image object.
  var cgImage: CGImage? {
    let outlineRadius = size.outerRadius - (size.borderWidth + size.outlineWidth)
    let borderRadius = size.outerRadius - size.borderWidth
    
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
    
    switch style {
    case .default:
      context.beginPath()
      context.addPath(roundedRect: bounds, cornerRadius: size.outerRadius)
      context.closePath()
      context.setFillColor(DynamicColor(color.outlineColor[colorScheme]).cgColor)
      context.fillPath()
      
      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(size.borderWidth), cornerRadius: borderRadius)
      context.closePath()
      context.setFillColor(DynamicColor(color.borderColor[colorScheme]).cgColor)
      context.fillPath()
      
      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(size.borderWidth + size.outlineWidth), cornerRadius: outlineRadius)
      context.closePath()
      context.setFillColor(DynamicColor(color.backgroundColor[colorScheme]).cgColor)
      context.fillPath()
      
    case .outline:
      context.beginPath()
      context.addPath(roundedRect: bounds.insetBy(size.borderWidth + 0.5), cornerRadius: borderRadius)
      context.closePath()
      context.setStrokeColor(DynamicColor(color.borderColor[colorScheme]).cgColor)
      context.strokePath()
    }
    
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
    
    let weight = PlatformFont.Weight.regular
    let font = PlatformFont.systemFont(ofSize: size.fontSize + fontSizeAdjustment, weight: weight)
    
    var textColor = DynamicColor(.white).cgColor
    if style == .outline || color == .monochrome {
      textColor = DynamicColor(color.borderColor[colorScheme]).cgColor
    }
    
    let symbolFrame = bounds
      .insetBy(size.borderWidth + size.outlineWidth)
      //// + style == .outline ? 0.5 : 0 ?
      //.offsetBy(dx: 0, dy: size.yOffset + yOffsetAdjustment) // + style == .outline ? 0.5 : 0 ?
    
    switch content {
    case .text(let string):
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      paragraphStyle.minimumLineHeight = 0
      // print(paragraphStyle.lineHeightMultiple)
      paragraphStyle.minimumLineHeight = symbolFrame.height // - yOffsetAdjustment

      let textFrame = symbolFrame.insetBy(dx: -1, dy: -1).offsetBy(dx: 0, dy: yOffsetAdjustment) // size.yOffset + yOffsetAdjustment)
      // NSDottedFrameRect(textFrame)
      string.draw(in: textFrame, withAttributes: [
        .font: font,
        .paragraphStyle: paragraphStyle,
        .foregroundColor: PlatformColor(cgColor: textColor) as Any,
      ])
    case .systemImage(let systemName):
      // NSDottedFrameRect(symbolFrame)
      
      let image = NSImage(systemSymbolName: systemName, accessibilityDescription: nil)!
        .withSymbolConfiguration(
          .init(pointSize: size.fontSize + fontSizeAdjustment, weight: weight)
          .applying(.init(paletteColors: [PlatformColor(cgColor: textColor)!]))
        )!
      
      image.draw(in: image.size.centered(in: symbolFrame))
    default:
      break
    }
    
    return context.makeImage()
  }
}

extension IDEIcon {
  var _image: PlatformImage {
    if let cachedImage = cache[self] { return cachedImage }
    let image = PlatformImage(self)
    cache[self] = image
    return image
  }
}

extension CGSize {
  func centered(in rect: CGRect) -> CGRect {
    let centeredPoint = CGPoint(x: rect.minX + (rect.width - width) / 2, y: rect.minY + (rect.height - height) / 2)
    return CGRect(origin: centeredPoint, size: self)
  }
}
