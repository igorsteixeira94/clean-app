import Foundation

public class SignUpPresenter {
    private let alertView: AlertView
    
    public init (alertView: AlertView) {
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewMdel) {
        if let erroMessage = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: erroMessage))
        }
    }
    
    private func validate(viewModel: SignUpViewMdel) -> String? {
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
        
        return nil
    }
}

public struct SignUpViewMdel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
    
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
