import Domain
import Extensions
import RealHTTP

struct SearchProductsRequestDTO: Encodable, APIResourceConvertible {
    let search: String
    let pageInfo: PageInfo
    
    typealias Result = GenericPaginationResponse<[ProductsDTO]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/products"
            $0.maxRetries = 3
            $0.method = .get
            $0.addQueryParameter(name: "per_page", value: "\(pageInfo.perPage)")
            $0.addQueryParameter(name: "page", value: "\(pageInfo.page)")
            $0.addQueryParameter(name: "search", value: search)
        }
    }
}
