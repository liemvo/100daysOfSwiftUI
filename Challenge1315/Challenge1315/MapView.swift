//
//  MapView.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
	var location: CLLocationCoordinate2D?
	
	func makeUIView(context: Context) -> MKMapView {
		MKMapView(frame: .zero)
	}
	
	func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
		guard let coordinate = location else { return }
		let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
		
		let annotation = UserAnnotation(coordinate)
		mapView.addAnnotations([annotation])
	}
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
