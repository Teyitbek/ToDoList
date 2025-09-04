import Foundation

public protocol PaginationResponseRepresentable {
    associatedtype Element
    var data: [Element] { get set }
    var message: String? { get set }
    var perPage: Int { get set }
    var page: Int { get set }
    var totalPage: Int { get set }
    var totalItems: Int { get set }
}
