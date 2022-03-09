//
//  MainViewController.swift
//  Express Order
//
//  Created by Ainura on 19.02.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    let networkManager = NetworkManager()
    var restaurants: [RestaurantData]?
    private let defaults = UserDefaults()
    private var hasAlreadyLaunched: Bool {
        return defaults.bool(forKey: KeysDefaults.keyLaunch)
    }
    private let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainMenuTableViewCell.nib, forCellReuseIdentifier: MainMenuTableViewCell.identifier)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        logoutButton.isEnabled = user.data != nil
        networkManager.path = .restaurants
        networkManager.fetchRestaurants { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let restaurants):
                self.restaurants = restaurants
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        guard let userData = user.data else { return }
        networkManager.headers = ["Authorization": "\(userData.tokenType.capitalized) \(userData.accessToken)"]
        networkManager.method = .post
        networkManager.path = .logout
        networkManager.makeRequest { [weak self] (result: Result<Auth>) in
            switch result {
            case .success(let auth):
                self?.defaults.removeObject(forKey: KeysDefaults.keyUser)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Logout", message: "Successful logout", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    self?.present(alert, animated: true) { [weak self] in
                        self?.logoutButton.isEnabled = false
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuTableViewCell.identifier) as! MainMenuTableViewCell
        let restaurant = restaurants?[indexPath.row]
        cell.configureCell(image: restaurant?.image, title: restaurant?.data.name, location: restaurant?.data.location)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = restaurants?[indexPath.row]
        networkManager.path = .menu(restaurant?.data.id ?? 1)
        networkManager.makeRequest { [weak self] (result: Result<Menu>) in
            guard let self = self else { return }
            switch result {
            case .success(let menu):
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                    vc.menu = menu.data
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
