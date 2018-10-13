//
//  SonectAnnoationView.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import MapKit
import Reusable

final class SonectAnnoationView: MKAnnotationView, NibReusable {
    // MARK:- IBOutlets
    
    // MARK:- Properties
    static let reuseIdentifier = "sonectAnnatation"
    
    // MARK:- func
    func fill(atm: Atm) {
        self.image = UIImage(named: Asset.cash.name)
        self.clusteringIdentifier = SonectAnnoationView.reuseIdentifier
        self.canShowCallout = true
        
        let myView: DetailsCalloutView = DetailsCalloutView.loadFromNib()
        
        let widthConstraint = NSLayoutConstraint(item: myView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        myView.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: myView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        myView.addConstraint(heightConstraint)
        
        myView.fill(atm: atm)
        
        self.detailCalloutAccessoryView = myView
    }
}
