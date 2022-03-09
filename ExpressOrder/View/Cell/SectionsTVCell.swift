//
//  ProductTableViewCell.swift
//  ExpressOrder
//
//  Created by Ainura on 02.03.2022.
//

import UIKit

class SectionsTVCell: UITableViewCell {
    
    static let identifier = "SectionsTVCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configureCell(categoryName: String?, quantity: Int) {
        sectionTitle.text = categoryName
        quantityLabel.text = "\(quantity)"
    }
    
}
