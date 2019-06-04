//
//  DeliveryListViewController.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import UIKit

class DeliveryListViewController: UIViewController {

    ///view components
    var deliverySubView: DeliveryListView!

    var presentor: DeliveryPresenterProtocol?
    
    var deliveryList: [DeliveryModel] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    /// This method will do inital setup of the view controller
    func initialSetup() {
        self.title = LocalizationConstant.navigationTitle
        self.view.backgroundColor = .white
        self.deliverySubView = DeliveryListView.init()
        self.view.addSubview(self.deliverySubView)
        self.setupRefreshControl()
        self.deliverySubView.deliveryTableView.accessibilityIdentifier = ViewIdentifier.kTabelIdentifier
        self.navigationController?.navigationBar.accessibilityIdentifier = ViewIdentifier.kNavigationIdentifier
    
        self.deliverySubView.deliveryTableView.delegate = self
        self.deliverySubView.deliveryTableView.dataSource = self
        
        setUpConstraints()
        presentor?.startFetchingDeliverList(false, loadMore: false)
        
        deliverySubView.retryHandler = { [weak self] in
            guard let unownedSelf = self else {
                return
            }
            unownedSelf.presentor?.startFetchingDeliverList(true, loadMore: false)
        }

    }
    
    private func setUpConstraints() {
        if #available(iOS 11, *) {
            self.deliverySubView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
        } else {
            self.deliverySubView.anchor(top: self.topLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.topLayoutGuide.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
        }
    }
    /// Method to setup refresh control
    private func setupRefreshControl() {
        self.deliverySubView.deliveryTableView.refreshControl = UIRefreshControl()
        self.deliverySubView.deliveryTableView.refreshControl?.attributedTitle = NSAttributedString(
            string: LocalizationConstant.refreshTitle)
        self.deliverySubView.deliveryTableView.refreshControl?.addTarget(self, action: #selector(DeliveryListViewController.refreshDeliveryTabel),
                                  for: .valueChanged)
    }
   
    @objc func refreshDeliveryTabel() {
        presentor?.startFetchingDeliverList(true, loadMore: false)
    }
    
}

extension DeliveryListViewController: DeliveryViewProtocol {
    
    func showDeliveryList() {
        DispatchQueue.main.async { [weak self] in
            guard let unownedSelf = self else {return}
            unownedSelf.deliverySubView.noResultMessageLabel.isHidden = true
            unownedSelf.deliverySubView.deliveryTableView.isHidden = false
            unownedSelf.deliverySubView.retryButton.isHidden = true
            unownedSelf.deliverySubView.deliveryTableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let unownedSelf = self else {return}
            
            let count = unownedSelf.presentor?.numberOfDeliveryItems() ?? 0
            if count == 0 {
                unownedSelf.deliverySubView?.showRetryButton()
            }
            
            let alert = UIAlertController(title: LocalizationConstant.alert, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: LocalizationConstant.alertButtonOKTitle, style: UIAlertAction.Style.default, handler: nil))
            unownedSelf.present(alert, animated: true, completion: nil)
        }
    }
    
    func setLoadingVisible(_ visible: Bool, loadMore: Bool) {

        if visible && loadMore {
            deliverySubView.setupFooter(true)
            
        } else if visible {
            showProgressIndicator(view: self.view)

        } else {
            hideProgressIndicator(view: self.view)
            deliverySubView.setupFooter(false)
            deliverySubView.deliveryTableView.refreshControl?.endRefreshing()
            deliverySubView.deliveryTableView.reloadData()
        }
    }
    
    func showEmptyMessage() {
        /// show no result label if data not found
         let count = presentor?.numberOfDeliveryItems() ?? 0
         self.deliverySubView.noResultMessageLabel.isHidden = count > 0
    }
    
}

extension DeliveryListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentor?.numberOfDeliveryItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ViewIdentifier.kTableViewCellIdentifier) as? DeliveryCell
        if cell == nil {
            cell = DeliveryCell.init(style: .default, reuseIdentifier: ViewIdentifier.kTableViewCellIdentifier)
            cell?.selectionStyle = .gray
        }
        cell?.deliveryModel = presentor?.listItemViewModel(at: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentor?.didSelectItem(at: indexPath, navigationController: navigationController!)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let yOffset = CGFloat((self.deliverySubView.deliveryTableView?.contentOffset.y)!)
        let tableHeight = (self.deliverySubView.deliveryTableView?.frame.size.height)!
        let contentsHeight = (self.deliverySubView.deliveryTableView?.contentSize.height)!
        
        if (yOffset + tableHeight) >= (contentsHeight - NumericConstants.someOffset) {
            presentor?.startFetchingDeliverList(false, loadMore: true)
            }
    }
}
