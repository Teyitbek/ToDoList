import Domain
import Extensions
import RealHTTP

struct ProductsRequestDTO: Encodable, APIResourceConvertible {
    let categoryId: Int
    let search: String
    let pageInfo: PageInfo
    
    typealias Result = GenericPaginationResponse<[ProductsDTO]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/categories/\(categoryId)"
            $0.maxRetries = 3
            $0.method = .get
            $0.addQueryParameter(name: "per_page", value: "\(pageInfo.perPage)")
            $0.addQueryParameter(name: "page", value: "\(pageInfo.page)")
            $0.addQueryParameter(name: "q", value: search)
        }
    }
}

struct PageInfo: Encodable {
    let page: Int
    let perPage: Int
}
