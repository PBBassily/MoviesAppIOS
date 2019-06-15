//
//  MovieCreationAndDetailsView.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/15/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

class MovieCreationAndDetailsView: UIView {

    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var titleField: UITextField!
    @IBOutlet private weak var dateField: UITextField!
    @IBOutlet private weak var overviewTextField: UITextView!
    
    internal override func awakeFromNib() {
        super.awakeFromNib()
        configurePosterView()
        configureOverviewField()
        configureDateField()
        configureTitleField()
        configureView()
    }
    
    private func configureOverviewField() {
        overviewTextField.delegate = self
        initTextViewWithPlaceholder()
    }
    
    private func initTextViewWithPlaceholder() {
        overviewTextField.text = "Write an overview about your movie"
        overviewTextField.textColor = .lightGray
    }
    
    private func configureDateField() {
        dateField.placeholder = "DD/MM/YYYY"
        dateField.delegate = self
    }
    
    private func configureTitleField() {
        titleField.placeholder = "Movie title"
        titleField.delegate = self
    }
    
    private func configurePosterView() {
        posterView.layer.cornerRadius = UIConstants.CornerRadius.small.rawValue
        posterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnPosterView)))
        posterView.contentMode = .scaleAspectFill
        posterView.clipsToBounds = true
        posterView.image = UIImage(named: "poster_placeholder")
    }
    
    private func configureView() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing(_:))))
    }
    
    private func setTitle(_ movieTitle: String) {
        titleField.text = movieTitle
        titleField.isEnabled = false
    }
    
    private func setOverview(_ movieOverview: String) {
        overviewTextField.text = movieOverview
        overviewTextField.contentInset = .zero
        overviewTextField.isEditable = false
    }
    
    internal func setMoviePoster(_ image: UIImage?) {
        if let image = image {
            posterView.image = image
        }
    }
    
    internal func configureMovie(_ movie: Movie) {
        setTitle(movie.title)
        setOverview(movie.overview)
        setMoviePoster(movie.poster)
    }
    
    @objc private func didTapOnPosterView() {
        
    }
}

extension MovieCreationAndDetailsView: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MovieCreationAndDetailsView: UITextViewDelegate {
    internal func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            initTextViewWithPlaceholder()
        }
    }
    
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = .black
        return true
    }
}
