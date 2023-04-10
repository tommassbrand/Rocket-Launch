//
//  File.swift
//  
//
//  Created by Tomáš Brand on 14.03.2023.
//

import UIKit

extension UICollectionReusableView {
    override open var backgroundColor: UIColor? {
        get { .clear }
        set { }

        // default separators use same color as background
        // so to have it same but new (say red) it can be
        // used as below, otherwise we just need custom separators
        //
        // set { super.backgroundColor = .red }
    }
}
