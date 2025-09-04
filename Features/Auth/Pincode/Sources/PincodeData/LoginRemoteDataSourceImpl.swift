import AppleAuthentication
import Domain
import FirebaseAuth
import RealHTTP

public final class LoginRemoteDataSourceImpl: LoginRemoteDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func login(with credentials: any Pincodeable) async throws -> any UserInfoRepresentable {
        try await client.fetch(LoginRequestDTO(pin: credentials.pin)).toDomain()
    }
}
