//
//  SonectAnnotation.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import MapKit

final class SonectAnnotation: MKPointAnnotation {
    var atm: Atm
    
    init(atm: Atm) {
        self.atm = atm
        super.init()
        let latitude = Double(atm.latitude ?? "0") ?? 0.0
        let longitude = Double(atm.longitude ?? "0") ?? 0.0
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.title = self.atm.name
        self.subtitle = self.atm.category
    }
}
