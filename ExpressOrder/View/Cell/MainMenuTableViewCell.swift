//
//  MainMenuTableViewCell.swift
//  Express Order
//
//  Created by ra on 2/21/22.
//

import UIKit

class MainMenuTableViewCell: UITableViewCell {
    static let identifier = "MainMenuTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var streetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        restaurantImageView.layer.masksToBounds = true
        restaurantImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(image: UIImage?, title: String, street: String) {
        if let image = image {
            restaurantImageView.image = image
        }
        titleLabel.text = title
        streetLabel.text = street
    }
}
