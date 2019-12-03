//
//  MKPointAnnotation.swift
//  BucketList
//
//  Created by Liem Vo on 12/3/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import MapKit


extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
