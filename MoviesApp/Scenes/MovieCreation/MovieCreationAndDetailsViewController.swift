//
//  MovieCreationAndDetails.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/15/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

internal protocol MovieCreationViewControlDelegate: class {
    func didCreateMovie(_ movie: Movie)
}

internal class MovieCreationAndDetailsViewController: UIViewController {
    
    private var usageType: UsageType = .movieCreation
    internal var selectedMovie: Movie? {
        didSet {
            if selectedMovie != nil {
                usageType = .showingMovieDetails
            }
        }
    }
    private var viewModel: MovieCreationViewModel!
    private var imagePicker: UIImagePickerController!
    internal weak var delegate: MovieCreationViewControlDelegate?
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        initViewModel()
        configureImagePicker()
    }
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if usageType == .movieCreation {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
            navigationItem.rightBarButtonItem?.accessibilityIdentifier = "MovieSaveButton"
        } else if usageType == .showingMovieDetails, let movie = selectedMovie {
            configureView(with: movie)
        }
        title = usageType.rawValue
    }
    
    private func configureView() {
        if let view = view as? MovieCreationAndDetailsView, usageType == .movieCreation {
            view.delegate = self
        }
    }
    
    private func configureView(with movie: Movie) {
        if let view = view as? MovieCreationAndDetailsView {
            view.configureMovie(movie)
        }
    }
    
    private func initViewModel() {
        viewModel = MovieCreationViewModel()
    }
    
    private func configureImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
    
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(alertVC, animated: true)
    }
    
    @objc private func save() {
        view.endEditing(true)
        if viewModel.shouldSave {
            delegate?.didCreateMovie(viewModel.getMovie())
            self.navigationController?.popViewController(animated: true)
        } else {
            showAlert(message: viewModel.getFaliureReasonMessage())
        }
    }
    
}

extension MovieCreationAndDetailsViewController {
    
    internal enum UsageType: String {
        case showingMovieDetails = "Movie details"
        case movieCreation = "Create your movie"
    }
}

extension MovieCreationAndDetailsViewController: MovieCreationViewDelegate {
    
    internal func didTapOnPosterView() {
        present(imagePicker, animated: true)
    }
    
    internal func didChangeDate(_ date: String) {
        viewModel.dateRawString = date
    }
    
    internal func didChangeTitle(_ title: String) {
        viewModel.title = title
    }
    
    internal func didChangeOverview(_ overview: String) {
        viewModel.overview = overview
    }
}

extension MovieCreationAndDetailsViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            viewModel.poster = pickedImage
            if let view = view as? MovieCreationAndDetailsView, usageType == .movieCreation {
                view.setMoviePoster(pickedImage)
            }
        }
        
        imagePicker.dismiss(animated: true)
    }
}
