//
//  ContentView.swift
//  HotProspects
//
//  Created by Liem Vo on 12/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	
	var prospects = Prospects()
	
	
    var body: some View {
        TabView {
			ProspectsView(filter: .none)
				.environmentObject(prospects)
				.tabItem {
					Image(systemName: "person.3")
					Text("Everyone")
				}
			ProspectsView(filter: .contacted)
				.environmentObject(prospects)
				.tabItem {
					Image(systemName: "checkmark.circle")
					Text("Contacted")
				}
			ProspectsView(filter: .uncontacted)
				.environmentObject(prospects)
				.tabItem {
					Image(systemName: "questionmark.diamond")
					Text("Uncontacted")
				}
			MeView()
				.tabItem {
					Image(systemName: "person.crop.square")
					Text("Me")
				}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
