//
//  ContentView.swift
//  AssistAid
//
//  Created by Adrian Martushev on 6/14/24.
//
import SwiftUI
import Speech
import AVFoundation
import OpenAI



struct HomeView: View {
    @EnvironmentObject var openAIVM : OpenAIViewModel
        
    @State var showAboutView = false
    @State var showSettings = false
    @State var showListeningView = true
    @State var showHistoryView = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                ZStack {
                    HStack {
                        Button(action: {
                            showHistoryView = true
                        }, label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(.white)
                        })
                        
                        Spacer()
                        
                        
                        Button(action: {
                            showSettings.toggle()
                        }, label: {
                            Image(systemName: "gear")
                                .foregroundStyle(.white)
                        })
                        .sheet(isPresented: $showSettings, content: {
                            ChooseVoiceView()
                        })
                    }
                    .padding()
                    
                    Button {
                        showAboutView.toggle()
                    } label: {
                        Text("AssistAid")
                            .font(.system(size: 14, weight : .semibold))
                        
                        Image(systemName : "chevron.right")
                            .font(.system(size: 12, weight : .semibold))
                    }
                    .foregroundStyle(.white)
                    .sheet(isPresented: $showAboutView, content: {
                        AboutView()
                    })
                }

                if showListeningView {
                    ListeningView(showListeningView: $showListeningView)
                    
                } else {
                    if openAIVM.messages.isEmpty {
                        VStack {
                            Spacer()
                            
                            Image("first-aid")
                                .resizable()
                                .scaledToFit()
                                .frame(width : 60, height : 60)
                            
                            Spacer()
                        }
                        
                    } else {
                        
                        ScrollView {
                            ForEach(openAIVM.messages) { message in
                                HStack(alignment : .top) {
                                    if message.role == .user {
                                        Spacer()
                                        Text("\(message.content)")
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: 300, alignment: .trailing)
                                    } else {
                                        Image("first-aid")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width : 25, height : 25)
                                        
                                        Text("\(message.content)")
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(Color.black.opacity(0.7))
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: 300, alignment: .leading)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex : "#1d1d1f")
                                    .shadow(.inner(color: .white.opacity(0.1), radius: 2, x: -1, y: -1))
                                    .shadow(.inner(color: .black.opacity(0.3), radius: 2, x: 2, y: 2))
                                )
                                .frame(height : 50)
                            
                            TextField("Get medical guidance", text: $openAIVM.query)
                                .foregroundColor(.white)
                                .padding()
                                .onSubmit {
                                    Task {
                                        await openAIVM.sendQuery(playAudio: false)
                                    }
                                }
                                .padding(.trailing, 30)

                            HStack {
                                Spacer()
                                if openAIVM.query.isEmpty {
                                    Button {
                                        showListeningView = true
                                    } label: {
                                        Image(systemName : "mic.fill")
                                            .font(Font.custom("SF Pro", size: 17))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                                    }
                                } else {
                                    Button {
                                        Task {
                                            await openAIVM.sendQuery(playAudio: false)
                                        }

                                    } label: {
                                        Image(systemName : "arrow.up.circle.fill")
                                            .font(Font.custom("SF Pro", size: 22))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.blue)
                                    }
                                }

                            }
                            .padding(.trailing)

                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                }
            }
            .background(.regularMaterial)
            .onTapGesture {
                hideKeyboard()
            }
            .overlay {
                Color(showHistoryView ? .black.opacity(0.3) : .clear)
                    .onTapGesture {
                        showHistoryView = false
                    }
            }
                        
            InstructionsHistoryView(showHistoryView : $showHistoryView)
                .leadingEdgeSheet(isPresented: showHistoryView)
        }
    }
}




#Preview {
    HomeView()
        .environmentObject(OpenAIViewModel())

}
