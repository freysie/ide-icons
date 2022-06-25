import SwiftUI

struct IDEIcon_Previews: PreviewProvider {
//  static func screenshot(_ name: String, view: AnyView) {
//    let window = NSWindow()
//    let view = NSHostingView(rootView: view)
//    window.contentView = view
//
//    let imageRep = view.bitmapImageRepForCachingDisplay(in: view.bounds)
//    guard let imageRep = imageRep else {
//      preconditionFailure()
//    }
//
//    view.cacheDisplay(in: view.bounds, to: imageRep)
//
//    guard let data = imageRep.representation(using: .png, properties: [:]) else {
//      preconditionFailure()
//    }
//
//    try? data.write(to: URL(fileURLWithPath: "/Users/Freya/Projects/ide-icons/Screenshots/\(name).png"))
//  }
  
  struct ColorEnum: View {
    var colorScheme: ColorScheme
    var body: some View {
      VStack(alignment: .leading) {
        ForEach(IDEIconColor.allCases, id: \.self) { color in
          Label("`.\(String(describing: color))`", IDEIcon("P", color: color, colorScheme: colorScheme))
        }
      }
      .fixedSize()
    }
  }

  struct StyleEnum: View {
    var colorScheme: ColorScheme
    var body: some View {
      VStack(alignment: .leading) {
        ForEach(IDEIconStyle.allCases, id: \.self) { style in
          Label("`.\(String(describing: style))`", IDEIcon("P", colorScheme: colorScheme, style: style))
        }
      }
      .fixedSize()
    }
  }

  struct SizeEnum: View {
    var colorScheme: ColorScheme
    var body: some View {
      VStack(alignment: .leading) {
        ForEach(IDEIconSize.allCases, id: \.self) { size in
          Label("`.\(String(describing: size))`", IDEIcon("P", colorScheme: colorScheme, size: size))
        }
      }
      .fixedSize()
    }
  }

  struct ReadMeLogo: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
      VStack {
        HStack(spacing: 1) { DataTreeExamples(style: .outline) }
        HStack(spacing: 1) { DataModelExamples() }
        HStack(spacing: 1) { SourceCodeExamples(style: .outline) }
        HStack(alignment: .top, spacing: 2) {
          Image(IDEIcon("I", color: .purple, colorScheme: colorScheme, size: .large)).zIndex(8)
          Image(IDEIcon("D", color: .green, colorScheme: colorScheme, size: .large)).zIndex(7)
          Image(IDEIcon("E", color: .orange, colorScheme: colorScheme, size: .large)).zIndex(6)
          Image(IDEIcon("I", color: .blue, colorScheme: colorScheme, size: .large)).zIndex(5)
          Image(IDEIcon("C", color: .red, colorScheme: colorScheme, size: .large)).zIndex(4)
          Image(IDEIcon("O", color: .teal, colorScheme: colorScheme, size: .large)).zIndex(3)
          Image(IDEIcon("N", color: .brown, colorScheme: colorScheme, size: .large)).zIndex(2)
          Image(IDEIcon("S", color: .yellow, colorScheme: colorScheme, size: .large)).zIndex(1)
        }
        HStack(spacing: 1) { SourceCodeExamples() }
          .environment(\.layoutDirection, .rightToLeft)
        HStack(spacing: 1) { DataModelExamples(style: .outline) }
          .environment(\.layoutDirection, .rightToLeft)
        HStack(spacing: 1) { DataTreeExamples() }
          .environment(\.layoutDirection, .rightToLeft)
      }
      .padding()
      .labelStyle(.iconOnly)
    }
  }
  
  static var previews: some View {
    Group {
      ReadMeLogo().preferredColorScheme(.light)
      ReadMeLogo().preferredColorScheme(.dark)
    }
    
    ColorEnum(colorScheme: .dark)
      .padding()
      .preferredColorScheme(.dark)

//      .onAppear {
//        screenshot("IDEIconPreviewSourceCode", view: AnyView(VStack(alignment: .leading) { SourceCodeExamples() }))
//        screenshot("IDEIconPreviewDataModel", view: AnyView(VStack(alignment: .leading) { DataModelExamples() }))
//        screenshot("IDEIconPreviewDataTree", view: AnyView(VStack(alignment: .leading) { DataTreeExamples() }))
//        screenshot("IDEIconPreviewDatabase", view: AnyView(VStack(alignment: .leading) { DatabaseExamples() }))
//
//        //      for color in IDEIconColor.allCases {
//        //        // screenshot("IDEIconColor.\(color)", view: AnyView(Image(IDEIcon("\(color)".first!.uppercased(), color: color))))
//        //        screenshot("IDEIconColor.\(color)~light", view: AnyView(Image(IDEIcon("P", color: color, colorScheme: .light))))
//        //        screenshot("IDEIconColor.\(color)~dark", view: AnyView(Image(IDEIcon("P", color: color, colorScheme: .dark))))
//        //      }
//
//        screenshot("IDEIcons~light", view: AnyView(Logo(colorScheme: .light)))
//        screenshot("IDEIcons~dark", view: AnyView(Logo(colorScheme: .dark)))
//
//        screenshot("IDEIconColor~light", view: AnyView(ColorEnum(colorScheme: .light)))
//        screenshot("IDEIconColor~dark", view: AnyView(ColorEnum(colorScheme: .dark)))
//        screenshot("IDEIconStyle~light", view: AnyView(StyleEnum(colorScheme: .light)))
//        screenshot("IDEIconStyle~dark", view: AnyView(StyleEnum(colorScheme: .dark)))
//        screenshot("IDEIconSize~light", view: AnyView(SizeEnum(colorScheme: .light)))
//        screenshot("IDEIconSize~dark", view: AnyView(SizeEnum(colorScheme: .dark)))
//
//        //      screenshot("IDEIconSize.regular", view: AnyView(Image(IDEIcon("P", size: .regular))))
//        //      screenshot("IDEIconSize.large", view: AnyView(Image(IDEIcon("P", size: .large))))
//        //
//        //      screenshot("IDEIconStyle.default", view: AnyView(Image(IDEIcon("P", style: .default))))
//        //      screenshot("IDEIconStyle.outline", view: AnyView(Image(IDEIcon("P", style: .outline))))
//        //      screenshot("IDEIconStyle.default~large", view: AnyView(Image(IDEIcon("P", style: .default, size: .large))))
//        //      screenshot("IDEIconStyle.outline~large", view: AnyView(Image(IDEIcon("P", style: .outline, size: .large))))
//      }

    HStack(spacing: 2) {
      ForEach(String.alphabet, id: \.self) {
        Image(IDEIcon(String($0)))
      }
    }
    .padding()
    .labelStyle(.iconOnly)
    .preferredColorScheme(.dark)
    
    Group {
      HStack(alignment: .top, spacing: 50) {
        VStack(alignment: .leading) { DebuggerExamples() }
        VStack(alignment: .leading) { DebuggerExamples(size: .large) }
      }
      .padding()
      .preferredColorScheme(.dark)

      HStack(alignment: .top, spacing: 50) {
        VStack(alignment: .leading) { DebuggerExamples() }
        VStack(alignment: .leading) { DebuggerExamples(size: .large) }
      }
      .padding()
      .preferredColorScheme(.light)
    }

    Group {
      HStack(alignment: .top, spacing: 50) {
        VStack(alignment: .leading) { DatabaseObjectExamples() }
        VStack(alignment: .leading) { DatabaseObjectExamples(size: .large) }
      }
      .padding()
      .preferredColorScheme(.dark)

      HStack(alignment: .top, spacing: 50) {
        VStack(alignment: .leading) { DatabaseObjectExamples() }
        VStack(alignment: .leading) { DatabaseObjectExamples(size: .large) }
      }
      .padding()
      .preferredColorScheme(.light)
    }

    HStack(alignment: .top, spacing: 50) {
      VStack(alignment: .leading) { SourceCodeExamples() }
      VStack(alignment: .leading) { DataModelExamples() }
      VStack(alignment: .leading) { DataTreeExamples(); DatabaseExamples() }
    }
    .padding()
    .preferredColorScheme(.dark)

    HStack(alignment: .top, spacing: 50) {
      VStack(alignment: .leading) { SourceCodeExamples(style: .outline) }
      VStack(alignment: .leading) { DataModelExamples(style: .outline) }
      VStack(alignment: .leading) { DataTreeExamples(style: .outline) }
    }
    .padding()
    .preferredColorScheme(.dark)

    HStack(alignment: .top, spacing: 50) {
      VStack(alignment: .leading) { SourceCodeExamples(size: .large) }
      VStack(alignment: .leading) { DataModelExamples(size: .large) }
      VStack(alignment: .leading) { DataTreeExamples(size: .large) }
    }
    .padding()
    .preferredColorScheme(.dark)

    HStack(alignment: .top, spacing: 50) {
      VStack(alignment: .leading) { SourceCodeExamples() }
      VStack(alignment: .leading) { DataModelExamples() }
      VStack(alignment: .leading) { DataTreeExamples() }
    }
    .padding()
    .preferredColorScheme(.light)

    HStack(alignment: .top, spacing: 50) {
      VStack(alignment: .leading) { SourceCodeExamples(size: .large) }
      VStack(alignment: .leading) { DataModelExamples(size: .large) }
      VStack(alignment: .leading) { DataTreeExamples(size: .large) }
    }
    .padding()
    .preferredColorScheme(.light)
  }

  struct SourceCodeExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      Group {
        Label("Type", IDEIcon("T", color: .orange, colorScheme: colorScheme, style: style, size: size))
        Label("Enum", IDEIcon("E", color: .orange, colorScheme: colorScheme, style: style, size: size))
        Label("Extension", IDEIcon("Ex", color: .orange, colorScheme: colorScheme, style: style, size: size))
      }

      Group {
        Label("Constant", IDEIcon("K", color: .green, colorScheme: colorScheme, style: style, size: size))
        Label("Local", IDEIcon("L", color: .green, colorScheme: colorScheme, style: style, size: size))
        Label("Function", IDEIcon("⨍", color: .green, colorScheme: colorScheme, style: style, size: size))
      }

      Label("Macro", IDEIcon("#", color: .red, colorScheme: colorScheme, style: style, size: size))

      Group {
        Label("Class", IDEIcon("C", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("Struct", IDEIcon("S", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("Protocol", IDEIcon("Pr", color: .purple, colorScheme: colorScheme, style: style, size: size))
      }

      Group {
        Label("Method", IDEIcon("M", color: .blue, colorScheme: colorScheme, style: style, size: size))
        Label("Property", IDEIcon("P", color: .teal, colorScheme: colorScheme, style: style, size: size))
      }

      Group {
        Label("Keyword", IDEIcon("@", color: .gray, colorScheme: colorScheme, style: style, size: size))
//        Label("Snippet", IDEIcon("{}", color: .gray, colorScheme: colorScheme, style: style, size: size))
        Label("Snippet", IDEIcon("{ }", color: .gray, colorScheme: colorScheme, style: style, size: size))
//        Label("Snippet", IDEIcon("􀡅", color: .gray, colorScheme: colorScheme, style: style, size: size))
        // Label("Snippet", IDEIcon(systemImage: "at", color: .gray, colorScheme: colorScheme, style: style, size: size))
        // Label("Snippet", IDEIcon(systemImage: "curlybraces", color: .gray, colorScheme: colorScheme, style: style, size: size))
      }

      Label("Comment", IDEIcon("􀋲", color: .monochrome, colorScheme: colorScheme, style: style, size: size))
//      / Label("Comment", IDEIcon(systemImage: "list.bullet", color: .monochrome, colorScheme: colorScheme, style: style, size: size))
    }
  }

  struct DataModelExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      Group {
        Label("Undefined", IDEIcon("?", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("Number", IDEIcon("N", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("String", IDEIcon("S", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("Boolean", IDEIcon("B", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("Date", IDEIcon("D", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Group {
          Label("Binary Data", IDEIcon("􀆨", color: .purple, colorScheme: colorScheme, style: style, size: size))
          // Label("Binary Data", IDEIcon(systemImage: "power", color: .purple, colorScheme: colorScheme, style: style, size: size))
        }
        Group {
          Label("UUID", IDEIcon("#", color: .purple, colorScheme: colorScheme, style: style, size: size))
          // Label("UUID", IDEIcon("􀘱", color: .purple, colorScheme: colorScheme, style: style, size: size)) // FIXME
          // Label("UUID", IDEIcon(systemImage: "barcode", color: .purple, colorScheme: colorScheme, style: style, size: size))
        }
        Label("URI", IDEIcon("U", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("Transformable", IDEIcon("T", color: .purple, colorScheme: colorScheme, style: style, size: size))
        Label("Time Interval", IDEIcon("Ti", color: .purple, colorScheme: colorScheme, style: style, size: size))
      }

      Group {
        Label("To One", IDEIcon("O", color: .red, colorScheme: colorScheme, style: style, size: size))
        Label("To Many", IDEIcon("M", color: .red, colorScheme: colorScheme, style: style, size: size))
      }

      Group {
        Label("Fetched Property", IDEIcon("F", color: .blue, colorScheme: colorScheme, style: style, size: size))
        Label("Configuration", IDEIcon("C", color: .gray, colorScheme: colorScheme, style: style, size: size))
        Label("Fetch Request", IDEIcon("R", color: .brown, colorScheme: colorScheme, style: style, size: size))
        Label("Fetch Index", IDEIcon("I", color: .brown, colorScheme: colorScheme, style: style, size: size))
      }
    }
  }

  struct DataTreeExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      Label("Object", IDEIcon("O", color: .yellow, colorScheme: colorScheme, style: style, size: size))
      Label("Array", IDEIcon("A", color: .yellow, colorScheme: colorScheme, style: style, size: size))
      Label("String", IDEIcon("S", color: .red, colorScheme: colorScheme, style: style, size: size))
      Label("Number", IDEIcon("N", color: .blue, colorScheme: colorScheme, style: style, size: size))
      Label("Boolean", IDEIcon("B", color: .purple, colorScheme: colorScheme, style: style, size: size))
      Label("Null", IDEIcon("N", color: .gray, colorScheme: colorScheme, style: style, size: size))
    }
  }

  struct DatabaseExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      Label("Point", IDEIcon("•", color: .purple, colorScheme: colorScheme, style: style, size: size))
      Label("IP Address", IDEIcon("􀩲", color: .purple, colorScheme: colorScheme, style: style, size: size))
      Label("TS Vector", IDEIcon("􀊫", color: .purple, colorScheme: colorScheme, style: style, size: size))
    }
  }

  struct DebuggerExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      // building.columns.fill
      // puzzlepiece.fill
      // paintbrush.pointed.fill
      // square.stack.3d.up.fill
      Label("Address", IDEIcon("􀣌", color: .brown, colorScheme: colorScheme, style: style, size: size))
      Label("Library", IDEIcon("􀤩", color: .brown, colorScheme: colorScheme, style: style, size: size))
      Label("Piece", IDEIcon("􀤛", color: .yellow, colorScheme: colorScheme, style: style, size: size))
      Label("Brush", IDEIcon("􀣷", color: .purple, colorScheme: colorScheme, style: style, size: size))
      Label("Layers", IDEIcon("􀐟", color: .pink, colorScheme: colorScheme, style: style, size: size))
      Label("Core", IDEIcon("􀙚", color: .pink, colorScheme: colorScheme, style: style, size: size))
      Label("Framework", IDEIcon("􀢠", color: .orange, colorScheme: colorScheme, style: style, size: size))
      // Label("Framework", IDEIcon("􀢠", color: .red, colorScheme: colorScheme, style: style, size: size))
      Label("User", IDEIcon("􀉪", color: .blue, colorScheme: colorScheme, style: style, size: size))
    }
  }

  struct DatabaseObjectExamples: View {
    var size = IDEIconSize.regular
    var style = IDEIconStyle.default
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      Group {
        Label("Table", IDEIcon("􀏣", color: .teal, colorScheme: colorScheme, style: style, size: size))
        Label("View", IDEIcon("􀬸", color: .teal, colorScheme: colorScheme, style: style, size: size))
        Label("Procedure", IDEIcon("􀤏", color: .orange, colorScheme: colorScheme, style: style, size: size))
        Label("Trigger", IDEIcon("􀋦", color: .orange, colorScheme: colorScheme, style: style, size: size))
      }
      
      Group {
        Label("Table", IDEIcon("􀏣", color: .monochrome, colorScheme: colorScheme, style: style, size: size))
        Label("View", IDEIcon("􀬸", color: .monochrome, colorScheme: colorScheme, style: style, size: size))
        Label("Procedure", IDEIcon("􀤏", color: .monochrome, colorScheme: colorScheme, style: style, size: size))
        Label("Trigger", IDEIcon("􀋦", color: .monochrome, colorScheme: colorScheme, style: style, size: size))
      }
      
      // Label("Table", IDEIcon(systemImage: "tablecells", color: .teal, colorScheme: colorScheme, style: style, size: size))
      // Label("View", IDEIcon(systemImage: "rectangle.and.text.magnifyingglass", color: .teal, colorScheme: colorScheme, style: style, size: size))
      // Label("Procedure", IDEIcon(systemImage: "scroll", color: .orange, colorScheme: colorScheme, style: style, size: size))
      // Label("Trigger", IDEIcon(systemImage: "bolt.fill", color: .orange, colorScheme: colorScheme, style: style, size: size))
    }
  }
}
