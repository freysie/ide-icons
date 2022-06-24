import SwiftUI
import PreviewScreenshots

struct IDEIcon_PreviewScreenshots: PreviewProvider {
  static var previews: some View {
    ScreenshotGroup("../../Screenshots", relativeTo: #filePath) {
      IDEIcon_Previews.ReadMeLogo(colorScheme: .light).screenshotName("IDEIcons~light")
      IDEIcon_Previews.ReadMeLogo(colorScheme: .dark).screenshotName("IDEIcons~dark")
    }
  }
}
