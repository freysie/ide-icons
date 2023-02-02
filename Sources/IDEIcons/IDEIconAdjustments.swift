import SwiftUI

extension IDEIcon {
  var fontWeight: PlatformFont.Weight {
    switch content {
    case .text(let string):
      switch string {
      case "#": return .light
      case "Ti": return .regular
      case "􀋲": return .black // FIXME: has no effect, it seems
      case "􀘱": return .ultraLight // FIXME: has no effect, it seems
      case "⨍": return .black // FIXME: has no effect
      default: break
      }
      
    default:
      break
    }
    
    return style.fontWeight
  }
  
  var fontSizeAdjustment: CGFloat {
    switch content {
    case .text(let string):
      switch string {
      case "@": return 1
      case "{}", "{ }": return -1
      case "#": return 2.5
      case "Ti": return 0.5
      case "⨍": return 0
      case "􀩲": return -1
      case "•": return 2
      default: break
      }
      
    default:
      break
    }
    
    return 0
  }
  
  var yOffsetAdjustment: CGFloat {
    switch content {
    case .text(let string):
      switch size {
      case .regular:
        switch string {
        case "@": return 1
        case "#": return 1
        case "{}", "{ }": return 0
        case "⨍": return 3
        case "􀋲": return 0
          // case "􀩲": xOffset = 0.5
        case "•": return 2
          //      case "Ti": return -2
        default: break
        }
      case .large:
        switch string {
        case "@": return 4
        case "#": return 3
        case "{}", "{ }": return 2.5
        case "⨍": return 4.5
        case "􀋲": return 1
          //      case "Ti": return -2
        default: break
        }
      }
      
    default:
      break
    }
    
    return 0
  }
}
