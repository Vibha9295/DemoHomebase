
// MARK: - ShiftModel
struct ShiftModel: Codable {
    let shifts: [Shift]
}

// MARK: - Shift
struct Shift: Codable {
    let role, name, startDate, endDate: String
    let color: Color

    enum CodingKeys: String, CodingKey {
        case role, name
        case startDate = "start_date"
        case endDate = "end_date"
        case color
    }
}

enum Color: String, Codable {
    case blue = "blue"
    case green = "green"
    case red = "red"
}
