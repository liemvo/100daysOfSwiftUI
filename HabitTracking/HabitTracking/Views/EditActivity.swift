//
//  EditActivity.swift
//  HabitTracking
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct EditActivity: View {
	@Environment(\.presentationMode) var presentationMode
	
	static let types: [String] = ["Very Good", "Good", "Normal", "Bad", "Very Bad"]
	
	@Binding var activities: [Activity]
	@Binding var activity: Activity
	@State private var isShowAlert = false
	
	var body: some View {
		Form {
			
			TextField("Title", text: $activity.title)
				.padding(.bottom)
			
			Picker("Type", selection: $activity.type) {
				ForEach(Self.types, id: \.self) {
					Text($0)
				}
			}
			.padding(.bottom)
			
			TextField("Description", text: $activity.description)
				.padding(.bottom)
			
			
			Picker("Repeat times", selection: $activity.repeatTime)
			{
				ForEach(1...50, id:\.self) {
					Text("\($0)")
				}
			}.padding(.bottom)
			
		}
		.navigationBarTitle("Edit habit")
		.navigationBarItems(trailing: Button("Save") {
			if self.activity.title.count > 0 {
				
				self.activities = self.activities.map { $0.id == self.activity.id ? self.activity : $0 }
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
