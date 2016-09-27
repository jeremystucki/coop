import Foundation

extension String {

    var bold: String {
        return "\u{001B}[1m\(self)\u{001B}[0m"
    }

    var blue: String {
        return "\u{001B}[36m\(self)\u{001B}[0m"
    }

}
