//
//  MovieCreationViewModel.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/15/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import Foundation
import UIKit

internal class MovieCreationViewModel {
    internal var poster: UIImage?
    internal var title: String = ""
    internal var overview: String = ""
    internal var dateRawString: String = ""
    internal var shouldSave: Bool {
        return formattedDate != nil && !title.isEmpty && !overview.isEmpty
    }
    private var formattedDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: dateRawString)
    }
    
    internal func getFaliureReasonMessage() -> String {
        if title.isEmpty ||
            overview.isEmpty ||
            dateRawString.isEmpty {
            return "All fields are mandatory"
        } else {
            return "Date is invalid"
        }
    }
    
    internal func getMovie() -> Movie {
        return Movie(title: title, overview: overview, date: formattedDate, poster: poster)
    }
}
