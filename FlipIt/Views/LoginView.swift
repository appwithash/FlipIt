//
//  SignUpView.swift
//  FlipIt
//
//  Created by ashutosh on 19/11/22.
//

import SwiftUI

struct LoginView: View {
   
    @EnvironmentObject var sessionManager : SessionManager
    @State var showSignUpView = false
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack(spacing: Screen.maxWidth*0.08){
                Text("Flip It")
                    .font(.custom("Verdana", size: 35))
                ZStack{
                    RoundedRectangle(cornerRadius: Screen.maxWidth*0.02)
                        .foregroundColor(.white)
                    TextField("Email",text: $sessionManager.currentUser.email)
                        .font(.custom("Verdana", size: 14))
                        .padding()
                }
                .frame(width: Screen.maxWidth*0.9,height: Screen.maxWidth*0.09)
                
                ZStack{
                    RoundedRectangle(cornerRadius: Screen.maxWidth*0.02)
                        .foregroundColor(.white)
                    HStack{
                        if self.sessionManager.showPassword{
                            TextField("Password",text: $sessionManager.password)
                                .font(.custom("Verdana", size: 14))
                        }else{
                            SecureField("Password",text: $sessionManager.password)
                                .font(.custom("Verdana", size: 14))
                        }
                        Spacer()
                        Image(systemName: (self.sessionManager.showPassword ? "eye" : "eye.slash"))
                            .onTapGesture {
                                self.sessionManager.showPassword.toggle()
                            }
                    }
                    .padding()
                }
                .frame(width: Screen.maxWidth*0.9,height: Screen.maxWidth*0.09)
                
                Button {
                    self.sessionManager.Login(email: self.sessionManager.currentUser.email, password: self.sessionManager.password)
                } label: {
                    Text("Login")
                        .font(.custom("Verdana", size: 14))
                        .frame(width: Screen.maxWidth*0.9,height: Screen.maxWidth*0.09)
                        .foregroundColor(Color.white)
                        .padding(.vertical,Screen.maxWidth*0.02)
                        .background(Color.black)
                        .cornerRadius(Screen.maxWidth*0.02)
                }
                
                HStack{
                    Text("New user ?")
                        .font(.custom("Verdana", size: 14))
                        .foregroundColor(.gray.opacity(0.4))
                    Text("SignUp")
                        .bold()
                        .font(.custom("Verdana", size: 14))
                        .foregroundColor(.black)
                        .onTapGesture {
                            self.showSignUpView=true
                        }
                }
                .fullScreenCover(isPresented: $showSignUpView) {
                    NavigationView{
                        SignUpView()
                            .environmentObject(self.sessionManager)
                    }
                }
                
                NavigationLink(destination: BottomTabBarView(), isActive: $sessionManager.showHomeView) {
                    EmptyView()
                }

            }
            .navigationBarHidden(true)
            .showLoader(self.sessionManager.isLoading)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
