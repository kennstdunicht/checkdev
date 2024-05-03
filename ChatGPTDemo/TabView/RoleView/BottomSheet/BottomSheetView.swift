//
//  BottomSheetView.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI


struct BottomSheetView: View {
    
    @Binding var isShowing: Bool
    @State var roleName: String = ""
    @State private var temperature: Double = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
                
                VStack {
                    
                    
                    Form {
                        TextField("Role Name", text: $roleName)
                        VStack(alignment: .leading, spacing: 20) {
                        
                            Text("Temperature")
                                .font(.headline)
                            HStack {
                                Slider(value: $temperature, in: 0...1)
                                Text(String(format: "%.2f", temperature))
                            }
                           
                            Button {
                                
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Submit")
                                    Spacer()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                       
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 350)
                .background(.white)
                .cornerRadius(16, corners: .topLeft)
                .cornerRadius(16, corners: .topRight)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
        
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


#Preview {
    BottomSheetView(isShowing: .constant(true))
}
