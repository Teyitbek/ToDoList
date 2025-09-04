import Domain

struct LocationDTO: Locationable, Codable {
    var id: Int
    var name: String
}

extension LocationDTO {
    func toDomain() -> Locationable {
        Location(id: self.id, name: self.name)
    }
}
