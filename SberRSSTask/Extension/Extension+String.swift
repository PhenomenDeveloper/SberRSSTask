//
//  Extension+String.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

extension String {
    
    var formattedDate: String {
        guard let date = DateFormatter.dateFormatFromXML.date(from: self) else { return "" }
        return DateFormatter.dateFormatForView.string(from: date)
    }
}
