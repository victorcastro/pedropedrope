//
//  ContentView.swift
//  PedroPedroPe
//
//  Created by Victor Castro on 24/04/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack() {
                
                Image("racoon")
                    .padding()
                Text("Ingresa a la aplicación desde tu AppleWatch")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }.padding(40)
            
            VStack {
                Spacer()
                Text("Desarrollado por @NativoDigital_iOS")
                    .foregroundColor(.gray).opacity(0.7)
                    .font(.caption2)
            }
        }
    }
}

#Preview {
    ContentView()
}
