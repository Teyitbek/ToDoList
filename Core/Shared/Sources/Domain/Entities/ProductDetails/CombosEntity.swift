import Foundation

public class CombosEntity: @unchecked Sendable {
    public var drinks: [ComboItem]
    public var snacks: [ComboItem]
    
    public init(drinks: [ComboItem], snacks: [ComboItem]) {
        self.drinks = drinks
        self.snacks = snacks
    }
    
    public init() {
        drinks = []
        snacks = []
    }
}

extension CombosEntity: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = CombosEntity(drinks: drinks.map { $0.copy() as! ComboItem }, snacks: snacks.map{ $0.copy() as! ComboItem})
        return copy
    }
}
