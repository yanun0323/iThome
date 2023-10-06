import Foundation

protocol Repository: MemberRepository {}

protocol MemberRepository {
    func getMember(_ name: String?, _ position: Position?) throws -> [Member]
    func saveMember(_:Member) throws -> Member?
    func updateMember(_:Member) throws
    func deleteMember(_:Member) throws
}
