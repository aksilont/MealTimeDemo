//
//  MainView.swift
//  MealTime
//
//  Created by Aksilont on 29.05.2021.
//

import UIKit

class MainView: UIView {
    
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
    }
}
