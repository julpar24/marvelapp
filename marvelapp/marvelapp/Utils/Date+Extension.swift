//
//  Date+Extension.swift
//  marvelapp
//
//  Created by Juliana Pardal on 03/09/2021.
//

import Foundation

extension Date {
    func dateInNaturalLanguage() -> String? {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "es_AR")
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        guard let year = components.year, let month = components.month, let day = components.day else { return nil }
        let monthName = calendar.monthSymbols[month - 1].capitalized
        return "\(day) de \(monthName) de \(year)"
    }
}
