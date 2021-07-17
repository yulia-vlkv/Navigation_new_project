//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Iuliia Volkova on 15.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: PostVK? {
        didSet{
            authorLabel.text = post?.author
            postImageView.image = UIImage(named: post?.image ?? "No image")
            descriptionLabel.text = post?.description
            likesLabel.text = "Likes: \(post?.likes ?? 0)"
            viewsLabel.text = "Views: \(post?.views ?? 0)"
        }
    }
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
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
        likes.textColor = .black
        likes.toAutoLayout()
        return likes
    }()
    
    private let viewsLabel: UILabel = {
        let views = UILabel()
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        views.toAutoLayout()
        return views
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
}
