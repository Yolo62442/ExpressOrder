//
//  RegistrationPasswordViewController.swift
//  Express Order
//
//  Created by ra on 2/21/22.
//

import UIKit

class RegistrationPasswordViewController: UIViewController {
    
    static let identifier = "RegistrationPasswordViewController"
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var offerButton: UIButton!
    
    
    
    var email: String?
    var offerButtonAttributeString: NSMutableAttributedString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 5
        offerButton.setAttributedTitle(offerButtonAttributeString, for: .normal)
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let password = passwordTextField.text else { return }
        changeNextButtonColor(!password.isEmpty)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let email = email, let password = passwordTextField.text else { return }
        print(email, password)
        navigationController?.popToRootViewController(animated: false)
    }
}


extension RegistrationPasswordViewController {
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
