//
//  OrdersViewController.swift
//  Express Order
//
//  Created by Ainura on 19.02.2022.
//

import UIKit
protocol DetailsDelegate: AnyObject{
    func sendToDetailVC()
}

class OrdersViewController: UIViewController {
    @IBOutlet weak var ordersTableView: UITableView!
    var cellId = "OrderTableViewCell"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    func configureTableView(){
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
           
       }
    

}

extension OrdersViewController: DetailsDelegate{
    func sendToDetailVC() {
        /*let vc = storyboard?.instantiateViewController(identifier: "OrderDetailsViewController") as! OrderDetailsViewController
                
                navigationController?.pushViewController(vc, animated: true)*/
        print("hello")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let vc = storyboard.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController{
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true, completion: nil)
                }
                  
    }
    
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderTableViewCell
        cell.delegate = self
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.opaqueSeparator.cgColor
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
            return headerView
        }
}
 
