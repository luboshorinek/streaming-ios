// Created with ❤️ by Luboš Hořínek
//

import AVFoundation


extension AVCaptureSession {
    
    // MARK: - Properties
    
    var movieFileOutput: AVCaptureMovieFileOutput? {
        outputs.compactMap { $0 as? AVCaptureMovieFileOutput }.first
    }
    
    
    // MARK: - Setup
    
    func addPhotoOutput() -> AVCapturePhotoOutput? {
        let photoOutput = AVCapturePhotoOutput()
        
        if canAddOutput(photoOutput) {
            addOutput(photoOutput)
            print("📸 Added captureSession output")
        }
        
        return photoOutput
    }
    
    func addMovieInput() throws -> Self {
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            throw VideoError.device("🎥 Error getting video input")
        }
        
        let videoInput = try AVCaptureDeviceInput(device: videoDevice)
        guard self.canAddInput(videoInput) else {
            throw VideoError.device("🎥 Error setting video input")
        }
        
        self.addInput(videoInput)
        
        return self
    }
    
    func addMovieFileOutput() throws -> Self {
        guard self.movieFileOutput == nil else {
            // return itself if output is already set
            return self
        }
        
        let fileOutput = AVCaptureMovieFileOutput()
        guard self.canAddOutput(fileOutput) else {
            throw VideoError.device("🎥 Error setting video output")
        }
        
        self.addOutput(fileOutput)
        
        return self
    }
}
