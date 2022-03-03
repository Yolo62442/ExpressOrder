//
//  ProductTableViewCell.swift
//  ExpressOrder
//
//  Created by Ainura on 02.03.2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
