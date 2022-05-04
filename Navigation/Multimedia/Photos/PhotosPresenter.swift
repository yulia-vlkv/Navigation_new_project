//
//  PhotosPresenter.swift
//  Navigation
//
//  Created by Iuliia Volkova on 24.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import iOSIntPackage
import UIKit

class PhotosPresenter: ImageLibrarySubscriber {
    
    private weak var view: PhotosViewController?
    private let coordinator: ProfileCoordinator
    let facade = ImagePublisherFacade()
    let processor = ImageProcessor()
    var arrayOfPhotos = allPhotos.photoArray
    
    init(view: PhotosViewController,
         coordinator: ProfileCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func receive(images: [UIImage]) {
        self.view?.configure(with: images)
    }
    
    func viewWillAppear(){
        facade.subscribe(self)
    }
    
    func viewWillDisappear() {
        facade.removeSubscription(for: self)
        facade.rechargeImageLibrary()
    }
    
    func viewDidLoad(){
        processPhotos()
    }
    
    private func processPhotos() {
        var processedImages: [UIImage] = []
        let filter = ColorFilter.noir
        let qos = QualityOfService.userInteractive
        let start = CFAbsoluteTimeGetCurrent()
        
        processor.processImagesOnThread(sourceImages: arrayOfPhotos, filter: filter, qos: qos) { [self] processedPhotos in
            
            for photo in processedPhotos {
                if let image = photo {
                    processedImages.append(UIImage(cgImage: image))
                }
            }
                                        
            DispatchQueue.main.async { [self] in
                facade.addImagesWithTimer(time: 0.8, repeat: processedPhotos.count, userImages: processedImages)
                
                self.view?.indicator.stopAnimating()
                self.view?.indicator.isHidden = true
                
                let diff = CFAbsoluteTimeGetCurrent() - start
                let result = String(format: "%.2f", diff)
                print("Took \(result) seconds to process images with \(filter) filter")
            }
        }
    }
}
