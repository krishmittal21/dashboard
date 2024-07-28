//
//  FontExtension.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

enum FontWeight {
    case ultralight
    case light
    case regular
    case medium
    case semiBold
    case bold
    case heavy
    case black
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .ultralight:
            Font.custom("SFUIDisplay-Ultralight", size: size)
        case .light:
            Font.custom("SFUIDisplay-Light", size: size)
        case .regular:
            Font.custom("SFUIDisplay-Regular", size: size)
        case .medium:
            Font.custom("SFUIDisplay-Medium", size: size)
        case .semiBold:
            Font.custom("SFUIDisplay-Semibold", size: size)
        case .bold:
            Font.custom("SFUIDisplay-Bold", size: size)
        case .heavy:
            Font.custom("SFUIDisplay-Heavy", size: size)
        case .black:
            Font.custom("SFUIDisplay-Black", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight = .regular, _ size: CGFloat = 16) -> Text {
        return self.font(.customFont(fontWeight, size))
    }
}
