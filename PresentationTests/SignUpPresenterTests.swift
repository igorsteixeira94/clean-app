import XCTest
import Presentation

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
