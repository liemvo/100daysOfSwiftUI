//
//  ContentView.swift
//  HabitTracking
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var activities = Activities()
	
	@State private var showingAddActivity = false
	var body: some View {
		NavigationView {
			List {
				if activities.isEmpty() {
					Text("You have no habits")
				} else {
					ForEach(activities.activities) { index in
						ActivityRow(activity: self.$activities.activities[index], activities: self.$activities.activities)
					}
					.onDelete { indexSet in
						self.activities.activities.remove(atOffsets: indexSet)
					}
				}
			}
			.navigationBarTitle("Habits")
			.navigationBarItems(leading: EditButton(), trailing: Button(action: {
				self.showingAddActivity.toggle()
			}) {
				Image(systemName: "plus")
			})
				.sheet(isPresented: $showingAddActivity) {
					AddActivity(activities: self.activities)
			}
		}
	}
	
	private func removeActivity(at offsets: IndexSet) {
		self.activities.activities.remove(atOffsets: offsets)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
