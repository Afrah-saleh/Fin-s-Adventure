
//
//  ContentView.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 03/08/1445 AH.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct ContentView: View {
    @StateObject var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x: 0, y: 0)
        scene.speed = 1
        return scene
    }()
    
    @Binding var start: Bool
       
       var body: some View {
           ZStack {
               SpriteView(scene: scene)
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                   .ignoresSafeArea()
               
               if !scene.isGameOver {
                   GameElementView(scene: scene)
               }
           }
       }
   }
        struct GameElementView: View {
            @ObservedObject var scene: GameScene
            
            var body: some View {
                VStack {
                    HStack {
                        ZStack {
                            TimerView()
                            Text("\(scene.countdown)")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.leading, 35)
                        }
                        
                        Spacer()
                        
                        HealthBarView(health: scene.score)
                            .frame(height: 20)
                        Text("\(scene.score) / 10")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Spacer()
                }
            }
        }
        struct RootView: View {
            @State var start: Bool = false
            @State var onboardingDone: Bool = false
            
            var body: some View {
                
                Group {
                    if !start {
                        IntroView(start: $start)
                        
                    } else if !onboardingDone {
                        OnboardingView(onboardingDone: $onboardingDone)
                    } else {
                        ContentView(start: $start)

                    }
                }
                .onAppear {
                    SoundManager.shared.setupBackgroundMusic(soundName: "BG1", withExtension: "mp3")
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("resetBut"), object: nil, queue: .main) { _ in
                        self.start = false
                        self.onboardingDone = false
                    }
                }

            }
            
        }


struct IntroView: View {
    @Binding var start: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background image filling the entire screen
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all) // Ensures the background extends into the safe area

                // Vertical stack for logo and button
                VStack(spacing: 20) { // Adjusted spacing to a fixed value for consistency
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.6) // Adjusted to only specify width for better scaling

                    Button(action: {
                        start = true
                        SoundManager.shared.playSoundEffect(soundName: "ButtonSound", withExtension: "mp3")
                    }) {
                        Image("startBut")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.3) // Removed height to maintain aspect ratio
                    }
                }
                .padding(.top, geometry.safeAreaInsets.top + 50) // Adjust padding to consider safe area
            }
        }
    }
}
