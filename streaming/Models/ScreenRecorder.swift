// Created with ❤️ by Luboš Hořínek
//

import ReplayKit


class ScreenRecorder: NSObject {
    
    var recorder: RPScreenRecorder {
        RPScreenRecorder.shared()
    }
    
    override init() {
        super.init()
        
        recorder.isMicrophoneEnabled = true
    }
}


// MARK: - RPScreenRecorderDelegate

extension ScreenRecorder: RPScreenRecorderDelegate {
    
    
}
