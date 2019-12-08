//
//  AstronautView.swift
//  Moonshot
//
//  Created by Liem Vo on 11/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
	let astronaut: Astronaut
	let missions: [Mission]
	var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					Image(self.astronaut.id)
						.resizable()
						.scaledToFit()
						.frame(width: geometry.size.width)
						.accessibility(label: Text("Astronaut id: \(self.astronaut.id)"))
					Text(self.astronaut.description)
						.padding()
						.layoutPriority(Double(1))
						.accessibility(label: Text("Astronaut description: \(self.astronaut.description)"))
					
					ForEach(self.missions) { mission in
						HStack {
							Image(mission.image)
							.resizable()
							.scaledToFit()
								.frame(width: 60, height: 60)
								.clipShape(Circle())
								.overlay(Circle().stroke(Color.primary, lineWidth: 1))
							
							VStack(alignment: .leading) {
								Text(mission.formattedLaunchDate)
									.font(.headline)
								Text(mission.displayName)
									.foregroundColor(.secondary)
							}
							
							Spacer()
						}.padding()
							.accessibility(label: Text("mission item: \(mission.displayName)"))
					}
					.accessibility(label: Text("All missions of this astronaut: \(self.astronaut.name)"))
					.buttonStyle(PlainButtonStyle())
				}
			}
		}
		.navigationBarTitle(Text(astronaut.name))
	}
	
	init(astronaut: Astronaut) {
		
		let allMissions: [Mission] = Bundle.main.decode("missions.json")
		self.astronaut = astronaut
		
		var missions = [Mission]()
		
		for mission in allMissions {
			if mission.crew.first(where: {$0.name == astronaut.id }) != nil {
				missions.append(mission)
			}
		}
		
		self.missions = missions
	}
}

struct AstronautView_Previews: PreviewProvider {
	static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	static var previews: some View {
		AstronautView(astronaut: astronauts[2])
	}
}
