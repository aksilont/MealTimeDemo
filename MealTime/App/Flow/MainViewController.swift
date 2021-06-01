//
//  ViewController.swift
//  MealTime
//
//  Created by Aksilont on 29.05.2021.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    var context: NSManagedObjectContext!
    
    lazy var contentView: MainView = {
        return MainView(frame: .zero, delegate: self)
    }()
    
    var array = [Date]()
    var person: Person!
    
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
        fetchData(with: "Max")
    }
    
    private func fetchData(with personName: String) {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", personName)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                person = Person(context: context)
                person.name = personName
                try context.save()
            } else {
                person = results.first
            }
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    private func addNewMeal(with date: Date) {
        // Old record:
        // let entity = NSEntityDescription.entity(forEntityName: "Meal", in: context)
        // let newMeal = NSManagedObject(entity: entity!, insertInto: context) as! Meal
        let newMeal = Meal(context: context)
        newMeal.date = date
        
        let meals = person.meals?.mutableCopy() as? NSMutableOrderedSet
        meals?.add(newMeal)
        person.meals = meals
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription); userInfo: \(error.userInfo)")
        }
    }
    
    private func setupUI() {
        title = "Meal time"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewTime))
    }

    @objc private func addNewTime() {
        addNewMeal(with: Date())
        contentView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My happy meal time"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let meals = person.meals else { return 1 }
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let meal = person.meals?[indexPath.row] as? Meal, let mealDate = meal.date else { return cell }
        
        var contentConfguration = cell.defaultContentConfiguration()
        contentConfguration.text = dateFormatter.string(from: mealDate)
        cell.contentConfiguration = contentConfguration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard let mealToDelete = person.meals?[indexPath.row] as? Meal, editingStyle == .delete else { return }
        context.delete(mealToDelete)
        
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription); userInfo: \(error.userInfo)")
        }
    }
    
}
