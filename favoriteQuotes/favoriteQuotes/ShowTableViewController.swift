//
//  ShowTableViewController.swift
//  favoriteQuotes
//
//  Created by user on 1/25/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ShowTableViewController: UITableViewController {

    var quotesInCategory = [Quote]()
    var quoteCategory: String = ""
    var delegate: ChangeDelegate?
    
    @IBOutlet var categoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print (quoteCategory, quotesInCategory)
        categoryLabel.text = "Quotes from " + quoteCategory + "s"
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotesInCategory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell
        let quote = quotesInCategory[indexPath.row]
        cell.quoteLabel.text = "'" + quote.content! + "'"
        cell.creatorLabel.text = "-" + quote.creator!
        if quote.from != "" {
            cell.fromLabel.text = quote.from
        }
        else {
            cell.fromLabel.text = ""
        }
        tableView.rowHeight = 100
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "updateDeleteSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! UpdateDeleteViewController
        destination.delegate = self
        let indexPath = sender as! IndexPath
        let selectedQuote = quotesInCategory[indexPath.row]
        destination.quote = selectedQuote
        destination.quoteIndex = indexPath
    }
}

extension ShowTableViewController: ChangeDelegate {
    
    func updateQuote(quote: Quote, indexPath: IndexPath) {
        
        quotesInCategory[indexPath.row] = quote
        tableView.reloadData()
        delegate?.updateQuote(quote: quote, indexPath: indexPath)
    }
    
    func deleteQuote(quote: Quote) {
        
        var quoteToDel: Int?
        for i in 1...quotesInCategory.count {
            if quotesInCategory[i] == quote {
                quoteToDel = i
            }
        }
        quotesInCategory.remove(at: quoteToDel!)
        tableView.reloadData()
        delegate?.deleteQuote(quote: quote)
    }
}
