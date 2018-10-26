
import UIKit

enum ColorHelper: String {
    case red = "Red"
    case green = "Green"
    case blue = "Blue"
    case grey = "Grey"
    case yellow = "Yellow"
    case bgGrey = "BgGrey"
    case clear = "Clear"
    
    func color() -> UIColor {
        switch self {
        case .red:
            return UIColor(red:0.96, green:0.52, blue:0.56, alpha:1.0)
        case .green:
            return UIColor(red:0.75, green:0.89, blue:0.79, alpha:1.0)
        case .blue:
            return UIColor(red:0.65, green:0.85, blue:0.94, alpha:1.0)
        case .grey:
            return UIColor(red:0.82, green:0.89, blue:0.93, alpha:1.0)
        case .yellow:
            return UIColor(red:1.00, green:0.85, blue:0.56, alpha:1.0)
        case .bgGrey:
            return UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        case .clear:
            return UIColor.clear
        }
    }
    
    static func color(from string: String) -> UIColor {
        if let c = self.init(rawValue: string) {
            return c.color()
        }
        
        // yellow to be clear that string does not match defined color constants
        return UIColor.yellow
    }
    
}
