import Domain
import Extensions
import RealHTTP

struct ProductDetailsRequest: APIResourceConvertible {
    let productId: Int
    let type: ProductDetailType
    
    typealias Result = GenericResponse<ProductDetailsDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/products/\(productId)"
            $0.method = .get
            $0.maxRetries = 3
            switch type {
            case .reward(let rewardId, let variationId):
                if let rewardId = rewardId {
                    $0.addQueryParameter(name: "reward_id", value: "\(rewardId)")
                }
                if let variationId = variationId {
                    $0.addQueryParameter(name: "variation_id", value: "\(variationId)")
                }
            case .variation(let id):
                $0.add(parameters: ["variation_id": id])
            default:
                break
            }
        }
    }
}
