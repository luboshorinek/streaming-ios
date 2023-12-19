// Created with ❤️ by Luboš Hořínek
//

import SwiftUI
import AVFoundation


struct VideoPreview: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    let previewLayer: AVCaptureVideoPreviewLayer
    let gravity: AVLayerVideoGravity

    
    // MARK: - Initialization
    
    init(
        with session: AVCaptureSession,
        gravity: AVLayerVideoGravity
    ) {
        self.gravity = gravity
        self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
    }
    
    
    // MARK: - UIViewControllerRepresentable stuff

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        previewLayer.videoGravity = gravity
        uiViewController.view.layer.addSublayer(previewLayer)
        
        previewLayer.frame = uiViewController.view.bounds
    }

    func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: ()) {
        previewLayer.removeFromSuperlayer()
    }
}
