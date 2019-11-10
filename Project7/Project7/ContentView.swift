//
//  ContentView.swift
//  Project7
//
//  Created by Liem Vo on 11/10/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var expenses = Expenses()
	@State private var showingAddExpense = false
	var body: some View {
		NavigationView {
			List {
				ForEach(expenses.items) { item in
					HStack {
						VStack(alignment: .leading) {
							Text(item.name).font(.headline)
							Text(item.type).foregroundColor(.gray)
						}
						Spacer()
						Text("$\(item.amount, specifier: "%g")")
							.font(.body)
							.background(self.backgroundColor(amount: item.amount))
						.foregroundColor(.white)
					}
				}
				.onDelete(perform: removeItems)
			}
			.navigationBarTitle("iExpense")
			.navigationBarItems(leading: EditButton(), trailing:
				Button(action: {
					self.showingAddExpense.toggle()
				}){
					Image(systemName: "plus")
			})
				.sheet(isPresented: $showingAddExpense) {
					AddView(expenses: self.expenses)
			}
		}
	}
	
	private func removeItems(at offsets: IndexSet) {
		self.expenses.items.remove(atOffsets: offsets)
	}
	
	private func backgroundColor(amount: Double) -> Color {
		if amount < 10.0 {
			return Color.green
		} else if amount < 100.0 {
			return Color.blue
		} else {
			return Color.red
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
