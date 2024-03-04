//
//  DetailView.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class DetailView: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    var movie: Results?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.montserratBold, size: .twenty)
        label.textColor = UIColor(hex: Colors.green900)
        label.numberOfLines = Int(.four)
        label.textAlignment = .center
        return label
    }()
    
    let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = .ten
        imageView.layer.borderWidth = .one
        imageView.layer.borderColor = UIColor(hex: Colors.green200).cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let starButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.star), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.backgroundColor = .clear
        button.layer.cornerRadius = .ten
        return button
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.montserratRegular, size: .seventeen)
        label.textColor = UIColor(hex: Colors.green700)
        label.numberOfLines = Int(.five)
        label.textAlignment = .center
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.montserratMedium, size: .seventeen)
        label.textColor = UIColor(hex: Colors.green900)
        label.numberOfLines = Int(.five)
        label.textAlignment = .center
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buy, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratBold, size: .seventeen)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: Colors.green800)
        button.layer.cornerRadius = .ten
        return button
    }()
    
    let greenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = .twenty
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor(hex: Colors.green800)
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.montserratMedium, size: .seventeen)
        label.textColor = UIColor(hex: Colors.green0)
        label.numberOfLines = Int(.twenty)
        label.textAlignment = .justified
        return label
    }()
    
    override func viewDidLoad() {
        configUI()
        showMovie()
    }
    
    private func configUI() {
        navigationItem.hidesBackButton = false
        view.backgroundColor = UIColor(hex: Colors.green0)
        configureConstraints()
        configureActions()
    }
    
    private func configureConstraints() {
        view.addSubview(nameLabel)
        view.addSubview(photoView)
        view.addSubview(starButton)
        view.addSubview(releaseLabel)
        view.addSubview(ratingLabel)
        view.addSubview(buyButton)
        view.addSubview(greenView)
        greenView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .twenty),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.twenty),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .five),
            
            photoView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .twenty),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .twenty),
            photoView.widthAnchor.constraint(equalToConstant: .oneHundredThirty),
            photoView.heightAnchor.constraint(equalToConstant: .twoHundredTwenty),
            
            starButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: .twenty),
            starButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.twenty),
            starButton.widthAnchor.constraint(equalToConstant: .fifty),
            starButton.heightAnchor.constraint(equalToConstant: .fifty),
            
            releaseLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .seventy),
            releaseLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: .twenty),
            releaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.twenty),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: .twenty),
            ratingLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: .twenty),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.twenty),
            
            buyButton.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: .twenty),
            buyButton.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: .twenty),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.twenty),
            
            greenView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: .twenty),
            greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            greenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: greenView.topAnchor, constant: .twenty),
            descriptionLabel.leadingAnchor.constraint(equalTo: greenView.leadingAnchor, constant: .twenty),
            descriptionLabel.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: -.twenty),
        ])
    }
    
    private func configureActions() {
        buyButton.addTarget(self, action: #selector(buyAction), for: .touchUpInside)
        starButton.addTarget(self, action: #selector(rateAction), for: .touchUpInside)
    }
}

extension DetailView {
    
    private func showMovie() {
        guard let movie = movie else { return }
        presenter?.setMovie(movie: movie)
    }
    
    @objc func buyAction() {
        showCustomAlert(title: Constants.readyToFun, message: Constants.successPurchase)
    }

    @objc func rateAction() {
        showCustomAlert(title: Constants.thanksForRate, message: Constants.ratingSent)
    }
}

extension DetailView: DetailViewProtocol {
    
    func showMovieData(movie: Results) {
        nameLabel.text = movie.title
        photoView.setImage(fromPath: movie.poster_path)
        releaseLabel.text = .releaseLabelText(for: movie.release_date)
        ratingLabel.text = .ratingLabelText(for: movie.vote_average)
        descriptionLabel.text = movie.overview
    }
}
