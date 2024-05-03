import SwiftUI

struct AnimatedSprite: View {
    @State var counter = 0
    let sprites: [UIImage]
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(uiImage: sprites[counter % sprites.count])
            .resizable()
            .scaledToFit()
            .onReceive(timer) { _ in
                counter += 1
            }
    }
}

#Preview {
    AnimatedSprite(sprites: DuckyImages.idle())
}
