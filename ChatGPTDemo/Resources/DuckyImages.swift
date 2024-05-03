import UIKit

enum DuckyImages {
    static var idle_01 = UIImage(named: "ducky_idle_01")
    static var idle_02 = UIImage(named: "ducky_idle_02")
    
    static var idle_bounce_01 = UIImage(named: "ducky_idle_bounce_01")
    static var idle_bounce_02 = UIImage(named: "ducky_idle_bounce_02")
    static var idle_bounce_03 = UIImage(named: "ducky_idle_bounce_03")
    static var idle_bounce_04 = UIImage(named: "ducky_idle_bounce_04")
    
    static var walk_01 = UIImage(named: "ducky_walk_01")
    static var walk_02 = UIImage(named: "ducky_walk_02")
    static var walk_03 = UIImage(named: "ducky_walk_03")
    static var walk_04 = UIImage(named: "ducky_walk_04")
    static var walk_05 = UIImage(named: "ducky_walk_05")
    static var walk_06 = UIImage(named: "ducky_walk_06")
    
    static var walk_bounce_01 = UIImage(named: "ducky_walk_bounce_01")
    static var walk_bounce_02 = UIImage(named: "ducky_walk_bounce_02")
    static var walk_bounce_03 = UIImage(named: "ducky_walk_bounce_03")
    static var walk_bounce_04 = UIImage(named: "ducky_walk_bounce_04")
    static var walk_bounce_05 = UIImage(named: "ducky_walk_bounce_05")
    static var walk_bounce_06 = UIImage(named: "ducky_walk_bounce_06")
    
    static func idle() -> [UIImage] {
        return [
            idle_01,
            idle_02
        ].compactMap {$0}
    }
    
    static func idleBounce() -> [UIImage] {
        return [
            idle_bounce_01,
            idle_bounce_02,
            idle_bounce_03,
            idle_bounce_04
        ].compactMap {$0}
    }
    
    static func walk() -> [UIImage] {
        return [
            walk_01,
            walk_02,
            walk_03,
            walk_04,
            walk_05,
            walk_06
        ].compactMap {$0}
    }
}
