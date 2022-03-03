//
//  OrderDetailsTVCell.swift
//  ExpressOrder
//
//  Created by Ainura on 03.03.2022.
//

import UIKit

class OrderDetailsTVCell: UITableViewCell {
    static let identifier = "OrderDetailsTVCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
