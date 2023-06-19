import XCTest

class SignUpPresenter {
    private let alertView: AlertView
    
    init (alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignUpViewMdel) {
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

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
    
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

struct SignUpViewMdel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

final class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let viewModel = SignUpViewMdel(email:"email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let viewModel = SignUpViewMdel(name:"any_name",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let viewModel = SignUpViewMdel(name:"any_name",
                                       email: "any_email@mail.com",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Password é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let viewModel = SignUpViewMdel(name:"any_name",
                                       email: "any_email@mail.com",
                                       password: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Confirmar senha é obrigatório"))
    }
}

extension SignUpPresenterTests {
    func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        
        return (sut, alertViewSpy)
    }
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}

extension String? {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
