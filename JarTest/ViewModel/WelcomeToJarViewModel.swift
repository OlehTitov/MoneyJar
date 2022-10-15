//
//  WelcomeToJarViewModel.swift
//  JarTest
//
//  Created by Oleh Titov on 25.07.2022.
//

import Foundation

class WelcomeToJarViewModel: ObservableObject {
    @Published var isCreateJarPressed = false
    @Published var animate = false
    
    func createPressed() {
        isCreateJarPressed = true
    }
    
    func startAnimation() {
        animate = true
    }
}
