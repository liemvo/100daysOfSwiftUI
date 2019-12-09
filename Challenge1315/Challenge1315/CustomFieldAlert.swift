//
//  CustomFieldAlert.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/9/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {
	@Binding var isShowing: Bool
	@Binding var text: String
	let presenting: Presenting
	let title: Text
	var onDismiss:  (() -> Void) = {}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				self.presenting
					.disabled(self.isShowing)
				VStack {
					self.title
					TextField("Insert name", text: self.$text)
					
					Divider()
					HStack {
						Button(action: {
							withAnimation {
								self.isShowing.toggle()
								self.onDismiss()
							}
						}) {
							Text("Dismiss")
						}
					}
				}
				.padding()
				.background(Color.white)
				.frame(maxWidth: geometry.size.width * 0.7, maxHeight: geometry.size.height * 0.7)
				.shadow(radius: 1)
				.opacity(self.isShowing ? 0.9 : 0)
				
			}
		}
		
	}
}

extension View {
	
	func textFieldAlert(isShowing: Binding<Bool>,
						text: Binding<String>,
						title: Text,
						onDismiss: @escaping (() -> Void) = {}) -> some View {
		TextFieldAlert(isShowing: isShowing,
					   text: text,
					   presenting: self,
					   title: title,
					   onDismiss: onDismiss)
	}
	
}

