//
//  MainMenuTableViewCell.swift
//  Express Order
//
//  Created by ra on 2/21/22.
//

import UIKit
import Kingfisher

class MainMenuTableViewCell: UITableViewCell {
    static let identifier = "MainMenuTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        restaurantImageView.layer.masksToBounds = true
        restaurantImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(image: Image?, title: String?, location: String?) {
        if let image = image {
            restaurantImageView.kf.setImage(with: image.url)
        }
        titleLabel.text = title
        locationLabel.text = location
    }
}
