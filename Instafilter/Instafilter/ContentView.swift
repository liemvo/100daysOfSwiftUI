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
	@State private var filterIntensity = 0.5
	
	@State private var showingImagePicker = false
	@State private var inputImage: UIImage?
	
	@State var currentFilter = CIFilter.sepiaTone()
	let context = CIContext()
	
	
	var body: some View {
		
		let intensity = Binding<Double> (
			get: {
				self.filterIntensity
			},
			set: {
				self.filterIntensity = $0
				self.applyProcessing()
			}
		)
		return NavigationView {
			VStack {
				ZStack {
					Rectangle()
						.fill(Color.secondary)
					if image != nil {
						image?.resizable()
						.scaledToFit()
					} else {
						Text("Tap to select a  picture")
							.foregroundColor(.white)
							.font(.headline)
					}
				}
				.onTapGesture {
					self.showingImagePicker = true
				}
				
				HStack {
					Text("Intensity")
					Slider(value: intensity)
				}
				
				HStack {
					Button("Change Filter") {
						
					}
					Spacer()
					Button("Save") {
						
					}
				}
			}
			.padding([.horizontal, .bottom])
			.navigationBarTitle("Intafilter")
			.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
				ImagePicker(image: self.$inputImage)
			}
		}
	}
	
	private func loadImage() {
		guard let inputImage  = inputImage else { return }
		let beginImage = CIImage(image: inputImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		applyProcessing()
	}
	
	private func  applyProcessing() {
		currentFilter.intensity = Float(filterIntensity)
		
		guard let outputImage = currentFilter.outputImage else { return }
		
		if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
			let uiImage  = UIImage(cgImage: cgimg)
			image  = Image(uiImage: uiImage)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
