//
//  MainViewController.swift
//  Express Order
//
//  Created by Ainura on 19.02.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainMenuTableViewCell.nib, forCellReuseIdentifier: MainMenuTableViewCell.identifier)
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuTableViewCell.identifier) as! MainMenuTableViewCell
        cell.configureCell(image: UIImage(named: "testImage"), title: "Del Papa", street: "ул. Бухар жырау, 66, уг. ул. Ауэзова")
        return cell
    }
}
