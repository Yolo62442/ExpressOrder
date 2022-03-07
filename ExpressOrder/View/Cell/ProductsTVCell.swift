//
//  ProductsTVCell.swift
//  ExpressOrder
//
//  Created by Ainura on 02.03.2022.
//

import UIKit
import Kingfisher

class ProductsTVCell: UITableViewCell {

    static let identifier = "ProductsTVCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var counterStepper: UIStepper!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    weak var delegate: CartDelegate?
    private var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plusButton.layer.cornerRadius = 10
        counterStepper.layer.cornerRadius = 10
        productImage.layer.cornerRadius = 20
    }
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        guard let product = product else { return }
        let count = Int(sender.value)
        changeStepper(count: count)
        delegate?.countChanged(for: product, count: count)
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        guard let product = product else { return }
        changeStepper(count: 1)
        delegate?.countChanged(for: product, count: 1)
    }
}

extension ProductsTVCell {
    func configureCell(product: Product, count: Int = 0) {
        self.product = product
        changeStepper(count: count)
        titleLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = product.price.prettyNumber() + " тг"
        productImage.kf.setImage(with: product.imageUrl)
    }
    
    private func changeStepper(count: Int) {
        counterStepper.value = Double(count)
        counterLabel.text = "\(count)"
        if count > 0 && !plusButton.isHidden {
            plusButton.isHidden = true
            counterStepper.isHidden = false
            counterLabel.isHidden = false
        } else if count == 0 && plusButton.isHidden {
            plusButton.isHidden = false
            counterStepper.isHidden = true
            counterLabel.isHidden = true
        }
    }
}

