//
//  LoginRegister.swift
//  DevSwiftUI
//
//  Created by Cairocoders
//
 
import SwiftUI
import Firebase

struct SecureTextField: View {
    
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View{
        HStack{
            if isSecureField {
                SecureField("Password", text: $text)
            } else {
                TextField("Password", text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash" : "eye" )
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}
 
struct LoginRegister: View {
     
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var fname = ""
    @State var lname = ""
     
    @State private var shouldShowLoginAlert: Bool = false
     
    @State var StatusMessage = ""
     
    @Binding var isUserCurrentlyLoggedOut : Bool
     
    var body: some View {
        ScrollView {
 
            VStack(spacing: 16) {
                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("Login")
                        .tag(true)
                    Text("Create Account")
                        .tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                 
                if !isLoginMode {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .padding()
                            .foregroundColor(Color(.label))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black, lineWidth: 3)
                    )
                    Group {
                        TextField("First Name", text: $fname)
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                        TextField("Last Name", text: $lname)
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                        SecureTextField(text: $password)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                     
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 28, weight: .bold))
                            Spacer()
                        }.background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .purple], startPoint: .top , endPoint: .bottomTrailing))
                            )
   
                    }.cornerRadius(10)
                }else{
                    Image("Login")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .cornerRadius(64)
                     
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                        SecureTextField(text: $password)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                     
                    Button {
                        loginUser()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Login")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 28, weight: .bold))
                            Spacer()
                        }.background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .purple], startPoint: .top , endPoint: .bottomTrailing))
                            )
   
                    }.cornerRadius(10)
                    .alert(isPresented: $shouldShowLoginAlert) {
                        Alert(title: Text("Email/Password incorrect"))
                    }
                }
                 
                Text(self.StatusMessage)
                    .foregroundColor(Color.white)
                 
            }.padding()
        } //End ScrollView
        .navigationViewStyle(StackNavigationViewStyle())
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.5),.blue.opacity(0.3), .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        )
    }
     
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.StatusMessage = "Failed to login user: \(err)"
                self.shouldShowLoginAlert = true
                return
            }
   
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
   
            self.StatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
 
            self.isUserCurrentlyLoggedOut = true
        }
    }
     
    private func handleAction() {
        createNewAccount()
    }
      
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.StatusMessage = "Failed to create user: \(err)"
                return
            }
             
            print("Successfully created user: \(result?.user.uid ?? "")")
   
            self.StatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
             
            self.storeUserInformation()
        }
    }
     
    private func storeUserInformation() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["fname": self.fname, "lname": self.lname, "email": self.email, "profileImageUrl": "profileurl", "uid": uid]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.StatusMessage = "\(err)"
                    return
                }
  
                print("Success")
            }
    }
}
 
struct LoginRegister_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        LoginRegister(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
