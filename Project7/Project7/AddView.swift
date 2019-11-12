//
//  AddView.swift
//  Project7
//
//  Created by Liem Vo on 11/10/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct AddView: View {
	@Environment(\.presentationMode) var presentationMode
	@State private var name = ""
	@State private var type = "Personal"
	@State private var amount = ""
	static let types = ["Business", "Personal"]
	
	@ObservedObject var expenses: Expenses
	@State private var isShowAlert = false
	
    var body: some View {
		NavigationView {
			Form {
				TextField("Name", text: $name)
				
				Picker("Type", selection: $type) {
					ForEach(Self.types, id: \.self) {
						Text($0)
					}
				}
				
				TextField("Amount", text: $amount)
					.keyboardType(.numberPad)
			}
		.navigationBarTitle("Add new expense")
			.navigationBarItems(trailing: Button("Save") {
				if let amount = Double(self.amount) {
					let item = ExpenseItem(name: self.name, type: self.type, amount: amount)
					self.expenses.items.append(item)
					self.presentationMode.wrappedValue.dismiss()
				} else {
					self.isShowAlert = true
				}
			}).alert(isPresented: $isShowAlert) {
				Alert(title: Text("Invalidate amout"), message: Text("Please enter a valid number"), dismissButton: .default(Text("Cancel")) {
					self.isShowAlert = false
				})
			}
		}
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
