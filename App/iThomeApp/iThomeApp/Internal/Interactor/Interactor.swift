import Foundation

struct Interactor {
    var member: MemberInteractor
}

protocol MemberInteractor {
    func getAllMember()
    func saveMember(_:Member) -> Bool
    func updateMember(_:Member) -> Bool
    func deleteMember(_:Member) -> Bool
}
