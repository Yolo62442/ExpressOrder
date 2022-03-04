//
//  ViewController.swift
//  ExpressOrder
//
//  Created by Ainura on 27.02.2022.
//

import UIKit

protocol CartDelegate: AnyObject {
    func addToCart(id: Int)
    func removeFromCart(id: Int)
}



class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var productBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cartTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productsTV: UITableView!
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var cartButtonView: UIView!
    @IBOutlet weak var cartButton: UIView!
    var cart: [Int:Int] = [:]
    var imagesArr = [
        UIImage(named: "testImage"),
        UIImage(named: "testImage"),
        UIImage(named: "testImage")
    ]
    var sections = [ "Group1", "Group2", "Group3"]
    var menu: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
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
    @IBAction func cartButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CartDelegate
extension MainMenuViewController: CartDelegate{
    func addToCart(id: Int) {
        if(cart.keys.contains(id)){
            cart[id]! += 1
        }else{
            cart[id] = 1
        }
        cartButtonView.isHidden = false
        productBottomConstraint.isActive = false
        cartTopConstraint.isActive = true
    }
    func removeFromCart(id: Int) {
        if(cart[id] == 1){
            cart.removeValue(forKey: id)
        }else{
            cart[id]! -= 1
        }
        if(cart.isEmpty){
            cartButtonView.isHidden = true
            cartTopConstraint.isActive = false
            productBottomConstraint.isActive = true
        }
    }
}

//MARK: - UITableViewDelegate
extension MainMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTVCell.identifier, for: indexPath) as! ProductsTVCell
        cell.id = indexPath.row
        cell.delegate = self
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let title = UILabel(frame: CGRect(x: 10, y: -10, width: 80, height: 40))
        title.font = UIFont.systemFont(ofSize: CGFloat(22), weight: .bold)
        title.textColor = UIColor.darkGray
        title.text = sections[section]
        headerView.addSubview(title)
        return headerView
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == groupsCollectionView{
            return 3
        }else{
            return imagesArr.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if collectionView == groupsCollectionView{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as! GroupCollectionViewCell
            return cell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if let vc = cell.viewWithTag(1) as? UIImageView{
                vc.image = imagesArr[indexPath.row]
            }
            return cell
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainMenuViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == groupsCollectionView{
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
        if collectionView == groupsCollectionView{
            return 10
        }
        return 0
    }
}
