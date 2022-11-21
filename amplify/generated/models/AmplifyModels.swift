// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "097a21f0afdc477fbfb312dd307d5439"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Users.self)
  }
}