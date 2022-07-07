//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Iuliia Volkova on 15.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    private let processor = ImageProcessor()
    
    var doubleTapHandler : (() throws -> ())?
    
    var post: PostVK? {
        didSet{
            authorLabel.text = post?.author ?? "Anon"
            postImageView.image = UIImage(named: post?.image ?? "angryCat")
            descriptionLabel.text = post?.description
            likesLabel.text = "Likes: \(post?.likes ?? 0)"
            viewsLabel.text = "Views: \(post?.views ?? 0)"
//            postImageView.image = UIImage(named: post?.image ?? "no image")
            if let image = UIImage(named: post?.image ?? "angryCat") {
                processor.processImage(sourceImage: image, filter: ColorFilter.allCases.randomElement() ?? .noir) { (image) in postImageView.image = image
                }
            }
        }
    }
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = CustomColors.setColor(style: .textColor)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.toAutoLayout()
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        description.numberOfLines = 0
        description.toAutoLayout()
        return description
    }()
    
    private let likesLabel: UILabel = {
        let likes = UILabel()
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = CustomColors.setColor(style: .textColor)
        likes.toAutoLayout()
        return likes
    }()
    
    private let viewsLabel: UILabel = {
        let views = UILabel()
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = CustomColors.setColor(style: .textColor)
        views.toAutoLayout()
        return views
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSingleAndDoubleTapGesture()
        
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        let constraints = [
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor),
        
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private var inset: CGFloat {return 16}
    
    private func addSingleAndDoubleTapGesture() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTapGesture)

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapGesture)

        singleTapGesture.require(toFail: doubleTapGesture)
    }

    @objc private func handleSingleTap(_ tapGesture: UITapGestureRecognizer) {
        print("single tap")
    }

    @objc private func handleDoubleTap(_ tapGesture: UITapGestureRecognizer){
        print("double tap")
        try? doubleTapHandler?()
    }
    
}
