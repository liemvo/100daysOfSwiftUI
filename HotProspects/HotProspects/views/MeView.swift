//
//  MeView.swift
//  HotProspects
//
//  Created by Liem Vo on 12/14/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct MeView: View {
	let context = CIContext()
	let filter = CIFilter.qrCodeGenerator()
	
	@State private var name = "Anonymous"
	@State private var emailAddress = "you@yoursite.com"
	
	
	var body: some View {
		NavigationView {
			VStack {
				TextField("Name", text: $name)
					.textContentType(.name)
					.font(.title)
					.padding(.horizontal)
				TextField("Email address", text: $emailAddress)
					.textContentType(.emailAddress)
					.font(.title)
					.padding([.horizontal, .bottom])
				Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
					.interpolation(.none)
					.resizable()
					.scaledToFit()
					.frame(width: 200, height: 200)
				
				Spacer()
			}
			.navigationBarTitle("Your code")
		}
	}
	
	func generateQRCode(from string: String) -> UIImage {
		let data = Data(string.utf8)
		filter.setValue(data, forKey: "inputMessage")
		
		if let outputImage = filter.outputImage {
			if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
				return UIImage(cgImage: cgimg)
			}
		}
		
		return UIImage(systemName: "xmark.circle") ?? UIImage()
	}
}

struct MeView_Previews: PreviewProvider {
	static var previews: some View {
		MeView()
	}
}
