import Foundation

public protocol Model: Codable, Equatable {}

extension Model {
    public func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
