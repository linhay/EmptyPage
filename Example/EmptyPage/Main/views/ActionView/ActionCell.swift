//
//  ActionCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class ActionCell: UITableViewCell, STNibProtocol {

    @IBOutlet private weak var leftBtn: UIButton!
    @IBOutlet private weak var rightBtn: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        rightBtn.setTitle(nil, for: .normal)
        rightBtn.st.add(for: .touchUpInside, action: nil)
        leftBtn.setTitle(nil, for: .normal)
        leftBtn.st.add(for: .touchUpInside, action: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configLeft(title: String?, action: ((_: UIControl) -> Void)?) {
        leftBtn.setTitle(title, for: .normal)
        leftBtn.st.add(for: .touchUpInside, action: action)
    }

    func configRight(title: String?, action: ((_: UIControl) -> Void)?) {
        rightBtn.setTitle(title, for: .normal)
        rightBtn.st.add(for: .touchUpInside, action: action)
    }
}
