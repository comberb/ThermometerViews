//
//  VSlider.swift
//
//  Created by Ben Comber on 25/08/2023.
//

import SwiftUI
import Toolbox

struct VSlider: View {
    @Binding var sliderProgress: CGFloat
    @State private var dragGestureValue: CGFloat = 0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack(alignment: .center) {
                    VStack(spacing: 0) {
                        Color(UIColor(hex: "#EE3A32"))
                            .frame(height: proxy.size.height * 0.25)
                        Rectangle()
                            .fill(LinearGradient.rainbow)
                            .frame(maxHeight: .infinity)
                        Color(UIColor(hex: "#55C1DC"))
                            .frame(height: proxy.size.height * 0.25)
                    }
                    .mask {
                        ZStack {
                            Image(systemName: "arrow.up.and.down.circle.fill")
                                .resizable()
                                .frame(
                                    width: 48,
                                    height: 48
                                )
                                .position(x: proxy.size.width * 0.55, y: dragGestureValue)
                            
                            Rectangle()
                                .frame(height: proxy.size.height * 2)
                                .mask(Image("curve-nob"))
                                .position(x: proxy.size.width * 0.35, y: dragGestureValue)
                        }
                    }
                    .mask(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .clear,
                                    .black,
                                    .black,
                                    .black,
                                    .black,
                                    .black,
                                    .clear
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: proxy.size.height * 0.75)
                    )
                }
                
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { (value) in
                            let minY = proxy.size.height * 0.25
                            let maxY = proxy.size.height - minY
                            let y = min(max(value.location.y, minY), maxY)
                            
                            let range = proxy.size.height - (minY * 2)
                            let relative = (value.location.y - minY) / range
                            let abs = abs(relative - 1)
                            
                            sliderProgress = y < maxY ? min(max(abs, 0.00), 1.00) : 0
                            dragGestureValue = y
                        }
                )
                .onAppear {
                    dragGestureValue = proxy.size.height * sliderProgress
                }
            }
        }
        .frame(width: 80)
    }
}

struct VSlider_Previews: PreviewProvider {
    static var previews: some View {
        VSlider(sliderProgress: .constant(0.5))
    }
}

