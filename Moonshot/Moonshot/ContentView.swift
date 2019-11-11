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
	var body: some View {
		NavigationView {
			List(missions) { mission in
				NavigationLink(destination: Text("Detail View")) {
					Image(mission.image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 44, height: 44)
					
					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.headline)
						Text(mission.formattedLaunchDate)
					}
				}
				
			}
			.navigationBarTitle("MoonShot")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
