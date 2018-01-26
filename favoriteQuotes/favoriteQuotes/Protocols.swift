//
//  Protocols.swift
//  favoriteQuotes
//
//  Created by user on 1/25/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate {
    
    func addQuote(content: String, creator: String, type: String, from: String, year: Int16)
}

protocol ChangeDelegate {
    
    func updateQuote(quote: Quote, indexPath: IndexPath)
    func deleteQuote(quote: Quote)
}
