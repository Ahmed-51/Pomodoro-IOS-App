//
//  Home.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/9/22.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @State var shouldShowLogOutOptions = false
    @Binding var isUserCurrentlyLoggedOut : Bool
    @State var navigatedPomo = false
    @State var navigatedPro = false
    @State var navigatedEdit = false
    @State var navigatedAbout = false
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView{
                
                VStack {
                    
                    VStack (alignment: .leading) {
                        Text("Home").font(.system(size: 56, weight: .heavy, design: .monospaced))
                    }
                    
                    NavigationLink("", destination: PomodoroMain(), isActive: $navigatedPomo)
                    Button(action: { self.navigatedPomo.toggle() } ) {
                        HStack{
                            Image(systemName: "timer")
                            Text("PomoDoro").font(.title)
                        }
                        .modifier(ButtonModifers())
                        .padding()
                    }
                    
    //                Button {
    //                    //API Call
    //                }label: {
    //                    Text("Basic API")
    //                        .bold()
    //                        .frame(width: 200, height: 40)
    //                        .background(
    //                            RoundedRectangle(cornerRadius: 10, style: .continuous)
    //                                .fill(.linearGradient(colors: [.pink, .red], startPoint: .top , endPoint: .bottomTrailing))
    //                        )
    //                        .foregroundColor(.white)
    //                }
    //                .padding(.top)
    //                .offset(y: 0)
                    
                    NavigationLink("", destination: ProfileView(), isActive: $navigatedPro)
                    Button(action: {self.navigatedPro.toggle()}){
                        HStack{
                            Image(systemName: "person")
                            Text("Profile").font(.title)
                        }
                        .modifier(ButtonModifers())
                        .padding()
                    }
                    
                    NavigationLink("", destination: EditProfileView(), isActive: $navigatedEdit)
                    Button(action: {self.navigatedEdit.toggle()}){
                        HStack{
                            Image(systemName: "pencil")
                            Text("Edit Profile").font(.title)
                        }
                        .modifier(ButtonModifers())
                        .padding()
                    }
                    
                    
                    NavigationLink("", destination: AboutUs(), isActive: $navigatedAbout)
                    Button(action: {self.navigatedAbout.toggle()}){
                        HStack{
                            Image(systemName: "doc.text.image.fill")
                            Text("About Us").font(.title)
                        }
                        .modifier(ButtonModifers())
                        .padding()
                    }
                    
                    
                    Button {
                        shouldShowLogOutOptions.toggle()
                    } label: {
                            HStack{
                                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                Text("Log Out").font(.title)
                            }
                            .modifier(ButtonModifers())
                            .padding()
                    }
                }
                .padding()
                .actionSheet(isPresented: $shouldShowLogOutOptions) {
                    .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                        .destructive(Text("Sign Out"), action: {
                            print("handle sign out")
                            try? Auth.auth().signOut()
                            self.isUserCurrentlyLoggedOut = false
                        }),
                        .cancel()
                    ])
                }
            }.background(
                LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.5),.blue.opacity(0.3), .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            )
        }
    }
    
    struct Home_Previews: PreviewProvider {
        @State static var isUserCurrentlyLoggedOut = false
        static var previews: some View {
            Home(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
        }
    }
}
