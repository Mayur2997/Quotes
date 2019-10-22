//
//  quoteCategoriesTableViewCell.swift
//  Quotes
//
//  Created by Agstya Technologies on 09/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

class QuoteCategoriesTableViewCell: UITableViewCell {
    
    //MARK:- Outlet Declaration
    @IBOutlet weak var quoteCategoriesLabel: UILabel!
    
    //MARK:- Cell lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
