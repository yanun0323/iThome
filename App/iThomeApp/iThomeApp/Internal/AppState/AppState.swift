import Foundation
import Combine

struct AppState {
    var members = CurrentValueSubject<[Member]?, Never>([])
}
