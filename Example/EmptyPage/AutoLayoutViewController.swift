//
//  AutoLayoutViewController.swift
//  EmptyPage_Example
//
//  Created by linhey on 2018/12/24.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

class AutoLayoutViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var rightContraint: NSLayoutConstraint!
  @IBOutlet weak var leftContraint: NSLayoutConstraint!
  @IBOutlet weak var topContraint: NSLayoutConstraint!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
  @IBAction func tableViewLeft(_ sender: UIButton) {
    leftContraint.constant += 10
  }
  
  @IBAction func tableViewRight(_ sender: UIButton) {
    rightContraint.constant += 10
  }
  
  @IBAction func tableViewTop(_ sender: Any) {
    topContraint.constant += 10
  }
  
  @IBAction func tableViewBottom(_ sender: Any) {
    bottomConstraint.constant += 10
  }
  
  let onlyTextView = EmptyPageView.Template.text
    .set(text: "A测试B测试C测试D测试E测试F测试G测试E测试F测试G测试")
  
  let onlyImageView = EmptyPageView.Template.image
    .set(image: UIImage(named: "404"))
  
  let standardView = EmptyPageView.Template.standard
    .set(image: UIImage(named: "404"))
    .set(title: "标题|标题|标题|标题|标题|标题|标题|标题")
    .set(text:  "A测试B测试C测试D测试E测试F测试G测试E测试F测试G测试")
    .set(buttonTitle: "按钮")
    .config(titleLabel: { (item) in
    item.backgroundColor = UIColor.yellow
    }).config(textLabel: { (item) in
      item.backgroundColor = UIColor.yellow
    }).config(imageView: { (item) in
      item.backgroundColor = UIColor.yellow
    })
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorStyle = .none
  }
  
  @IBAction func setStandardEvent(_ sender: UIButton) {
    onlyTextView.removeFromSuperview()
    onlyImageView.removeFromSuperview()
    standardView.removeFromSuperview()
    tableView.ep.setEmpty(standardView.mix())
    tableView.reloadData()
  }
  
  @IBAction func setImageStyleEvent(_ sender: UIButton) {
    onlyTextView.removeFromSuperview()
    onlyImageView.removeFromSuperview()
    standardView.removeFromSuperview()
    tableView.ep.setEmpty(onlyImageView.mix())
    tableView.reloadData()
  }
  
  @IBAction func setTextStyleEvent(_ sender: UIButton) {
    onlyTextView.removeFromSuperview()
    onlyImageView.removeFromSuperview()
    standardView.removeFromSuperview()
    tableView.ep.setEmpty(onlyTextView.mix())
    tableView.reloadData()
  }
  
  // MARK: - 水平
  var imageSpaceValue: CGFloat = 0
  @IBAction func imageSpace(_ sender: UIButton) {
    imageSpaceValue += (imageSpaceValue > 100) ? -90 : 10
    if onlyImageView.superview != nil {
//      onlyImageView.change(hspace: EmptyPageForImage.HSpaceType.image, value: imageSpaceValue)
    }
    
    if standardView.superview != nil {
      standardView.change(hspace: EmptyPageForStandard.HSpaceType.image, value: imageSpaceValue)
    }
  }
  
  var textSpaceValue: CGFloat = 0
  @IBAction func textSpace(_ sender: UIButton) {
    textSpaceValue += (textSpaceValue > 100) ? -90 : 10
    if onlyTextView.superview != nil {
//      onlyTextView.change(hspace: EmptyPageForText.HSpaceType.text, value: textSpaceValue)
    }
    
    if standardView.superview != nil {
      standardView.change(hspace: EmptyPageForStandard.HSpaceType.text, value: textSpaceValue)
    }
  }
  
  var titleSpaceValue: CGFloat = 0
  @IBAction func titleSpace(_ sender: UIButton) {
    titleSpaceValue += (titleSpaceValue > 100) ? -90 : 10
    if standardView.superview != nil {
      standardView.change(hspace: EmptyPageForStandard.HSpaceType.title, value: titleSpaceValue)
    }
  }
  
  var buttonSpaceValue: CGFloat = 0
  @IBAction func buttonSpace(_ sender: UIButton) {
    buttonSpaceValue += (buttonSpaceValue > 100) ? -90 : 10
    
    if standardView.superview != nil {
      standardView.change(hspace: EmptyPageForStandard.HSpaceType.button, value: buttonSpaceValue)
    }
  }
  
  // MARK: - 垂直
  var imageTopValue: CGFloat = 0
  @IBAction func imageTop(_ sender: UIButton) {
    imageTopValue += (imageTopValue  > 50) ? -50 : 5
    if standardView.superview != nil {
      standardView.change(vspace: EmptyPageForStandard.VSpaceType.imageTop, value: imageTopValue)
    }
  }
  
  var imageWithTitleValue: CGFloat = 0
  @IBAction func imageWithTitle(_ sender: UIButton) {
    imageWithTitleValue += (imageWithTitleValue  > 50) ? -35 : 5
    if standardView.superview != nil {
      standardView.change(vspace: EmptyPageForStandard.VSpaceType.imageWithTitle, value: imageWithTitleValue)
    }
  }
  
  var titleWithTextValue: CGFloat = 0
  @IBAction func titleWithText(_ sender: UIButton) {
    titleWithTextValue += (titleWithTextValue  > 50) ? -35 : 5
    if standardView.superview != nil {
      standardView.change(vspace: EmptyPageForStandard.VSpaceType.titleWithText, value: titleWithTextValue)
    }
  }
  
  var textWithButtonValue: CGFloat = 0
  @IBAction func textWithButton(_ sender: UIButton) {
    textWithButtonValue += (textWithButtonValue > 50) ? -35 : 5
    if standardView.superview != nil {
      standardView.change(vspace: EmptyPageForStandard.VSpaceType.textWithButton, value: textWithButtonValue)
    }
  }
  
  // MARK: - 高度
  
  var buttonHeightValue: CGFloat = 0
  @IBAction func buttonHeight(_ sender: UIButton) {
    buttonHeightValue += (buttonHeightValue > 80) ? -60 : 10
    
    if standardView.superview != nil {
      standardView.change(height: EmptyPageForStandard.HeightType.button, value: buttonHeightValue)
    }
  }
  
}
