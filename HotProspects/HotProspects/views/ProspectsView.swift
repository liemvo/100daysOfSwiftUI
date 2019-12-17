//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Liem Vo on 12/14/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum SortType: String {
	case name = "Name"
	case email = "Email"
	case recent = "Recent"
}

struct ProspectsView: View {
	enum FilterType {
		case none, contacted, uncontacted
	}
	
	@EnvironmentObject var prospects: Prospects
	let filter: FilterType
	
	@State private var isShowingScanner = false
	@State private var isShowingSort = false
	@State private var sortType: SortType = .name
	
	@State private var sortProspectes: [Prospect] = [Prospect]()
	
	var title: String {
		switch filter {
		case .none:
			return "Everyone"
		case .contacted:
			return "Contacted people"
		case .uncontacted:
			return "Uncontacted people"
		}
	}
	
	var filteredProspects: [Prospect] {
		switch filter {
		case .none:
			return prospects.people
		case .contacted:
			return prospects.people.filter { $0.isContacted }
		case .uncontacted:
			return prospects.people.filter { !$0.isContacted }
		}
	}
	
	var body: some View {
		NavigationView {
			List {
				ForEach(filteredProspects.count > sortProspectes.count ? filteredProspects : sortProspectes) { prospect in
					HStack {
						VStack(alignment: .leading) {
							Text(prospect.name)
								.font(.headline)
							Text(prospect.emailAddress)
								.foregroundColor(.secondary)
						}
						Spacer()
						if self.filter == .none {
							Image(systemName: prospect.isContacted ? "star.fill" : "star")
								.foregroundColor(.purple)
						}
					}
					.contextMenu {
						Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
							self.prospects.toggle(prospect)
						}
						
						if !prospect.isContacted {
							Button("Remind Me") {
								self.addNotification(for: prospect)
							}
						}
					}
				}
			}
			.navigationBarTitle(title)
			.navigationBarItems(leading: Button(action: {
				self.isShowingSort = true
			}) {
				Text("Sort")
				}, trailing: Button(action: {
					self.isShowingScanner = true
				}) {
					Image(systemName: "qrcode.viewfinder")
					Text("Scan")
			})
				.sheet(isPresented: $isShowingScanner) {
					CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudsond\npaul@hackingwithswift.com", completion: self.handleScan)
			}
			.actionSheet(isPresented: $isShowingSort) {
				ActionSheet(title: Text("Sort type"), message: nil, buttons: [
					.default(Text("Name"), action: {
						self.sortType = .name
						self.sortData()
					}),
					.default(Text("Recent"), action: {
						self.sortType = .recent
						self.sortData()
					}),
					.cancel()])
			}
			
		}
	}
	
	func sortData() {
		sortProspectes = filteredProspects.sorted(by: { (ps1, ps2) -> Bool in
			if self.sortType == .name {
				return ps1.name < ps2.name
			}
			else if self.sortType == .recent {
				return ps1.position > ps2.position
			}
			else { return ps1.emailAddress < ps2.emailAddress
			}
		})
	}
	
	func handleScan(result: Result<String, CodeScannerView.ScanError>) {
		self.isShowingScanner = false
		
		switch result {
		case .success(let code):
			
			let details = code.components(separatedBy: "\n")
			guard details.count == 2 else { return }
			
			let person = Prospect()
			person.name = details[0]
			person.emailAddress = details[1]
			self.prospects.add(person)
		case .failure( _):
			print("Scanning failed")
		}
	}
	
	func addNotification(for prospect: Prospect) {
		let center  = UNUserNotificationCenter.current()
		
		let addRequest =  {
			let content = UNMutableNotificationContent()
			content.title  = "Contact \(prospect.name)"
			content.subtitle  = prospect.emailAddress
			content.sound = UNNotificationSound.default
			
			var dateComponents  = DateComponents()
			dateComponents.hour  = 9
			let  trigger  =  UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
			
			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			
			center.add(request)
		}
		
		center.getNotificationSettings { settings in
			if settings.authorizationStatus == .authorized {
				addRequest()
			} else {
				center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						addRequest()
					} else {
						print("D'oh")
					}
				}
			}
		}
	}
}

struct ProspectsView_Previews: PreviewProvider {
	static var previews: some View {
		ProspectsView(filter: .none)
	}
}
