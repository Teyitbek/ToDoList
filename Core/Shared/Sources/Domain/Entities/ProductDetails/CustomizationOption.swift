import Foundation

public enum CustomizationOptionType: String {
    case ingredients = "ingredient"
}

public class CustomizationOption {
    public var id: Int
    public var type: String
    public var name: String
    public var image: String?
    public var fieldsType: String
    public var options: [OptionItem]
    public var selected: Bool
    public var required: Bool
    public var quantity: Int
    public var description: String?
    public var groupedPricing: GroupedPricing?
    
    public init(id: Int, type: String, name: String, image: String?, fieldsType: String, options: [OptionItem], selected: Bool, required: Bool, quantity: Int, description: String?, groupedPricing: GroupedPricing?) {
        self.id = id
        self.type = type
        self.name = name
        self.image = image
        self.fieldsType = fieldsType
        self.options = options
        self.selected = selected
        self.quantity = quantity
        self.required = required
        self.description = description
        self.groupedPricing = groupedPricing
    }
    
    public func getType() -> CustomizationOptionType? {
        CustomizationOptionType(rawValue: type)
    }
}

extension CustomizationOption: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = CustomizationOption(id: id,
                                       type: type,
                                       name: name,
                                       image: image,
                                       fieldsType: fieldsType,
                                       options: options.map { $0.copy() as! OptionItem },
                                       selected: selected,
                                       required: required,
                                       quantity: quantity,
                                       description: description,
                                       groupedPricing: groupedPricing?.copy() as? GroupedPricing)
        return copy
    }
}
