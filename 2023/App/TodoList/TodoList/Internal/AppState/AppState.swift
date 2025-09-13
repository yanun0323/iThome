import Foundation
import Combine

struct AppState {
    private static let `default` = AppState()
    
    var todoEvents = CurrentValueSubject<[TodoEvent], Never>([])
    var todoEventError = PassthroughSubject<Error?, Never>()
}

extension AppState {
    static func get() -> AppState { return .default }
}
