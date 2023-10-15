//
//  MenuBarUIKit.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/15/23.
//
import SwiftUI
import UIKit

struct MenuBarUIKit: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let menuBar = MenuBar(maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        return menuBar
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
