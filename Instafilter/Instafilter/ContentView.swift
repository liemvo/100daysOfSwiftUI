//
//  ContentView.swift
//  Instafilter
//
//  Created by Liem Vo on 11/24/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

class ImageSaver: NSObject {
	func writeToPhotoAlbum(image: UIImage) {
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
	}
	
	@objc private func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		print("Save finish")
	}
}

struct ContentView: View {
	
	@State private var image: Image?
	@State private var showingImagePicker  = false
	@State private var inputImage: UIImage?
	
	var body: some View {
		VStack {
			image?.resizable()
			.scaledToFit()
			
			Button("Select Image") {
				self.showingImagePicker = true
			}
		}
		.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
			ImagePicker(image: self.$inputImage)
		}
	}
	
	private func loadImage() {
		guard let inputImage = inputImage else { return }
		image = Image(uiImage: inputImage)
		let imageSaver  =  ImageSaver()
		imageSaver.writeToPhotoAlbum(image: inputImage)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
