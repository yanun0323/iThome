import Foundation
import Ditto

struct TodoEventService {
    private let appState: AppState
    private let repo: Repository
    
    init(appState: AppState, repo: Repository) {
        self.appState = appState
        self.repo = repo
    }
}

extension TodoEventService: TodoEventInteractor {
    func listEvents() {
        System.async {
            do {
                let events = try repo.listEvents()
                appState.todoEvents.send(events)
            } catch {
                appState.todoEvents.send([])
                appState.todoEventError.send(error)
            }
        }
    }
    
    func createEvent(_ event: TodoEvent) {
        System.async {
            do {
                let created = try repo.saveEvent(event)
                var value = appState.todoEvents.value
                value.append(created)
                appState.todoEvents.send(value)
            } catch {
                appState.todoEventError.send(error)
            }
        }
    }
    
    func deleteEvent(_ event: TodoEvent) {
        System.async {
            do {
                if try repo.deleteEvent(event.id) {
                    var value = appState.todoEvents.value
                    value.removeAll { $0.id == event.id }
                    appState.todoEvents.send(value)
                } else {
                    throw TodoEvent.Errors.recordNotFound
                }
            } catch {
                appState.todoEventError.send(error)
            }
        }
    }
}

extension TodoEvent {
    enum Errors: String, Error {
    case recordNotFound = "record not found"
    }
}
