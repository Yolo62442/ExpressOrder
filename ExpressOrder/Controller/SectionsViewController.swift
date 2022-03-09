//
//  SectionsViewController.swift
//  ExpressOrder
//
//  Created by Ainura on 07.03.2022.
//

import UIKit

class SectionsViewController: UIViewController {

    @IBOutlet weak var sectionsTV: UITableView!
    var menu: MenuData?
    weak var delegate: SectionsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Меню"
        sectionsTV.dataSource = self
        sectionsTV.delegate = self
        sectionsTV.register(SectionsTVCell.nib, forCellReuseIdentifier: SectionsTVCell.identifier)
        // Do any additional setup after loading the view.
    }
    

}

extension SectionsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu?.productCategories.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionsTVCell.identifier, for: indexPath) as! SectionsTVCell
        cell.configureCell(categoryName: menu?.productCategories[indexPath.row].name, quantity: menu?.productCategories[indexPath.row].products.count ?? 0)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.scrollToSection(section: indexPath.row)
        print(indexPath.row)
        navigationController?.popViewController(animated: true)
    }
}

