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
    weak var delegate: CartDelegate?
    var cart: [CartProduct]?
    var restaurant: RestaurantDataContent?
    var totalPrice: Int = 0
    @IBOutlet weak var priceLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Корзина"
        productsTV.delegate = self
        productsTV.dataSource = self
        productsTV.register(ProductsTVCell.nib, forCellReuseIdentifier: ProductsTVCell.identifier)
        titleLabel.text = restaurant?.name
        addressLabel.text = restaurant?.location
        totalPrice = countTotalPrice()
        priceLable.text = "\(totalPrice)  ₸"
    }
    func countTotalPrice() -> Int{
        let price = cart?.reduce(0) { $0 + ($1.product.price * $1.count) }
        return price ?? 0
    }
    
    @IBAction func payButtonTaapped(_ sender: Any) {

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
        self.totalPrice = countTotalPrice()
        priceLable.text = "\(totalPrice)  ₸"
        self.productsTV.reloadData()
    }
}
    
