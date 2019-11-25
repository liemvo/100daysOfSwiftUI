//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Liem Vo on 11/25/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
	func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
		
	}
}

