//
//  CartViewController.swift
//  ExpressOrder
//
//  Created by Ainura on 04.03.2022.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var productsTV: UITableView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var priceLable: UILabel!

    weak var delegate: CartDelegate?
    var cart: [CartProduct]?
    var restaurant: RestaurantDataContent?
    private var totalPrice: Int {
        let price = cart?.reduce(0) { $0 + ($1.product.price * $1.count) }
        return price ?? 0
    }
    private let networkManager = NetworkManager()
    private let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Корзина"
        productsTV.delegate = self
        productsTV.dataSource = self
        productsTV.register(ProductsTVCell.nib, forCellReuseIdentifier: ProductsTVCell.identifier)
        titleLabel.text = restaurant?.name
        addressLabel.text = restaurant?.location
        priceLable.text = "\(totalPrice.prettyNumber()) ₸"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = user.data {
            payButton.setTitle("Оплатить", for: .normal)
            payButton.isEnabled = true
        } else {
            payButton.setTitle("Войдите в аккаунт", for: .normal)
            payButton.isEnabled = false
        }
    }
    
    @IBAction func payButtonTaapped(_ sender: Any) {
        guard let restaurant = restaurant, let cart = cart, let userData = user.data else { return }
        networkManager.headers = ["Authorization": "\(userData.tokenType.capitalized) \(userData.accessToken)", "Content-Type": "application/json"]
        networkManager.path = .makeOrder
        networkManager.method = .post
        networkManager.bodyParameters = ["restaurant_id": restaurant.id, "products": cart.map({ ["id": $0.product.id, "quantity": $0.count] })]
        networkManager.makeRequest { [weak self] (result: Result<Auth>) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Order", message: "Order created successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] alert in
                        self?.navigationController?.popToRootViewController(animated: true)
                    }))
                    self?.present(alert, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTVCell.identifier, for: indexPath) as! ProductsTVCell
        if let cartProduct = cart?[indexPath.row] {
            cell.configureCell(product: cartProduct.product, count: cartProduct.count)
        }
        cell.delegate = self
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
        title.text = "Мой заказ"
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
        let priceLabel = UILabel(frame: CGRect(x: 10 + widthOfFooter, y: 0, width: widthOfFooter, height: 60))
        priceLabel.font = UIFont.systemFont(ofSize: CGFloat(17), weight: .bold)
        priceLabel.textColor = UIColor.black
        priceLabel.textAlignment = .right
        priceLabel.text = totalPrice.prettyNumber() + " ₸"
        footerView.addSubview(separatorView)
        footerView.addSubview(title)
        footerView.addSubview(priceLabel)
        return footerView
    }
}

//MARK: - CartDelegate
extension CartViewController: CartDelegate {
    func countChanged(for product: Product, count: Int) {
        let index = cart?.firstIndex { $0.product == product }
        if let index = index {
            cart?[index].count = count
            if count == 0 {
                cart?.remove(at: index)
            }
            if (cart?.isEmpty ?? true) {
                payButton.isEnabled = false
            }
        } else {
            cart?.append((product, 1))
            if (!payButton.isEnabled){
                payButton.isEnabled = true
            }
        }
        delegate?.countChanged(for: product, count: count)
        delegate?.cartChanged(cart)
        priceLable.text = "\(totalPrice.prettyNumber()) ₸"
        self.productsTV.reloadData()
    }
}
    
