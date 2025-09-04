import Foundation

public protocol LanguagesRemoteRepository {
    func getLanguages() async throws -> [LanguageRepresentable]
    func getLabels(for language: String) async throws -> [String: String]
}
