//
//  BadgeLabel.swift
//  Pods-FHXBageView_Example
//
//  Created by 冯汉栩 on 2018/7/27.
//

import UIKit

public enum PPBadgeViewFlexMode {
  case head    // 左伸缩 Head Flex    : <==●
  case tail    // 右伸缩 Tail Flex    : ●==>
  case middle  // 左右伸缩 Middle Flex : <=●=>
}

open class BadgeLabel: UILabel {

  private var padding = UIEdgeInsets.zero
  
  @IBInspectable
  var paddingLeft: CGFloat {
    get { return padding.left }
    set { padding.left = newValue }
  }
  
  @IBInspectable
  var paddingRight: CGFloat {
    get { return padding.right }
    set { padding.right = newValue }
  }
  
  @IBInspectable
  var paddingTop: CGFloat {
    get { return padding.top }
    set { padding.top = newValue }
  }
  
  @IBInspectable
  var paddingBottom: CGFloat {
    get { return padding.bottom }
    set { padding.bottom = newValue }
  }
  
  
  // 文字区域
  override open func drawText(in rect: CGRect) {
    super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    
  }
  
  // UILabel的内容区域
  override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let insets = self.padding
    var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
    rect.origin.x    -= insets.left
    rect.origin.y    -= insets.top
    rect.size.width  += (insets.left + insets.right)
    rect.size.height += (insets.top + insets.bottom)
    return rect
  }
  
  public class func `default`() -> Self {
    return self.init(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
  
  /// 记录Badge的偏移量 Record the offset of Badge
  public var offset: CGPoint = CGPoint(x: 0, y: 0)
  
  /// Badge伸缩的方向, Default is PPBadgeViewFlexModeTail
  public var flexMode: PPBadgeViewFlexMode = .tail
  
  public var limit:CGFloat = 0 {
    didSet{
      let stringWidth = bounds(string: self.text ?? "", font: self.font, height: self.p_height)
      if limit == 0 || limit == CGFloat((self.text?.int ?? 0).digits) {
        if self.p_height > stringWidth + 18 {
          self.p_width = self.p_height
          return
        }
        self.p_width = stringWidth + 18
      }else{
        guard let result = self.text?.int?.digits else { return }
        if result > Int(limit) {
          self.text = self.text!.substringInclude(front: Int(limit)) + "+"
          self.p_width = limit*9.5 + 18 + 9.5
        }else{
          self.p_width = stringWidth + 18
        }
      }
    }
  }
  
  
  /// 重写UILabel的text属性方法
  override open var text: String? {
    didSet {
      // 根据内容长度调整Label宽
      let stringWidth = bounds(string: self.text ?? "", font: self.font, height: self.p_height)
      if self.p_height > stringWidth + 18 {
        self.p_width = self.p_height
        return
      }
      self.p_width = stringWidth + 18
    }
  }
  
  private func setupUI() {
    self.textColor = UIColor.white
    self.font = UIFont.systemFont(ofSize: 13)
    self.textAlignment = NSTextAlignment.center
    self.layer.cornerRadius = self.p_height * 0.5
    self.layer.masksToBounds = true
    self.backgroundColor = UIColor.init(red: 1.00, green: 0.17, blue: 0.15, alpha: 1.0)
  }
  
  private func bounds(string: String,font: UIFont,height: CGFloat) -> CGFloat {
    let attributes = [NSFontAttributeName: font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let size = CGSize(width: CGFloat(Double.greatestFiniteMagnitude), height: height)
    let rect = ceil((string as NSString).boundingRect(with: size, options: option, attributes: attributes, context: nil).width)
    return rect
  }

}

extension Int {
  
  /// 计算: 位数
  public var digits: Int {
    if self == 0 {
      return 1
    } else if Int(fabs(Double(self))) <= LONG_MAX {
      return Int(log10(fabs(Double(self)))) + 1
    } else {
      return -1
    }
  }
  
}
