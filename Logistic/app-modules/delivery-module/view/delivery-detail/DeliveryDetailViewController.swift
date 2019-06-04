//
//  DeliveryDetailViewController.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {

    var presentor: DeliveryPresenterProtocol?
    var deliveryDetailView: DeliveryDetailView!
    var deliveryDetail: DeliveryModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  LocalizationConstant.detailNavigationTitle
        initialSetup()
    }

    func initialSetup() {
        self.setUpUI()
        self.setUpConstraints()
        self.updateUI()
    }
    
    // MARK: UI Configuration
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.deliveryDetailView = DeliveryDetailView.init()
        self.view.addSubview(self.deliveryDetailView)
        self.deliveryDetailView.mapView.delegate = self
    }
    
    private func setUpConstraints() {
        if #available(iOS 11, *) {
            self.deliveryDetailView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
        } else {
            self.deliveryDetailView.anchor(top: self.topLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.topLayoutGuide.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
        }
    }
    
    private func updateUI() {
        self.showImageAndDescription(deliveryItem: self.deliveryDetail)
        if let lat = self.deliveryDetail.location?.lat, let long = self.deliveryDetail.location?.lng {
            self.showAnnotatiOnMapView(lat: lat, long: long, address: self.deliveryDetail.location?.address)
        }
    }
    
    func showAnnotatiOnMapView(lat: Double, long: Double, address: String?) {
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.deliveryDetailView.mapView.setRegion(region, animated: true)
        let pinLocation = MKPointAnnotation()
        if let theAddress = address {
            pinLocation.title = theAddress
        }
        pinLocation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.deliveryDetailView.mapView.addAnnotation(pinLocation)
    }
    
    private func showImageAndDescription(deliveryItem: DeliveryModel!) {
        self.deliveryDetailView.deliveryDescriptionView.data = deliveryItem
    }
}

// MARK: MapViewDelegate
extension DeliveryDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ViewIdentifier.anotationIdentifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: ViewIdentifier.anotationIdentifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
