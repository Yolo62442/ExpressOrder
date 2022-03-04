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
    override func viewDidLoad() {
        super.viewDidLoad()
        productsTV.delegate = self
        productsTV.dataSource = self
        productsTV.register(ProductsTVCell.nib, forCellReuseIdentifier: ProductsTVCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func payButtonTaapped(_ sender: Any) {
    }
}

//MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTVCell.identifier, for: indexPath) as! ProductsTVCell
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
        price.text = "3 900 тг"
        footerView.addSubview(separatorView)
        footerView.addSubview(title)
        footerView.addSubview(price)
        return footerView
    }
}
