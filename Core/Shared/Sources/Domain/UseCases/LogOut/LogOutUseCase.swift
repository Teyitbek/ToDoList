public protocol LogOutUseCase {
    func execute() async throws -> String?
}
