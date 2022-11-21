//
//  EmailVerificationView.swift
//  FlipIt
//
//  Created by ashutosh on 19/11/22.
//

import SwiftUI

struct EmailVerificationView: View {
    @EnvironmentObject var sessionManager : SessionManager
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack{
                VStack(alignment:.leading){
                    Text("Email Verification")
                        .font(.custom("Verdana", size: 35))
                    Text("Enter code send to your email")
                        .foregroundColor(.gray.opacity(0.4))
                }
                .padding(.bottom)
                HStack{
                    ForEach(0...5,id:\.self){index in
                        if index >= self.sessionManager.emailVerificationCode.count{
                            Circle()
                                .stroke()
                                .foregroundColor(.black)
                                .frame(width: 10,height: 10)
                        }else{
                            Text("\(self.sessionManager.emailVerificationCode[index])")
                        }
                    }
                }
                
                LazyVGrid(columns: [GridItem(.fixed(Screen.maxWidth*0.3)),GridItem(.fixed(Screen.maxWidth*0.3)),GridItem(.fixed(Screen.maxWidth*0.3))]) {
                    ForEach(1...9,id:\.self){number in
                        Text("\(number)")
                            .frame(width: Screen.maxWidth*0.27,height: Screen.maxWidth*0.12)
                            .scaleEffect(1.5)
                            .padding(.vertical)
                            .onTapGesture {
                                if self.sessionManager.emailVerificationCode.count<6{
                                    self.sessionManager.emailVerificationCode.append("\(number)")
                                    print(self.sessionManager.emailVerificationCode)
                                }
                            }
                    }
                  
                        Text("\(1)")
                            .frame(width: Screen.maxWidth*0.27,height: Screen.maxWidth*0.12)
                            .scaleEffect(1.5)
                            .padding(.vertical)
                            .opacity(0)
                            
                        Text("0")
                            .frame(width: Screen.maxWidth*0.27,height: Screen.maxWidth*0.12)
                            .scaleEffect(1.5)
                            .padding(.vertical)
                            .onTapGesture {
                                if self.sessionManager.emailVerificationCode.count<6{
                                    self.sessionManager.emailVerificationCode.append("0")
                                    print(self.sessionManager.emailVerificationCode)
                                }
                            }
                        
                        Image(systemName: "delete.backward")
                            .foregroundColor(.black)
                            .frame(width: Screen.maxWidth*0.27,height: Screen.maxWidth*0.12)
                            .scaleEffect(1.5)
                            .padding(.vertical)
                            .onTapGesture {
                                if !self.sessionManager.emailVerificationCode.isEmpty{
                                    self.sessionManager.emailVerificationCode.removeLast()
                                    print(self.sessionManager.emailVerificationCode)
                                }
                            }
                
                    
                }
                
                Button {
                    if self.sessionManager.emailVerificationCode.count == 6{
                        var code = ""
                        for char in self.sessionManager.emailVerificationCode{
                            code += char
                        }
                        self.sessionManager.confirmation(email: self.sessionManager.currentUser.email, code: code)
                    }
                } label: {
                    Text("Verify")
                        .font(.custom("Verdana", size: 14))
                        .frame(width: Screen.maxWidth*0.9,height: Screen.maxWidth*0.09)
                        .foregroundColor(Color.white)
                        .padding(.vertical,Screen.maxWidth*0.02)
                        .background(Color.black)
                        .cornerRadius(Screen.maxWidth*0.02)
                        
                    
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

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerificationView()
    }
}
