import XCTest
import Domain

@testable import Data

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let (sut, httpClientSpy) = makeSut()
        
        sut.add(addAccountModel: makeAddAccountModel())
        let expectedURL = URL(string: "http://any-url.com")!
        XCTAssertEqual(httpClientSpy.url, [expectedURL])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        
        let model = makeAddAccountModel()
        sut.add(addAccountModel: model)
        let expectedData = model.toData()
        XCTAssertEqual(httpClientSpy.data, expectedData)
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
    
    class HttpClientSpy: HttpPostClient {
        var url = [URL]()
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url.append(url)
            self.data = data
        }
    }
}