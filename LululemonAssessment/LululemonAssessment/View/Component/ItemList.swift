//
//  ItemList.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-18.
//

import SwiftUI

struct ItemList: View {
    let items: [String]
    
    var body: some View {
        List(items.enumerated().map{ $0 }, id: \.offset) { index, item in
            Text(item)
        }
        .animation(.default, value: items)
        .listStyle(.plain)
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList(items: ["T-shirt", "Jeans"])
    }
}
