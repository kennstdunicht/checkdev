import UIKit

enum GirlImages {
    static var idle_01 = UIImage(named: "girl_01")
    static var idle_02 = UIImage(named: "girl_02")
    static var idle_03 = UIImage(named: "girl_03")
    static var idle_04 = UIImage(named: "girl_04")
    static var idle_05 = UIImage(named: "girl_05")
    static var idle_06 = UIImage(named: "girl_06")
    static var idle_07 = UIImage(named: "girl_07")
    
    
    static func idle() -> [UIImage] {
        return [
            idle_01,
            idle_02,
            idle_03,
            idle_04,
            idle_05,
            idle_06,
            idle_07
        ].compactMap {$0}
    }
}
