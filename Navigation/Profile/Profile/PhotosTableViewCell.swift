//
//  PhotoCollectionViewCell.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()
    
    private let arrow: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.forward"))
        image.tintColor = .black
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let pictures: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.toAutoLayout()
        return stackView
    }()
    
    private let photo1: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "CometNearJupitersAsteroids"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let photo2: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "FamousBlackHole"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let photo3: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "LegacyFellows"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let photo4: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "VeilNebula"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(photoLabel)
        contentView.addSubview(arrow)
        contentView.addSubview(pictures)
        
        pictures.addArrangedSubview(photo1)
        pictures.addArrangedSubview(photo2)
        pictures.addArrangedSubview(photo3)
        pictures.addArrangedSubview(photo4)
        
        let constraints = [
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            
            arrow.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            arrow.heightAnchor.constraint(equalToConstant: 20),
            arrow.widthAnchor.constraint(equalTo: arrow.heightAnchor),
        
            pictures.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: inset),
            pictures.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            pictures.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            pictures.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            pictures.heightAnchor.constraint(equalToConstant: (contentView.frame.size.width - inset * 2 - spacing * 3) / 4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private var inset: CGFloat {return 12}
    private var spacing: CGFloat {return 8}
}
