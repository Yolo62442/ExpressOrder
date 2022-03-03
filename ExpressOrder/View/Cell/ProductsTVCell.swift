//
//  ProductsTVCell.swift
//  ExpressOrder
//
//  Created by Ainura on 02.03.2022.
//

import UIKit



class ProductsTVCell: UITableViewCell {

    @IBOutlet weak var counterStepper: UIStepper!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    static let identifier = "ProductsTVCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    weak var delegate: CartDelegate?
    var id = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plusButton.layer.cornerRadius = 10
        counterStepper.layer.cornerRadius = 10
        productImage.layer.cornerRadius = 20
        
           
    }
    @IBAction func stepperTapped(_ sender: UIStepper) {
        counterLabel.text = String(Int(sender.value))
        
        if sender.value == 0{
            plusButton.isHidden = false
            delegate?.removeFromCart(id: id)
            counterStepper.isHidden = true
            counterLabel.isHidden = true
        }
    }
    @IBAction func plusButtonTapped(_ sender: Any) {
        plusButton.isHidden = true
        delegate?.addToCart(id: id)
        counterStepper.isHidden = false
        counterLabel.isHidden = false
        counterStepper.value = 1
        counterLabel.text = "1"
        
        
    }
    
}

