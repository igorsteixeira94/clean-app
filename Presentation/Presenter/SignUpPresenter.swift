import Foundation

public class SignUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidatorType
    
    public init (alertView: AlertView, emailValidator: EmailValidatorType) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let erroMessage = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: erroMessage))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name.isNilOrEmpty {
            return "O campo Nome é obrigatório"
        }
        
        if viewModel.email.isNilOrEmpty {
            return "O campo Email é obrigatório"
        }
        
        if viewModel.password.isNilOrEmpty {
            return "O campo Password é obrigatório"
        }
        
        if viewModel.passwordConfirmation.isNilOrEmpty {
            return "O campo Confirmar senha é obrigatório"
        }
        
        if viewModel.password != viewModel.passwordConfirmation {
            return "Falha ao confirmar senha"
        }
        
        if !emailValidator.isValid(email: viewModel.email!) {
            return "Email inválido"
        }
        
        return nil
    }
}

public struct SignUpViewModel {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(name: String? = nil,
                email: String? = nil,
                password: String? = nil,
                passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
