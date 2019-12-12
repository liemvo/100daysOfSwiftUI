//
//  UserAnnotation.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation
import MapKit


class UserAnnotation:  MKPointAnnotation {

	override init() {
        super.init()
    }
	
	init(_ coordinate: CLLocationCoordinate2D) {
		super.init()
		self.coordinate = coordinate
	}
}
