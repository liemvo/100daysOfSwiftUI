//
//  AddActivity.swift
//  HabitTracking
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct AddActivity: View {
	
	@Environment(\.presentationMode) var presentationMode
	@State private var title = ""
	@State private var type: HabitType = .Good
	@State private var description = ""
	@State private var repeatTime = 1
	
	let types: [HabitType] = [.VeryGood, .Good, .Normal, .Bad, .VeryBad]
	
	@ObservedObject var activities: Activities
	@State private var isShowAlert = false
	
	var body: some View {
		NavigationView {
			Form {
				
				TextField("Title", text: $title)
					.padding(.bottom)
				
				Picker("Type", selection: $type) {
					ForEach(self.types, id: \.self) {
						Text($0.rawValue)
					}
				}
				.padding(.bottom)
				
				TextField("Description", text: $description)
					.padding(.bottom)
				
				
				Picker("Repeat times", selection: $repeatTime)
				{
					ForEach(1...50, id:\.self) {
						Text("\($0)")
					}
				}.padding(.bottom)
			}
			.navigationBarTitle(Text("Add habit"), displayMode: .inline)
			.navigationBarItems(trailing: Button("Save") {
				if self.title.count > 0 {
					
					let activity = Activity(title: self.title, type: self.type.rawValue, description: self.description, repeatTime: self.repeatTime)
					self.activities.activities.append(activity)
					self.presentationMode.wrappedValue.dismiss()
					
				} else {
					self.isShowAlert = true
				}
			}.alert(isPresented: $isShowAlert) {
				Alert(title: Text("Missing title"), message: Text("Please add the title of your habit"), dismissButton: .default(Text("Cancel")) {
					self.isShowAlert = false
					})
			})
		}
	}
}

struct AddActivity_Previews: PreviewProvider {
	static let activities = Activities()
	static var previews: some View {
		AddActivity(activities: activities)
	}
}
