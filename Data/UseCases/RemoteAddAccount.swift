import Foundation
import Domain

final class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        let data = addAccountModel.toData()
        httpClient.post(to: url, with: data) { error in
            completion(.failure(.unexpected))
        }
    }
}
