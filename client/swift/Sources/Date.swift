import Foundation

extension Date {

    func getTimestampForToday() -> Int {
        let date = Calendar.current.startOfDay(for: Date())
        return Int(date.timeIntervalSince1970)
    }

}
