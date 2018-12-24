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
  
  let onlyTextView = EmptyPageView.ContentView.onlyText
    .set(text: "A测试B测试C测试D测试E测试F测试G测试E测试F测试G测试")
  
  let onlyImageView = EmptyPageView.ContentView.onlyImage
    .set(image: UIImage(named: "404"))
  
  
  let onlyStandardView = EmptyPageView.ContentView.standard
    .set(image: UIImage(named: "404"))
    .set(title: "标题|标题|标题|标题|标题|标题|标题|标题")
    .set(text:  "A测试B测试C测试D测试E测试F测试G测试E测试F测试G测试")
    .set(buttonTitle: "按钮")
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorStyle = .none
  }
  
  @IBAction func setStandardEvent(_ sender: UIButton) {
    onlyTextView.removeFromSuperview()
    onlyImageView.removeFromSuperview()
    onlyStandardView.removeFromSuperview()
    tableView.setEmpty(view: onlyStandardView.mix())
    tableView.reloadData()
  }
  
  @IBAction func setImageStyleEvent(_ sender: UIButton) {
    onlyTextView.removeFromSuperview()
    onlyImageView.removeFromSuperview()
    onlyStandardView.removeFromSuperview()
    tableView.setEmpty(view: onlyImageView.mix())
    tableView.reloadData()
  }
  
  @IBAction func setTextStyleEvent(_ sender: UIButton) {
    onlyTextView.removeFromSuperview()
    onlyImageView.removeFromSuperview()
    onlyStandardView.removeFromSuperview()
    tableView.setEmpty(view: onlyTextView.mix())
    tableView.reloadData()
  }
  
  // MARK: - 水平
  var imageSpaceValue: CGFloat = 0
  @IBAction func imageSpace(_ sender: UIButton) {
    imageSpaceValue += (imageSpaceValue > 100) ? -90 : 10
    if onlyImageView.superview != nil {
      onlyImageView.change(hspace: EmptyPageForImage.HSpaceType.image, value: imageSpaceValue)
    }
    
    if onlyStandardView.superview != nil {
      onlyStandardView.change(hspace: EmptyPageForStandard.HSpaceType.image, value: imageSpaceValue)
    }
  }
  
  var textSpaceValue: CGFloat = 0
  @IBAction func textSpace(_ sender: UIButton) {
    textSpaceValue += (textSpaceValue > 100) ? -90 : 10
    if onlyTextView.superview != nil {
      onlyTextView.change(hspace: EmptyPageForText.HSpaceType.text, value: textSpaceValue)
    }
    
    if onlyStandardView.superview != nil {
      onlyStandardView.change(hspace: EmptyPageForStandard.HSpaceType.text, value: textSpaceValue)
    }
  }
  
  var titleSpaceValue: CGFloat = 0
  @IBAction func titleSpace(_ sender: UIButton) {
    titleSpaceValue += (titleSpaceValue > 100) ? -90 : 10
    if onlyStandardView.superview != nil {
      onlyStandardView.change(hspace: EmptyPageForStandard.HSpaceType.title, value: titleSpaceValue)
    }
  }
  
  var buttonSpaceValue: CGFloat = 0
  @IBAction func buttonSpace(_ sender: UIButton) {
    buttonSpaceValue += (buttonSpaceValue > 100) ? -90 : 10
    
    if onlyStandardView.superview != nil {
      onlyStandardView.change(hspace: EmptyPageForStandard.HSpaceType.button, value: buttonSpaceValue)
    }
  }
  
  // MARK: - 垂直
  var imageTopValue: CGFloat = 0
  @IBAction func imageTop(_ sender: UIButton) {
    imageTopValue += (imageTopValue  > 50) ? -50 : 5
    if onlyStandardView.superview != nil {
      onlyStandardView.change(vspace: EmptyPageForStandard.VSpaceType.imageTop, value: imageTopValue)
    }
  }
  
  var imageWithTitleValue: CGFloat = 0
  @IBAction func imageWithTitle(_ sender: UIButton) {
    imageWithTitleValue += (imageWithTitleValue  > 50) ? -35 : 5
    if onlyStandardView.superview != nil {
      onlyStandardView.change(vspace: EmptyPageForStandard.VSpaceType.imageWithTitle, value: imageWithTitleValue)
    }
  }
  
  var titleWithTextValue: CGFloat = 0
  @IBAction func titleWithText(_ sender: UIButton) {
    titleWithTextValue += (titleWithTextValue  > 50) ? -35 : 5
    if onlyStandardView.superview != nil {
      onlyStandardView.change(vspace: EmptyPageForStandard.VSpaceType.titleWithText, value: titleWithTextValue)
    }
  }
  
  var textWithButtonValue: CGFloat = 0
  @IBAction func textWithButton(_ sender: UIButton) {
    textWithButtonValue += (textWithButtonValue > 50) ? -35 : 5
    if onlyStandardView.superview != nil {
      onlyStandardView.change(vspace: EmptyPageForStandard.VSpaceType.textWithButton, value: textWithButtonValue)
    }
  }
  
  // MARK: - 高度
  
  var buttonHeightValue: CGFloat = 0
  @IBAction func buttonHeight(_ sender: UIButton) {
    buttonHeightValue += (buttonHeightValue > 80) ? -60 : 10
    
    if onlyStandardView.superview != nil {
      onlyStandardView.change(height: EmptyPageForStandard.HeightType.button, value: buttonHeightValue)
    }
  }
  
}
