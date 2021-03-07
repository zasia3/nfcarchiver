//
//  NFCHandler.swift
//  NFCArchiver
//
//  Created by Joanna Zatorska on 04/01/2021.
//

import Foundation
import CoreNFC

enum NFCHandlerError: Error {
    case invalidated
}

class NFCHandler: NSObject {
    private static let shared = NFCHandler()
    private var session: NFCNDEFReaderSession?
    
    func beginWrite(_ sender: Any) {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near an NDEF tag to write the message."
        session?.begin()
    }
}

extension NFCHandler: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        handleError(error)
        self.session = nil
    }
    
    private func handleError(_ error: Error) {
        session?.alertMessage = error.localizedDescription
        session?.invalidate()
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {

    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        guard let tag = tags.first,
              tags.count == 1 else {
              session.alertMessage = """
                There are too many tags present. Remove all and then try again.
                """
              DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500)) {
                session.restartPolling()
              }
              return
        }
        
        session.connect(to: tag) { error in
          if let error = error {
            self.handleError(error)
            return
          }

          // 2
          tag.queryNDEFStatus { status, _, error in
            if let error = error {
              self.handleError(error)
              return
            }

            // 3
            switch (status) {
            case .notSupported:
              session.alertMessage = "Unsupported tag."
              session.invalidate()
            case .readOnly:
              session.alertMessage = "Unable to write to tag."
              session.invalidate()
            case .readWrite:
              self.write(tag)
            default:
              return
            }
          }
        }
        
    }
    
    func write(_ tag: NFCNDEFTag) {
        tag.readNDEF { (message, error) in
            if let message = message {
                let record = message.records.first
                
            }
        }
        let newTag = Tag()
        guard let payload = NFCNDEFPayload
                .wellKnownTypeTextPayload(string: newTag.id.uuidString, locale: Locale.current)
              else {
                handleError(NFCHandlerError.invalidated)
                return
            }

            // 2
            let message = NFCNDEFMessage(records: [payload])

            // 3
            tag.writeNDEF(message) { error in
              if let error = error {
                self.handleError(error)
                return
              }

              self.session?.alertMessage = "Wrote location data."
              self.session?.invalidate()
//              self.completion?(.success(Location(name: name)))
            }
    }
}
