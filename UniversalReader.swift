```swift
import SwiftUI
import CoreNFC

final class NFCReader: NSObject, NFCTagReaderSessionDelegate {

    private var session: NFCTagReaderSession?

    func startScanning() {
        guard NFCTagReaderSession.readingAvailable else {
            return
        }

        guard let newSession = NFCTagReaderSession(
            pollingOption: [.iso14443, .iso15693, .iso18092],
            delegate: self,
            queue: nil
        ) else {
            return
        }

        newSession.alertMessage = "Przyłóż urządzenie NFC"
        session = newSession
        newSession.begin()
    }

    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("NFC reader aktywny")
    }

    func tagReaderSession(
        _ session: NFCTagReaderSession,
        didInvalidateWithError error: Error
    ) {
        print("NFC zakończone: \(error.localizedDescription)")
    }

    func tagReaderSession(
        _ session: NFCTagReaderSession,
        didDetect tags: [NFCTag]
    ) {
        print("Wykryto \(tags.count) urządzenie/urządzenia NFC")
    }
}

struct ContentView: View {

    private let nfcReader = NFCReader()

    var body: some View {
        VStack(spacing: 20) {
            Text("Universal Reader")
                .font(.largeTitle)
                .bold()

            Button("Skanuj NFC") {
                nfcReader.startScanning()
            }
            .font(.title2)
        }
        .padding()
    }
}

@main
struct UniversalReaderApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```
