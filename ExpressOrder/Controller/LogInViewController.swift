//
//  LogInViewController.swift
//  ExpressOrder
//
//  Created by Ainura on 08.03.2022.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func logInButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    @IBAction func emailTextfieldChanged(_ sender: Any) {
        guard let email = passwordTextField.text else { return }
        changeNextButtonColor(!email.isEmpty )
    }
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        guard let password = emailTextField.text else { return }
        changeNextButtonColor(!password.isEmpty )
    }
}
extension LogInViewController {
    private func changeNextButtonColor(_ isActive: Bool) {
        let backgroundColor = isActive ? UIColor(named: "NextButtonActiveColor") : UIColor.systemGray5
        let tintColor = isActive ? UIColor.white : UIColor.systemGray
        if logInButton.backgroundColor != backgroundColor {
            logInButton.backgroundColor = backgroundColor
            logInButton.tintColor = tintColor
            logInButton.isEnabled = isActive
        }
    }
}
