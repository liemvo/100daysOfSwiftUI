//
//  MapView.swift
//  BucketList
//
//  Created by Liem Vo on 12/1/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import MapKit
import SwiftUI


struct MapView: UIViewRepresentable {
	
	class Coordinator: NSObject, MKMapViewDelegate {
		var parent: MapView
		
		init(_ parent: MapView) {
			self.parent = parent
		}
		
		func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
			print(mapView.centerCoordinate)
		}
		
		func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
			let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
			view.canShowCallout = true
			return view
		}
	}
	
	func makeCoordinator() -> MapView.Coordinator {
		Coordinator(self)
	}
	
	func makeUIView(context: Context) -> MKMapView {
		let mapView = MKMapView()
		mapView.delegate = context.coordinator
		
		let annotation = MKPointAnnotation()
		annotation.title = "London"
		annotation.subtitle = "Capital of England"
		annotation.coordinate  = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
		mapView.addAnnotation(annotation)
		mapView.centerCoordinate = annotation.coordinate
		
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
		
	}
}
