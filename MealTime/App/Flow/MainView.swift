//
//  MainView.swift
//  MealTime
//
//  Created by Aksilont on 29.05.2021.
//

import UIKit

class MainView: UIView {
    
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "meal")
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(topImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0.0),
            topImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            topImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0.0),
            topImageView.heightAnchor.constraint(equalToConstant: 150.0)
        ])
    }
}
