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
    weak var delegate: DetailsDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func detailsButton(_ sender: Any) {
    }
    @IBOutlet weak var statusLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func DetailsButtonTapped(_ sender: Any) {
        delegate?.sendToDetailVC()
    }
}
