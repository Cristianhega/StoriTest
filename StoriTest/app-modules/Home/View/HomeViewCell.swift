//
//  HomeViewCell.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = .ten
        view.layer.borderWidth = .one
        view.layer.borderColor = UIColor(hex: Colors.green300).cgColor
        view.backgroundColor = UIColor(hex: Colors.green200)
        return view
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.montserratBold, size: .twenty)
        label.textColor = UIColor(hex: Colors.green900)
        label.numberOfLines = Int(.four)
        return label
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.montserratItalic, size: .fifteen)
        label.textColor = UIColor(hex: Colors.green800)
        label.numberOfLines = Int(.five)
        return label
    }()
    
    let arrowImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.clipsToBounds = false
        view.image = UIImage(named: Constants.doubleArrow)
        view.tintColor = UIColor(hex: Colors.green900)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(whiteView)
        addSubview(photoView)
        whiteView.addSubview(nameLabel)
        whiteView.addSubview(releaseLabel)
        whiteView.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .twenty),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.twenty),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.ten),
            whiteView.topAnchor.constraint(equalTo: topAnchor, constant: .fifty),
            
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .twenty),
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: .ten),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.ten),
            photoView.widthAnchor.constraint(equalToConstant: .oneHundredTwenty),
            
            nameLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: .ten),
            nameLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: .oneHundredThirty),
            nameLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -.ten),
            
            releaseLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .ten),
            releaseLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: .oneHundredThirty),
            releaseLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -.ten),
            
            arrowImage.heightAnchor.constraint(equalToConstant: .thirty),
            arrowImage.widthAnchor.constraint(equalToConstant: .thirty),
            arrowImage.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -.ten),
            arrowImage.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -.ten),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewCell {
    
    func setData(movie: Results) {
        nameLabel.text = movie.title
        releaseLabel.text = movie.release_date?.formatDate()
        photoView.setImage(fromPath: movie.poster_path)
    }
}
