//
//  ContentView.swift
//  PedroPedroPe Watch App
//
//  Created by Victor Castro on 24/04/24.
//

import SwiftUI
import AVKit
import AVFoundation
import Foundation

struct ContentView: View {
    
    private var player = AVPlayer()
    
    @State private var imageOpacity: Double = 1.0
    @State private var currentTime = ""
    @State private var isMuted = false
    @State private var isPlaying = true
    @State private var showAnimation = false
    
    init() {
        self.player = createPlayer()
        notification()
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                VideoPlayer(player: player)
                    .mask {
                        Circle()
                            .frame(width: 180, height: 180)
                    }
                
                if showAnimation {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .opacity(imageOpacity)
                    }
                }
                
                Rectangle()
                    .fill(.black)
                    .opacity(0.1)
                    .onTapGesture {
                        toggleMute()
                    }
                    .onLongPressGesture(minimumDuration: 0.2) {
                        togglePlay()
                    }
                
                VStack {
                    Spacer()
                    Text(currentTime)
                        .font(.custom("Jersey10-Regular", size: 85))
                        .shadow(radius: 12)
                }
                
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    self.updateCurrentTime()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("didBecomeActiveWatch"))) { _ in
                isPlaying = true
                player.play()
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("WillEnterForegroundWatch"))) { _ in
                isPlaying = false
                player.pause()
            }
        }
        .ignoresSafeArea()
    }
    
    private func togglePlay() {
        isPlaying.toggle()
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    private func createPlayer() -> AVPlayer {
        if let url = Bundle.main.url(forResource: "racoon", withExtension: "mp4") {
            return AVPlayer(url: url)
        } else {
            print("Error: No se encontró el archivo 'racoon.mp4'")
            return AVPlayer()
        }
    }
    
    private func notification() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: .zero)
            isPlaying = true
            player.play()
        }
    }
    
    private func updateCurrentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        currentTime = formatter.string(from: Date())
    }
    
    private func toggleMute() {
        isMuted.toggle()
        player.isMuted = isMuted
        showAnimation = true
        
        withAnimation {
            imageOpacity = imageOpacity == 1 ? 0 : 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            showAnimation = false
        }
    }
}

#Preview {
    ContentView()
}


