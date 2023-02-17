import SwiftUI
import PreviewsCapture

class IDEIcon_Screenshots: PreviewProvider, ScreenshotProvider {
  static var previews: some View {
    IDEIcon_Previews.ReadMeLogo()
      .previewDisplayName("IDEIcons")
      .task { await ScreenshotController().saveAll() }
  }
}
