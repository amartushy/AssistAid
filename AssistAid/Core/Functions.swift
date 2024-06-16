//
//  Functions.swift
//  AssistAid
//
//  Created by Adrian Martushev on 6/14/24.
//

import Foundation
import UIKit


//Functions
func generateHapticFeedback() {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.prepare()
    generator.impactOccurred()
}
