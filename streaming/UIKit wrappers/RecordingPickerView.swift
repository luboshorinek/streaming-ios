// Created with ❤️ by Luboš Hořínek
//

import SwiftUI
import ReplayKit


struct RecordingPickerView: UIViewRepresentable {
    
    typealias UIViewType = RPSystemBroadcastPickerView
    
    func makeUIView(context: Context) -> RPSystemBroadcastPickerView {
        let broadcastPicker = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        broadcastPicker.preferredExtension = "cz.horinek.streaming.broadcastExtension"
        
        return broadcastPicker
    }
    
    func updateUIView(_ uiView: RPSystemBroadcastPickerView, context: Context) {
        
    }
}
