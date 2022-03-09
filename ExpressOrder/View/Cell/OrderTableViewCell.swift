//
//  TableViewCell.swift
//  Express Order
//
//  Created by Ainura on 19.02.2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String?, price: Int?, date: String?, status: String?) {
        titleLabel.text = title
        if let price = price {
            priceLabel.text = "\(price.prettyNumber()) тг"
        }
        dateLabel.text = date
        statusLabel.text = status
    }
}
