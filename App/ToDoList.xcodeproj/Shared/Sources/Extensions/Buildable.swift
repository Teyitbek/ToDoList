public protocol Buildable {
  init()
}

public extension Buildable {
    typealias BuilderParameter = (inout Self) -> Void
  
    static func build(_ with: BuilderParameter) -> Self {
    var this = self.init()
    with(&this)
    return this
  }
}
