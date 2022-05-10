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
    
    private let urlTodoString = "https://jsonplaceholder.typicode.com/todos/"
    private let urlPlanetString = "https://swapi.dev/api/planets/1"
    private var networkService = NetworkService()
    
    private lazy var titleLabel: UILabel = {
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
    
    private lazy var planetInfoLabel: UILabel = {
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
    }()
    
    private lazy var containerView: UIStackView = {
        let containerView = UIStackView()
        
        containerView.toAutoLayout()
        containerView.axis = .vertical
        containerView.spacing = sideInset
        containerView.distribution = .fillEqually
        
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(planetInfoLabel)
        containerView.addArrangedSubview(button)
        
        return containerView
    }()
    
    private lazy var residentsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        tableView.toAutoLayout()
        tableView.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
        
    }()
    
    private var sideInset: CGFloat { return 40 }
    private var topInset: CGFloat { return 200 }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.delegate = self
        setUI()
        networkService.performNewRequest(with: urlTodoString)
        networkService.performPlanetRequest(with: urlPlanetString)
        
        print("decoding from: \(urlTodoString)")
        print("decoding from: \(urlPlanetString)")

    }
    
    private func setUI(){
        view.backgroundColor = .lightGray
    
        view.addSubview(containerView)
        view.addSubview(residentsTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        let constraints = [
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: sideInset),
            containerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sideInset),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topInset),
            
            residentsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: sideInset),
            residentsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sideInset),
            residentsTableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: sideInset),
            residentsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -topInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
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
    
    func didUpdatePlanetInfo(_ service: NetworkService, info: PlanetModel) {
        DispatchQueue.main.async {
            self.planetInfoLabel.text = "The orbital period of the \(info.name) planet is \(info.orbitalPeriod) days"
        }
    }
    
    func didUpdateResidentInfo(_ service: NetworkService, info: [String]) {
        DispatchQueue.main.async {
            self.residentsTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = UITableViewHeaderFooterView()
        headerView.contentView.backgroundColor = UIColor(named: "mint")
        headerView.textLabel?.text = "Residents:"
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.networkService.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) else {
            return UITableViewCell()
        }

        cell.textLabel?.text = self.networkService.textLabelForRow(index: indexPath.row)
        cell.textLabel?.font = .systemFont(ofSize: 14)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = UIColor(named: "mint")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        return 50
    }
}
