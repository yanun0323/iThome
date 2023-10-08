import Foundation

struct MemberInteractorService {
    private var appState: AppState
    private var repo: Repository
    
    init(appState: AppState, repo: Repository) {
        self.appState = appState
        self.repo = repo
    }
}

extension MemberInteractorService: MemberInteractor {
    func getAllMember() {
        do {
            let member = try repo.getMember(nil, nil)
            appState.members.send(member)
        } catch {
            print("get all members error: \(error)")
            appState.members.send(nil)
        }
    }
    
    func saveMember(_ member: Member) -> Bool {
        do {
            _ = try repo.saveMember(member)
            getAllMember()
            return true
        } catch {
            print("save member \(member) error: \(error)")
            return false
        }
    }
    
    func updateMember(_ member: Member) -> Bool {
        do {
            try repo.updateMember(member)
            getAllMember()
            return true
        } catch {
            print("update member \(member) error: \(error)")
            return false
        }
    }
    
    func deleteMember(_ member: Member) -> Bool {
        do {
            try repo.deleteMember(member)
            getAllMember()
            return true
        } catch {
            print("delete member \(member) error: \(error)")
            return false
        }
    }
}
