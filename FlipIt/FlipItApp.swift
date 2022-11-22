//
//  FlipItApp.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import Combine
@main
struct FlipItApp: App {
    @ObservedObject var sessionManager = SessionManager()
   
    init(){
        self.configureAmplify()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                switch self.sessionManager.authState{
                case .login : LoginView()
                        .environmentObject(self.sessionManager)
    
                case .session(user: let user):
                    BottomTabBarView()
                    .environmentObject(self.sessionManager)
                       
                }
            }
            .onAppear{
                self.sessionManager.getCurrentAuthUser()
            }
            
        }
    }
    
    
   
    
    func fetchUser() -> AnyCancellable {
       
        return Amplify.API.query(
            request: .get(Users.self, byId: Amplify.Auth.getCurrentUser()!.userId)
        )
        .resultPublisher
        .receive(on: DispatchQueue.main)
        .sink {
            if case let .failure(error) = $0 {
                print("Got failed event with error \(error)")
            }
        }
        receiveValue: { result in
            switch result {
            case .success(let todo):
                guard let todo = todo else {
                    print("Could not find todo")
                    return
                }
                print("Successfully retrieved todo: \(todo)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
        
    }
    func configureAmplify(){
        
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        let apiPlugins = AWSAPIPlugin(modelRegistration: AmplifyModels())
        do{
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.add(plugin: apiPlugins)
                     
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
//            self.sessionManager.tokens.insert(self.fetchUser())
            print("Amplify configure successfully")
        }catch{
            print("err could not configure amplify",error.localizedDescription)
        }
    }
    

    
}
