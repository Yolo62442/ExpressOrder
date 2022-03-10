//
//  OrderDetailsViewController.swift
//  Express Order
//
//  Created by Ainura on 21.02.2022.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var cafeTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var orderListTableView: UITableView!
    var order: OrderDataContent?
    private let networkManager = NetworkManager()
    private var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Детали заказа"
        configureTableView()
        if let order = order {
            cafeTitleLabel.text = order.restaurant.name
            locationLabel.text = order.restaurant.location
            orderNumLabel.text = "№\(order.id)"
            dateLabel.text = order.createdAt.prettyDate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkManager.path = .menu(order?.restaurant.id ?? 0)
        networkManager.makeRequest { [weak self] (result: Result<Menu>) in
            guard let self = self else { return }
            switch result {
            case .success(let menu):
                self.products.append(contentsOf: menu.data.productCategories.flatMap { $0.products })
                DispatchQueue.main.async { [weak self] in
                    self?.orderListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func configureTableView() {
        orderListTableView.delegate = self
        orderListTableView.dataSource = self
        orderListTableView.register(OrderDetailsTVCell.nib, forCellReuseIdentifier: OrderDetailsTVCell.identifier)
    }
}

//MARK: - UITableViewDelegate

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order?.orderDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailsTVCell.identifier, for: indexPath) as! OrderDetailsTVCell
        let index = products.firstIndex { $0.id == order?.orderDetails[indexPath.row].productId }
        if let index = index {
            let product = products[index]
            cell.configureCell(name: product.name, price: product.price, quantity: order?.orderDetails[indexPath.row].quantity ?? 1)
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let widthOfHeader = UIScreen.main.bounds.width - 20
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: widthOfHeader, height: 40))
        title.font = UIFont.systemFont(ofSize: CGFloat(17), weight: .bold)
        title.textColor = UIColor.darkGray
        title.text = "Позиция в заказе"
        headerView.addSubview(title)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let separatorView = UIView(frame: CGRect(x: 10, y: 0, width: tableView.bounds.width - 20, height: 1))
        separatorView.backgroundColor = UIColor.lightGray
        let widthOfFooter = (UIScreen.main.bounds.width - 20)/2
        footerView.backgroundColor = UIColor.white
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: 80, height: 60))
        title.font = UIFont.systemFont(ofSize: CGFloat(17), weight: .bold)
        title.textColor = UIColor.black
        title.text = "Итого"
        footerView.addSubview(title)
        let price = UILabel(frame: CGRect(x: 10 + widthOfFooter, y: 0, width: widthOfFooter, height: 60))
        price.font = UIFont.systemFont(ofSize: CGFloat(17), weight: .bold)
        price.textColor = UIColor.black
        price.textAlignment = .right
        if let total = order?.total {
            price.text = "\(total.prettyNumber()) тг"
        }
        footerView.addSubview(separatorView)
        footerView.addSubview(title)
        footerView.addSubview(price)
        return footerView
    }
}
