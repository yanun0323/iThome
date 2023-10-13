import Foundation

struct Interactor {
    private static var `default`: Interactor?
    
    var todoEvent: TodoEventInteractor
    
    init(appState: AppState, isMock: Bool) {
        let repo = Dao(isMock: isMock)
        self.todoEvent = TodoEventService(appState: appState, repo: repo)
    }
}

extension Interactor {
    static func get(isMock: Bool) -> Interactor {
        if Interactor.default == nil {
            Interactor.default = Interactor(appState: .get(), isMock: isMock)
        }
        return Interactor.default!
    }
}

protocol TodoEventInteractor {
    func listEvents()
    func createEvent(_:TodoEvent)
    func deleteEvent(_:TodoEvent)
}
