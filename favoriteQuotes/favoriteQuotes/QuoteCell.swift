//
//  QuoteCell.swift
//  favoriteQuotes
//
//  Created by user on 1/25/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class QuoteCell: UITableViewCell {

    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var creatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
