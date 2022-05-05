//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    init(coordinator: FeedCoordinator){
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let urlString = "https://jsonplaceholder.typicode.com/todos/"
    private var networkService = NetworkService()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.backgroundColor = UIColor(named: "mint")
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.toAutoLayout()
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = CustomButton(
            title: "Detele this post",
            titleColor: .black,
            backgroungColor: .clear,
            backgroungImage: nil,
            cornerRadius: 15) {
                self.showAlert()
            }
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.delegate = self
        setUI()
        networkService.performNewRequest(with: urlString)
        
        print("decoding from: \(urlString)")

    }
    
    private func setUI(){
        view.backgroundColor = .lightGray
        view.addSubviews(button, titleLabel)
        button.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(150)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(50)
            make.center.equalToSuperview()
        }
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Delete this post?", message: "Are you sure? The post cannot be restored", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            print("Отмена")
        }
        let delete = UIAlertAction(title: "Delete", style: .default) { _ in
            print("Удалить")
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension InfoViewController: NetworkServiceDelegate {
    
    func didUpdateTitleLabel(_ service: NetworkService, title: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
        }
    }
}
