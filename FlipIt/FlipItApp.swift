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
    
    
    func deleteUser() -> AnyCancellable {
        // Retrieve your Todo using Amplify.API.query
        var user = Users(id: "32249E9E-7043-42FB-94CF-148666918496", username: "ashutoshpandey", email: "ashutoshpandey731093@gmail.com", phoneNumber: "+917310939209", address: "old ITI")
        

        return Amplify.API.mutate(request: .deleteMutation(of: user, modelSchema: Users.schema,version: 10))
        .resultPublisher
        .receive(on: DispatchQueue.main)
        .sink {
            if case let .failure(error) = $0 {
                print("Got failed event with error \(error.errorDescription)")
            }
        }
        receiveValue: { result in
            switch result {
            case .success(let todo):
                print("Successfully Deleted User: \(todo)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
    }
    
    func fetchUser() -> AnyCancellable{
        let request = RESTRequest(path: "/Users")
        return Amplify.API.get(request: request)
        .resultPublisher
        .receive(on: DispatchQueue.main)
           .sink {
               if case let .failure(apiError) = $0 {
                   print("Failed", apiError)
               }
           }
           receiveValue: { data in
               let str = String(decoding: data, as: UTF8.self)
               print("Success \(str)")
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
          //  self.sessionManager.tokens.insert(self.deleteUser())
            print("Amplify configure successfully")
        }catch{
            print("err could not configure amplify",error.localizedDescription)
        }
    }
    

    
}
