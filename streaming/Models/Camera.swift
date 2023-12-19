// Created with ❤️ by Luboš Hořínek
//

import AVFoundation
import UIKit
import Photos


class Camera: NSObject, ObservableObject {
    
    // MARK: - Private properties
    
    private var cameraLayer: AVCaptureVideoPreviewLayer?
    private var photoOutput: AVCapturePhotoOutput?
    private let captureSession = AVCaptureSession()
    
    @Published var preview: VideoPreview?
    @Published var isRecording = false
    
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        Task {
            do {
                photoOutput = captureSession.addPhotoOutput()
                _ = try captureSession.addMovieInput()
                _ = try captureSession.addMovieFileOutput()
                captureSession.startRunning()
            } catch {
                print("📸 Setup error: \(error.localizedDescription)")
            }
        }
        
        setupCameraPreview()
    }
    
    
    // MARK: - Setup
    
    private func setupCameraPreview() {
        cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        preview = VideoPreview(with: captureSession, gravity: .resizeAspectFill)
    }
    
    
    // MARK: - Actions
    
    func takePhoto() {
        print("📸 Take photo")
        
        guard let photoOutput else {
            print("📸 Error taking photo: no photoOutput")
            return
        }
        
        let settings = AVCapturePhotoSettings()
        guard let photoPreviewType = settings.availablePreviewPhotoPixelFormatTypes.first else {
            print("📸 Error taking photo: no photoPreviewType")
            return
        }
        
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoPreviewType]
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func startRecording() {
        print("🎥 Start recording")
        
        guard let output = captureSession.movieFileOutput else {
            print("🎥 Cannot find movie file output")
            return
        }
        
        guard let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("🎥 Cannot access local file domain")
            return
        }
        
        let fileName = UUID().uuidString
        let filePath = directoryPath
            .appendingPathComponent(fileName)
            .appendingPathExtension("mp4")
        
        output.startRecording(to: filePath, recordingDelegate: self)
    }
    
    func stopRecording() {
        print("🎥 Stop recording")
        
        guard let output = captureSession.movieFileOutput else {
            print("🎥 Cannot find movie file output")
            return
        }
        
        output.stopRecording()
    }
}


// MARK: - AVCapturePhotoCaptureDelegate

extension Camera: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("📸 Photo output")
        
        guard
            let imageData = photo.fileDataRepresentation(),
            let image = UIImage(data: imageData)
        else {
            print("📸 Error: no image")
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            guard status == .authorized else {
                print("📸 Error: not authorized")
                return
            }
            
            do {
                try PHPhotoLibrary.shared().performChangesAndWait {
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }
                print("📸 Photo saved")
            } catch {
                print("📸 Photo library error: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - AVCaptureFileOutputRecordingDelegate

extension Camera: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(
        _ output: AVCaptureFileOutput,
        didStartRecordingTo fileURL: URL,
        from connections: [AVCaptureConnection]
    ) {
        isRecording = true
        print("🎥 Video recording started")
    }
    
    func fileOutput(
        _ output: AVCaptureFileOutput,
        didFinishRecordingTo outputFileURL: URL,
        from connections: [AVCaptureConnection], error: Error?
    ) {
        isRecording = false
        print("🎥 Video recording finished! Path: \(outputFileURL.absoluteString)")
    }
}
