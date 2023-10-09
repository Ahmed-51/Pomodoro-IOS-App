 //
//  FormField.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/23/22.
//

import SwiftUI

struct FormField: View {
    @Binding var value: String
    var icon:String
    var placeholder: String
    var isSecure = false
    
    var body: some View {
        Group{
            HStack{
                Image(systemName: icon).padding()
                Group{
                    if isSecure {
                        SecureField(placeholder, text: $value)
                    } else {
                        TextField(placeholder, text: $value)
                    }
                }.font(Font.system(size: 20, design: .monospaced))
                    .foregroundColor(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
            }.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 4)).padding()
        }
    }
}
