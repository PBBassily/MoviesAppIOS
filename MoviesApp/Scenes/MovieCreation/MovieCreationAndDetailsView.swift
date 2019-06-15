//
//  MovieCreationAndDetailsView.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/15/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

internal protocol MovieCreationViewDelegate: class {
    func didChangePotser(_ potser: UIImage?)
    func didChangeDate(_ date: String)
    func didChangeTitle(_ title: String)
    func didChangeOverview(_ overview: String)
}

class MovieCreationAndDetailsView: UIView {
    
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var titleField: UITextField!
    @IBOutlet private weak var dateField: UITextField!
    @IBOutlet private weak var overviewTextField: UITextView!
    internal weak var delegate: MovieCreationViewDelegate?
    
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
        dateField.keyboardType = .numbersAndPunctuation
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
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateField {
            delegate?.didChangeDate(textField.text ?? "")
        } else if textField == textField {
            delegate?.didChangeTitle(textField.text ?? "")
        }
    }
}

extension MovieCreationAndDetailsView: UITextViewDelegate {
    internal func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.didChangeOverview(textView.text)
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
