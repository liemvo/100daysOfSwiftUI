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
	@State private var filterIntensity = 0.5
	@State private var filterRadius = 30.5
	
	@State private var showingImagePicker = false
	@State private var showingFilterSheet = false
	
	@State private var inputImage: UIImage?
	@State private var processedImage: UIImage?
	
	@State var currentFilter: CIFilter = CIFilter.sepiaTone()
	@State private var isShowingErrorSave = false
	@State private var filterName = "Change Filter"
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
		
		let radius = Binding<Double> (
			get: {
				self.filterRadius
			},
			set: {
				self.filterRadius = $0
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
					Text("Radius")
					Slider(value: radius)
				}
				HStack {
					Button(self.filterName) {
						self.showingFilterSheet = true
					}
					.popSheet(isPresented: self.$showingFilterSheet, content: {
						PopSheet(title: Text("Select a filter"), buttons: [
							PopSheet.Button(kind: .default, label: Text(FilterType.Crystallize.rawValue), action: {
								self.filterName = FilterType.Crystallize.rawValue
								self.setFilter(CIFilter.crystallize())
							}),
							PopSheet.Button(kind: .default, label: Text(FilterType.Edges.rawValue), action: {
								self.filterName = FilterType.Edges.rawValue
								self.setFilter(CIFilter.edges())
							}),
							PopSheet.Button(kind: .default, label: Text(FilterType.GaussianBlur.rawValue), action: {
								self.filterName = FilterType.GaussianBlur.rawValue
								self.setFilter(CIFilter.gaussianBlur())
							}),
							PopSheet.Button(kind: .default, label: Text(FilterType.SepiaTone.rawValue), action: {
								self.filterName = FilterType.SepiaTone.rawValue
								self.setFilter(CIFilter.sepiaTone())
							}),
							PopSheet.Button(kind: .default, label: Text(FilterType.UnsharpMask.rawValue), action: {
								self.filterName = FilterType.UnsharpMask.rawValue
								self.setFilter(CIFilter.unsharpMask())
							}),
							PopSheet.Button(kind: .default, label: Text(FilterType.Vignette.rawValue), action: {
								self.filterName = FilterType.Vignette.rawValue
								self.setFilter(CIFilter.vibrance())
							}),
							PopSheet.Button(kind: .cancel, label: Text("Cancel"), action: {})
						])
					})
					Spacer()
					Button("Save") {
						self.isShowingErrorSave = self.processedImage == nil
						guard let processedImage = self.processedImage else {
							return
						}
						let imageSaver = ImageSaver()
						imageSaver.successHandler = {
							print("Success!!!")
						}
						imageSaver.errorHandler = {
							print("\($0.localizedDescription)")
						}
						imageSaver.writeToPhotoAlbum(image: processedImage)
					}.alert(isPresented: self.$isShowingErrorSave) {
						Alert(title: Text("Save Error"), message: Text("Can not save with empty image"), dismissButton: .default(Text("OK")))
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
		let inputKeys = currentFilter.inputKeys
		
		
		if inputKeys.contains(kCIInputIntensityKey) {
			currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
		}
		
		if inputKeys.contains(kCIInputRadiusKey) {
			currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
		}
		
		if inputKeys.contains(kCIInputScaleKey) {
			currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
		}
		
		guard let outputImage = currentFilter.outputImage else { return }
		
		if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
			let uiImage  = UIImage(cgImage: cgimg)
			image  = Image(uiImage: uiImage)
			processedImage = uiImage
		}
	}
	
	private func setFilter(_ filter: CIFilter) {
		currentFilter = filter
		loadImage()
	}
	
	func popSheet(isPresented: Binding<Bool>, arrowEdge: Edge = .bottom, content: @escaping () -> PopSheet) -> some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                popover(isPresented: isPresented, attachmentAnchor: .rect(.bounds), arrowEdge: arrowEdge, content: { content().popover(isPresented: isPresented) })
            } else {
                actionSheet(isPresented: isPresented, content: { content().actionSheet() })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

