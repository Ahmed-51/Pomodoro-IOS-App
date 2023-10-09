//
//  ProfileView.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/24/22.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @State private var uname = ""
    @State private var mail = ""
    @State private var address = ""
    @State private var phone = ""
    @State private var age = ""
    
    @State private var profileImage: Image?
    
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    @StateObject var photoPicker = PhotoPicker()
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
            VStack
                {
                    VStack (alignment: .leading) {
                        Text("Profile Details").font(.system(size: 32, weight: .heavy, design: .monospaced))
                    }
           
                    
//                        VStack{
//                            if  let image = photoPicker.image {
//                                image
//                                .resizable()
//                                .clipShape(Circle())
//                                .frame(width: 150, height: 150)
//                                .padding(.top, 20)
//                                } else {
//                                    Image(systemName: "person.circle.fill")
//                                    .resizable()
//                                    .clipShape(Circle())
//                                    .frame(width: 150, height: 150)
//                                    .padding(.top, 20)
//                            }
//                        }
//                        .padding()
//                        .navigationTitle("Profile Details")
//                        .font(.system(size: 32, weight: .heavy))
//                        .toolbar{
//                            ToolbarItem(placement: .navigationBarTrailing) {
//                                PhotosPicker(selection: $photoPicker.imageSelection,
//                                             matching: .images,
//                                             photoLibrary: .shared()) {
//                                    Image(systemName: "photo")
//                                        .imageScale(.large)
//                                }
//                            }
//                        }

                    
//                    VStack{
//                        Group{
//
//                            if
//
//                            if profileImage != nil {
//                                profileImage!.resizable()
//                                    .clipShape(Circle())
//                                    .frame(width: 150, height: 150)
//                                    .padding(.top, 20)
//                                    .onTapGesture{
//                                        showingActionSheet.toggle()
//                                    }
//                            } else {
//                                Image(systemName: "person.circle.fill")
//                                    .resizable()
//                                    .clipShape(Circle())
//                                    .frame(width: 150, height: 150)
//                                    .padding(.top, 20)
//                                    .onTapGesture{
//                                        showingActionSheet.toggle()
//                                    }
//
//                            }
//                        }
//                    }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
//                        ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
//                    }.actionSheet(isPresented: $showingActionSheet ) {
//                        ActionSheet(title: Text(""), buttons: [
//                            .default(Text("Choose a Photo")){
//                                self.sourceType = .photoLibrary
//                                self.showingImagePicker = true
//                            },
//                            .default(Text("Take A Photo")){
//                                self.sourceType = .camera
//                                self.showingImagePicker = true
//                            }, .cancel()
//                        ])
//                    }
                    
//                    Group{
                        FormField(value: $uname, icon: "person.fill", placeholder: "UserName").disabled(true)
                        
                        FormField(value: $mail, icon: "person.crop.square.filled.and.at.rectangle.fill", placeholder: "E-mail").disabled(true)
                        
                        FormField(value: $address, icon: "location.north.circle.fill", placeholder: "Address").disabled(true)
                        
                    FormField(value: $phone, icon: "phone.fill", placeholder: "Phone").disabled(true)
                        
//                        FormField(value: $uname, icon: "person.badge.clock.fill", placeholder: "Age")
                    
                    HStack{
                        Image(systemName: "person.badge.clock.fill" ).padding()
                        TextField("age", text: $age)
                            .font(Font.system(size: 20, design: .monospaced))
                            .foregroundColor(.black)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.leading)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .disabled(true)
                    }.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 4)).padding()
                        
                    
                }
            }.background(
                LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.5),.blue.opacity(0.3), .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            )
        }.onAppear{
            let userID : String = (Auth.auth().currentUser?.uid)!
            print("Current user id" + userID )
            
            let db = Firestore.firestore()
            let docRef = db.collection("Users").document(userID)
            
            docRef.getDocument{ (document,error) in
                guard error == nil else
                {
                    print("Error Writing Doc")
                    return
                }
                
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        print("data",data)
                        self.uname = data["UserName"] as? String ?? ""
                        self.mail = data["Email"] as? String ?? ""
                        self.address = data["Address"] as? String ?? ""
                        self.phone = data["Phone"] as? String ?? ""
                        self.age = data["Age"] as? String ?? ""
                    }
                }
                
            }
 
        }
 
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
