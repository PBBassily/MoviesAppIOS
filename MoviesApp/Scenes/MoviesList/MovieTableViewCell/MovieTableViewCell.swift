//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

internal class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var posterLoadingIndicator: UIActivityIndicatorView!
    private var movieId: Int?
    internal static var resubaleIdentifier: String {
        return "\(self)"
    }
    
    override internal func awakeFromNib() {
        super.awakeFromNib()
        configurePosterView()
    }
    
    private func configurePosterView() {
        posterView.layer.cornerRadius = UIConstants.CornerRadius.small.rawValue
        posterView.contentMode = .scaleAspectFill
        posterView.clipsToBounds = true
    }
    
    private func configureDateLabel(with date: Date?) {
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            dateLabel.text = formatter.string(from: date)
        } else {
            dateLabel.text = "Unknown"
        }
        
    }
    
    internal func configure(with movie: Movie) {
        configureDateLabel(with: movie.date)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterLoadingIndicator.startAnimating()
        movieId = movie.id
    }
    
    internal func setMoviePoster(_ image: UIImage?, of id: Int?) {
        if movieId == id {
            posterLoadingIndicator.stopAnimating()
            posterView.image = image
        }
        
    }
    
    override internal func prepareForReuse() {
        clearView()
    }
    
    private func clearView() {
        posterView.image = nil
        posterLoadingIndicator.stopAnimating()
        titleLabel.text = ""
        overviewLabel.text = ""
        dateLabel.text = ""
    }
    
}
