import CoreServices
import DeviceKit
import Foundation

public enum Constants {
    public enum UI {
        public static let viewsTop: CGFloat = 16 * Constants.ScreenSizeConstant
        public static let viewsLeadingTrailing: CGFloat = 16 * Constants.ScreenSizeConstant
        public static let padding4: CGFloat = 4 * Constants.ScreenSizeConstant
        public static let padding6: CGFloat = 6 * Constants.ScreenSizeConstant
        public static let padding8: CGFloat = 8 * Constants.ScreenSizeConstant
        public static let padding10: CGFloat = 10 * Constants.ScreenSizeConstant
        public static let padding12: CGFloat = 12 * Constants.ScreenSizeConstant
        public static let padding14: CGFloat = 14 * Constants.ScreenSizeConstant
        public static let padding18: CGFloat = 18 * Constants.ScreenSizeConstant
        public static let padding20: CGFloat = 20 * Constants.ScreenSizeConstant
        public static let padding22: CGFloat = 22 * Constants.ScreenSizeConstant
        public static let padding24: CGFloat = 24 * Constants.ScreenSizeConstant
        public static let padding26: CGFloat = 26 * Constants.ScreenSizeConstant
        public static let padding28: CGFloat = 28 * Constants.ScreenSizeConstant
        public static let padding30: CGFloat = 30 * Constants.ScreenSizeConstant
        public static let padding32: CGFloat = 32 * Constants.ScreenSizeConstant
        public static let padding34: CGFloat = 34 * Constants.ScreenSizeConstant
        public static let padding36: CGFloat = 36 * Constants.ScreenSizeConstant
        public static let padding40: CGFloat = 40 * Constants.ScreenSizeConstant
        public static let padding42: CGFloat = 42 * Constants.ScreenSizeConstant
        public static let padding44: CGFloat = 44 * Constants.ScreenSizeConstant
        public static let padding48: CGFloat = 48 * Constants.ScreenSizeConstant
        public static let padding52: CGFloat = 52 * Constants.ScreenSizeConstant
        public static let padding54: CGFloat = 54 * Constants.ScreenSizeConstant
        public static let padding56: CGFloat = 56 * Constants.ScreenSizeConstant
        public static let padding58: CGFloat = 58 * Constants.ScreenSizeConstant
        public static let padding60: CGFloat = 60 * Constants.ScreenSizeConstant
        public static let padding64: CGFloat = 64 * Constants.ScreenSizeConstant
        public static let padding66: CGFloat = 66 * Constants.ScreenSizeConstant
        public static let padding68: CGFloat = 68 * Constants.ScreenSizeConstant
        public static let padding72: CGFloat = 72 * Constants.ScreenSizeConstant
        public static let padding76: CGFloat = 76 * Constants.ScreenSizeConstant
        public static let padding78: CGFloat = 78 * Constants.ScreenSizeConstant
        public static let padding80: CGFloat = 80 * Constants.ScreenSizeConstant
        public static let padding82: CGFloat = 82 * Constants.ScreenSizeConstant
        public static let padding84: CGFloat = 84 * Constants.ScreenSizeConstant
        public static let padding88: CGFloat = 88 * Constants.ScreenSizeConstant
        public static let padding100: CGFloat = 100 * Constants.ScreenSizeConstant
        public static let padding104: CGFloat = 104 * Constants.ScreenSizeConstant
        public static let padding120: CGFloat = 120 * Constants.ScreenSizeConstant
        public static let padding160: CGFloat =  160 * Constants.ScreenSizeConstant
        public static let padding180: CGFloat = 180 * Constants.ScreenSizeConstant
    }
    
    static var ScreenSizeConstant: CGFloat {
        switch DeviceScreenSize.current {
        case .large:
            return 1.0
        case .normal:
            return 0.8
        case .small:
            return 0.7
        }
    }
}

public enum ScreenType {
    case small
    case normal
    case large
}

public enum DeviceScreenSize {
    public static var current: ScreenType {
        switch Device.current {
        case .iPhone4,
                .iPhone4s,
                .iPhone5,
                .iPhone5s,
                .iPhone5c,
                .iPhoneSE,
                .simulator(.iPhone4),
                .simulator(.iPhone4s),
                .simulator(.iPhone5),
                .simulator(.iPhone5s),
                .simulator(.iPhoneSE):
            return .small
        case .iPhone6,
                .iPhone6s,
                .iPhone7,
                .iPhone8,
                .iPhoneSE2,
                .iPhoneSE3,
                .simulator(.iPhone6),
                .simulator(.iPhone6s),
                .simulator(.iPhone7),
                .simulator(.iPhone8),
                .simulator(.iPhoneSE2),
                .simulator(.iPhoneSE3):
            return .normal
        default:
            return .large
        }
    }
}

