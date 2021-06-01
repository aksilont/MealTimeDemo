//
//  ViewController.swift
//  MealTime
//
//  Created by Aksilont on 29.05.2021.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    var context: NSManagedObjectContext?
    
    lazy var contentView: MainView = {
        return MainView(frame: .zero, delegate: self)
    }()
    
    var array = [Date]()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
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
        let date = Date()
        array.append(date)
        contentView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My happy meal time"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = array[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var contentConfguration = cell.defaultContentConfiguration()
        contentConfguration.text = dateFormatter.string(from: date)
        cell.contentConfiguration = contentConfguration
        return cell
    }
    
}
