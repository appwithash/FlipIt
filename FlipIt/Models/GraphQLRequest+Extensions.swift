//
//  GraphQLRequest+Extensions.swift
//  FlipIt
//
//  Created by ashutosh on 21/11/22.
//

import SwiftUI
import Amplify
import AmplifyPlugins


extension GraphQLRequest{
    static func updateUser(with newUser : Users,version : Int)->GraphQLRequest<Users>{
        let document = """
        mutation MyMutation {
          updateUsers(input: {id: $newUser.id, _version: $version, address: $newUser.address, email: $newUser.email, phoneNumber: $newUser.phoneNumber, username: $newUser.username}) {
            _lastChangedAt
            _version
            address
            createdAt
            email
            id
            phoneNumber
            updatedAt
            username
            _deleted
          }
        }


        """
        
        return GraphQLRequest<Users>(document:document,
                variables: [
                    "id":newUser.id,
                    "username":newUser.username,
                    "email":newUser.email,
                    "address":newUser.address,
                    "phoneNumber":newUser.phoneNumber,
                    "_version" : version,
//                    "id":newUser.,
                ],
                responseType: Users.self
        )
    }
}
