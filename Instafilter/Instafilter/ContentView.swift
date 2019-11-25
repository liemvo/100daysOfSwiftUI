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

struct ContentView: View {
	
	@State private var image: Image?
	@State private var showingImagePicker  = false
	var body: some View {
		VStack {
			image?.resizable()
			.scaledToFit()
			
			Button("Select Image") {
				self.showingImagePicker = true
			}
		}
		.sheet(isPresented: $showingImagePicker) {
			ImagePicker()
		}
	}
	
	private func loadImage() {
		guard let inputImage = UIImage(named: "hcm") else { return }
		
		let begingImage = CIImage(image: inputImage)
		let context = CIContext()
		let currentFilter = CIFilter.sepiaTone()
		
		currentFilter.inputImage = begingImage
		currentFilter.intensity = 1
		
		guard let outputImage = currentFilter.outputImage else { return }
		if let cgimage = context.createCGImage(outputImage, from: outputImage.extent){
			let uiImage = UIImage(cgImage: cgimage)
			image = Image(uiImage: uiImage)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
