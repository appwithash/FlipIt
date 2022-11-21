//
//  SessionManager.swift
//  FlipIt
//
//  Created by ashutosh on 19/11/22.
//

import SwiftUI
import Amplify
import Combine
final class SessionManager : ObservableObject{
    @Published var authState : AuthState = .login
    @Published var emailVerificationCode : [String] = []
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var showPassword = false
    @Published var showConfirmPassword = false
    @Published var showEmailConfirmationScreen = false
    @Published var isLoading = false
    @Published var showHomeView = false
    @Published var tokens : Set<AnyCancellable> = []
    @AppStorage("user_id") var userId = ""
    @Published var currentUser : Users = Users(id: UUID().uuidString, username: "", email: "", phoneNumber: "", address: "")
    func getCurrentAuthUser(){
       
        if let user = Amplify.Auth.getCurrentUser(){
            print("current user",user.username)
            self.authState = .session(user: user)
        }else{
            print("no current user")
            self.authState = .login
        }
    }
    
    func showLogin(){
        self.authState = .login
    }
    
    func Login(email:String,password:String){
        DispatchQueue.main.async {
            self.isLoading=true
        }
        Amplify.Auth.signIn(
            username: email,
            password: password
        ){result in
            switch result{
            case .success(let signUpResult) :
                print("Login result :", signUpResult)
                
                DispatchQueue.main.async {
                    self.isLoading=false
                    self.showHomeView=true
                }
            case .failure(let err):
                print("Login Failure : ",err.localizedDescription)
                DispatchQueue.main.async {
                    self.isLoading=false
                }
            }
        }
    }
    
    func signUp(username:String,email:String,password:String){
        DispatchQueue.main.async {
            self.isLoading=true
        }
        let attributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)
        
        _ = Amplify.Auth.signUp(
            username: email,
            password: password,
            options: options
        ){result in
            switch result{
            case .success(let signUpResult) : print("SignUp result :", signUpResult)
                switch signUpResult.nextStep{
                case .done : print("signup successfully")
                case .confirmUser(let details, _) :
                    print(details ?? "no details")
                    DispatchQueue.main.async {
                        self.isLoading=false
                        self.showEmailConfirmationScreen=true
                    }
                }
            case .failure(let err):
                print("SignUp Failure : ",err.localizedDescription)
                DispatchQueue.main.async {
                    self.isLoading=false
                }
            }
        }
    }
    
    
    func signout(){
        Amplify.Auth.signOut { [weak self] result in
            switch result{
            case .success :
                DispatchQueue.main.async {
                    self?.getCurrentAuthUser()
                }
            case .failure(let err) :
                print("Signout failure",err)
            }
        }
    }
    func confirmation(email : String, code : String){
        DispatchQueue.main.async {
            self.isLoading=true
        }
        _ = Amplify.Auth.confirmSignUp(for: email, confirmationCode: code, listener: { result in
            switch result{
            case .success(let confirmResult) :
                print("confirmation result :",confirmResult)
                if confirmResult.isSignupComplete{
                    self.createUser()
                    self.Login(email: email, password: self.password)
                    DispatchQueue.main.async {
                        self.isLoading=false
                        self.showHomeView=true
                        self.showLogin()
                    }
                }
                
            case .failure(let error) : print("confirmation failed : ",error)
                DispatchQueue.main.async {
                    self.isLoading=false
                }
            }
        })
    }
    
    func observeUser(){
        Amplify.DataStore.observeQuery(for: Users.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let err) = completion{
                    print("Error - ",err.localizedDescription)
                }
            } receiveValue: { snapShot in
                self.userId = snapShot.items.first!.id
                print("user",snapShot.items.first!.email)
            }
            .store(in: &tokens)
    }
    
    func dataStore(){
        let user = Users(id: UUID().uuidString, username: "ashutosh", email: "ashutoshpandey731093@gmail.com", phoneNumber: "7310939209", address: "old ITI")
        Amplify.DataStore.save(user)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let err) = completion{
                    print("Error DataStore - ",err.localizedDescription)
                }
            } receiveValue: { savedUser in
                print("User",savedUser)
            }
            .store(in: &tokens)
    }
    
    func updateUser() -> AnyCancellable {
        // Retrieve your Todo using Amplify.API.query
        var user = Users(id: "32249E9E-7043-42FB-94CF-148666918496", username: "ashutoshpandey", email: "ashutoshpandey731093@gmail.com", phoneNumber: "+917310939209", address: "old ITI")
        user.username = "ashutodhpandey"
        let todoUpdated = user
//        let updateRequest = GraphQLRequest<Users>.updateUser(with: todoUpdated, version: 8)
        return Amplify.API.mutate(request: .updateMutation(of: todoUpdated,version: 10))
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
                print("Successfully Updated User: \(todo)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
    }
    func createUser() -> AnyCancellable {
        print("current user",self.currentUser)
        return Amplify.API.mutate(request: .update(self.currentUser))
        .resultPublisher
        .receive(on: DispatchQueue.main)
        .sink { completion in
            if case .failure(let err) = completion{
                print("Error API - ",err.localizedDescription)
            }
        }
        receiveValue: { result in
            switch result {
            case .success(let todo):
                print("Successfully Updated the User: \(todo)")
            case .failure(let graphQLError):
                print("Could not decode result: \(graphQLError)")
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
    
    
}


enum AuthState{
    case login
    case session(user : AuthUser)
}
