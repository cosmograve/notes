//
//  Support.swift
//  Notes
//
//  Created by Алексей Авер on 05.02.2023.
//

import Foundation

func getStringDate(currentDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM YYYY, HH:mm:ss"
    let dateString = dateFormatter.string(from: currentDate)
    return dateString
}
