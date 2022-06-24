import DynamicColor
import SwiftUI

// TODO: use asset catalog instead?

struct AdaptiveColor {
  let lightColor: Color
  let darkColor: Color
  
  init(light: Color, dark: Color) {
    lightColor = light
    darkColor = dark
  }
  
  subscript(_ scheme: ColorScheme) -> Color {
    switch scheme {
    case .light: return lightColor
    case .dark: return darkColor
    @unknown default: fatalError()
    }
  }
}

//public extension Color {
//  static var ideSymbolBlue: Self { .init("ideSymbolBlue") }
//  static var ideSymbolBlueBorder: Self { .init("ideSymbolBlueBorder") }
//  static var ideSymbolBrown: Self { .init("ideSymbolBrown") }
//  static var ideSymbolBrownBorder: Self { .init("ideSymbolBrownBorder") }
//  static var ideSymbolGray: Self { .init("ideSymbolGray") }
//  static var ideSymbolGrayBorder: Self { .init("ideSymbolGrayBorder") }
//  static var ideSymbolGreen: Self { .init("ideSymbolGreen") }
//  static var ideSymbolGreenBorder: Self { .init("ideSymbolGreenBorder") }
//  static var ideSymbolOrange: Self { .init("ideSymbolOrange") }
//  static var ideSymbolOrangeBorder: Self { .init("ideSymbolOrangeBorder") }
//  static var ideSymbolPurple: Self { .init("ideSymbolPurple") }
//  static var ideSymbolPurpleBorder: Self { .init("ideSymbolPurpleBorder") }
//  static var ideSymbolRed: Self { .init("ideSymbolRed") }
//  static var ideSymbolRedBorder: Self { .init("ideSymbolRedBorder") }
//  static var ideSymbolTeal: Self { .init("ideSymbolTeal") }
//  static var ideSymbolTealBorder: Self { .init("ideSymbolTealBorder") }
//}

/// Specifies the color of an IDE icon.
///
/// ![](IDEIconColor) 
public enum IDEIconColor: String, CaseIterable {
  case monochrome
  case blue
  case brown
  case gray
  case green
  case orange
  case pink // TODO: either rename or make more pink
  case purple
  case red
  case teal
  case yellow

  // TODO: consider adding indigo, mint, and cyan
}

extension IDEIconColor {
  var backgroundColor: AdaptiveColor {
    switch self {
    case .monochrome: return AdaptiveColor(
      light: .white,
      dark: .black
    )
    case .blue: return AdaptiveColor(
      light: Color(red: 0.291, green: 0.588, blue: 0.998),
      dark: Color(red: 0.01, green: 0.199, blue: 0.417)
    )
    case .brown: return AdaptiveColor(
      light: Color(red: 0.714, green: 0.622, blue: 0.513),
      dark: Color(red: 0.271, green: 0.217, blue: 0.15)
    )
    case .gray: return AdaptiveColor(
      light: Color(red: 0.651, green: 0.651, blue: 0.667),
      dark: Color(red: 0.235, green: 0.235, blue: 0.243)
    )
    case .green: return AdaptiveColor(
      light: Color(red: 0.031, green: 0.763, blue: 0.394),
      dark: Color(red: 0.037, green: 0.281, blue: 0.075)
    )
    case .orange: return AdaptiveColor(
      light: Color(red: 0.94, green: 0.623, blue: 0.283),
      dark: Color(red: 0.378, green: 0.223, blue: 0.006)
    )
    case .pink: return AdaptiveColor(
      light: Color(red: 0.717, green: 0.309, blue: 0.69),
      dark: Color(red: 0.274, green: 0.082, blue: 0.286)
    )
    case .purple: return AdaptiveColor(
      light: Color(red: 0.704, green: 0.452, blue: 0.831),
      dark: Color(red: 0.302, green: 0.128, blue: 0.393)
    )
    case .red: return AdaptiveColor(
      light: Color(red: 1, green: 0.403, blue: 0.389),
      dark: Color(red: 0.415, green: 0.089, blue: 0.072)
    )
    case .teal: return AdaptiveColor(
      light: Color(red: 0.374, green: 0.684, blue: 0.748),
      dark: Color(red: 0.123, green: 0.254, blue: 0.292)
    )
    case .yellow: return AdaptiveColor(
      light: Color(red: 0.952, green: 0.85, blue: 0.501),
      dark: Color(red: 0.384, green: 0.298, blue: 0.043)
    )
    }
  }

  var borderColor: AdaptiveColor {
    switch self {
    case .monochrome: return AdaptiveColor(
      light: Color(red: 0.443, green: 0.443, blue: 0.462),
      dark: Color(red: 0.568, green: 0.564, blue: 0.592)
    )
    case .blue: return AdaptiveColor(
      light: Color(red: 0.051, green: 0.439, blue: 0.96),
      dark: Color(red: 0.077, green: 0.599, blue: 0.999)
    )
    case .brown: return AdaptiveColor(
      light: Color(red: 0.636, green: 0.517, blue: 0.37),
      dark: Color(red: 0.675, green: 0.556, blue: 0.409)
    )
    case .gray: return AdaptiveColor(
      light: Color(red: 0.596, green: 0.596, blue: 0.616),
      dark: Color(red: 0.557, green: 0.556, blue: 0.577)
    )
    case .green: return AdaptiveColor(
      light: Color(red: 0.103, green: 0.701, blue: 0.197),
      dark: Color(red: 0.157, green: 0.705, blue: 0.238)
    )
    case .orange: return AdaptiveColor(
      light: Color(red: 0.921, green: 0.521, blue: 0),
      dark: Color(red: 0.921, green: 0.572, blue: 0.028)
    )
    case .pink: return AdaptiveColor(
      light: Color(red: 0.647, green: 0.137, blue: 0.615),
      dark: Color(red: 0.807, green: 0.231, blue: 0.835)
    )
    case .purple: return AdaptiveColor(
      light: Color(red: 0.623, green: 0.293, blue: 0.789),
      dark: Color(red: 0.801, green: 0.394, blue: 0.999)
    )
    case .red: return AdaptiveColor(
      light: Color(red: 0.999, green: 0.23, blue: 0.19),
      dark: Color(red: 0.998, green: 0.272, blue: 0.228)
    )
    case .teal: return AdaptiveColor(
      light: Color(red: 0.161, green: 0.601, blue: 0.682),
      dark: Color(red: 0.339, green: 0.64, blue: 0.721)
    )
    case .yellow: return AdaptiveColor(
      light: Color(red: 0.749, green: 0.658, blue: 0.349),
      dark: Color(red: 0.929, green: 0.752, blue: 0.215)
    )
    }
  }

  var outlineColor: AdaptiveColor {
    AdaptiveColor(
      light: Color(white: 0.96, opacity: 0.75),
      dark: Color(white: 0, opacity: 0.5)
    )
  }
}
