//
//  BottomTabBarView.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//

import SwiftUI

struct BottomTabBarView: View {
    @State var selectedTab = 1
    @EnvironmentObject var sessionManager : SessionManager
    var body: some View {
        ZStack{
            switch selectedTab{
            case 1 : HomeScreenView()
            case 2 : HomeScreenView()
            case 3 : HomeScreenView()
            case 4 :HomeScreenView()
            case 5 :HomeScreenView()
            default: HomeScreenView()
            }
            VStack{
            Spacer()
            BottomBar(selectedTab: $selectedTab)
//                    .environmentObject(self.sessionManager)
            } .ignoresSafeArea()
        }
    }
}

struct BottomBar : View{
    @Binding var selectedTab : Int
    @EnvironmentObject var sessionManager : SessionManager
    var body : some View{
        HStack{
            Group{
            Spacer()
                Image( self.selectedTab==1 ? "home.fill" : "home")
                    .resizable()
                    .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                .foregroundColor(self.selectedTab==1 ? .black : .gray)
                .onTapGesture {
                    self.selectedTab=1
                }
            Spacer()
                VStack(spacing:0){
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: Screen.maxWidth*0.042, height: Screen.maxWidth*0.042, alignment: .center)
                    Capsule()
                        .frame(width: Screen.maxWidth*0.005, height: Screen.maxWidth*0.02, alignment: .center)
                }.rotationEffect(.degrees(-45))
                .foregroundColor(self.selectedTab==2 ? .black : .gray)
                .onTapGesture {
                    self.selectedTab=2
                }
            Spacer()
            }
            Group{
                ZStack{
                    RoundedRectangle(cornerRadius: Screen.maxWidth*0.01)
                        .stroke(lineWidth: 2.0)
                        .frame(width: Screen.maxWidth*0.05, height: Screen.maxWidth*0.05, alignment: .center)
                    Image(systemName: "plus")
                        .font(.system(size: 15))
                    
                }
                .foregroundColor(self.selectedTab==3 ? .black : .gray)
                .onTapGesture {
                    self.selectedTab=3
                }
            Spacer()
                Image(systemName:self.selectedTab==4 ? "heart.fill" : "heart")
                .font(.system(size: 23))
                .foregroundColor(self.selectedTab==4 ? .black : .gray)
                .onTapGesture {
                    self.selectedTab=4
                }
            Spacer()
                Image(systemName: self.selectedTab==5 ? "person.fill" : "person")
                    .font(.system(size: 23))
                    .foregroundColor(self.selectedTab==5 ? .black : .gray)
                    .onTapGesture {
                        self.selectedTab=5
                        self.sessionManager.signout()
                    }
                Spacer()
            }
        }
        .frame(height:Screen.maxHeight*0.1)
        .background(Color.white)
        .cornerRadius(Screen.maxWidth*0.07)
      
    }
}

struct BottomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBarView()
    }
}
