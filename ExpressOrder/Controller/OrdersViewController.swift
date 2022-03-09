//
//  OrdersViewController.swift
//  Express Order
//
//  Created by Ainura on 19.02.2022.
//

import UIKit

class OrdersViewController: UIViewController {
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var unauthorizedView: UIView!
    @IBOutlet weak var logInButton: UIButton!
    var cellId = "OrderTableViewCell"
    private let user = User()
    private let networkManager = NetworkManager()
    private var orders: [OrderDataContent]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unauthorizedView.isHidden = user.data != nil
        navigationController?.setNavigationBarHidden(false, animated: animated)
        if let userData = user.data {
            networkManager.headers = ["Authorization": "\(userData.tokenType.capitalized) \(userData.accessToken)"]
            networkManager.path = .orders
            networkManager.makeRequest { [weak self] (result: Result<Order>) in
                switch result {
                case .success(let order):
                    DispatchQueue.main.async { [weak self] in
                        self?.orders = order.content.data
                        self?.ordersTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OrdersViewController {
    private func configureTableView() {
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
}

//MARK: - UITableViewDelegate
extension OrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderTableViewCell
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.opaqueSeparator.cgColor
        cell.clipsToBounds = true
        let order = orders?[indexPath.section]
        cell.configureCell(title: order?.restaurant.name, price: order?.total, date: order?.createdAt.prettyDate(), status: "Статус - Завершен")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "OrderDetailsViewController") as! OrderDetailsViewController
        vc.order = orders?[indexPath.section]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
 
