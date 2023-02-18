import SwiftUI

struct IDEIcon_Previews: PreviewProvider {
  struct ColorEnum: View {
    var body: some View {
      VStack(alignment: .leading) {
        ForEach(IDEIconColor.allCases, id: \.self) { color in
          Label("`.\(String(describing: color))`", IDEIcon("P", color: color))
//#if os(macOS)
//          ImageView(image: IDEIcon("P", color: color).image)
//#endif
        }
      }
      .fixedSize()
    }
  }

  struct StyleEnum: View {
    var body: some View {
      VStack(alignment: .leading) {
        ForEach(IDEIconStyle.allCases, id: \.self) { style in
          Label("`.\(String(describing: style))`", IDEIcon("P", style: style))
        }
      }
      .fixedSize()
    }
  }

  struct SizeEnum: View {
    var body: some View {
      VStack(alignment: .leading) {
        ForEach([10, 14, 16, 20, 24, 32, 40, 48, 64, 96], id: \.self) { size in
          Label("\(size) pt", IDEIcon("P", size: CGFloat(size)))
        }
      }
      .fixedSize()
    }
  }

  struct ReadMeLogo: View {
    var simple = false

    var style: IDEIconStyle { simple ? .simple : .default }
    var altStyle: IDEIconStyle { simple ? .simpleHighlighted : .outline }

    var body: some View {
      VStack {
        HStack(spacing: 2) { DataTreeExamples(style: altStyle) }
        HStack(spacing: 2) { SourceCodeExamples(style: style) }
        HStack(spacing: 2) { DataModelExamples(style: altStyle) }
        HStack(alignment: .top, spacing: 2) {
          Image(IDEIcon("I", color: .purple, style: style, size: 32)).zIndex(9)
          Image(IDEIcon("D", color: .green, style: style, size: 32)).zIndex(8)
          Image(IDEIcon("E", color: .orange, style: style, size: 32)).zIndex(7)
          Image(IDEIcon("I", color: .blue, style: style, size: 32)).zIndex(6)
          Image(IDEIcon("C", color: .red, style: style, size: 32)).zIndex(5)
          Image(IDEIcon("O", color: .teal, style: style, size: 32)).zIndex(4)
          Image(IDEIcon("N", color: .brown, style: style, size: 32)).zIndex(3)
          Image(IDEIcon("S", color: .yellow, style: style, size: 32)).zIndex(2)

          //Image(IDEIcon("S", color: .blue, size: 32)).zIndex(6)
          //Image(IDEIcon("Y", color: .red, size: 32)).zIndex(5)
          //Image(IDEIcon("M", color: .teal, size: 32)).zIndex(4)
          //Image(IDEIcon("B", color: .brown, size: 32)).zIndex(3)
          //Image(IDEIcon("O", color: .yellow, size: 32)).zIndex(2)
          //Image(IDEIcon("L", color: .gray, size: 32)).zIndex(1)
          //Image(IDEIcon("S", color: .pink, size: 32)).zIndex(0)
        }
        HStack(spacing: 2) { DataModelExamples(style: style) }
          //.environment(\.layoutDirection, .rightToLeft)
        HStack(spacing: 2) { SourceCodeExamples(style: altStyle) }
          //.environment(\.layoutDirection, .rightToLeft)
        HStack(spacing: 2) { DataTreeExamples(style: style) }
          //.environment(\.layoutDirection, .rightToLeft)

        // Group {
        //   HStack(spacing: 2) { SourceCodeExamples(style: .simple) }
        //   HStack(spacing: 2) { DataModelExamples(style: .simple) }
        //   HStack(spacing: 2) { DataTreeExamples(style: .simple) }
        //   HStack(spacing: 2) { DataTreeExamples(style: .simpleHighlighted) }
        // }
      }
      .padding()
      .labelStyle(.iconOnly)
    }
  }

  static var previews: some View {
    Group {
      ReadMeLogo(simple: true).previewDisplayName("Logo (Simple)")//.background(.pink)
      ReadMeLogo().previewDisplayName("Logo")
    }
    
    ColorEnum()
      .padding()
      .previewDisplayName("Colors")

    SizeEnum()
      .padding()
      .previewDisplayName("Sizes")

    StyleEnum()
      .padding()
      .previewDisplayName("Styles")

    HStack(spacing: 2) {
      ForEach(String.alphabet, id: \.self) {
        Image(IDEIcon(String($0)))
      }
    }
    .padding()
    .labelStyle(.iconOnly)
    .previewDisplayName("Alphabet")

    Group {
      HStack(alignment: .top, spacing: 50) {
        VStack(alignment: .leading) { DebuggerExamples() }
        VStack(alignment: .leading) { DebuggerExamples(size: 32) }
      }
      .padding()
      .previewDisplayName("Debugger Examples")

      HStack(alignment: .top, spacing: 50) {
        VStack(alignment: .leading) { DatabaseObjectExamples() }
        VStack(alignment: .leading) { DatabaseObjectExamples(size: 32) }
      }
      .padding()
      .previewDisplayName("Database Object Examples")

      HStack(alignment: .top, spacing: 50) {
        VStack(alignment: .leading) { DatabaseExamples() }
        VStack(alignment: .leading) { DatabaseExamples(size: 32) }
      }
      .padding()
      .previewDisplayName("Database Examples")
    }

//    HStack(alignment: .top, spacing: 50) {
//      VStack(alignment: .leading) { SourceCodeExamples() }
//      VStack(alignment: .leading) { DataModelExamples() }
//      VStack(alignment: .leading) { DataTreeExamples(); DatabaseExamples() }
//    }
//    .padding()
//    .preferredColorScheme(.dark)
//
//    HStack(alignment: .top, spacing: 50) {
//      VStack(alignment: .leading) { SourceCodeExamples(style: .outline) }
//      VStack(alignment: .leading) { DataModelExamples(style: .outline) }
//      VStack(alignment: .leading) { DataTreeExamples(style: .outline) }
//    }
//    .padding()
//    .preferredColorScheme(.dark)
//
//    HStack(alignment: .top, spacing: 50) {
//      VStack(alignment: .leading) { SourceCodeExamples(size: 32) }
//      VStack(alignment: .leading) { DataModelExamples(size: 32) }
//      VStack(alignment: .leading) { DataTreeExamples(size: 32) }
//    }
//    .padding()
//    .preferredColorScheme(.dark)
//
//    HStack(alignment: .top, spacing: 50) {
//      VStack(alignment: .leading) { SourceCodeExamples() }
//      VStack(alignment: .leading) { DataModelExamples() }
//      VStack(alignment: .leading) { DataTreeExamples() }
//    }
//    .padding()
//    .preferredColorScheme(.light)
//
//    HStack(alignment: .top, spacing: 50) {
//      VStack(alignment: .leading) { SourceCodeExamples(size: 32) }
//      VStack(alignment: .leading) { DataModelExamples(size: 32) }
//      VStack(alignment: .leading) { DataTreeExamples(size: 32) }
//    }
//    .padding()
//    .preferredColorScheme(.light)
  }

  struct SourceCodeExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default
    // @Environment(\.colorScheme) var colorScheme

    var body: some View {
      Group {
        Label("Type", IDEIcon("T", color: .orange, style: style, size: size))
        Label("Enum", IDEIcon("E", color: .orange, style: style, size: size))
        Label("Extension", IDEIcon("Ex", color: .orange, style: style, size: size))
      }

      Group {
        Label("Constant", IDEIcon("K", color: .green, style: style, size: size))
        Label("Local", IDEIcon("L", color: .green, style: style, size: size))
        Label("Function", IDEIcon("⨍", color: .green, style: style, size: size))
      }

      Label("Macro", IDEIcon("#", color: .red, style: style, size: size))

      Group {
        Label("Class", IDEIcon("C", color: .purple, style: style, size: size))
        Label("Struct", IDEIcon("S", color: .purple, style: style, size: size))
        Label("Protocol", IDEIcon("Pr", color: .purple, style: style, size: size))
      }

      Group {
        Label("Method", IDEIcon("M", color: .blue, style: style, size: size))
        Label("Property", IDEIcon("P", color: .teal, style: style, size: size))
      }

      Group {
        Label("Keyword", IDEIcon("@", color: .gray, style: style, size: size))
//        Label("Snippet", IDEIcon("{}", color: .gray, style: style, size: size))
        Label("Snippet", IDEIcon("{ }", color: .gray, style: style, size: size))
//        Label("Snippet", IDEIcon("􀡅", color: .gray, style: style, size: size))
        // Label("Snippet", IDEIcon(systemImage: "at", color: .gray, style: style, size: size))
        // Label("Snippet", IDEIcon(systemImage: "curlybraces", color: .gray, style: style, size: size))
      }

      //Label("Comment", IDEIcon("􀋲", color: .monochrome, style: style, size: size))
      Label("Comment", IDEIcon(systemImage: "list.bullet", color: .monochrome, style: style, size: size))
    }
  }

  struct DataModelExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default

    var body: some View {
      Group {
        Label("Number", IDEIcon("N", color: .purple, style: style, size: size))
        Label("String", IDEIcon("S", color: .purple, style: style, size: size))
        Label("Boolean", IDEIcon("B", color: .purple, style: style, size: size))
        Label("Date", IDEIcon("D", color: .purple, style: style, size: size))
        Group {
          Label("Binary Data", IDEIcon(systemImage: "power", color: .purple, style: style, size: size))
        }
        Group {
          Label("UUID", IDEIcon("#", color: .purple, style: style, size: size))
          Label("UUID", IDEIcon(systemImage: "barcode", color: .purple, style: style, size: size))
        }
        Label("URI", IDEIcon("U", color: .purple, style: style, size: size))
        Label("Transformable", IDEIcon("T", color: .purple, style: style, size: size))
        Label("Time Interval", IDEIcon("Ti", color: .purple, style: style, size: size))
        Label("Undefined", IDEIcon("?", color: .purple, style: style, size: size))
      }

      Group {
        Label("To One", IDEIcon("O", color: .red, style: style, size: size))
        Label("To Many", IDEIcon("M", color: .red, style: style, size: size))
      }

      Group {
        Label("Fetched Property", IDEIcon("F", color: .blue, style: style, size: size))
        Label("Configuration", IDEIcon("C", color: .gray, style: style, size: size))
        Label("Fetch Request", IDEIcon("R", color: .brown, style: style, size: size))
        Label("Fetch Index", IDEIcon("I", color: .brown, style: style, size: size))
      }
    }
  }

  struct DataTreeExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default

    var body: some View {
      Label("Object", IDEIcon("O", color: .yellow, style: style, size: size))
      Label("Array", IDEIcon("A", color: .yellow, style: style, size: size))
      Label("String", IDEIcon("S", color: .red, style: style, size: size))
      Label("Number", IDEIcon("N", color: .blue, style: style, size: size))
      Label("Boolean", IDEIcon("B", color: .purple, style: style, size: size))
      Label("Null", IDEIcon("N", color: .gray, style: style, size: size))
    }
  }

  struct DatabaseExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default

    var body: some View {
      Label("Point", IDEIcon("•", color: .purple, style: style, size: size))
      // Label("IP Address", IDEIcon("􀩲", color: .purple, style: style, size: size))
      // Label("TS Vector", IDEIcon("􀊫", color: .purple, style: style, size: size))
      Label("Point", IDEIcon(systemImage: "smallcircle.filled.circle", color: .purple, style: style, size: size))
      Label("IP Address", IDEIcon(systemImage: "rectangle.connected.to.line.below", color: .purple, style: style, size: size))
      Label("TS Vector", IDEIcon(systemImage: "magnifyingglass", color: .purple, style: style, size: size))
    }
  }

  struct DebuggerExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default

    var body: some View {
      Label("Address", IDEIcon(systemImage: "gearshape.fill", color: .brown, style: style, size: size))
      Label("Library", IDEIcon(systemImage: "building.columns.fill", color: .brown, style: style, size: size))
      Label("Piece", IDEIcon(systemImage: "puzzlepiece.fill", color: .yellow, style: style, size: size))
      Label("Brush", IDEIcon(systemImage: "paintbrush.pointed.fill", color: .purple, style: style, size: size))
      Label("Layers", IDEIcon(systemImage: "square.stack.3d.up.fill", color: .pink, style: style, size: size))
      Label("Core", IDEIcon(systemImage: "chevron.left.forwardslash.chevron.right", color: .pink, style: style, size: size))
      Label("Framework", IDEIcon(systemImage: "latch.2.case.fill", color: .orange, style: style, size: size))
      // Label("Framework", IDEIcon(systemImage: "latch.2.case.fill", color: .red, style: style, size: size))
      Label("User", IDEIcon(systemImage: "person.fill", color: .blue, style: style, size: size))
    }
  }

  struct DatabaseObjectExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default

    var body: some View {
      Group {
        Label("Table", IDEIcon("􀏣", color: .teal, style: style, size: size))
        Label("View", IDEIcon("􀬸", color: .teal, style: style, size: size))
        Label("Procedure", IDEIcon("􀤏", color: .orange, style: style, size: size))
        Label("Trigger", IDEIcon("􀋦", color: .orange, style: style, size: size))

        Label("Table", IDEIcon(systemImage: "tablecells", color: .teal, style: style, size: size))
        Label("View", IDEIcon(systemImage: "rectangle.and.text.magnifyingglass", color: .teal, style: style, size: size))
        Label("Procedure", IDEIcon(systemImage: "scroll", color: .orange, style: style, size: size))
        Label("Trigger", IDEIcon(systemImage: "bolt.fill", color: .orange, style: style, size: size))
      }
      
      Group {
        Label("Table", IDEIcon("􀏣", color: .monochrome, style: style, size: size))
        Label("View", IDEIcon("􀬸", color: .monochrome, style: style, size: size))
        Label("Procedure", IDEIcon("􀤏", color: .monochrome, style: style, size: size))
        Label("Trigger", IDEIcon("􀋦", color: .monochrome, style: style, size: size))

        Label("Table", IDEIcon(systemImage: "tablecells", color: .monochrome, style: style, size: size))
        Label("View", IDEIcon(systemImage: "rectangle.and.text.magnifyingglass", color: .monochrome, style: style, size: size))
        Label("Procedure", IDEIcon(systemImage: "scroll", color: .monochrome, style: style, size: size))
        Label("Trigger", IDEIcon(systemImage: "bolt.fill", color: .monochrome, style: style, size: size))
      }
      
      // Label("Table", IDEIcon(systemImage: "tablecells", color: .teal, style: style, size: size))
      // Label("View", IDEIcon(systemImage: "rectangle.and.text.magnifyingglass", color: .teal, style: style, size: size))
      // Label("Procedure", IDEIcon(systemImage: "scroll", color: .orange, style: style, size: size))
      // Label("Trigger", IDEIcon(systemImage: "bolt.fill", color: .orange, style: style, size: size))
    }
  }
}
