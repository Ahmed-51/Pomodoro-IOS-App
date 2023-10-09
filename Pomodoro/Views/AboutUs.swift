//
//  AboutUs.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/24/22.
//

import SwiftUI

struct AboutUs: View {
    @State private var uname1 = ""
    @State private var uname2 = ""
    @State private var uname3 = ""
    
    @State private var guest1 = ""
    @State private var guest2 = ""
    
    @State private var device = ""

    
    @State private var profileImage: Image?
    
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    @StateObject var photoPicker = PhotoPicker()
    
    @ObservedObject var data = dataFetching()
    
    var body: some View {
        
//        List(data.datalist) { x in
//            VStack{
//                Text(x.developer1)
//            }
//
//        }
//        VStack{
//            self.uname1 = data.datalist.developer1
//        }
        
        NavigationStack{
            ScrollView{
                VStack
                {
                    VStack (alignment: .leading) {
                        Text("About Us").font(.system(size: 32, weight: .heavy, design: .monospaced))
                    }
                    
                    VStack (alignment: .leading) {
                        Text("JSON Parse").font(.system(size: 25, weight: .heavy, design: .monospaced)).padding(10)
                    }
                    
                    VStack{
                        Text("Developer").font(.system(size: 20, weight: .heavy, design: .monospaced))
                        
                        FormField(value: $uname1, icon: "person.fill", placeholder: "Developer1").disabled(true)
                        FormField(value: $uname2, icon: "person.fill", placeholder: "Developer2").disabled(true)
                        FormField(value: $uname3, icon: "person.fill", placeholder: "Developer3").disabled(true)
                    }
   
                    VStack {
                        Text("Supports").font(.system(size: 20, weight: .heavy, design: .monospaced))
                        FormField(value: $guest1, icon: "person.fill", placeholder: "Support1").disabled(true)
                        FormField(value: $guest2, icon: "person.fill", placeholder: "Support2").disabled(true)
                    }
  
                    VStack {
                        Text("Device Support").font(.system(size: 20, weight: .heavy, design: .monospaced))
                        FormField(value: $device, icon: "person.fill", placeholder: "Device").disabled(true)
                    }

                    
                }
            }.background(
                LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.5),.blue.opacity(0.3), .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            )
        }.onAppear{
            
            if data.datalist.count > 0
            {
                self.uname1 = data.datalist[0].developer1
                self.uname2 = data.datalist[0].developer2
                self.uname3 = data.datalist[0].developer3
                self.guest1 = data.datalist[0].support1
                self.guest2 = data.datalist[0].support2
                self.device = data.datalist[0].device1
            }
        }
        
 
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
