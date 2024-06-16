//
//  SavedHistoryView.swift
//  AssistAid
//
//  Created by Adrian Martushev on 6/15/24.
//

import SwiftUI

struct InstructionsHistoryView: View {
    @EnvironmentObject var openAIVM: OpenAIViewModel
    @Binding var showHistoryView : Bool
    
    @State var savedInstructions : [PresetInstructions] = []
    
    var body: some View {

        HStack {
            VStack {
                HStack {
                    Text("Saved Instructions")
                        .font(.title2)
                    Spacer()
                    Button(action: {
                        showHistoryView = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                    })
                }
                .padding()
                
                ScrollView {
                    ForEach(savedInstructions, id : \.id) { instruction in
                        
                        NavigationLink {
                            PresetInstructionsHistoryView(instructions: instruction)
                        } label: {
                            HStack {
                                Image(instruction.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width : 60, height :60)
                                    .clipped()
                                    .cornerRadius(20)
                                
                                Text(instruction.steps.first?.title ?? "")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.white)
                        }
                        
                        Divider()
                            .padding(.vertical)

                    }
                    .padding(.horizontal)
                }
            }
            .background(.regularMaterial)
            .frame(width : 300)
            Spacer()
        }
        .onAppear {
            savedInstructions = openAIVM.getSavedInstructions()
        }

    }
}


struct PresetInstructionsHistoryView : View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var instructions : PresetInstructions
    
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                Spacer()
            }
            .padding(.leading)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .navigationTitle("")
            .navigationBarHidden(true)
            
            PresetInstructionsView(instructions: instructions)
        }
        .background(.regularMaterial)
    }
}

#Preview {
//    InstructionsHistoryView(showHistoryView: .constant(false))
//        .environmentObject(OpenAIViewModel())
    
    PresetInstructionsHistoryView(instructions: presetInstructions[0])
            .environmentObject(OpenAIViewModel())

}
