//
//  CameraView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/2/24.
//

import Foundation
import UIKit
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    @Binding var takenImage: UIImage
    @Binding var didUseImage: Bool
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self)
    }
}

extension CameraView {
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Cancel pressed")
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                parent.takenImage = image
                parent.didUseImage = true
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
