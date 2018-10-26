
import Foundation

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return  formatter.string(from: self as Date)
    }
    
    var formatTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return  formatter.string(from: self as Date)
    }
}
