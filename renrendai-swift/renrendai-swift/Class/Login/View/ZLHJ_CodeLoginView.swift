//
//  ZLHJ_CodeLoginView.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/9/3.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit

class ZLHJ_CodeLoginView: UIView {



    var contentView:UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadXib()
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadXib()
        addSubview(contentView)
        
    }

    func loadXib() ->UIView {

        let name: String = String(describing: ZLHJ_CodeLoginView.self)


        return Bundle.main.loadNibNamed("ZLHJ_CodeLoginView", owner: nil, options: nil)?.first as! UIView

    }
}
