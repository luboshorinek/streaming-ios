// Created with ❤️ by Luboš Hořínek
//

import SwiftUI
import ReplayKit


struct ContentView: View {
    
    @ObservedObject var camera = Camera()
    
    var body: some View {
        VStack {
            RecordingPickerView()
                .frame(width: 50, height: 50)
            
            camera.preview?
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Button {
                camera.takePhoto()
            } label: {
                Text("Take photo")
            }
            
            Button {
                if camera.isRecording {
                    camera.stopRecording()
                } else {
                    camera.startRecording()
                }
            } label: {
                Text(camera.isRecording ? "Stop recording" : "Start recording")
            }
        }
        .background(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    ContentView()
}
