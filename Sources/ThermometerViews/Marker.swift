//
//  Marker.swift
//
//  Created by Ben Comber on 25/08/2023.
//

import SwiftUI
import Toolbox

public struct Marker: View {
    @Binding public var progress: CGFloat
    
    public init(progress: Binding<CGFloat>) {
        self._progress = progress
    }
    
    public var body: some View {
        ZStack(content:{
            Rectangle()
                .fill(Color(UIColor(hex: "#DFE5F1")).opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color(UIColor(hex: "#A1A7B4")).opacity(0.8))
                        .frame(height: proxy.size.height * progress)
                }
            }
        })
        .frame(width: 52)
        .mask(Image("mark-num"))
    }
}

struct Marker_Previews: PreviewProvider {
    static var previews: some View {
        Marker(progress: .constant(0.5))
    }
}
