//
//  ContentView.swift
//  Moonshot
//
//  Created by Liem Vo on 11/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	let missions: [Mission] = Bundle.main.decode("missions.json")
	let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	
	@State private var showLaunchDate = true
	var body: some View {
		NavigationView {
			List(missions) { mission in
				NavigationLink(destination: MissonView(mission: mission, astronauts: self.astronauts)) {
					
					Image(mission.image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 44, height: 44)
						.accessibility(label: Text("Image of \(mission.displayName)"))
					
					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.headline)
						Text(self.showLaunchDate ? mission.formattedLaunchDate : mission.crewName)
					}
				}.accessibility(label: Text("View of mission \(mission.displayName)"))
				
			}
			.navigationBarTitle("MoonShot")
			.navigationBarItems(trailing:
				Button(showLaunchDate ? "Show Crew" : "Show Launch Date") {
				self.showLaunchDate.toggle()
			})
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
