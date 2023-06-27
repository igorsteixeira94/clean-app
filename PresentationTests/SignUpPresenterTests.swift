import XCTest
import Presentation

final class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertView.viewModel, makeAlertViewModel(message: "O campo Nome é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertView.viewModel, makeAlertViewModel(message: "O campo Email é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertView.viewModel, makeAlertViewModel(message: "O campo Password é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertView.viewModel, makeAlertViewModel(message: "O campo Confirmar senha é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_match() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        XCTAssertEqual(alertView.viewModel, makeAlertViewModel(message: "Falha ao confirmar senha"))
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() {
        let emailValidator = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidator)
        let viewModel = makeSignUpViewModel()
        
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(emailValidator.email, viewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let alertView = AlertViewSpy()
        let emailValidator = EmailValidatorSpy()
        let sut = makeSut(alertView: alertView, emailValidator: emailValidator)
        
        emailValidator.isValid = false
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(alertView.viewModel, makeAlertViewModel(message: "Email inválido"))
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                 emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        
        return sut
    }
    
    func makeSignUpViewModel(name: String? = "any_name",
                             email: String? = "invalid_email@mail.com",
                             password: String? = "any_password",
                             passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        SignUpViewModel(name: name,
                        email: email,
                        password: password,
                        passwordConfirmation: passwordConfirmation)
    }
    
    func makeAlertViewModel(message: String) -> AlertViewModel {
        AlertViewModel(title: "Falha na validação", message: message)
    }
}
