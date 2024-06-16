//
//  PresetInstructionsView.swift
//  AssistAid
//
//  Created by Adrian Martushev on 6/15/24.
//

import SwiftUI

struct PresetInstructions : Identifiable, Codable {
    var id : String
    var image : String
    var steps : [PresetInstructionsStep]
}
struct PresetInstructionsStep : Identifiable, Codable {
    var id : Int
    var title : String
    var description : String
}


let presetInstructions : [PresetInstructions] = [
    PresetInstructions(id: "cpr", image: "cpr", steps: [
        PresetInstructionsStep(id: 1, title: "Check the scene", description: "Check the scene for safety, then check the person. Tap on the shoulder and shout, 'Are you OK?' to ensure that the person needs help."),
        PresetInstructionsStep(id: 2, title: "Call 911", description: "Call 911 or ask someone else to do so."),
        PresetInstructionsStep(id: 3, title: "Open the airway", description: "Open the airway by tilting the head back and lifting the chin."),
        PresetInstructionsStep(id: 4, title: "Check for breathing", description: "Check for breathing for no more than 10 seconds. If there is no breathing, begin CPR."),
        PresetInstructionsStep(id: 5, title: "Perform CPR", description: "Perform 30 chest compressions followed by 2 rescue breaths."),
        PresetInstructionsStep(id: 6, title: "Continue CPR", description: "Continue CPR steps until medical help arrives or the person begins to move.")
    ]),
    PresetInstructions(id: "burns", image: "burns", steps: [
        PresetInstructionsStep(id: 1, title: "Ensure safety", description: "Ensure the safety of all people involved. Remove any clothing or jewelry near the burnt area."),
        PresetInstructionsStep(id: 2, title: "Cool the burn", description: "Cool the burn with cool (not cold) water for at least 10 minutes."),
        PresetInstructionsStep(id: 3, title: "Cover the burn", description: "Cover the burn with a sterile, non-fluffy dressing or cloth."),
        PresetInstructionsStep(id: 4, title: "Treat for shock", description: "Treat for shock if necessary and do not apply creams, ointments, or greases."),
        PresetInstructionsStep(id: 5, title: "Seek medical help", description: "Seek medical help if the burn is severe or covers a large area.")
    ]),
    
    PresetInstructions(id: "choking", image: "choking", steps: [
        PresetInstructionsStep(id: 1, title: "Determine ability to speak", description: "Determine if the person can speak or breathe. If the person is unable to talk or is turning blue, act quickly."),
        PresetInstructionsStep(id: 2, title: "Position yourself", description: "Stand behind the person and wrap your arms around their waist."),
        PresetInstructionsStep(id: 3, title: "Perform Heimlich maneuver", description: "Make a fist with one hand and place it just above the person's navel. Grasp the fist with the other hand and perform a quick, upward thrust."),
        PresetInstructionsStep(id: 4, title: "Repeat if necessary", description: "Repeat the upward thrusts until the object is expelled and the person can breathe or cough on their own.")
    ]),
    
    PresetInstructions(id: "bleeding", image: "bleeding", steps: [
        PresetInstructionsStep(id: 1, title: "Wear gloves", description: "Wear gloves if available. Apply pressure with a clean cloth to stop the bleeding."),
        PresetInstructionsStep(id: 2, title: "Maintain pressure", description: "Maintain pressure by binding the wound with a thick bandage or a piece of clean clothing."),
        PresetInstructionsStep(id: 3, title: "Add more layers", description: "Do not remove the cloth or bandage if it becomes soaked. Add more layers if needed."),
        PresetInstructionsStep(id: 4, title: "Continue pressure", description: "If the bleeding is severe and does not stop, continue pressure until medical help arrives.")
    ]),
    
    PresetInstructions(id: "sprain", image: "sprain", steps: [
        PresetInstructionsStep(id: 1, title: "Rest the limb", description: "Rest the injured limb. Avoid using the injured area."),
        PresetInstructionsStep(id: 2, title: "Ice the area", description: "Ice the area for 20 minutes every hour while awake."),
        PresetInstructionsStep(id: 3, title: "Compress the area", description: "Compress the area with an elastic wrap or bandage."),
        PresetInstructionsStep(id: 4, title: "Elevate the limb", description: "Elevate the injured limb above the heart level to reduce swelling."),
        PresetInstructionsStep(id: 5, title: "Seek medical attention", description: "Seek medical attention if there is no improvement within 24-48 hours.")
    ])
]


let presetInstructionsGerman: [PresetInstructions] = [
    PresetInstructions(id: "cpr-german", image: "cpr", steps: [
        PresetInstructionsStep(id: 1, title: "Überprüfen Sie die Szene", description: "Überprüfen Sie die Szene auf Sicherheit, dann überprüfen Sie die Person. Tippen Sie auf die Schulter und rufen Sie 'Geht es Ihnen gut?', um sicherzustellen, dass die Person Hilfe benötigt."),
        PresetInstructionsStep(id: 2, title: "Rufen Sie 911 an", description: "Rufen Sie 911 an oder bitten Sie jemand anderen, dies zu tun."),
        PresetInstructionsStep(id: 3, title: "Öffnen Sie die Atemwege", description: "Öffnen Sie die Atemwege, indem Sie den Kopf nach hinten neigen und das Kinn anheben."),
        PresetInstructionsStep(id: 4, title: "Überprüfen Sie die Atmung", description: "Überprüfen Sie die Atmung für nicht mehr als 10 Sekunden. Wenn keine Atmung vorhanden ist, beginnen Sie mit der CPR."),
        PresetInstructionsStep(id: 5, title: "Führen Sie die CPR aus", description: "Führen Sie 30 Brustkompressionen gefolgt von 2 Rettungsatmungen durch."),
        PresetInstructionsStep(id: 6, title: "Fahren Sie mit der CPR fort", description: "Fahren Sie mit den CPR-Schritten fort, bis medizinische Hilfe eintrifft oder die Person zu sich kommt.")
    ]),
    PresetInstructions(id: "burns-german", image: "burns", steps: [
        PresetInstructionsStep(id: 1, title: "Sicherheit gewährleisten", description: "Stellen Sie die Sicherheit aller Beteiligten sicher. Entfernen Sie Kleidung oder Schmuck in der Nähe der verbrannten Stelle."),
        PresetInstructionsStep(id: 2, title: "Kühlen Sie die Verbrennung", description: "Kühlen Sie die Verbrennung mindestens 10 Minuten lang mit kühlem (nicht kaltem) Wasser."),
        PresetInstructionsStep(id: 3, title: "Decken Sie die Verbrennung ab", description: "Decken Sie die Verbrennung mit einem sterilen, nicht fusselnden Verband oder Tuch ab."),
        PresetInstructionsStep(id: 4, title: "Behandeln Sie den Schock", description: "Behandeln Sie den Schock bei Bedarf und tragen Sie keine Cremes, Salben oder Fette auf."),
        PresetInstructionsStep(id: 5, title: "Suchen Sie medizinische Hilfe", description: "Suchen Sie medizinische Hilfe, wenn die Verbrennung schwerwiegend ist oder eine große Fläche bedeckt.")
    ]),
    PresetInstructions(id: "choking-german", image: "choking", steps: [
        PresetInstructionsStep(id: 1, title: "Bestimmen Sie die Sprechfähigkeit", description: "Bestimmen Sie, ob die Person sprechen oder atmen kann. Wenn die Person nicht sprechen kann oder blau wird, handeln Sie schnell."),
        PresetInstructionsStep(id: 2, title: "Positionieren Sie sich", description: "Stellen Sie sich hinter die Person und umschließen Sie ihre Taille mit Ihren Armen."),
        PresetInstructionsStep(id: 3, title: "Führen Sie das Heimlich-Manöver aus", description: "Bilden Sie mit einer Hand eine Faust und platzieren Sie sie knapp über dem Bauchnabel der Person. Greifen Sie die Faust mit der anderen Hand und führen Sie einen schnellen, nach oben gerichteten Stoß aus."),
        PresetInstructionsStep(id: 4, title: "Wiederholen Sie bei Bedarf", description: "Wiederholen Sie die Aufwärtsstöße, bis das Objekt ausgestoßen wird und die Person selbstständig atmen oder husten kann.")
    ]),
    PresetInstructions(id: "bleeding-german", image: "bleeding", steps: [
        PresetInstructionsStep(id: 1, title: "Tragen Sie Handschuhe", description: "Tragen Sie Handschuhe, falls verfügbar. Wenden Sie mit einem sauberen Tuch Druck an, um die Blutung zu stoppen."),
        PresetInstructionsStep(id: 2, title: "Halten Sie den Druck aufrecht", description: "Halten Sie den Druck aufrecht, indem Sie die Wunde mit einem dicken Verband oder einem Stück sauberer Kleidung verbinden."),
        PresetInstructionsStep(id: 3, title: "Fügen Sie mehr Schichten hinzu", description: "Entfernen Sie das Tuch oder den Verband nicht, wenn es durchtränkt ist. Fügen Sie bei Bedarf weitere Schichten hinzu."),
        PresetInstructionsStep(id: 4, title: "Halten Sie den Druck aufrecht", description: "Wenn die Blutung schwerwiegend ist und nicht aufhört, halten Sie den Druck aufrecht, bis medizinische Hilfe eintrifft.")
    ]),
    PresetInstructions(id: "sprain-german", image: "sprain", steps: [
        PresetInstructionsStep(id: 1, title: "Ruhe das Glied", description: "Ruhe das verletzte Glied. Vermeiden Sie die Benutzung der verletzten Stelle."),
        PresetInstructionsStep(id: 2, title: "Kühlen Sie die Stelle", description: "Kühlen Sie die Stelle 20 Minuten lang jede Stunde, solange Sie wach sind."),
        PresetInstructionsStep(id: 3, title: "Komprimieren Sie die Stelle", description: "Komprimieren Sie die Stelle mit einem elastischen Wickel oder Verband."),
        PresetInstructionsStep(id: 4, title: "Heben Sie das Glied an", description: "Heben Sie das verletzte Glied über das Herzlevel, um die Schwellung zu verringern."),
        PresetInstructionsStep(id: 5, title: "Suchen Sie medizinische Aufmerksamkeit", description: "Suchen Sie medizinische Aufmerksamkeit, wenn sich innerhalb von 24-48 Stunden keine Besserung zeigt.")
    ])
]


struct PresetInstructionsView: View {
    @EnvironmentObject var openAIVM : OpenAIViewModel
    
    var instructions: PresetInstructions
    
    @State private var isSaved = false
    
    func toggleSave() {
        if isSaved {
            // Remove from saved history
            var savedInstructions = openAIVM.getSavedInstructions()
            savedInstructions.removeAll { $0.id == instructions.id }
            openAIVM.saveInstructionsList(savedInstructions)
        } else {
            // Add to saved history
            var savedInstructions = openAIVM.getSavedInstructions()
            savedInstructions.append(instructions)
            openAIVM.saveInstructionsList(savedInstructions)
            isSaved = true
        }
    }
    
    func checkIfSaved() {
        let savedInstructions = openAIVM.getSavedInstructions()
        isSaved = savedInstructions.contains(where: { $0.id == instructions.id })
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Image(instructions.image)
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)

                ForEach(instructions.steps) { step in
                    VStack(alignment: .leading) {
                        Text("\(step.id). \(step.title)")
                            .font(.headline)
                            .padding(.bottom, 1)
                        Text(step.description)
                            .padding(.horizontal)
                            .font(.system(size: 14))
                    }
                    .padding(.bottom, 5)
                }
                
                HStack {
                    
                    Button(action: {
                        toggleSave()
                        generateHapticFeedback()
                    }, label: {
                        HStack {
                            if !isSaved {
                                Image(systemName: "arrow.down.to.line.compact")
                                Text("Save")
                            } else {
                                Image(systemName: "checkmark")
                                Text("Saved")
                            }

                        }
                        .padding(12)
                        .foregroundColor(.white)
                        .background(.white.opacity(0.1))
                        .cornerRadius(10)
                    })
                    
                    Button(action: {
                        openAIVM.clearInstructions()
                        self.isSaved = false

                    }, label: {
                        HStack {
                            Image(systemName: "arrow.circlepath")
                            Text("Clear")
                        }
                        .padding(12)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    })

                }

            }
            .padding(.horizontal, 30)
        }
        .onAppear(perform: checkIfSaved)

    }
}

#Preview {
    PresetInstructionsView(instructions: presetInstructions[0])
}
