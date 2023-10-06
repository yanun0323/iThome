import Foundation
import SQLite

let id = Expression<Int64>("id")
let name = Expression<String>("name")
let position = Expression<Position>("position")

let tableMember = Table("members")

func createMemberTable(_ db: Connection) throws {
    try db.run(tableMember.create(ifNotExists: true) { t in
        t.column(id, primaryKey: .autoincrement)
        t.column(name, unique: true)
        t.column(position)
    })
    
    try db.run(tableMember.createIndex(name, ifNotExists: true))
}

func insertMember(_ db: Connection, member: Member) -> Member? {
    do {
        let id = try db.run(
            tableMember
                .insert(
                    name <- member.name,
                    position <- member.position
                )
        )
        return Member(id: id, name: member.name, position: member.position)
    } catch {
        print("insert member \(member.name) error: \(error)")
    }
    return nil
}

func updateMember(_ db: Connection, member: Member) {
    do {
        let effectedRows = try db.run(
            tableMember
                .filter(id == member.id)
                .update(
                    name <- member.name,
                    position <- member.position
                )
        )
        print("updated \(effectedRows) rows")
    } catch {
        print("udpate member \(member.name) error: \(error)")
    }
}

func deleteMember(_ db: Connection, member: Member) {
    do {
        let effectedRows = try db.run(
            tableMember
                .filter(id == member.id)
                .delete()
        )
        print("delete \(effectedRows) rows")
    } catch {
        print("delete member \(member.name) error: \(error)")
    }
}

func findMember(_ db: Connection, name target: String) -> [Member]? {
    do {
        let rows = try db.prepare(
            tableMember
                .select(id, name, position)
                .where(name == target && position == .Mid)
                .order(id.asc)
        )
        
        var members: [Member] = []

        for row in rows {
            let id = try row.get(id)
            let name = try row.get(name)
            let position = try row.get(position)

            let member = Member(id: id, name: name, position: position)
            members.append(member)
        }
        
        return members
        
    } catch {
        print("find member name: \(target) error: \(error)")
    }
    
    return nil
}
