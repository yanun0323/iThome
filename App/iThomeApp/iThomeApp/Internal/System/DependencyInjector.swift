import Foundation
import SwiftUI

struct DIContainer {
    var appState: AppState
    var interactor: Interactor
    
    init(isMock: Bool = false) {
        let repo = Dao(isMock: isMock)
        let state = AppState()
        
        self.appState = state
        self.interactor = Interactor(appState: state, repo: repo)
    }
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
