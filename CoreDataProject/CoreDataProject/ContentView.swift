//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Liem Vo on 11/21/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
	
	var body: some View {
		VStack {
			List {
				ForEach(countries, id:\.self) { country in
					Section(header: Text(country.wrappedFullName)) {
						ForEach(country.candyArray, id: \.self) { candy in
							Text(candy.wrappedName)
						}
					}
				}
			}
			
			Button("Add") {
				let country1 = Country(context: self.moc)
				country1.shortName = "UK"
				country1.fullName = "United Kingdom"
				
				let country2 = Country(context: self.moc)
				country2.shortName = "CH"
				country2.fullName = "Switzerland"
				
				let candy1 = Candy(context: self.moc)
				candy1.name = "Mars"
				candy1.origin = country1
				
				let candy2 = Candy(context: self.moc)
				candy2.name = "KitKat"
				candy2.origin = country1
				
				let candy3 = Candy(context: self.moc)
				candy3.name = "Twix"
				candy3.origin = country1
				
				let candy4 = Candy(context: self.moc)
				candy4.name = "Toblerone"
				candy4.origin = country2
				
				try? self.moc.save()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
