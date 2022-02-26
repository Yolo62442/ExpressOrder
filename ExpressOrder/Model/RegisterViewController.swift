//
//  ViewController.swift
//  Express Order
//
//  Created by Ainura on 17.02.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var offerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    let attributeString = NSMutableAttributedString(
       string: "условия публичной оферты",
       attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.systemGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
       ]
    )
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 5
        offerButton.setAttributedTitle(attributeString, for: .normal)
    }
    @IBAction func textFieldChanged(_ sender: Any) {
        guard let email = emailTextField.text else { return }
               changeNextButtonColor(!email.isEmpty)
    }
    

    @IBAction func offerButtonTapped(_ sender: Any) {
    }
 
    @IBAction func nextButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: RegistrationPasswordViewController.identifier) as! RegistrationPasswordViewController
                vc.email = emailTextField.text
                vc.offerButtonAttributeString = attributeString
                navigationController?.pushViewController(vc, animated: true)
    }

}


extension RegisterViewController {
    private func changeNextButtonColor(_ isActive: Bool) {
        let backgroundColor = isActive ? UIColor(named: "NextButtonActiveColor") : UIColor.systemGray5
        let tintColor = isActive ? UIColor.white : UIColor.systemGray
        if nextButton.backgroundColor != backgroundColor {
            nextButton.backgroundColor = backgroundColor
            nextButton.tintColor = tintColor
            nextButton.isEnabled = isActive
        }
    }
}
