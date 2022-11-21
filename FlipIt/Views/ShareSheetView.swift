//
//  ShareSheetView.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//
import SwiftUI


struct ShareSheetView : UIViewControllerRepresentable{
    typealias UIViewControllerType = UIActivityViewController
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    var products : [Any]
    let applicationActivities: [UIActivity]? = nil
        let excludedActivityTypes: [UIActivity.ActivityType]? = nil
        let callback: Callback? = nil
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: products, applicationActivities: .none)
    //    controller.isModalInPresentation=true
        controller.excludedActivityTypes = excludedActivityTypes
                controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
}
