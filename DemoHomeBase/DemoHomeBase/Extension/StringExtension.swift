//
//  StringExtension.swift
//  DemoHomeBase

extension String {
    
    func toDate(withFormat format: String = DateAndTimeFormatString.strDateFormate_yyyyMMddhhmmss)-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    func toDate (dateFormatter: DateFormatter) -> Date? {
        return dateFormatter.date(from: self)
    }
    

}
