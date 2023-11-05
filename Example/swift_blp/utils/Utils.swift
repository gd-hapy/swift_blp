//
//  Utils.swift
//  Pods
//
//  Created by Apple on 10/19/23.
//

import Foundation
import UIKit
import HandyJSON

let kScreenWidth = UIScreen.main.bounds.size.width

let kScreenHeight = UIScreen.main.bounds.size.height


let TimerHeight = 100

let SearchBarHeight = 160

let BaseFont = UIFont.systemFont(ofSize: 16)

let kHotSearchKey = "__key_hot_search_key" //热门搜索
let kHotSearchTop100Key = "__key_hot_search_top_100_key"// 搜索排行榜

let kHomeTimeHeight = 150// 首页 时间 高度
let kHomeSearchBarHeight = 200// 首页 搜索框 高度

let kHomeHotSearchHeight = 200// 首页 热门搜索 高度

// 主题色
let kThemeColor = UIColor.init(hexString: "#2e8b57")

func currentDate() -> String {
    let now = Date()
    
    let calendar = Calendar.current
    
    let year = calendar.component(.year, from: now)
    let month = calendar.component(.month, from: now)
    let day = calendar.component(.day, from: now)
    
    return "\(year) : \(month) : \(day)"
}

func currentDay() -> Int {
    let now = Date()
    
    let calendar = Calendar.current
    let day = calendar.component(.day, from: now)
    return day
}

func currentTime() -> String {
    let now = Date()
    
    let calendar = Calendar.current
    
    let hour = calendar.component(.hour, from: now)
    let min = calendar.component(.minute, from: now)
    let sec = calendar.component(.second, from: now)
    let h = String(format: "%.2d", hour)
    let m = String(format: "%.2d", min)
    let s = String(format: "%.2d", sec)
    
    return "\(h) : \(m) : \(s)"
}


func timeStamp() -> String {
    //jQuery182002313945027965092_1697895735454&_=1697895735921"
    let now = Date()
    let timeStamp = now.timeIntervalSince1970 * 1_000
    return String(Int(timeStamp))
}

func paramJquery() -> String{
    //jQuery18205182143773100034_1697901003569&_=1697901003609
    //jQuery1820018307304202344385_1697901957796"

    let ts = timeStamp()
    let res = "jQuery182" + generateIntString(18) + "_" + ts
    return res
}

func generateIntString(_ length: Int) -> String {
    var result = ""
    for _ in 0..<length {
        let num = Int(arc4random_uniform(10))
        result += String(num)
    }
    return result
}

extension UIColor {
    
   // Hex String -> UIColor
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
       let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
       let scanner = Scanner(string: hexString)
        
       if hexString.hasPrefix("#") {
           scanner.scanLocation = 1
       }
        
       var color: UInt32 = 0
       scanner.scanHexInt32(&color)
        
       let mask = 0x000000FF
       let r = Int(color >> 16) & mask
       let g = Int(color >> 8) & mask
       let b = Int(color) & mask
        
       let red   = CGFloat(r) / 255.0
       let green = CGFloat(g) / 255.0
       let blue  = CGFloat(b) / 255.0
        
       self.init(red: red, green: green, blue: blue, alpha: 1)
   }
    
   // UIColor -> Hex String
   var hexString: String? {
       var red: CGFloat = 0
       var green: CGFloat = 0
       var blue: CGFloat = 0
       var alpha: CGFloat = 0
        
       let multiplier = CGFloat(255.999999)
        
       guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
           return nil
       }
        
       if alpha == 1.0 {
           return String(
               format: "#%02lX%02lX%02lX",
               Int(red * multiplier),
               Int(green * multiplier),
               Int(blue * multiplier)
           )
       }
       else {
           return String(
               format: "#%02lX%02lX%02lX%02lX",
               Int(red * multiplier),
               Int(green * multiplier),
               Int(blue * multiplier),
               Int(alpha * multiplier)
           )
       }
   }
}

extension Array {
    func c_prefix(_ index: Int) -> Array {
        let slice = self.prefix(index)
        return Array(slice)
    }
}




let kStatusBarHeight        : CGFloat = UIDevice.vg_statusBarHeight()
let kStatusBarSpaceX        : CGFloat = UIDevice.vg_safeDistanceTop()
let kTopBarHeight           : CGFloat = UIDevice.vg_navigationBarHeight()//44
let kNavigationBar64        : CGFloat = UIDevice.vg_navigationFullHeight()
let kBottomBarHeight        : CGFloat = UIDevice.vg_tabBarFullHeight()
let kBottomBarRealHeight    : CGFloat = UIDevice.vg_tabBarHeight()//49
let kTabbarSafeBottomMargin : CGFloat = UIDevice.vg_safeDistanceBottom()


extension UIDevice {
    
    /// 顶部安全区高度
    static func vg_safeDistanceTop() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.top
        }
        return 0;
    }
    
    /// 底部安全区高度
    static func vg_safeDistanceBottom() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        }
        return 0;
    }
    
    /// 顶部状态栏高度（包括安全区）
    static func vg_statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    /// 导航栏高度
    static func vg_navigationBarHeight() -> CGFloat {
        return 44.0
    }
    
    /// 状态栏+导航栏的高度
    static func vg_navigationFullHeight() -> CGFloat {
        return UIDevice.vg_statusBarHeight() + UIDevice.vg_navigationBarHeight()
    }
    
    /// 底部导航栏高度
    static func vg_tabBarHeight() -> CGFloat {
        return 49.0
    }
    
    /// 底部导航栏高度（包括安全区）
    static func vg_tabBarFullHeight() -> CGFloat {
        return UIDevice.vg_tabBarHeight() + UIDevice.vg_safeDistanceBottom()
    }
}


extension UIView {
    
    /// X
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    /// Y
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    /// 右边界的X值
    public var rightX: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    
    /// 下边界的Y值
    public var bottomY: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    
    /// centerX
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    /// centerY
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    /// width
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    /// height
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    /// origin
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    /// size
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
}


extension String{
    /// String的宽度计算
    /// - Parameter font: 设定字体前提
    public func widthWith(font: UIFont) -> CGFloat {
        let str = self as NSString
        return str.size(withAttributes: [NSAttributedString.Key.font:font]).width
    }
    /// String的高度计算
    /// - Parameters:
    ///   - width: 设定宽度前提
    ///   - lineSpacing: 设定行高前提
    ///   - font: 设定字体前提
    public func heightWith(width: CGFloat, lineSpacing: CGFloat = 1.5, font: UIFont) -> CGFloat {
        
        let str = self as NSString
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpacing
        let size = str.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:font], context: nil).size
        return size.height
    }
    /// String的宽度计算
    /// - Parameter font: 设定字体前提
    public func widthHeight(_ size:CGSize,font: UIFont,attributes : [NSAttributedString.Key : Any]? = nil) -> CGFloat {
        let str = self as NSString
        let s = str.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil).size.height
        return s
    }
}


