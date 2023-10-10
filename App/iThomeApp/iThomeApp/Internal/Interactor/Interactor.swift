import Foundation

struct Interactor {
    static private var `default`: Interactor?
    
    var member: MemberInteractor
    
    init(appState: AppState, isMock: Bool) {
        let repo = Dao(isMock: isMock)
        self.member = MemberInteractorService(appState: appState, repo: repo)
    }
}

extension Interactor {
    static func get(_ isMock: Bool) -> Interactor {
        if Self.default == nil {
            Self.default = Interactor(appState: .get(), isMock: isMock)
        }
        return Self.default!
    }
}

protocol MemberInteractor {
    func getAllMember()
    func saveMember(_:Member) -> Bool
    func updateMember(_:Member) -> Bool
    func deleteMember(_:Member) -> Bool
}
