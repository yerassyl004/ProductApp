//
//  CustomSkyFloatingLabelTextField.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 04.06.2024.
//

import UIKit
import SkyFloatingLabelTextField

final class CustomSkyFloatingLabelTextField: SkyFloatingLabelTextField {
    
    private let leftPadding = CGFloat(16)
    private let rightPadding = CGFloat(36)

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        let rect = CGRect(
            x: leftPadding,
            y: titleHeight() - 6,
            width: bounds.size.width - rightPadding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )

        return rect

    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        let rect = CGRect(
            x: leftPadding,
            y: titleHeight(),
            width: bounds.size.width - rightPadding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )

        return rect

    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        let rect = CGRect(
            x: leftPadding,
            y: titleHeight(),
            width: bounds.size.width - rightPadding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )

        return rect

    }

    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {

        if editing {
            return CGRect(x: leftPadding, y: 5, width: bounds.size.width, height: titleHeight())
        }

        return CGRect(x: leftPadding, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
            x: bounds.size.width - rightPadding,
            y: 0,
            width: 20,
            height: bounds.size.height
        )

        return rect
    }
}

