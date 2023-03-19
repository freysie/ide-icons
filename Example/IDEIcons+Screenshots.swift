import SwiftUI
import IDEIcons
import Screenshotting
import ScreenshottingRNG

@available(macOS 13.0, iOS 16.0, watchOS 9.0, *)
class IDEIcons_Screenshots: PreviewProvider {
  static var previews: some View {
    IconGrid(horizontalSpacing: 3, verticalSpacing: 2, horizontalPadding: 4, verticalPadding: 5)//, iconSize: IDEIconSize.large)
      .padding()
      .frame(width: 304, height: 200)
      .background()
      .previewLayout(.sizeThatFits)
      .previewDisplayName("README Banner")
      .screenshot("IDEIcons")

    IconGrid(wordmarkStyle: .simpleHighlighted)
      .padding()
      .frame(width: 640, height: 320)
      .background()
      .previewLayout(.sizeThatFits)
      .previewDisplayName("GitHub Social Preview")
      .screenshot("GitHubSocialPreview", colorScheme: .dark, scale: 2)

    AllPermutations()
      .padding()
      .previewDisplayName("All Permutations")

    Alphabet()
      .padding()
      .previewDisplayName("Alphabet")

    Alphabet(size: 32)
      .padding()
      .previewDisplayName("Alphabet (32 pt)")
  }

  struct AllPermutations: View {
    var body: some View {
      HStack {
        ForEach(IDEIconColor.allCases, id: \.self) { color in
          VStack {
            ForEach([16, 20, 24, 32].reversed(), id: \.self) { size in
              ForEach([IDEIconStyle.default, IDEIconStyle.outline, IDEIconStyle.simple], id: \.self) { style in
                Image(IDEIcon("P", color: color, style: style, size: CGFloat(size)))
              }
            }
          }
        }
      }
    }
  }

  struct Alphabet: View {
    static var alphabet: [Character] {
      let aScalars = "A".unicodeScalars
      let aCode = aScalars[aScalars.startIndex].value
      return (0..<26).map { Character(Unicode.Scalar(aCode + $0) ?? aScalars[aScalars.startIndex]) }
    }

    var size = IDEIconSize.regular

    var body: some View {
      HStack(spacing: 2) { ForEach(Self.alphabet, id: \.self) { Image(IDEIcon(String($0), size: size)) } }
    }
  }

  struct IconGrid: View {
    var wordmark = "IDEIcons"
    var wordmarkStyle = IDEIconStyle.default
    var largeWordmark = false

    var horizontalSpacing = 4.0
    var verticalSpacing = 3.0

    var horizontalPadding = 12
    var verticalPadding = 8

    var numberOfColumns: Int { wordmark.count * (largeWordmark ? 2 : 1) + horizontalPadding * 2 }
    var numberOfRows: Int { wordmark.count * (largeWordmark ? 2 : 1) + verticalPadding * 2 }

    var iconSize = IDEIconSize.regular

    //@State var rng = Rand48RandomNumberGenerator(seed: 0x1)
    @State var rng = GKMersenneTwisterRandomSource(seed: 0x1)
    //@State var rng = Xoroshiro256StarStarRandomNumberGenerator(seed: (1, 0, 2, 4))
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
        ForEach(0..<verticalPadding, id: \.self) { _ in
          GridRow { ForEach(0..<numberOfColumns, id: \.self) { _ in example } }
        }

        GridRow {
          if largeWordmark {
            Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
              GridRow { ForEach(0..<horizontalPadding, id: \.self) { _ in example } }
              GridRow { ForEach(0..<horizontalPadding, id: \.self) { _ in example } }
            }
            .gridCellColumns(horizontalPadding)

            ForEach(Array(wordmark.uppercased().enumerated()), id: \.offset) { (_, c) in
              IconView(IDEIcon("\(c)", color: .monochrome, style: wordmarkStyle, size: 32))
                  .gridCellColumns(2)
            }

            Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
              GridRow { ForEach(0..<horizontalPadding, id: \.self) { _ in example } }
              GridRow { ForEach(0..<horizontalPadding, id: \.self) { _ in example } }
            }
            .gridCellColumns(horizontalPadding)
          } else {
            GridRow { ForEach(0..<horizontalPadding, id: \.self) { _ in example } }

            ForEach(Array(wordmark.uppercased().enumerated()), id: \.offset) { (_, c) in
              IconView(IDEIcon("\(c)", color: .monochrome, style: wordmarkStyle, size: iconSize))
            }

            GridRow { ForEach(0..<horizontalPadding, id: \.self) { _ in example } }
          }
        }

        ForEach(0..<verticalPadding, id: \.self) { _ in
          GridRow { ForEach(0..<numberOfColumns, id: \.self) { _ in example } }
        }
      }
    }

    var example: some View {
      //IconView(nextExample())
      var icon = Self.examples.randomElement(using: &rng)!
      icon.size = iconSize
      return IconView(icon)
      //Image(Self.examples.randomElement(using: &rng)!)
    }

    //@State var i = 0
    //func nextExample() -> IDEIcon {
    //  //Self.examples.randomElement(using: &rng)!
    //  //i += 1
    //  //if i >= Self.examples.count - 1 { i = -1 }
    //  //i += 1
    //  //if i >= Self.examples.count - 1 { i = 0 }
    //  //return Self.examples.next()
    //}

    static var examples = [
      IDEIcon("T", color: .orange),
      IDEIcon("E", color: .orange),
      IDEIcon("Ex", color: .orange),
      IDEIcon("K", color: .green),
      IDEIcon("L", color: .green),
      IDEIcon("⨍", color: .green),
      IDEIcon("#", color: .red),
      IDEIcon("C", color: .purple),
      IDEIcon("S", color: .purple),
      IDEIcon("Pr", color: .purple),
      IDEIcon("M", color: .blue),
      IDEIcon("P", color: .teal),
      //IDEIcon("@", color: .gray),
      IDEIcon(systemImage: "at", color: .gray),
      IDEIcon("{ }", color: .gray),
      //IDEIcon(systemImage: "list.bullet", color: .monochrome),

      IDEIcon("N", color: .purple),
      IDEIcon("S", color: .purple),
      IDEIcon("B", color: .purple),
      IDEIcon("D", color: .purple),
      IDEIcon(systemImage: "power", color: .purple),
      IDEIcon("#", color: .purple),
      IDEIcon(systemImage: "barcode", color: .purple),
      IDEIcon("U", color: .purple),
      IDEIcon("T", color: .purple),
      IDEIcon("Ti", color: .purple),
      IDEIcon("?", color: .purple),
      IDEIcon("O", color: .red),
      IDEIcon("M", color: .red),
      IDEIcon("F", color: .blue),
      IDEIcon("C", color: .gray),
      IDEIcon("R", color: .brown),
      IDEIcon("I", color: .brown),

      IDEIcon("O", color: .yellow),
      IDEIcon("A", color: .yellow),
      IDEIcon("S", color: .red),
      IDEIcon("N", color: .blue),
      IDEIcon("B", color: .purple),
      IDEIcon("N", color: .gray),

      IDEIcon("•", color: .purple),
      IDEIcon(systemImage: "rectangle.connected.to.line.below", color: .purple),
      IDEIcon(systemImage: "magnifyingglass", color: .purple),

      IDEIcon(systemImage: "gearshape.fill", color: .brown),
      IDEIcon(systemImage: "building.columns.fill", color: .brown),
      IDEIcon(systemImage: "puzzlepiece.fill", color: .yellow),
      IDEIcon(systemImage: "paintbrush.pointed.fill", color: .purple),
      IDEIcon(systemImage: "square.stack.3d.up.fill", color: .pink),
      IDEIcon(systemImage: "chevron.left.forwardslash.chevron.right", color: .pink),
      IDEIcon(systemImage: "latch.2.case.fill", color: .orange),
      IDEIcon(systemImage: "person.fill", color: .blue),

      //IDEIcon(systemImage: "tablecells", color: .teal),
      //IDEIcon(systemImage: "rectangle.and.text.magnifyingglass", color: .teal),
      //IDEIcon(systemImage: "scroll", color: .orange),
      //IDEIcon(systemImage: "bolt.fill", color: .orange),
    ]
      .flatMap {
        var o = $0
        o.style = .outline
        var s = $0
        s.style = .simple
        //return [s]
        return [s, $0, o]
      }
  }
}

extension String {
  static var alphabet: [Character] {
    let aScalars = "A".unicodeScalars
    let aCode = aScalars[aScalars.startIndex].value
    return (0..<26).map { i in Character(Unicode.Scalar(aCode + i) ?? aScalars[aScalars.startIndex]) }
  }
}

//struct ColorEnum: View {
//  var body: some View {
//    VStack(alignment: .leading) {
//      ForEach(IDEIconColor.allCases, id: \.self) { color in
//        Label("`.\(String(describing: color))`", IDEIcon("P", color: color))
////#if os(macOS)
////          ImageView(image: IDEIcon("P", color: color).image)
////#endif
//      }
//    }
//    .fixedSize()
//  }
//}
//
//struct StyleEnum: View {
//  var body: some View {
//    VStack(alignment: .leading) {
//      ForEach(IDEIconStyle.allCases, id: \.self) { style in
//        Label("`.\(String(describing: style))`", IDEIcon("P", style: style))
//      }
//    }
//    .fixedSize()
//  }
//}
