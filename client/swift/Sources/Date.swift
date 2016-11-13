import Foundation

extension Date {

    func getTimestampForToday() -> Int {
        let date = Calendar.current.startOfDay(for: Date())

        // Seriously, I have no idea
        #if os(Linux)
            return Int(date.timeIntervalSince1970) - 7200
        #else
            return Int(date.timeIntervalSince1970)
        #endif
    }

}
