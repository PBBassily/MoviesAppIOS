//
//  Movie.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import Foundation
import UIKit

internal struct Movie {
    internal var title: String
    internal var overview: String
    internal var date: Date?
    internal private(set) var posterUrl: String?
    internal var poster: UIImage?
    internal var hasPoster: Bool {
        return poster != nil
    }
    
    internal init(title: String, overview: String, dateRaw: String?, posterUrl: String?) {
        self.title = title
        self.overview = overview
        self.posterUrl = posterUrl
        self.date = DateFormatter().date(from: dateRaw ?? "")
    }
}
