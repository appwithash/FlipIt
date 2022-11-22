// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "3cef5e3c5e522e65376bc004eda1b10c"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Users.self)
  }
}