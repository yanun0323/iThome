import Foundation
import SwiftUI

struct DIContainer {
    var appState: AppState?
    var interactor: Interactor?
}

extension DIContainer: EnvironmentKey {
    static var defaultValue: DIContainer {
        return DIContainer()
    }
}

extension EnvironmentValues {
    var injected: DIContainer {
            get { self[DIContainer.self] }
            set { self[DIContainer.self] = newValue }
        }
}
