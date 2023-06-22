import Foundation

public extension String? {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
