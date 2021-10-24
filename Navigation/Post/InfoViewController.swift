//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let button: UIButton = {
        let button = CustomButton(
            title: "Detele this post",
            titleColor: .black,
            backgroungColor: .clear,
            backgroungImage: nil,
            cornerRadius: 15) {
                
            }
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
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
