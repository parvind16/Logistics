//
//  DeliveryDetailView.swift
//  Logistic
//
//  Created by parvind bhatt on 18/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//
import UIKit

typealias RetryClosure = (() -> Void)

class DeliveryListView: UIView {
    
    // MARK: Variables
    var deliveryTableView: UITableView!
    var noResultMessageLabel: UILabel!
    var retryButton: UIButton = UIButton(type: .roundedRect)
    var retryHandler: RetryClosure?

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        inititalUISetUP()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func inititalUISetUP() {
        setupTableView()
        setUpLabel()
        setUpRetryButton()
        setUpConstraints()
    }
    
    /// Method to setup tableView
    private func setupTableView() {
        self.backgroundColor = .white
        self.deliveryTableView = UITableView.init()
        self.deliveryTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.deliveryTableView)
        let footer = UIView()
        self.deliveryTableView.tableFooterView = footer
        
        deliveryTableView.register(DeliveryCell.self, forCellReuseIdentifier: ViewIdentifier.kTableViewCellIdentifier)
        deliveryTableView.allowsSelection = true
        deliveryTableView.backgroundColor = UIColor.lightText
        deliveryTableView.separatorStyle = .singleLine
        deliveryTableView.rowHeight = UITableView.automaticDimension
        deliveryTableView.estimatedRowHeight = NumericConstants.kEstimatedRowHeight

        deliveryTableView.translatesAutoresizingMaskIntoConstraints = false
        deliveryTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        deliveryTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        deliveryTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    private func setUpLabel() {
        //Message lable if no result found
        self.noResultMessageLabel = UILabel.init()
        self.noResultMessageLabel.font = Theme.CustomFont.arialHebrewBold(20)
        self.noResultMessageLabel.textColor = UIColor.lightGray
        self.noResultMessageLabel.text = LocalizationConstant.noResultFound
        self.noResultMessageLabel.textAlignment = .center
        self.noResultMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noResultMessageLabel.numberOfLines = 0
        self.noResultMessageLabel.isHidden = true
        self.addSubview(self.noResultMessageLabel)
    }
    
    private func setUpRetryButton() {
        // Button
        retryButton.frame = CGRect(x: .kXZero, y: .kYZero, width: NumericConstants.kRetryButtonWidth, height: NumericConstants.kRetryButtonHeight)
        retryButton.setTitle(LocalizationConstant.retryButtonTitle, for: .normal)
        retryButton.layer.borderColor = UIColor.blue.cgColor
        retryButton.layer.cornerRadius = NumericConstants.kCornerRadius
        retryButton.layer.borderWidth = NumericConstants.kBorderWidth
        retryButton.addTarget(self, action: #selector(retryAgain), for: .touchUpInside)
        self.addSubview(retryButton)
        retryButton.center = self.center
        retryButton.isHidden = true
    }
    
    private func setUpConstraints() {
        self.deliveryTableView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        self.noResultMessageLabel.widthAnchor.constraint(equalToConstant: NumericConstants.messageLblHightConstant).isActive = true
        self.noResultMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.noResultMessageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func showRetryButton() {
        DispatchQueue.main.async {[weak self] in
            self?.deliveryTableView?.isHidden = true
            self?.retryButton.center = self?.center ?? CGPoint.zero
            self?.retryButton.isHidden = false
        }
    }
    
    @objc func retryAgain() {
        retryHandler?()
    }
    
    func setupFooter(_ hasNextPage: Bool) {
        if hasNextPage {
            let view = UIActivityIndicatorView(frame: CGRect(x: .kXZero, y: .kYZero, width: .kActivityViewWidth, height: .kActivityViewHeight))
            view.style = .whiteLarge
            view.color = .gray
            view.startAnimating()
            self.deliveryTableView?.tableFooterView = view
        } else {
            self.deliveryTableView?.tableFooterView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: self.deliveryTableView?.bounds.width ?? 0, height: 8))
        }
    }
}
