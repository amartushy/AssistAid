//
//  AboutView.swift
//  AssistAid
//
//  Created by Adrian Martushev on 6/15/24.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        
        VStack(alignment : .leading) {
            ZStack {
                HStack {
                    Spacer()
                    
                    Text("About AssistAid")
                        .font(.system(size: 16, weight : .bold))
                    Spacer()

                }
                
                HStack {
                    Spacer()
                    Button("Done") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("About the App")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("AssistAid is designed to provide users with quick and accessible first aid information at their fingertips. The app leverages advanced artificial intelligence to offer immediate instructions for common medical emergencies such as CPR, burns, choking, bleeding, and sprains.")
                        .padding(.bottom, 5)
                        .font(.system(size: 14))
                    
                    Text("Features:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("• Interactive AI to guide through emergencies.\n• Step-by-step instructions for first aid procedures.\n• Ability to save and retrieve critical medical advice.\n• Visual and textual aid for better understanding.")
                        .padding(.bottom, 10)
                        .font(.system(size: 14))

                    
                    Text("Medical Disclaimer")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("AssistAid is intended for informational purposes only and should not be used as a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on this app.")
                        .padding(.bottom, 5)
                        .font(.system(size: 14))

                    
                    Text("If you believe you may have a medical emergency, call your doctor, go to the emergency department, or call emergency services immediately. AssistAid does not recommend or endorse any specific tests, physicians, procedures, opinions, or other information that may be mentioned on the app. Reliance on any information provided by AssistAid, its employees, contracted writers, or medical professionals presenting content for publication to the app is solely at your own risk.")
                        .padding(.bottom, 5)
                        .font(.system(size: 14))

                    
                    Text("The app is not intended for use in the diagnosis, immediate treatment, or management of any medical conditions.")
                        .padding(.bottom, 20)
                        .font(.system(size: 14))

                    
                }
                .padding()
            }
        }
        .background(.regularMaterial)

    }
}

#Preview {
    AboutView()
}
