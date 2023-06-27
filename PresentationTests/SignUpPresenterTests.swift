import XCTest
import Presentation

final class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let viewModel = SignUpViewModel(email:"email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertView.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let viewModel = SignUpViewModel(name:"any_name",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertView.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertView.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Password é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       password: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertView.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Confirmar senha é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_match() {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "wrong_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertView.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "Falha ao confirmar senha"))
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() {
        let emailValidator = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidator)
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(emailValidator.email, viewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let alertView = AlertViewSpy()
        let emailValidator = EmailValidatorSpy()
        let sut = makeSut(alertView: alertView, emailValidator: emailValidator)
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "invalid_email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        emailValidator.isValid = false
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertView.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "Email inválido"))
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                 emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        
        return sut
    }
}
