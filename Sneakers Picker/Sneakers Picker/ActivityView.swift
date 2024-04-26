//
//  ActivityView.swift
//  SegmentSwiftUI
//
//  Created by Mathew Lantsov on 14.04.2024.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]?
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return vc
        
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
    

    
    
}
