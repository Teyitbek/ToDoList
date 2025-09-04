import Foundation

extension Date {
    init(timestampInSeconds timestamp: Int) {
        self.init(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    public func toString(format: String = "dd.MM.yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func isSameDayAndMonth(as date: Date) -> Bool {
        let components1 = self.get(.day, .month)
        let components2 = date.get(.day, .month)
        guard let month1 = components1.month,
              let month2 = components2.month,
              month1 == month2 else {
            return false
        }
        guard let day1 = components1.day,
              let day2 = components2.day,
              day1 == day2 else {
            return false
        }
        return true
    }
    
    private var calendar: Calendar { return .current }
    
    private var components: DateComponents {
        let unitFlags = Set<Calendar.Component>([.minute, .hour, .day])
        let now = Date()
        return calendar.dateComponents(unitFlags, from: self, to: now)
    }
    
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .numeric
        formatter.unitsStyle = .short
        formatter.formattingContext = .listItem
        formatter.locale = Locale(identifier: "ru")
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    public func isSameDate(date: Date) -> Bool {
        return Calendar.current.component(.year, from: self) == Calendar.current.component(.year, from: date) &&
        Calendar.current.component(.month, from: self) == Calendar.current.component(.month, from: date) &&
        Calendar.current.component(.day, from: self) == Calendar.current.component(.day, from: date)
    }
    
    func adding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }
    
    func isToday() -> Bool {
        calendar.isDateInToday(self)
    }
}

extension Date {
    var startOfWeek: Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let date = calendar.dateInterval(of: .weekOfMonth, for: self)?.start
        let dateWithHour = calendar.date(byAdding: .second, value: +1, to: date!)
        return dateWithHour
    }
    
    var endOfWeek: Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let date = calendar.dateInterval(of: .weekOfMonth, for: self)?.end
        let dateWithHour = calendar.date(byAdding: .second, value: -1, to: date!)
        return dateWithHour
    }
}
