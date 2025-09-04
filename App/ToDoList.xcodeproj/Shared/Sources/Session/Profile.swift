import Foundation

public struct Profile {
    public let name: String
    public let profilePhotoUrl: String?
    
    public init(name: String, profilePhotoUrl: String?) {
        self.name = name
        self.profilePhotoUrl = profilePhotoUrl
    }
    
    public func imageUrl() -> URL? {
        guard let url = profilePhotoUrl else { return nil }
        return URL(string: url)
    }
}
