import XCTest
import Presentation

final class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let viewModel = SignUpViewModel(email:"email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let viewModel = SignUpViewModel(name:"any_name",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Password é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       password: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "O campo Confirmar senha é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_match() {
        let (sut, alertViewSpy, _) = makeSut()
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "wrong_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "Falha ao confirmar senha"))
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() {
        let (sut, _ , emailValidatorSpy) = makeSut()
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "any_email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(emailValidatorSpy.email, viewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let (sut, alertViewSpy, emailValidatorSpy) = makeSut()
        let viewModel = SignUpViewModel(name:"any_name",
                                       email: "invalid_email@mail.com",
                                       password: "any_password",
                                       passwordConfirmation: "any_password")
        emailValidatorSpy.isValid = false
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel,
                       AlertViewModel(title: "Falha na validação", message: "Email inválido"))
    }
}

extension SignUpPresenterTests {
    func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy, emailValidatorSpy: EmailValidatorSpy) {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        
        return (sut, alertViewSpy, emailValidatorSpy)
    }
}
