//
//  RegisterViewController.swift
//  ExpressOrder
//
//  Created by ra on 2/27/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var offerButton: UIButton!
    
    private let attributeString = NSMutableAttributedString(
       string: "условия публичной оферты",
       attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.systemGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
       ]
    )
    private let validator = Validator()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 5
        offerButton.setAttributedTitle(attributeString, for: .normal)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let email = emailTextField.text else { return }
        changeNextButtonColor(validator.validate(email, with: [.validEmail]))
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: RegistrationPasswordViewController.identifier) as! RegistrationPasswordViewController
        vc.email = emailTextField.text
        vc.offerButtonAttributeString = attributeString
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func offerButtonTapped(_ sender: Any) {
        
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
