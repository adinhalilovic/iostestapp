import UIKit

struct Constants {
    
    struct Device {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
        static let smallerScreens = (Device.height <= 568.0)
        static let iphone6Size = (Device.height <= 667.0)
    }
    
}

