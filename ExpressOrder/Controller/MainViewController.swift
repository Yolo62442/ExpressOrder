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
    let path: String = "/api/restaurants"
    var restaurants: [RestaurantData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainMenuTableViewCell.nib, forCellReuseIdentifier: MainMenuTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        networkManager.path = path
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
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuTableViewCell.identifier) as! MainMenuTableViewCell
        let restaurant = restaurants?[indexPath.row]
        cell.configureCell(image: restaurant?.image, title: restaurant?.restaurantData.name, location: restaurant?.restaurantData.location)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
