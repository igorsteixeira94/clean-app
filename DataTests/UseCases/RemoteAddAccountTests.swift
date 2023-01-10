import XCTest
import Domain

@testable import Data

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let (sut, httpClientSpy) = makeSut()
        
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        let expectedURL = URL(string: "http://any-url.com")!
        XCTAssertEqual(httpClientSpy.url, [expectedURL])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        
        let model = makeAddAccountModel()
        sut.add(addAccountModel: model) { _ in }
        let expectedData = model.toData()
        XCTAssertEqual(httpClientSpy.data, expectedData)
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_fails() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")

        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            case .success: XCTFail("Expected error received \(result) instead")
            }
            exp.fulfill()
        }
        
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_data() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        let expectedAccount = makeAccountModel()
        
        
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure(let error): XCTFail("Expected error received \(result) instead")
            case .success(let account): XCTAssertEqual(account, expectedAccount)
            }
            
            exp.fulfill()
        }
        httpClientSpy.completeWithData(expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }
    

}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut =  RemoteAddAccount(url: url, httpClient: httpClientSpy)
        
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "Jon Doe",
                               email: "jonDoe@mail.com",
                               password: "123456",
                               passwordConfirmation: "123456")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "any_id",
                            name: "Jon Doe",
                            email: "jonDoe@mail.com",
                            password: "123456")
    }
    
    class HttpClientSpy: HttpPostClient {
        var url = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.url.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
        
        func completeWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}
