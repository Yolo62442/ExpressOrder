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
    var cellId  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        /*configureTableView()*/
    }

/*        func configureTableView(){
            orderListTableView.delegate = self
            orderListTableView.dataSource = self
            orderListTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
               
           }
}

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }*/
    
    
}
