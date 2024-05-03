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

struct LoadingSprite: View {
    @Binding var counter: Int
    @Binding var percentage: Double
    @Binding var isLoading: Bool
    let height: CGFloat
    let sprites: [UIImage]

    private let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    
    var body: some View {
        Group {
            GeometryReader { proxy in
                let width = proxy.size.width
                Image(uiImage: sprites[counter % sprites.count])
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .offset(x: width * percentage)
                    .onReceive(timer) { _ in
                        if isLoading {
                            counter += 1
                            if percentage >= 1.1 {
                                percentage = 0
                            }
                            withAnimation(.linear) {
                                percentage += 0.05
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct LoadingSpritePreview: View {
    @State var counter = 0
    @State var percentage = 0.0
    @State var isLoading = true
    
    var body: some View {
        LoadingSprite(
            counter: $counter,
            percentage: $percentage,
            isLoading: $isLoading,
            height: 32,
            sprites: DuckyImages.walk()
        )
    }
}

#Preview {
    VStack {
        AnimatedSprite(sprites: DuckyImages.idle())
            .frame(height: 64)
        LoadingSpritePreview()
    }
}
