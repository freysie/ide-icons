import SwiftUI

@main
struct IDEIconsExampleApp: App {
  var body: some Scene {
    WindowGroup {
      HStack {
        //IDEIcons_Screenshots._allPreviews[0].content
        IDEIcons_Screenshots.previews
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.gray.opacity(0.5))
#if os(iOS)
      .statusBarHidden()
#endif
      .onAppear {
        for family in NSFontManager.shared.availableFontFamilies {
          print(family)
        }
      }
    }
  }
}
