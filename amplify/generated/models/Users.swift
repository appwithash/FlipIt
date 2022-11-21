// swiftlint:disable all
import Amplify
import Foundation

public struct Users: Model {
  public let id: String
  public var username: String
  public var email: String
  public var phoneNumber: String
  public var address: String
  public var firstName: String?
  public var lastName: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      username: String,
      email: String,
      phoneNumber: String,
      address: String,
      firstName: String? = nil,
      lastName: String? = nil) {
    self.init(id: id,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      firstName: firstName,
      lastName: lastName,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      username: String,
      email: String,
      phoneNumber: String,
      address: String,
      firstName: String? = nil,
      lastName: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.username = username
      self.email = email
      self.phoneNumber = phoneNumber
      self.address = address
      self.firstName = firstName
      self.lastName = lastName
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}