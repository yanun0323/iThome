import Foundation
import Combine

struct AppState {
    static private var `default`: AppState = AppState()
    
    var members = CurrentValueSubject<[Member]?, Never>([])
}

extension AppState {
    static func get() -> AppState {
        return AppState()
    }
}
