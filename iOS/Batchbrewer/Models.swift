import Foundation

struct BatchEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var startDate: Date
    var recipeNotes: String
    var status: String

    init(id: UUID = UUID(), name: String = "", startDate: Date = Date(), recipeNotes: String = "", status: String = "") {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.recipeNotes = recipeNotes
        self.status = status
    }
}
