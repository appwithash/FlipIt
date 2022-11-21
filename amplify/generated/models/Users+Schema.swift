// swiftlint:disable all
import Amplify
import Foundation

extension Users {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case username
    case email
    case phoneNumber
    case address
    case firstName
    case lastName
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let users = Users.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Users"
    
//    model.attributes(
//      .primaryKey(fields: [users.id])
//    )
    
    model.fields(
      .field(users.id, is: .required, ofType: .string),
      .field(users.username, is: .required, ofType: .string),
      .field(users.email, is: .required, ofType: .string),
      .field(users.phoneNumber, is: .required, ofType: .string),
      .field(users.address, is: .required, ofType: .string),
      .field(users.firstName, is: .optional, ofType: .string),
      .field(users.lastName, is: .optional, ofType: .string),
      .field(users.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(users.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

//extension Users: ModelIdentifiable {
//  public typealias IdentifierFormat = ModelIdentifierFormat.Default
//  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
//}
