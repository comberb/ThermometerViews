//
//  Thermometer.swift
//
//  Created by Ben Comber on 25/08/2023.
//

import SwiftUI
import Wave

struct Thermometer: View {
    @State private var phase = 0.0
    @Binding var progress: CGFloat
    @Binding var strength: Double
    @Binding var frequency: Double

    let lightGray = Color(red: 236/255, green: 234/255, blue: 235/255)

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                WaterWave(
                    progress: progress,
                    strength: strength,
                    frequency: frequency,
                    phase: phase + frequency
                )
                .fill(LinearGradient.rainbow)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .mask(RoundedRectangle(cornerRadius: proxy.size.width * 0.5))
                .overlay(
                    Capsule()
                        .stroke(lightGray, lineWidth: 1)
                        .shadow(color: Color.black.opacity(0.7), radius: proxy.size.width * 0.2, x: 0, y: 0)
                        .clipShape(Capsule())
                )
                .overlay {
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8),
                                    Color(red: 0.93, green: 0.94, blue: 0.97, opacity: 1)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 4
                        )
                }

                WaterWave(
                    progress: progress,
                    strength: strength,
                    frequency: frequency,
                    phase: phase
                )
                .fill(LinearGradient.rainbow)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .mask(RoundedRectangle(cornerRadius: proxy.size.width * 0.5))
                .opacity(0.5)

                RoundedRectangle(cornerRadius: proxy.size.width * 0.2)
                    .fill(.white)
                    .frame(width: proxy.size.width * 0.25, height: proxy.size.height * 0.8)
                    .mask(RoundedRectangle(cornerRadius: proxy.size.width * 0.2))
                    .blur(radius: 7)
                    .opacity(0.5)
                    .blendMode(.overlay)
                    .offset(x: proxy.size.width * 0.55, y: proxy.size.height * 0.1)

                RoundedRectangle(cornerRadius: proxy.size.width * 0.2)
                    .fill(.white)
                    .frame(width: proxy.size.width * 0.12, height: proxy.size.height * 0.78)
                    .mask(RoundedRectangle(cornerRadius: proxy.size.width * 0.2))
                    .blur(radius: 4)
                    .opacity(0.3)
                    .blendMode(.overlay)
                    .offset(x: proxy.size.width * 0.25, y: proxy.size.height * 0.11)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(
                .linear(duration: 0.75)
                .repeatForever(autoreverses: false)
            ) {
                self.phase = .pi * 2
            }
        }
    }
}

struct Thermometer_Previews: PreviewProvider {
    static var previews: some View {
        Thermometer(progress: .constant(0.85), strength: .constant(5), frequency: .constant(10))
    }
}

