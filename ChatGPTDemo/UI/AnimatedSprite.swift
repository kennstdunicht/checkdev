//
//  ContentView.swift
//  SpriteSheet
//
//  Created by Pierre Burghardt on 03.05.24.
//

import SpriteKit
import SwiftUI

struct AnimatedSprite: View {
    @State var counter = 0
    let sprites = DuckyImages.walk()
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(uiImage: sprites[counter % sprites.count])
            .resizable()
            .scaledToFit()
            .frame(width: 164, height: 164)
            .onReceive(timer) { _ in
                counter += 1
            }
    }
}

#Preview {
    AnimatedSprite()
}
