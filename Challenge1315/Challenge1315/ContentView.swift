//
//  ContentView.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/9/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import CoreData
import MapKit

struct ContentView: View {
	@Environment(\.managedObjectContext) var moc
	
	@FetchRequest(entity: User.entity(), sortDescriptors:[
		NSSortDescriptor(keyPath: \User.name, ascending: true)
	]) var users: FetchedResults<User>
	@State private var showingImagePicker = false
	@State private var showingAddName = false
	@State private var inputImage: UIImage?
	@State private var name: String = ""
	@State private var lastKnownLocation: CLLocationCoordinate2D?
	
	var body: some View {
		NavigationView {
			VStack {
				if self.showingAddName {
					EditName(text: self.$name, lastKnownLocation: self.$lastKnownLocation) {
						self.savedUser()
					}
				} else {
					List {
						ForEach(users, id: \.self) {user in
							NavigationLink(destination: UserDetailView(user: user)) {
								HStack(spacing: CGFloat(8)) {
									user.wrappedImage
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: CGFloat(80), height: CGFloat(120))
									Text(user.wrappedName)
										.font(.headline)
								}
							}
						}
					}
				}
			}
			.sheet(isPresented: $showingImagePicker, onDismiss: addName) {
				ImagePicker(image: self.$inputImage)
			}
			.navigationBarTitle("Challenge1315")
			.navigationBarItems(trailing: Button(action: {
				self.showingImagePicker = true
			}){
				Image(systemName: "plus")
			})
		}
	}
	
	private func addName() {
		self.showingImagePicker = false
		self.showingAddName = true
	}
	
	private func savedUser() {
		self.showingAddName = false
		if name.isEmpty { return }
		let user = User(context: self.moc)
		user.id = UUID()
		user.name = self.name
		user.latitude = self.lastKnownLocation?.latitude ?? 0.0
		user.longitude = self.lastKnownLocation?.longitude ?? 0.0
		
		guard let inputImage  = inputImage else { return }
		
		user.imageData = inputImage.jpegData(compressionQuality: 0.9)
		
		try? self.moc.save()
		self.name = ""
		self.inputImage = nil
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
