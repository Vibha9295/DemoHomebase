//
//  DateExtenstion.swift
//  DemoHomeBase

extension Date {
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    func stringValueForDate()-> String?{
       
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = DateAndTimeFormatString.strDateFormate_MMdd
        return formatter.string(from: self)
        
        
    }
    func stringValueForDay()-> String?{
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = DateAndTimeFormatString.strDateFormate_EEE
        return formatter.string(from: self)
    }
    func stringValueForTime()-> String?{
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "h a"
        return formatter.string(from: self)
    }
    func stringValueStartTime()-> String?{
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "h"
        return formatter.string(from: self)
    }
   
}
