//
//  DateFormatterExtension.swift
//  DemoHomeBase

extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
