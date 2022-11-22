//
//  Typography.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 22/11/22.
//

import UIKit

extension NSAttributedString {
    internal static func title(_ string: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    internal static func paragraph(_ string: String, color: UIColor = .black, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.black
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
}
