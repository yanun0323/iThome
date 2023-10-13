import Foundation
import Ditto

extension DIContainer {
    var appState: AppState { .get() }
    var interactor: Interactor { .get(isMock: isMock) }
}

extension DIContainer {
    static let preview = DIContainer(isMock: true)
}

