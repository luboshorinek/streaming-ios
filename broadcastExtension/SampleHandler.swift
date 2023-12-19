//  Created with ❤️ by Luboš Hořínek
//

import ReplayKit


class SampleHandler: RPBroadcastSampleHandler {
    
    let camera = Camera()
    
    
    // MARK: - Broadcasting stuff
    
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
        print("📢 STARTED")
    }
    
    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
        print("📢 PAUSED")
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
        print("📢 RESUMED")
    }
    
    override func broadcastFinished() {
        // User has requested to finish the broadcast.
        print("📢 FINISHED")
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            // Handle video sample buffer
            print("📢 PROCESS VIDEO")
            break
        case RPSampleBufferType.audioApp:
            // Handle audio sample buffer for app audio
            print("📢 PROCESS AUDIO APP")
            break
        case RPSampleBufferType.audioMic:
            // Handle audio sample buffer for mic audio
            print("📢 PROCESS AUDIO MIC")
            break
        @unknown default:
            // Handle other sample buffer types
            fatalError("📢 Unknown type of sample buffer")
        }
    }
}
