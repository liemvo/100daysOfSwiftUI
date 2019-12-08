//
//  MissonView.swift
//  Moonshot
//
//  Created by Liem Vo on 11/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct MissonView: View {
	struct CrewMemeber {
		let role: String
		let astronaut: Astronaut
	}
	
	let mission: Mission
	let astronauts: [CrewMemeber]
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					Image(self.mission.image)
						.resizable()
						.scaledToFit()
						.frame(maxWidth: geometry.size.width * 0.7)
						.padding(.top)
					Text(self.mission.formattedLaunchDate)
						.accessibility(label: Text("Mission launch date \(self.mission.formattedLaunchDate)"))
					
					Text(self.mission.description)
						.padding()
					accessibility(label: Text("Mission description: \(self.mission.description)"))
					
					ForEach(self.astronauts, id: \.role) { crewMember in
						NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
							HStack {
								Image(crewMember.astronaut.id)
									.resizable()
									.frame(width: 83, height: 60)
									.clipShape(Capsule())
									.overlay(Capsule().stroke(Color.primary, lineWidth: 1))
								
								VStack(alignment: .leading) {
									Text(crewMember.astronaut.name)
										.font(.headline)
									Text(crewMember.role)
										.foregroundColor(.secondary)
								}
								
								Spacer()
							}
							.accessibilityElement(children: .ignore)
							.accessibility(label: Text("Astronaut: \(crewMember.astronaut.name) and role: \(crewMember.role)"))
						}
						.padding(.horizontal)
					}
					.buttonStyle(PlainButtonStyle())
					
					Spacer(minLength: CGFloat(25.0))
				}
			}
		}
		.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
	}
	
	init(mission: Mission, astronauts: [Astronaut]) {
		self.mission = mission
		
		var matches = [CrewMemeber]()
		
		for member in mission.crew {
			if let match = astronauts.first(where: {$0.id == member.name }) {
				matches.append(CrewMemeber(role: member.role, astronaut: match))
			} else {
				fatalError("Missing \(member)")
			}
		}
		
		self.astronauts = matches
	}
}

struct MissonView_Previews: PreviewProvider {
	static let missions: [Mission] = Bundle.main.decode("mission.json")
	static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	static var previews: some View {
		MissonView(mission: missions[0], astronauts: astronauts)
	}
}
