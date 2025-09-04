import Domain
import Foundation

public struct CustomizationOptionDTO: Codable, DomainMappable {
    public var id: Int
    public var type: String
    public var name: String
    public var image: String?
    public var fieldsType: String
    public var options: [OptionDTO]
    public var selected: Bool
    public var required: Bool
    public var quantity: Int
    public var description: String?
    public var groupedPricing: GroupedPricingDTO?

    public init(id: Int, type: String, name: String, image: String?, fieldsType: String, options: [OptionDTO], selected: Bool, required: Bool, quantity: Int, description: String?, groupedPricing: GroupedPricingDTO?) {
        self.id = id
        self.type = type
        self.name = name
        self.image = image
        self.fieldsType = fieldsType
        self.options = options
        self.selected = selected
        self.required = required
        self.quantity = quantity
        self.description = description
        self.groupedPricing = groupedPricing
    }
    
    public init(from customizationOption: CustomizationOption) {
        self.id = customizationOption.id
        self.type = customizationOption.type
        self.name = customizationOption.name
        self.image = customizationOption.image
        self.fieldsType = customizationOption.fieldsType
        self.options = customizationOption.options.map { OptionDTO(from: $0) }
        self.selected = customizationOption.selected
        self.required = customizationOption.required
        self.quantity = customizationOption.quantity
        self.description = customizationOption.description
        
        if let groupedPricing = customizationOption.groupedPricing {
            self.groupedPricing = GroupedPricingDTO(amountOfFreeQuantity: groupedPricing.amountOfFreeQuantity,
                                                    price: groupedPricing.price)
        } else {
            self.groupedPricing = nil
        }
    }
    
    public func toDomain() -> CustomizationOption {
        CustomizationOption(id: self.id, type: self.type, name: self.name, image: self.image, fieldsType: self.fieldsType, options: self.options.map { $0.toDomain() }, selected: self.selected, required: self.required, quantity: self.quantity, description: self.description, groupedPricing: self.groupedPricing?.toDomain())
    }
}
