//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Iuliia Volkova on 18.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

//ImageLibrarySubscriber

class PhotosViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    var presenter: PhotosPresenter?
    
    func configure(with images: [UIImage]) {
        arrayOfPublishedPhotos = images
        
        guard (images.count - 1) == photoCollectionView.numberOfItems(inSection: 0) else { return }
        let indexPath = IndexPath(item: images.count - 1, section: 0)
        photoCollectionView.insertItems(at: [indexPath])
    }
    
    private var arrayOfPublishedPhotos: [UIImage] = []
    let layout = UICollectionViewFlowLayout()
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let collectionCellID = "collectionCellID"
    
    let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.toAutoLayout()
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        navigationController?.navigationBar.topItem?.title = "Back"
        navigationController?.navigationBar.tintColor = CustomColors.setColor(style: .textColor)
        
        setupCollectionView()
        
        setupIndicator()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        self.presenter?.viewWillDisappear()
    }
    
    private func setupCollectionView(){
        view.addSubview(photoCollectionView)
        photoCollectionView.toAutoLayout()
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellID")
        
        let constraints = [
            photoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupIndicator(){
        view.addSubview(indicator)
        indicator.isHidden = false
        indicator.startAnimating()
        
        let constraints = [
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfPublishedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellID", for: indexPath) as! PhotosCollectionViewCell
        
        cell.photo = self.arrayOfPublishedPhotos[indexPath.item]
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (photoCollectionView.frame.width - inset * 4) / 3, height: (photoCollectionView.frame.width - inset * 4) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    private var inset: CGFloat {return 8}
}
