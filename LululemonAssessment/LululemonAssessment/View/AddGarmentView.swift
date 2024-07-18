//
//  AddGarmentView.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import SwiftUI

struct AddGarmentView: View {
    @StateObject var addGarmentViewModel: AddGarmentViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var refreshList: Bool?
    @FocusState private var focusedField: FocusedField?
    
    enum FocusedField {
        case garmentName
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Garment Name:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Enter garment name", text: $addGarmentViewModel.garmentName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.leading)
                        .focused($focusedField, equals: FocusedField.garmentName)
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarTitle("Add")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //Save button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addGarmentViewModel.addGarment(named: addGarmentViewModel.garmentName)
                        refreshList = true
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                    })
                    .disabled(addGarmentViewModel.isSaveDisabled)
                }
                
                //Cancel button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                // Done button
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        focusedField = nil
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .onAppear {
                focusedField = .garmentName
            }
            .alert(addGarmentViewModel.errorMessage,
                   isPresented: $addGarmentViewModel.isError,
                   actions: {
                Button("Ok", role: .cancel){}
            })
        }
    }
}

struct AddGarmentView_Previews: PreviewProvider {
    @State static var refreshList: Bool? = false
    static var previews: some View {
        AddGarmentView(addGarmentViewModel: AddGarmentViewModel(garmentRepositoryManager: GarmentRepositoryManager(persistanceController: PersistenceManager.shared)),
                       refreshList: $refreshList)
    }
}
