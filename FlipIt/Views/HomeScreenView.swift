//
//  HomeScreenView.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//

import SwiftUI

struct HomeScreenView: View {
    @State var tabList = ["Recommended","Cloths","Technology","Foods"]
    @State var storesIFollowList : [FollowStoreModel] = [
        FollowStoreModel(logo: "apple", storeName: "Apple"),
        FollowStoreModel(logo: "adidas", storeName: "Adidas"),
        FollowStoreModel(logo: "nike", storeName: "Nike"),
        FollowStoreModel(logo: "channel", storeName: "Channel"),
    ]
    @EnvironmentObject var sessionManager : SessionManager
    @State var isLoading = false
    @State var selectedTabIndex = 0
    var body: some View {
        ZStack{
            Color.white
            VStack(alignment:.leading,spacing:0){
                ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment:.leading,spacing:Screen.maxHeight*0.025){
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing:0){
                        ForEach(0..<tabList.count,id:\.self){index in
                            Text(tabList[index])
                                .font(.custom("Verdana", size: 15))
                                .padding(.all,Screen.maxWidth*0.03)
                                .background(selectedTabIndex==index ? Color.black :Color.white)
                                .cornerRadius(Screen.maxWidth*0.05)
                                .foregroundColor(selectedTabIndex==index ? .white : .black)
                                .padding(.leading)
                                .onTapGesture {
                                    self.selectedTabIndex=index
                                }
                        }
                    }
                })
                .padding(.top,Screen.maxHeight*0.075)
             Text("Stores you follow")
                .font(.custom("Verdana", size: 15))
                .bold()
                .unredacted()
                .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:0){
                            ForEach(storesIFollowList){store in
                               FollowingStoresView(store: store)
                                .padding(.leading)
                            }
                        }
                    })
             Text("Top sales")
                .font(.custom("Verdana", size: 15))
                .bold()
                .padding(.leading)
                .unredacted()
              ProductView()
            Text("offers")
               .font(.custom("Verdana", size: 15))
               .bold()
               .padding(.leading)
               .unredacted()
             ProductView()
            }
                Spacer()
            }
        }
            .background(Color("background"))
        }
        .navigationBarHidden(true)
        
        .onAppear{
            self.isLoading=true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.isLoading=false
            }
        }.redacted(reason: self.isLoading ? .placeholder : [])
        .accentColor(.black)
        
        .overlay(
            VStack{
                TopBarView()
                Spacer()
            }
        )
    }
}






struct FollowingStoresView : View{
    var store : FollowStoreModel
    var body: some View{
        VStack(spacing:5){
            Image(store.logo)
                .resizable()
                .scaledToFill()
                .frame(width: Screen.maxWidth*0.12, height: Screen.maxWidth*0.12, alignment: .center)
            Text(store.storeName)
                .font(.custom("Verdana", size: 15))
                .foregroundColor(.black)
            
        }
        .frame(width: Screen.maxWidth*0.2, height: Screen.maxWidth*0.25, alignment: .center)
        .background(Color.white)
        .cornerRadius(Screen.maxWidth*0.05)
    }
}

//MARK: - TOP bar
struct TopBarView : View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: Screen.maxWidth*0.1)
                .foregroundColor(.white)
                .frame(height:Screen.maxHeight*0.15)
                HStack{
                    Spacer()
                    Spacer()
                    Text("Store")
                        .font(.custom("Verdana", size: 20))
                        .foregroundColor(.black)
                     
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        VStack(spacing:0){
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: Screen.maxWidth*0.04, height: Screen.maxWidth*0.04, alignment: .center)
                            Capsule()
                                .frame(width: Screen.maxWidth*0.004, height: Screen.maxWidth*0.02, alignment: .center)
                        }.rotationEffect(.degrees(-45))
                        .foregroundColor(.black)
                    })
                    .padding(.trailing)
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: Screen.maxWidth*0.04, height: Screen.maxWidth*0.05, alignment: .center)
                            .foregroundColor(.black)
                    })
                    .padding(.trailing,Screen.maxWidth*0.07)
                }
                .padding(.top,Screen.maxWidth*0.17)
        }
        .offset(y:-Screen.maxHeight*0.04)
        .ignoresSafeArea()
      
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

