//
//  GroupCollectionViewCell.swift
//  ExpressOrder
//
//  Created by Ainura on 02.03.2022.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    static let identifier = "GroupCollectionViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var groupTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
