//
//  AccountTab.swift
//  Tmarkis
//
//  Created by Agang Dut on 8/21/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct SignedInTab: View {
    @EnvironmentObject var session: SessionStore
    @State var isAlert = false
        func signout()  {
            if session.signOut() {
        }
            else {
            }
        }
    
    var body: some View {
        NavigationView {
            VStack() {
            Image("userimg")
                .resizable()
                .frame(width: 150, height: 150)
                .navigationBarTitle("My Account", displayMode: .inline)
                Spacer()
                // let currentuser = Auth.auth().currentUser?.uid
                // let name = Firestore.firestore().collection("users").document(currentuser)
                Text("Hi, ")
                .font(.title)

            List {
                Section(header: Text("User Information")) {
            NavigationLink(destination: SignupTab()){
                Text("Orders")
            }
            NavigationLink(destination: SignupTab()){
                Text("Address Book and Payment Methods")
            }
            NavigationLink(destination: SignupTab()){
                Text("Settings")
            }
        }
                Section(header: Text("Stay in Touch")) {
            NavigationLink(destination: SignupTab()){
                Text("Contact Us")
            }
            NavigationLink(destination: SignupTab()){
                Text("Leave Feedback")
            }
        }
            }
                Button(action: {
                    self.isAlert = true
                }) {
                    Text("Log Out")
                    .foregroundColor(Color.white)
                    
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(15)
                .alert(isPresented: $isAlert) { () -> Alert in
                    Alert(title: Text("Log Out"), message: Text("Are you sure you want to log out now?"), primaryButton: .default(Text("Cancel")), secondaryButton: .default(Text("Log Out"), action: {
                        self.signout()
                    }))
                    }
                }
            }
        }
    }

struct AccountTab: View {
    
    @EnvironmentObject var session: SessionStore
    @State var email: String = ""
    @State var password: String = ""
    @State var signInWorked = ""
    
    func login() {
        session.signIn(email: email, password: password) { (result,error) in
            if error != nil {
                self.signInWorked = "Invalid email or password please try again."
                print(error ?? "")
            } else {
                self.signInWorked = ""
            }
        }
    }

    var body: some View {
        NavigationView {
        VStack {
            Image("userimg")
                .resizable()
                .frame(width: 200, height: 200)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading)
                .padding(.leading)
                .padding(.trailing)
                .cornerRadius(10.0)
                .foregroundColor(Color.yellow)

            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading)
                .padding(.leading)
                .padding(.trailing)
                .cornerRadius(10.0)

            
            NavigationLink(destination: SignupTab()) {
                Text("Forgot Password?")
                    .padding(.trailing)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .font(.caption)
                }
            Text(signInWorked)
            
            Button(action: {
                self.login()
            }) {
                Text("Sign In")
                    .padding(.all, 7.0)
                .background(Color.yellow)
                .foregroundColor(Color.white)
                .cornerRadius(12)
            }
            
            Spacer()
            
            NavigationLink(destination: SignupTab()) {
                Text("No account? Sign up here")
            }
            Spacer()
            }
        }
    }
}

struct SignupTab: View {
    
    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmpass: String = ""
    @State var loading = false
    @State var error = false
    @State var signInWorked = ""
    @EnvironmentObject var session: SessionStore

func validatefields() -> String {
    
    if firstname == "" || lastname == "" || email == "" || password == "" || confirmpass == "" {
        return "Please fill in all fields."
    }
    if Utilities.emailtest(email) == false {
        return "Please enter a valid email address."
    }
    if password != confirmpass {
        return "Passwords do not match. Please check the fields and try again."
    }
    if Utilities.passwordtest(password) == false {
        return "Password must contain at least 8 characters, one number and one special character"
    } else if true {
    return ""
    }
}

    func signUp () {
        error = false
        if validatefields() != "400" {
            error = true
        }
        session.createuser(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
                print(error ?? "something is wrong if you're reading this lol")
            } else {
                let db = Firestore.firestore()
                db.collection("users").document(result!.user.uid).setData([ "First Name":self.firstname, "Last Name":self.lastname, "Email":self.email, "Password":self.password, "uid": result!.user.uid ])
            }
        }
    }

func sessionlisten() {
    session.listen()
}
    var body: some View {
        NavigationView {
        VStack {
    
            TextField("First Name", text: $firstname)
            
            TextField("Last Name", text: $lastname)
            
            TextField("Email Adress", text: $email)
            
            SecureField("Password", text: $password)
            
            SecureField("Confirm Password", text: $confirmpass)
            
            if (error) {
                Text(validatefields())
            }
            Button(action: signUp) {
               Text("Sign Up")
            }
        }
    }
}
}

struct AccountTab_Previews: PreviewProvider {
    static var previews: some View {
        AccountTab()
            .environmentObject(SessionStore())
        
    }
}

