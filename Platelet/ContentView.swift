//
//  ContentView.swift
//  Platelet
//
//  Created by Ethan Zhang on 25/8/2024.
//

import SwiftUI

import AVFoundation
struct ContentView: View {
    @State private var isPressed = false
    @State private var touchCount = 0

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(isPressed ? "platelet image2" : "platelet image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isPressed {
                                isPressed = true
                                touchCount += 1
                                SoundManager.shared.playTapSound()
                            }
                        }
                        .onEnded { _ in
                            isPressed = false
                        }
                )
            
            Text("Poke Count: \(touchCount)")
                           .font(.system(.largeTitle, design: .rounded))
                           .fontWeight(.medium)
                           .foregroundStyle(Color(red: 0.599, green: 0.412, blue: 0.409))
                           .padding(.bottom, 17.238)
        }
    }
}
class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        if let soundURL = Bundle.main.url(forResource: "poke", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file")
            }
        }
    }
    
    func playTapSound() {
        audioPlayer?.play()
    }
}
