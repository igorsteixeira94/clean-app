import Foundation

func makeInvalidData() -> Data {
    return Data("invlaid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\": \"Igor\"}".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeURL() -> URL {
    URL(string: "http://any-url.com")!
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 400)
}

func makeUrlResponse(statusCode: Int = 200) -> HTTPURLResponse {
   return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
