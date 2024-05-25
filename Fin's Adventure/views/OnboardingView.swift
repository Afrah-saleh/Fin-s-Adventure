//
//  OnboardingView.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 03/08/1445 AH.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var onboardingDone: Bool
    @State private var currentViewIndex = 0
    
    private let views = [
        OnboardingContentView(backgroundImage: "back5", text: "onBoard1"),
        OnboardingContentView(backgroundImage: "back2", text: "onBoard2"),
        OnboardingContentView(backgroundImage: "back3", text: "onBoard3"),
       // OnboardingContentView(backgroundImage: "back4", text: "onBoard4"),
        OnboardingContentView(backgroundImage: "back5", text: "HowToPlay")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundViewModel(imageName: views[currentViewIndex].backgroundImage)
                Image(views[currentViewIndex].text)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.6)
                    .offset(x: geometry.size.width * 0.001, y: geometry.size.height * -0.02)
                
                VStack {
                    Spacer()
                    HStack(spacing: 20) {
                        PreviousButton(geometry: geometry)
                        NextOrStartButton(geometry: geometry)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    @ViewBuilder
    private func PreviousButton(geometry: GeometryProxy) -> some View {
        if currentViewIndex > 0 {
            Button(action: {
                navigateToPreviousView()
            }) {
                Image("previous")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.2)
            }
        }
    }

    @ViewBuilder
    private func NextOrStartButton(geometry: GeometryProxy) -> some View {
        Button(action: {
            navigateToNextViewOrFinish()
        }) {
            Image(currentViewIndex == views.count - 1 ? "startBut" : "next")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width * 0.2)
        }
    }
    
    private func navigateToPreviousView() {
        withAnimation {
            currentViewIndex -= 1
            SoundManager.shared.playSoundEffect(soundName: "ButtonSound", withExtension: "mp3")
        }
    }
    
    private func navigateToNextViewOrFinish() {
        withAnimation {
            if currentViewIndex == views.count - 1 {
                onboardingDone = true
            } else {
                currentViewIndex += 1
            }
            SoundManager.shared.playSoundEffect(soundName: "ButtonSound", withExtension: "mp3")
        }
    }
}

struct OnboardingContentView {
    let backgroundImage: String
    let text: String
}
