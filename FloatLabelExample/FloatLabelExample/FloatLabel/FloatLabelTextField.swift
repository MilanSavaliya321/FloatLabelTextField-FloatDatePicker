//
//  FloatLabelTextField.swift

//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//  https://github.com/jverdi/JVFloatLabeledTextField
//  https://github.com/FahimF/FloatLabelFields

import UIKit

class FloatingTextField: UITextField {
    
    // MARK:- Properties
    var title = UILabel()
    private var titleLableText: String = ""
    private var isMandatory = false
    let animationDuration = 0.2
    
    private var attributedTitle: NSAttributedString? {
        let boldRange = (titleLableText as NSString).range(of: titleLableText)
        let fnameAttributedString = NSMutableAttributedString(string: titleLableText)
        fnameAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: FontName.regular.rawValue, size: Utils.shared.setFontSizeAsPerDeviceHeight(currentSize: FontSize.size_10)) ?? UIFont.systemFont(ofSize: FontSize.size_10.rawValue), range: boldRange)
        let fnametextRange = (titleLableText as NSString).range(of: "*")
        fnameAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: fnametextRange)
        return fnameAttributedString
    }
    
    var titleFont: UIFont = UIFont(name: FontName.regular.rawValue, size: Utils.shared.setFontSizeAsPerDeviceHeight(currentSize: FontSize.size_10))! {
        didSet {
            title.font = titleFont
            title.sizeToFit()
        }
    }
    
    private var textfeildFont: UIFont {
        return UIFont(name: FontName.medium.rawValue, size: Utils.shared.setFontSizeAsPerDeviceHeight(currentSize: FontSize.size_14))!
    }
    
    private var titleYPadding: CGFloat {
        let hh = (self.frame.height / 2) - 3
        return hh - self.title.font.lineHeight
    }
    
    override var text: String? {
        didSet {
            showTitle(isFirstResponder)
        }
    }
    
    @IBInspectable var hintYPadding:CGFloat = 0.0
    
    
    @IBInspectable var titleTextColour:UIColor = UIColor.init(hex: "737D97") {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }
    
    @IBInspectable var titleActiveTextColour:UIColor = UIColor.init(hex: "737D97") {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }
    
    // MARK:- Init
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if let txt = text , !txt.isEmpty && isResp {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if let txt = text , txt.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
    }
    
    override func textRect(forBounds bounds:CGRect) -> CGRect {
        title.sizeToFit()
        var r = super.textRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return r.integral
    }
    
    override func editingRect(forBounds bounds:CGRect) -> CGRect {
        title.sizeToFit()
        var r = super.editingRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return r.integral
    }
    
    override func clearButtonRect(forBounds bounds:CGRect) -> CGRect {
        title.sizeToFit()
        var r = super.clearButtonRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = CGRect(x:r.origin.x, y:r.origin.y + (top * 0.5), width:r.size.width, height:r.size.height)
        }
        return r.integral
    }
    
    // MARK:- Public Methods
    func setTitle(title: String, isMandatory: Bool = false) {
        self.font = textfeildFont
        titleLableText = isMandatory ? title + "*" : title
        self.isMandatory = isMandatory
        if isMandatory {
            self.attributedPlaceholder = setAttributedTextPlaceholder(text: titleLableText)
        } else {
            self.title.text = title
            self.attributedPlaceholder = NSAttributedString(string: "title", attributes: [
                .font: UIFont(name: FontName.regular.rawValue, size: Utils.shared.setFontSizeAsPerDeviceHeight(currentSize: FontSize.size_14)) ?? UIFont.systemFont(ofSize: FontSize.size_14.rawValue)
            ])
            self.placeholder = title
        }
        
    }
    
    private func setAttributedTextPlaceholder(text: String) -> NSAttributedString {
        let fnametext = text
        let boldRange = (fnametext as NSString).range(of: fnametext)
        let fnameAttributedString = NSMutableAttributedString(string: fnametext)
        fnameAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: FontName.regular.rawValue, size: Utils.shared.setFontSizeAsPerDeviceHeight(currentSize: FontSize.size_14)) ?? UIFont.systemFont(ofSize: FontSize.size_14.rawValue), range: boldRange)
        let fnametextRange = (fnametext as NSString).range(of: "*")
        fnameAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: fnametextRange)
        return fnameAttributedString
    }
    
    // MARK:- Private Methods
    fileprivate func setup() {
        borderStyle = .none
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.sizeToFit()
        self.addSubview(title)
    }
    
    fileprivate func maxTopInset() -> CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }
    
    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
    }
    
    fileprivate func showTitle(_ animated:Bool) {
        if isMandatory { title.attributedText = attributedTitle }
        title.sizeToFit()
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
        }, completion:nil)
    }
    
    fileprivate func hideTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [.beginFromCurrentState, .curveEaseIn], animations: {
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion:nil)
    }
}




extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
