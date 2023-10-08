import Foundation

struct Interactor {
    var member: MemberInteractor
    
    init(appState: AppState, repo: Repository) {
        self.member = MemberInteractorService(appState: appState, repo: repo)
    }
}

protocol MemberInteractor {
    func getAllMember()
    func saveMember(_:Member) -> Bool
    func updateMember(_:Member) -> Bool
    func deleteMember(_:Member) -> Bool
}
