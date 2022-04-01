//
//  ViewController.swift
//  FloatLabelExample
//
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var vwName:FloatingTextField!
    @IBOutlet var vwdatePicker:FloatingDatePicker!
	@IBOutlet var vwAddress:FloatingTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        vwName.font = UIFont.boldSystemFont(ofSize: 16)
        vwName.titleFont = UIFont.boldSystemFont(ofSize: 10)
        vwName.textColor = UIColor.init(hex: "172651")
        vwName.setTitle(title: "Milan", isMandatory: true)
        vwName.text = "Savaliya"
        
        vwdatePicker.setTitle(title: "Date", isMandatory: true)
//        vwdatePicker.minimumDate = Date()
//        vwdatePicker.minimumDate = Date()
//        vwdatePicker.currentDate = Date()
//        vwdatePicker.initialDate = Date()
        
        vwAddress.font = UIFont.boldSystemFont(ofSize: 18)
        vwAddress.titleFont = UIFont.boldSystemFont(ofSize: 13)
        vwAddress.setTitle(title: "Milan", isMandatory: false)
        vwAddress.text = "dsfhsdhaldfdksfdksfjkjkh"
	}
}



class Utils {
    static let shared = Utils()
    func setFontSizeAsPerDeviceHeight(currentSize : FontSize) -> CGFloat {
        let size = currentSize.rawValue * UIScreen.main.bounds.height / 812
        return size
    }
}

///Font name
enum FontName: String {
    case thin                                      = "Inter-Thin"
    case semiBold                                  = "Inter-SemiBold"
    case regular                                   = "Inter-Regular"
    case medium                                    = "Inter-Medium"
    case light                                     = "Inter-Light"
    case extraLight                                = "Inter-ExtraLight"
    case extraBold                                 = "Inter-ExtraBold"
    case bold                                      = "Inter-Bold"
    case black                                     = "Inter-Black"
}

///Font size
enum FontSize: CGFloat {
    case size_8                                     = 8.0
    case size_9                                     = 9.0
    case size_10                                    = 10.0
    case size_11                                    = 11.0
    case size_12                                    = 12.0
    case size_13                                    = 13.0
    case size_14                                    = 14.0
    case size_15                                    = 15.0
    case size_16                                    = 16.0
    case size_17                                    = 17.0
    case size_18                                    = 18.0
    case size_20                                    = 20.0
    case size_22                                    = 22.0
    case size_24                                    = 24.0
    case size_25                                    = 25.0
    case size_28                                    = 28.0
    case size_32                                    = 32.0
    case size_30                                    = 30.0
    case size_35                                    = 35.0
    case size_50                                    = 50.0
}
