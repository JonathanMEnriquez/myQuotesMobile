//
//  ViewController.swift
//  favoriteQuotes
//
//  Created by user on 1/25/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData

class QuotesViewController: UIViewController {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var quotesArr = [Quote]()
    var typesArr = [String]()
    
    @IBOutlet var categoryTableView: UITableView!
    @IBOutlet var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTableView.layer.cornerRadius = 10
        searchTableView.layer.cornerRadius = 10
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        fetchAndReload(type: nil)
        updateCategoriesAndReload()
    }

    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Core Data updated")
            } catch {
                print("failed to save", error)
            }
        }
    }
    
    func fetchAndReload(type:String?) {
        let request: NSFetchRequest<Quote> = Quote.fetchRequest()
        
        if let category = type {
            request.predicate = NSPredicate(format: "type CONTAINS %@", category)
        }
        do {
            let response = try managedObjectContext.fetch(request) as! [Quote]
            quotesArr = response
            categoryTableView.reloadData()
        } catch {
            print("failed in fetch", error)
        }
    }
    
    func updateCategoriesAndReload() {
        print("updating categories")
        typesArr = []
        
        for quote in quotesArr {
            
            if typesArr.contains(quote.type!) == false {
                typesArr.append(quote.type!)
            }
            else{
                print("already")
            }
        }
        print(typesArr.count)
        categoryTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSegue" {
            let destination = segue.destination as! AddViewController
            destination.delegate = self
        }
        else if segue.identifier == "showSegue" {
            let destination = segue.destination as! ShowTableViewController
            let indexPath = sender as! IndexPath
            destination.quoteCategory = typesArr[indexPath.row]
            fetchAndReload(type: typesArr[indexPath.row])
            destination.quotesInCategory = quotesArr
            destination.delegate = self
        }
    }
}

extension QuotesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSegue", sender: indexPath)
    }
}

extension QuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0 {
            return typesArr.count
        }
        else {
            return 1
        }
//        return quotesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            print("correct")
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath) as! TypeCell
            cell.categoryLabel.text = typesArr[indexPath.row]
            tableView.rowHeight = 108
            return cell
        }
        else {
            let cell = UITableViewCell()
            print("what?")
            return cell
        }
    }
}

extension QuotesViewController: AddViewControllerDelegate {
    
    func addQuote(content: String, creator: String, type: String, from: String, year: Int16) {
        
        let newQuote = Quote(context: managedObjectContext)
        newQuote.content = content
        newQuote.creator = creator
        newQuote.type = type
        if from != "" {
            newQuote.from = from
        }
        newQuote.year = year
        saveContext()
        fetchAndReload(type: nil)
        updateCategoriesAndReload()
        print(typesArr, quotesArr)
        navigationController?.popViewController(animated: true)
    }
}

extension QuotesViewController: ChangeDelegate {
    func updateQuote(quote: Quote, indexPath: IndexPath) {
        
        quotesArr[indexPath.row] = quote
        saveContext()
        fetchAndReload(type: quote.type)
        updateCategoriesAndReload()
        navigationController?.popViewController(animated: true)
    }
    
    func deleteQuote(quote: Quote) {
        
        managedObjectContext.delete(quote)
        saveContext()
        fetchAndReload(type: nil)
        updateCategoriesAndReload()
        navigationController?.popViewController(animated: true)
    }
}

