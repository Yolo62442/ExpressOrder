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
    private let validator = Validator()
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 5
        offerButton.setAttributedTitle(offerButtonAttributeString, for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let password = passwordTextField.text else { return }
        changeNextButtonColor(validator.validate(password, with: [.validPassword]))
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let email = email, let password = passwordTextField.text else { return }
        networkManager.headers = ["Content-Type": "application/json"]
        networkManager.path = .register
        networkManager.method = .post
        networkManager.bodyParameters = ["email": email, "password": password]
        networkManager.makeRequest { [weak self] (result: Result<Auth>) in
            switch result {
            case .success(let auth):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.popToRootViewController(animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
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
