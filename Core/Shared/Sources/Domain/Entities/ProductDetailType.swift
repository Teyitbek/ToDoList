import Foundation

public enum ProductDetailType {
    case reward(_ rewardId: Int?, _ variationId: Int?)
    case variation(Int)
    case `default`
    case edit(_ orderItemId: Int,_ productDetails: ProductDetails)
}
