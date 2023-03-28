import SwiftUI

@main
struct IDEIconsExampleApp: App {
  var body: some Scene {
    WindowGroup {
      VStack {
        //IDEIcons_Screenshots._allPreviews[0].content
        //IDEIcons_Screenshots.previews
        IDEIcons_Screenshots.Pangram()
        IDEIcons_Screenshots.Pangram(size: 32)
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
