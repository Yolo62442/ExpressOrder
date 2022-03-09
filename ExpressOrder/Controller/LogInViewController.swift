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
    private let validator = Validator()
    private let networkManager = NetworkManager()
    private let defaults = UserDefaults()
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.masksToBounds = true
        logInButton.layer.cornerRadius = 5
        emailTextField.text = "testios123@mail.kz"
        passwordTextField.text = "test123123"
    }
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        networkManager.headers = ["Content-Type": "application/json"]
        networkManager.path = .login
        networkManager.method = .post
        networkManager.bodyParameters = ["email": email, "password": password]
        networkManager.makeRequest { [weak self] (result: Result<Auth>) in
            guard let self = self else { return }
            switch result {
            case .success(let auth):
                self.user.data = auth.data
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func emailTextfieldChanged(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginTextFieldsChanged(email: email, password: password)
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginTextFieldsChanged(email: email, password: password)
    }
}

extension LogInViewController {
    private func loginTextFieldsChanged(email: String, password: String) {
        changeNextButtonColor(validator.validate(email, with: [.validEmail]) && validator.validate(password, with: [.validPassword]))
    }
    
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
