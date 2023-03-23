import SwiftUI

extension IDEIcon {
  var fontWeight: PlatformFont.Weight {
    switch content {
    case .text(let string):
      switch string {
      case "#": return .light
      case "Ti": return .regular
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
      //case "#": return 2.5
      //case "Ti": return 0.5
      case "⨍": return 0
      case "•": return 2.5
      default: break
      }

    case .systemImage(let name) :
      switch name {
      case "puzzlepiece.fill": return -1
      case "rectangle.connected.to.line.below": return -0.1
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
      if size <= IDEIconSize.regular {
        switch string {
        case "@": return 1
        case "#": return 0
        case "{}", "{ }": return 1
        case "⨍": return 1
          // case "􀩲": xOffset = 0.5
        case "•": return 1
          //      case "Ti": return -2
        default: break
        }
      } else {
        switch string {
        case "@": return 4
        case "#": return 3
        case "{}", "{ }": return 2.5
        case "⨍": return 4.5
          //      case "Ti": return -2
        default: break
        }
      }

    case .systemImage(let name) :
      switch name {
      case "list.bullet": return 1
      case "rectangle.connected.to.line.below": return -0.3
      default: break
      }

    default:
      break
    }
    
    return 0
  }
}
