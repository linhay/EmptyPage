//
//  MainHeaderView.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import SnapKit

class MainHeaderView: UITableViewHeaderFooterView, STViewProtocol {

    lazy private var titleLabel = UILabel()

    private var action: (() -> Void)?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(45)
        }

        contentView.st.setTapGesture({ _ in
            self.action?()
        })
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension MainHeaderView {

    func config(title: String?, action: (() -> Void)? = nil) {
        if action == nil {
            contentView.backgroundColor = UIColor("#F6F6F6")
            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }else{
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            contentView.backgroundColor = UIColor("#CCCCCC")
        }
        self.titleLabel.text = title
        self.action = action
    }
    
}
