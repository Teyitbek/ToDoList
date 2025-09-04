import Domain
import UIKit

public enum Images {
    public enum Placeholder {
        public static let coffee: UIImage = .coffee
        public static let iceCream: UIImage = .iceCream
        public static let harvest: UIImage = .harvest
        public static let hotFood: UIImage = .hotFood
        public static let beverages: UIImage = .beverages
        public static let snacks: UIImage = .snacks
        public static let juices: UIImage = .juices
        public static let bakery: UIImage = .bakery
        public static let nutritionBars: UIImage = .nutritionBars
        public static let breakfast: UIImage = .breakfast
        public static let other: UIImage = .other
        public static let rewards: UIImage = .rewards
        
        public static let coffeeLarge: UIImage = .coffeeLarge
        public static let iceCreamLarge: UIImage = .iceCreamLarge
        public static let harvestLarge: UIImage = .harvestLarge
        public static let hotFoodLarge: UIImage = .hotFoodLarge
        public static let beveragesLarge: UIImage = .beveragesLarge
        public static let snacksLarge: UIImage = .snacksLarge
        public static let juicesLarge: UIImage = .juicesLarge
        public static let bakeryLarge: UIImage = .bakeryLarge
        public static let nutritionBarsLarge: UIImage = .nutritionBarsLarge
        public static let breakfastLarge: UIImage = .breakfastLarge
        public static let otherLarge: UIImage = .otherLarge
        public static let rewardsLarge: UIImage = .rewardsLarge
    }
    
    public enum Navigation {
        public static let close: UIImage = .close
        public static let arrowRight: UIImage = .arrowRight
    }
}

public extension Images.Placeholder {
    static func image(for placeholder: Domain.Placeholder) -> UIImage {
        switch placeholder {
        case .hamburger:
            Images.Placeholder.harvest
        case .breakfast:
            Images.Placeholder.breakfast
        case .juice:
            Images.Placeholder.juices
        case .coffee:
            Images.Placeholder.coffee
        case .snack:
            Images.Placeholder.snacks
        case .beverage:
            Images.Placeholder.beverages
        case .iceCream:
            Images.Placeholder.iceCream
        case .bakery:
            Images.Placeholder.bakery
        case .nutritionBar:
            Images.Placeholder.nutritionBars
        case .hotFood:
            Images.Placeholder.hotFood
        case .other:
            Images.Placeholder.other
        }
    }
    
    static func largeImage(for placeholder: Domain.Placeholder) -> UIImage {
        switch placeholder {
        case .hamburger:
            Images.Placeholder.harvestLarge
        case .breakfast:
            Images.Placeholder.breakfastLarge
        case .juice:
            Images.Placeholder.juicesLarge
        case .coffee:
            Images.Placeholder.coffeeLarge
        case .snack:
            Images.Placeholder.snacksLarge
        case .beverage:
            Images.Placeholder.beveragesLarge
        case .iceCream:
            Images.Placeholder.iceCreamLarge
        case .bakery:
            Images.Placeholder.bakeryLarge
        case .nutritionBar:
            Images.Placeholder.nutritionBarsLarge
        case .hotFood:
            Images.Placeholder.hotFoodLarge
        case .other:
            Images.Placeholder.otherLarge
        }
    }
}

public extension CatalogOptionRepresentable {
    func getPlaceholderImage() -> UIImage {
        Images.Placeholder.image(for: getPlaceholder())
    }
}

public extension ProductRepresentable {
    func getPlaceholderImage() -> UIImage {
        Images.Placeholder.image(for: getPlaceholder())
    }
}

public extension ProductDetails {
    func getPlaceholderImage() -> UIImage {
        Images.Placeholder.largeImage(for: getPlaceholder())
    }
}

public extension CartItem {
    func getPlaceholderImage() -> UIImage {
        Images.Placeholder.image(for: getPlaceholder())
    }
}
