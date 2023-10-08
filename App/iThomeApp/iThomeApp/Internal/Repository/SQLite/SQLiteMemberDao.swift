import Foundation
import Sworm
import SQLite

protocol SQLiteMemberDao {}

extension SQLiteMemberDao where Self: MemberRepository {
    func getMember(_ name: String?, _ position: Position?) throws -> [Member] {
        let rows = try SQL.getDriver().query(Member.self) { t in
            if let name = name, let position = position {
                return t.where(Member.name == name && Member.position == position)
            }
            
            if let name = name {
                return t.where(Member.name == name)
            }
            
            if let position = position {
                return t.where(Member.position == position)
            }
            
            return t
        }
        
        
        var result = [Member]()
        for row in rows {
            result.append(try Member.parse(row))
        }
        return result
    }
    
    func saveMember(_ member: Member) throws -> Member? {
        let id = try SQL.getDriver().insert(member)
        return Member(id: id, name: member.name, position: member.position)
    }
    
    func updateMember(_ member: Member) throws {
        let _ = try SQL.getDriver().update(member, where: Member.id == member.id)
    }
    
    func deleteMember(_ member: Member) throws {
        let _ = try SQL.getDriver().delete(Member.self) { $0.where(Member.id == member.id) }
    }
}
