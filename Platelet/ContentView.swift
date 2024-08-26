//
//  ContentView.swift
//  Platelet
//
//  Created by Ethan Zhang on 25/8/2024.
//

import SwiftUI
import AVFoundation

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isPressed = false
    @State private var touchCount = UserDefaults.standard.integer(forKey: "touchCount") // Load from UserDefaults
    @State private var volume: Float = 0.5 // Default volume
    @State private var tap = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(isPressed ? "platelet image2" : "platelet image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

                .simultaneousGesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged ({ _ in
                            if !isPressed {
                                isPressed = true
                                touchCount += 1
                                saveTouchCount()
                                SoundManager.shared.playTapSound()
                                
                            }
                            
                        })
                        .onEnded({ _ in
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.02) {
                                isPressed = false
                            }
                            
                        })
                        
                )

            VStack {

                HStack {
                    Slider(value: Binding(
                        get: { volume },
                        set: { newVolume in
                            volume = newVolume
                            SoundManager.shared.setVolume(volume)
                        }
                    ), in: 0...1)
                    .tint(Color(red: 0.599, green: 0.412, blue: 0.409))
                    .frame(width: 150)
                    .padding()
                    Spacer()
                }
                .padding(.top, 30.0)
                Spacer()
            }
            Text("Poke Count: \(touchCount)")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color(red: 0.599, green: 0.412, blue: 0.409))
                .padding(.bottom, 17.238)
        }
        .onAppear {
            SoundManager.shared.playBackgroundMusic() // Start background music
            SoundManager.shared.setVolume(volume) // Set initial volume
        }
    }
    
    // Save the touch count to UserDefaults
    private func saveTouchCount() {
        UserDefaults.standard.set(touchCount, forKey: "touchCount")
    }
}

class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    private init() {
        if let soundURL = Bundle.main.url(forResource: "poke", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file")
            }
        }
        if let musicURL = Bundle.main.url(forResource: "background", withExtension: "mp3") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
                backgroundMusicPlayer?.prepareToPlay()
            } catch {
                print("Error loading background music file")
            }
        }
    }
    
    func playTapSound() {
        audioPlayer?.play()
    }
    func playBackgroundMusic() {
        backgroundMusicPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    func setVolume(_ volume: Float) {
        backgroundMusicPlayer?.volume = volume
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
