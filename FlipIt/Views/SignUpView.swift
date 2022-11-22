//
//  SignUpView.swift
//  FlipIt
//
//  Created by ashutosh on 19/11/22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var sessionManager : SessionManager
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack(spacing: Screen.maxWidth*0.08){
                Text("Flip It")
                    .font(.custom("Verdana", size: 35))
//                ZStack{
//                    RoundedRectangle(cornerRadius: Screen.maxWidth*0.02)
//                        .foregroundColor(.white)
//                    TextField("username",text: $sessionManager.currentUser.username)
//                        .font(.custom("Verdana", size: 14))
//                        .padding()
//                }
//                .frame(width: Screen.maxWidth*0.9,height: Screen.maxWidth*0.09)
                
                
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
                
                ZStack{
                    RoundedRectangle(cornerRadius: Screen.maxWidth*0.02)
                        .foregroundColor(.white)
                    HStack{
                        if self.sessionManager.showConfirmPassword{
                            TextField("Confirm Password",text: $sessionManager.confirmPassword)
                                .font(.custom("Verdana", size: 14))
                        }else{
                            SecureField("Confirm Password",text: $sessionManager.confirmPassword)
                                .font(.custom("Verdana", size: 14))
                        }
                        Spacer()
                        Image(systemName: (self.sessionManager.showConfirmPassword ? "eye" : "eye.slash"))
                            .onTapGesture {
                                self.sessionManager.showConfirmPassword.toggle()
                            }
                    }
                    .padding()
                }
                .frame(width: Screen.maxWidth*0.9,height: Screen.maxWidth*0.09)
                
                Button {
                    if self.sessionManager.confirmPassword == self.sessionManager.password{
                        self.sessionManager.signUp(username: self.sessionManager.currentUser.email, email: self.sessionManager.currentUser.email, password: self.sessionManager.password)
                    }
                } label: {
                    Text("Signup")
                        .font(.custom("Verdana", size: 14))
                        .frame(width: Screen.maxWidth*0.9,height: Screen.maxWidth*0.09)
                        .foregroundColor(Color.white)
                        .padding(.vertical,Screen.maxWidth*0.02)
                        .background(Color.black)
                        .cornerRadius(Screen.maxWidth*0.02)
                        
                    
                }
                
                NavigationLink(destination: EmailVerificationView().environmentObject(self.sessionManager), isActive: $sessionManager.showEmailConfirmationScreen) {
                    EmptyView()
                }
               

            }
            .navigationBarHidden(true)
            .showLoader(self.sessionManager.isLoading)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
