//
//  ActivityRow.swift
//  HabitTracking
//
//  Created by Liem Vo on 11/17/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ActivityRow: View {

	@Binding var activity: Activity
	@Binding var activities: [Activity]
    var body: some View {
		NavigationLink(destination: EditActivity(activities: $activities, activity: $activity)) {
			HStack {
				VStack(alignment: .leading) {
					Text(self.activity.title).font(.headline)
					Text(self.activity.description).foregroundColor(.gray)
				}
				Spacer()
				Text("Times: \(self.activity.repeatTime)")
					.font(.body)
					.foregroundColor(.gray)
			}
		}
    }
}
