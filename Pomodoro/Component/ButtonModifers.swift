//
//  ButtonModifers.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/23/22.
//

import SwiftUI

struct ButtonModifers: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .bold))
//            .stroke(Color.blue.opacity(0.7), lineWidth: 10)
            .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.linearGradient(colors: [.blue, .purple], startPoint: .top , endPoint: .bottomTrailing))
            )
            .cornerRadius(20.0)
            .shadow(color: Color.blue.opacity(0.3),radius: 10, x: 0.0, y: 10)
        
    }
}
