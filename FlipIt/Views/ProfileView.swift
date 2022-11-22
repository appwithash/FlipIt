//
//  ProfileView.swift
//  FlipIt
//
//  Created by ashutosh on 19/11/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionManager : SessionManager
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack{
//                TextField("First Name", text: $sessionManager.currentUser.firstName)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
