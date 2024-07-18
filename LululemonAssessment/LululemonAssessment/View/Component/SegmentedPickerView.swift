//
//  SegmentedPickerView.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import SwiftUI

struct SegmentedPickerView<T: Hashable>: View {
    let segments: [T]
    @Binding var selection: T
    var body: some View {
        VStack {
            Picker("", selection: $selection) {
                ForEach(segments, id: \.self) { segment in
                    Text(self.displayName(for: segment))
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private func displayName(for segment: T) -> String {
        if let garmentSortType = segment as? GarmentSortType {
            return garmentSortType.description
        } else {
            return String(describing: segment)
        }
    }
}

struct SegmentedPickerView_Previews: PreviewProvider {
    @State static var selection: GarmentSortType? = .name
    static var previews: some View {
        SegmentedPickerView(segments: GarmentSortType.allCases, selection: $selection)
    }
}
