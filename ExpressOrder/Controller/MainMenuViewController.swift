//
//  ViewController.swift
//  ExpressOrder
//
//  Created by Ainura on 27.02.2022.
//

import UIKit
import Kingfisher

protocol CartDelegate: AnyObject {
    func countChanged(for product: Product, count: Int)
    func cartChanged(_ cart: [CartProduct]?)
}
protocol SectionsDelegate: AnyObject{
    func scrollToSection(section: Int)
}
extension CartDelegate {
    func cartChanged(_ cart: [CartProduct]?) { }
}


class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var productBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cartTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productsTV: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var cartButtonView: UIView!
    @IBOutlet weak var cartButton: UIView!
    @IBOutlet weak var sectionsButton: UIButton!
    var currentSelected:Int = 0
    
    private var cart = [CartProduct]()
    var menu: MenuData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        locationLabel.text = menu?.location
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        productsTV.dataSource = self
        productsTV.delegate = self
        groupsCollectionView.dataSource = self
        groupsCollectionView.delegate = self
        groupsCollectionView.register(GroupCollectionViewCell.nib, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        productsTV.register(ProductsTVCell.nib, forCellReuseIdentifier: ProductsTVCell.identifier)
        productsTV.rowHeight = UITableView.automaticDimension
        productsTV.estimatedRowHeight = CGFloat(44.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexpath = IndexPath(row: currentSelected, section: 0)
        self.groupsCollectionView.scrollToItem(at: indexpath, at: .left, animated: true)
        let indexPath1 = IndexPath(row: 0, section: currentSelected)
        self.productsTV.scrollToRow(at: indexPath1, at: .top, animated: true)
        groupsCollectionView.reloadData()
    }
    
    @IBAction func cartButtonTapped(_ sender: Any) {
        guard let menu = menu else { return }
        let vc = storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        vc.cart = cart
        vc.delegate = self
        vc.restaurant = RestaurantDataContent(id: menu.restaurantId, name: menu.restaurantName, location: menu.location, images: nil, createdAt: nil, updatedAt: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func sectionsButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SectionsViewController") as! SectionsViewController
        vc.menu = menu
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - CartDelegate
extension MainMenuViewController: CartDelegate {
    func cartChanged(_ cart: [CartProduct]?) {
        guard let cart = cart else { return }
        self.cart = cart
    }
    
    func countChanged(for product: Product, count: Int) {
        let index = cart.firstIndex { $0.product == product }
        if let index = index {
            cart[index].count = count
            if count == 0 {
                cart.remove(at: index)
            }
            if (cart.isEmpty) {
                cartButtonView.isHidden = true
                cartTopConstraint.isActive = false
                productBottomConstraint.isActive = true
            }
        } else {
            cart.append((product, 1))
            cartButtonView.isHidden = false
            productBottomConstraint.isActive = false
            cartTopConstraint.isActive = true
        }
    }
}

//MARK: - SectionDelegate
extension MainMenuViewController: SectionsDelegate{
    func scrollToSection(section: Int) {
        currentSelected = section
    }
}

//MARK: - UITableViewDelegate
extension MainMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (section < currentSelected) {
            currentSelected = section
            let indexpath = IndexPath(row: section, section: 0)
            self.groupsCollectionView.scrollToItem(at: indexpath, at: .left, animated: true)
            self.groupsCollectionView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu?.productCategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu?.productCategories[section].products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTVCell.identifier, for: indexPath) as! ProductsTVCell
        cell.delegate = self
        if let product = menu?.productCategories[indexPath.section].products[indexPath.row] {
            let index = cart.firstIndex { $0.product == product }
            if let index = index {
                cell.configureCell(product: product, count: cart[index].count)
            } else {
                cell.configureCell(product: product)
            }
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let title = UILabel(frame: CGRect(x: 10, y: -10, width: tableView.bounds.width - 20, height: 40))
        title.font = UIFont.systemFont(ofSize: CGFloat(22), weight: .bold)
        title.textColor = UIColor.darkGray
        title.text = menu?.productCategories[section].name
        headerView.addSubview(title)
        return headerView
    }
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if(section == currentSelected){
            currentSelected = section + 1
            let indexpath = IndexPath(row: section, section: 0)
            self.groupsCollectionView.scrollToItem(at: indexpath, at: .left, animated: true)
            self.groupsCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == groupsCollectionView {
            return menu?.productCategories.count ?? 0
        }
        return menu?.restaurantImages.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == groupsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as! GroupCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.backgroundColor = currentSelected == indexPath.row ? UIColor.opaqueSeparator : UIColor.clear
            cell.configureCell(categoryName: menu?.productCategories[indexPath.item].name)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if let vc = cell.viewWithTag(1) as? UIImageView {
                vc.kf.setImage(with: menu?.restaurantImages[indexPath.item].url)
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPath1 = IndexPath(row: 1, section: indexPath.row)
        self.productsTV.scrollToRow(at: indexPath1, at: .top, animated: true)
        currentSelected = indexPath.row
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == groupsCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == groupsCollectionView{
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == groupsCollectionView {
            return 10
        }
        return 0
    }
}
