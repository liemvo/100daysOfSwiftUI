//
//  ContentView.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/9/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
	@Environment(\.managedObjectContext) var moc
	
	@FetchRequest(entity: User.entity(), sortDescriptors:[
		NSSortDescriptor(keyPath: \User.name, ascending: true)
	]) var users: FetchedResults<User>
	@State private var showingImagePicker = false
	@State private var showingAlert = false
	@State private var inputImage: UIImage?
	@State private var name: String = ""
	
	var body: some View {
		NavigationView {
			List {
				ForEach(users, id: \.self) {user in
					NavigationLink(destination: UserDetailView(user: user)) {
						HStack(spacing: 8) {
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
			.navigationBarTitle("Challenge1315")
			.navigationBarItems(trailing: Button(action: {
				self.showingImagePicker = true
			}){
				Image(systemName: "plus")
			})
			.sheet(isPresented: $showingImagePicker, onDismiss: addName) {
				ImagePicker(image: self.$inputImage)
			}
			.textFieldAlert(isShowing: $showingAlert, text: $name, title: Text("Edit Name!"), onDismiss: savedUser)
		}
	}
	
	private func addName() {
		self.showingAlert = true
	}
	
	private func savedUser() {
		let user = User(context: self.moc)
		user.id = UUID()
		user.name = self.name
		
		guard let inputImage  = inputImage else { return }

		user.imageData = inputImage.jpegData(compressionQuality: 0.9)
		
		try? self.moc.save()
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
