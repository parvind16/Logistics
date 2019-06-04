//
//  DeliveryCell.swift
//  Logistic
//
//  Created by parvind bhatt on 18/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import UIKit

class DeliveryCell: UITableViewCell {
    static let imageViewHeight: CGFloat = 70

    // Variables
    var imageIconView: UIImageView?
    var descriptionLabel: UILabel?
    
    var deliveryModel: DeliveryModel? {
        didSet {
            descriptionLabel?.text = "\(String(describing: deliveryModel?.descriptionText ?? "")) at \(String(describing: deliveryModel?.location?.address ?? ""))"
            if let imageUrl = deliveryModel?.imageUrl {
                imageIconView?.sd_setImage(with: URL(string: imageUrl), completed: nil)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Functions
    func setupUI() {
        // Image
        imageIconView = UIImageView()
        imageIconView?.contentMode = .scaleAspectFill
        self.imageIconView?.layer.cornerRadius = NumericConstants.kCellImageHeight/2
        imageIconView?.clipsToBounds = true

        self.addSubview(imageIconView!)
        
        // Label
        descriptionLabel = UILabel()
        descriptionLabel?.font = Theme.CustomFont.arialHebrewRegular(14)
        self.descriptionLabel?.numberOfLines = 0
        self.descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel?.text = nil
        self.descriptionLabel?.contentMode = .topLeft
        self.addSubview(descriptionLabel!)
        
        self.imageIconView?.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: NumericConstants.kCellImageWidth, heightConstant: NumericConstants.kCellImageHeight)
        
        self.descriptionLabel?.anchor(top: self.imageIconView?.topAnchor, left: self.imageIconView?.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
      self.descriptionLabel?.heightAnchor.constraint(greaterThanOrEqualToConstant: NumericConstants.kdescriptionLblMinHeightConstant).isActive = true
        
        self.descriptionLabel?.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(NumericConstants.kCellImageWidth)).isActive = true
        
        self.accessoryType = .disclosureIndicator
    }
}
