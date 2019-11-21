//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Liem Vo on 11/21/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import CoreData
import SwiftUI
enum PredicateType: String {
	case beginWith = "BEGINSWITH"
	
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

	init(sortKey: String, filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
		fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(key: sortKey, ascending: false)], predicate: NSPredicate(format: "%K \(PredicateType.beginWith.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

