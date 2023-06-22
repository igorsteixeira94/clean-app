import Foundation

public protocol EmailValidatorType {
    func isValid(email: String) -> Bool
}
