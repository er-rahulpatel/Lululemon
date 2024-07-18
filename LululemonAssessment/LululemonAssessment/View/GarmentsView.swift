//
//  GarmentsView.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import SwiftUI

struct GarmentsView: View {
    @StateObject var garmentListViewModel: GarmentListViewModel
    @State private var isPresentingAddGarmentView = false
    
    var body: some View {
        VStack {
            if (!garmentListViewModel.garments.isEmpty) {
                SegmentedPickerView(segments: GarmentSortType.allCases, selection: $garmentListViewModel.selectedSortType)
                    .padding()
                
                Divider()
                
                ItemList(items: garmentListViewModel.garments.compactMap { $0.name })
            }
            else {
                Text("Click on \(Image(systemName: "plus.circle")) to add garments in the list.")
            }
        }
        .navigationTitle("List")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingAddGarmentView = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
        }
        .onAppear{
            garmentListViewModel.fetchGarments(sortedBy: garmentListViewModel.selectedSortType)
        }
        .sheet(isPresented: $isPresentingAddGarmentView) {
            AddGarmentView(addGarmentViewModel: AddGarmentViewModel(garmentRepositoryManager: garmentListViewModel.garmentRepositoryManager), refreshList: $garmentListViewModel.refreshList)
        }
        .alert(garmentListViewModel.errorMessage,
               isPresented: $garmentListViewModel.isError,
               actions: {
            Button("Ok", role: .cancel){}
        })
    }
}

struct GarmentsView_Previews: PreviewProvider {
    static var previews: some View {
        GarmentsView(garmentListViewModel: GarmentListViewModel(garmentRepositoryManager: GarmentRepositoryManager(persistanceController: PersistenceManager.shared)))
    }
}
