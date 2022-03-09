//
//  MainViewController.swift
//  Express Order
//
//  Created by Ainura on 19.02.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let networkManager = NetworkManager()
    var restaurants: [RestaurantData]?
    private let defaults = UserDefaults()
    private var hasAlreadyLaunched: Bool {
        return defaults.bool(forKey: "hasAlreadyLaunched")
    }
    
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
    @IBAction func loginButtonTapped(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        navigationController?.pushViewController(vc, animated: true)
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
