//
//  OpenAIViewModel.swift
//  AssistAid
//
//  Created by Adrian Martushev on 6/14/24.
//

import SwiftUI
import Speech
import AVFoundation
import OpenAI



struct ChatMessage: Identifiable {
    var id: UUID = UUID()
    var role: Role
    var content: String
    
    enum Role: String {
        case user = "user"
        case assistant = "assistant"
    }
}

enum Voice: String, CaseIterable, Identifiable {
    case alloy = "alloy"
    case echo = "echo"
    case fable = "fable"
    case onyx = "onyx"
    case nova = "nova"
    case shimmer = "shimmer"

    var id: String { self.rawValue }

    // Convert to API's voice type
    func toAPIVoice() -> AudioSpeechQuery.AudioSpeechVoice {
        return AudioSpeechQuery.AudioSpeechVoice(rawValue: self.rawValue) ?? .alloy
    }
}


struct VoiceOption: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
}

struct LanguageOptions: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
}

extension UserDefaults {
    static let selectedVoiceKey = "selectedVoice"
    static let selectedLanguageKey = "selectedLanguage"
}

class OpenAIViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    let openAI = OpenAI(apiToken: "INSERT YOUR OPEN AI KEY HERE")
    @Published var query = ""
    @Published var messages: [ChatMessage] = []
    @Published var voices = Voice.allCases
    @Published var languages = [
        LanguageOptions(name: "German"),
        LanguageOptions(name: "English")
    ]
    
    @Published var selectedVoice: Voice {
        didSet {
            saveVoiceSelection()
        }
    }
    @Published var selectedLanguage: LanguageOptions {
        didSet {
            saveLanguageSelection()
        }
    }
    
    var audioPlayer: AVAudioPlayer?
    @Published var isAudioPlaying: Bool = false
    @Published var isResponding = false
    @Published var responsePending = false
    @Published var presetInstructionsAvailable = false
    @Published var instructions : PresetInstructions?
    
    override init() {
        selectedVoice = UserDefaults.standard.string(forKey: UserDefaults.selectedVoiceKey)
            .flatMap { Voice(rawValue: $0) } ?? .alloy
        selectedLanguage = UserDefaults.standard.string(forKey: UserDefaults.selectedLanguageKey)
            .flatMap { LanguageOptions(name: $0) } ?? LanguageOptions(name: "English")
        super.init()
    }

    private func saveVoiceSelection() {
        UserDefaults.standard.set(selectedVoice.rawValue, forKey: UserDefaults.selectedVoiceKey)
    }

    private func saveLanguageSelection() {
        UserDefaults.standard.set(selectedLanguage.name, forKey: UserDefaults.selectedLanguageKey)
    }
    
    
    func sendQuery(playAudio : Bool) async {
        print("Sending query : \(query)")
        responsePending = true
        let userMessage = ChatMessage(role: .user, content: query)
        
        DispatchQueue.main.async {
            self.messages.append(userMessage)
        }
        
        var systemMessage : ChatQuery.ChatCompletionMessageParam = .init(role: .assistant, content: "You are a medical assistant. Please respond with helpful medical advice that is factually correct")!
        if self.selectedLanguage.name == "German" {
            systemMessage = .init(role: .assistant, content: "Sie sind ein medizinischer Assistent. Bitte antworten Sie mit hilfreichen und sachlich korrekten medizinischen Ratschlägen.")!
        }

        let chatQuery = ChatQuery(
            messages: [systemMessage, .init(role: .user, content: query)!],
            model: .gpt3_5Turbo
        )
        
        DispatchQueue.main.async {
            self.query = ""
        }
        
        do {
            // Execute the query
            let result = try await openAI.chats(query: chatQuery)
            DispatchQueue.main.async { // Ensure UI updates are on the main thread
                if let firstChoice = result.choices.first,
                   case let .string(responseContent) = firstChoice.message.content {
                    let assistantMessage = ChatMessage(role: .assistant, content: responseContent)
                    self.messages.append(assistantMessage)
                    if playAudio {
                        Task {
                            await self.synthesizeResponse(from: responseContent)
                        
                            // Check for preset instructions in the response
                            if let instructions = self.findMatchingInstructions(in: responseContent) {
                                self.instructions = instructions
                                self.presetInstructionsAvailable = true
                            } else {
                                self.presetInstructionsAvailable = false
                            }
                        }
                    } else {
                        self.responsePending = false
                    }
                    
                    self.query = ""

                } else {
                    print("Received content is not a string or is empty")
                }
            }
        } catch {
            print("Failed to get response from OpenAI: \(error.localizedDescription)")
            self.responsePending = false

        }
    }
    
    func findMatchingInstructions(in text: String) -> PresetInstructions? {
        let instructionsToUse = selectedLanguage.name == "German" ? presetInstructionsGerman : presetInstructions
        for instruction in instructionsToUse {
            if text.localizedCaseInsensitiveContains(instruction.id) {
                return instruction
            }
        }
        return nil
    }

    func getSavedInstructions() -> [PresetInstructions] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "SavedInstructions"),
           let instructions = try? decoder.decode([PresetInstructions].self, from: data) {
            return instructions
        }
        return []
    }

    func saveInstructionsList(_ instructions: [PresetInstructions]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(instructions) {
            UserDefaults.standard.set(encoded, forKey: "SavedInstructions")
            print("Instructions saved")
        }
    }
    
    func clearInstructions() {
        DispatchQueue.main.async {
            self.instructions = nil
            self.presetInstructionsAvailable = false
        }
    }
    
    
    func synthesizeResponse(from text: String) async {
        let speechQuery = AudioSpeechQuery(
            model: .tts_1,
            input: text,
            voice: selectedVoice.toAPIVoice(),
            responseFormat: .mp3,
            speed: 1.0
        )
        do {
            let speechResult = try await openAI.audioCreateSpeech(query: speechQuery)
            DispatchQueue.main.async {
                self.playAudio(from: speechResult.audio)
            }
        } catch {
            DispatchQueue.main.async {
                print("Error synthesizing speech: \(error)")
            }
        }
    }
    
    /// Prepares and manages the audio session for playback
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    /// Plays audio from given data.
    func playAudio(from data: Data) {
        setupAudioSession()
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.delegate = self // Set delegate to self to detect when audio finishes playing
            audioPlayer?.play()
            DispatchQueue.main.async {
                self.responsePending = false
                self.isResponding = true
                self.isAudioPlaying = true
            }
        } catch {
            print("Failed to play audio: \(error)")
            DispatchQueue.main.async {
                self.isResponding = false
                self.isAudioPlaying = false
            }
        }
    }

    /// Called when audio playback finishes
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.isResponding = false
            self.isAudioPlaying = false

        }
    }
    
    func stopAudio() {
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
            self.isResponding = false
        }
    }
}
