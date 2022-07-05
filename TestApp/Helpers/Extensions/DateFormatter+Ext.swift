//
//  DateFormatter+Ext.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import Foundation

extension DateFormatter {
    func inStatFormatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}
