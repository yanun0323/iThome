import Ditto

extension DIContainer {
    var appState: AppState { AppState.get() }
    var interactor: Interactor { Interactor.get(isMock) }
}
