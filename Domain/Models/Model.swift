import Foundation

public protocol Model: Encodable {}

extension Model {
    public func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
    
}
