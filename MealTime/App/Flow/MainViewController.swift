//
//  ViewController.swift
//  MealTime
//
//  Created by Aksilont on 29.05.2021.
//

import UIKit

class MainViewController: UIViewController {

    lazy var contentView: MainView = {
        return MainView()
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Meal time"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewTime))
    }

    @objc private func addNewTime() {
        print(#function)
    }
    
}
