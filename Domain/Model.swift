import Foundation

protocol Model: Encodable {}

extension Model {
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
    
}
