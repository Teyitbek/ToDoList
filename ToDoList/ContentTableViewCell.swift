//
//  ContentTableViewCell.swift
//  ToDoList
//
//  Created by Tiku on 14/6/22.
//

import Foundation
import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
