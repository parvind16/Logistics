//
//  DeliveryDescriptionView.swift
//  Logistic
//
//  Created by parvind bhatt on 20/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//
import UIKit
import SDWebImage

class DeliveryDescriptionView: UIView {
    // MARK: Constants
    static let imageViewHeight: CGFloat = 70
    static let descriptionLblMinHeightConstant: CGFloat = 70
    
    // MARK: Variables
    var data: DeliveryModel? {
        didSet {
            self.loadImage()
            self.loadDescription()
        }
    }
    
    var itemImageView: UIImageView!
    var itemDescriptionLabel: UILabel!
    
    // MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setUpUI()
        self.setUpConstraints()
    }
    
    // MARK: UIConfiguration
    private func setUpUI() {
        
        self.itemImageView = UIImageView.init(image: UIImage(named: "black_pin.png"))
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.layer.cornerRadius = DeliveryDescriptionView.imageViewHeight/2
        self.itemImageView.clipsToBounds = true
        self.itemImageView.backgroundColor = UIColor.gray
        self.addSubview(self.itemImageView)
        
        self.itemDescriptionLabel = UILabel()
        self.itemDescriptionLabel.textColor = .black
        self.itemDescriptionLabel.font = Theme.CustomFont.arialHebrewRegular(16)
        self.itemDescriptionLabel.textAlignment = .left
        self.itemDescriptionLabel.numberOfLines = 0
        self.itemDescriptionLabel.text = ""
        self.addSubview(self.itemDescriptionLabel)
    }
    
    private func setUpConstraints() {

       self.itemImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: DeliveryDescriptionView.imageViewHeight, heightConstant: DeliveryDescriptionView.imageViewHeight)
        
        self.itemDescriptionLabel.anchor(top: self.itemImageView.topAnchor, left: self.itemImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    self.itemDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: DeliveryDescriptionView.descriptionLblMinHeightConstant).isActive = true
    }
    
    //show description on label
    private func loadDescription() {
         self.itemDescriptionLabel?.text = "\(String(describing: data?.descriptionText ?? "")) at \(String(describing: data?.location?.address ?? ""))"

    }
    
    //show image if available in document directory else fetch from url and save it
    private func loadImage() {
        let image = UIImage(named: "black_pin.png")
        self.itemImageView.image = image
        if  let imageUrlString = self.data?.imageUrl, let url = URL(string: imageUrlString) {
            let lastPathComponent = url.lastPathComponent
            if  let image = imageAtFilePath(imagePath: lastPathComponent) {
                self.itemImageView.image = image
            } else {
                
                self.itemImageView?.sd_setImage(with: url, placeholderImage: image, options: SDWebImageOptions(rawValue: 0), completed: { [weak self] image, error, cacheType, imageURL in
                    guard self != nil else { return }

                    if let theImage = image {
                        saveImageAtPath(imagePath: lastPathComponent, image: theImage)

                    }

                })
                
            }
        } else {
            self.itemImageView.image = #imageLiteral(resourceName: "defaultIcon")
        }
    }
}
