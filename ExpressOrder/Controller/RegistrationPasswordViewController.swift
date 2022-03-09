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
    private let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 5
        offerButton.setAttributedTitle(offerButtonAttributeString, for: .normal)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
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
            guard let self = self else { return }
            switch result {
            case .success(let auth):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if (self.defaults.bool(forKey: KeysDefaults.keyLaunch)) {
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        self.defaults.set(true, forKey: KeysDefaults.keyLaunch)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                        self.navigationController?.setNavigationBarHidden(true, animated: true)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
