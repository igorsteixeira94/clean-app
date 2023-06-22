import Foundation
import Presentation

final class EmailValidatorSpy: EmailValidatorType {
    var isValid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
}
