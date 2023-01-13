import Foundation

func makeInvalidData() -> Data {
    return Data("invlaid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\": \"Igor\"}".utf8)
}

func makeURL() -> URL {
    URL(string: "http://any-url.com")!
}
