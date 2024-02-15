//
//  Date+Ext.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/5/24.
//

import Foundation


extension Date {

    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
    
}
