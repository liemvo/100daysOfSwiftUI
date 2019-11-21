//
//  FilterView.swift
//  CoreDataProject
//
//  Created by Liem Vo on 11/21/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct FilterView: View {
	
	@Environment(\.managedObjectContext) var moc
	@State var lastNameFilter = "A"
	
	var body: some View {
		VStack {
			FilteredList(sortKey: "firstName", filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
				Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
			}
			Button("Add Examples") {
				let taylor = Singer(context: self.moc)
				taylor.firstName = "Taylor"
				taylor.lastName = "Swift"
				
				let ed = Singer(context: self.moc)
				ed.firstName = "Ed"
				ed.lastName = "Sheeran"
				
				let adele = Singer(context: self.moc)
				adele.firstName = "Adele"
				adele.lastName = "Adkins"
				
				try? self.moc.save()
			}
			
			Button("Show A") {
				self.lastNameFilter = "A"
			}
			
			Button("Show S") {
				self.lastNameFilter = "S"
			}
		}
	}
}

struct FilterView_Previews: PreviewProvider {
	static var previews: some View {
		FilterView()
	}
}
