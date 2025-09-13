import Foundation

protocol Repository: TodoEventRepository {}

protocol TodoEventRepository {
    func listEvents() throws -> [TodoEvent]
    func saveEvent(_:TodoEvent) throws -> TodoEvent
    /*** return true if delete succeed */
    func deleteEvent(_:Int64) throws -> Bool
}
