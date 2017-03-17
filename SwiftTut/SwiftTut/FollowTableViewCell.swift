//
//  FollowTableViewCell.swift
//  SwiftTut
//
//  Created by MILIKET on 11/20/16.
//  Copyright © 2016 Bình Anh Electonics. All rights reserved.
//

import UIKit
import RxSwift
import PHExtensions

class FollowTableViewCell: UITableViewCell {
    
    enum Size: CGFloat {
        case Padding15 = 15, Padding10 = 10, Button = 30, Image = 50
    }
    
    var disposeBagCell: DisposeBag = DisposeBag()
    
    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }

    var avatar: UIImageView!
    var name: UILabel!
    var cancel: UIButton!
    
    enum SeperatorStyle {
        case hidden
        case padding(CGFloat)
    }
    var seperatorStyle: SeperatorStyle = .padding(15) {
        didSet {
            switch seperatorStyle {
            case .hidden:
                seperator.isHidden = true
            case .padding(_):
                seperator.isHidden = false
            }
        }
    }
    
    var seperatorRightPadding: CGFloat = 15
    
    var seperator: UIView! = {
        var view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.insertSubview(seperator, aboveSubview: textLabel!)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView.insertSubview(seperator, aboveSubview: textLabel!)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatar.frame = CGRect(x: Size.Padding15..,
                               y: Size.Padding10..,
                               width: Size.Image..,
                               height: Size.Image..)
        
        name.frame = CGRect(x: avatar.frame.maxX + Size.Padding10..,
                            y: (bounds.height - Size.Image..) / 2,
                            width: bounds.width - Size.Image.. - Size.Button.. - Size.Padding10..,
                            height: Size.Image..)
        
        cancel.frame = CGRect(x: bounds.width - Size.Button.. - Size.Padding10..,
                              y: (bounds.height - Size.Button..) / 2,
                              width: Size.Button..,
                              height: Size.Button..)
        
        switch seperatorStyle {
        case .hidden:
            break
        case .padding(let padding):
            seperator.frame = CGRect(
                x: padding,
                y: contentView.bounds.height - 1 / UIScreen.main.scale,
                width: UIScreen.main.bounds.width - padding - seperatorRightPadding,
                height: 1 / UIScreen.main.scale)
        }
        
    }

}


extension FollowTableViewCell {
    fileprivate func setup() {
        
        avatar = setupAvatar()
        name = setupLabel()
        cancel = setupButton()
        
        addSubview(avatar)
        addSubview(name)
        addSubview(cancel)
        
    }
    
    fileprivate func setupAvatar() -> UIImageView {
        let image = UIImageView()
        image.layer.cornerRadius = Size.Image.. / 2
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }
    
    fileprivate func setupButton() -> UIButton {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = Size.Button.. / 2
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "x")!, for: .normal)
        return button
    }
    
    fileprivate func setupLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: FontType.AvenirRoman.., size: FontSize.large..)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
    
    
}
