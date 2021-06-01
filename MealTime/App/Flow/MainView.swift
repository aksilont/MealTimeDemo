//
//  MainView.swift
//  MealTime
//
//  Created by Aksilont on 29.05.2021.
//

import UIKit

class MainView: UIView {
    
    weak var delegate: (UITableViewDelegate & UITableViewDataSource)?
    
    lazy private var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "meal")
        return imageView
    }()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = delegate
        tableView.dataSource = delegate
        return tableView
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, delegate: (UITableViewDelegate & UITableViewDataSource)?) {
        super.init(frame: frame)
        self.delegate = delegate
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - UI
    
    func reloadData() {
        tableView.reloadData()
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(topImageView)
        addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0.0),
            topImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            topImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0.0),
            topImageView.heightAnchor.constraint(equalToConstant: 150.0),
            
            tableView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 0.0),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0.0)
        ])
    }
    
}
