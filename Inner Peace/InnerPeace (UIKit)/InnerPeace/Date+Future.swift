//
//  Date+Future.swift
//  InnerPeace
//
//  Created by Valerie 👩🏼‍💻 on 05/05/2021.
//

import Foundation

extension Date {
    func byAdding(days: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        
       return Calendar.current.date(byAdding: dateComponents, to: self) ?? self
    }
}
