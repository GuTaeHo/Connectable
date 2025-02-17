//
//  Server.swift
//  Connectable
//
//  Created by 구태호 on 2/17/25.
//

import Foundation
import Network


class Server {
    let port: NWEndpoint.Port
    var listener: NWListener?
    var receiveHandler: ((String) -> ())?
    var sendHandler: ((NWError?) -> ())?
    
    init(port: NWEndpoint.Port) {
        self.port = port
    }
    
    func startConnect() throws {
        listener = try NWListener(using: .tcp, on: port)
        bindHandler()
    }
    
    func bindHandler() {
        listener?.newConnectionHandler = { [weak self] connection in
            print("🟢 New client connected!")
            
            connection.start(queue: .main)

            connection.receiveMessage { (data, context, isComplete, error) in
                if let data = data, let message = String(data: data, encoding: .utf8) {
                    print("📩 Received: \(message)")
                    self?.receiveHandler?(message)
                    
                    // 클라이언트에게 응답 보내기
                    let response = "Hello from Server!"
                    connection.send(content: response.data(using: .utf8), completion: .contentProcessed({ sendError in
                        self?.sendHandler?(sendError)
//                        if let sendError = sendError {
//                            print("⚠️ Send error: \(sendError)")
//                        } else {
//                            print("✅ Response sent!")
//                        }
                    }))
                } else {
                    self?.receiveHandler?(error?.localizedDescription ?? "receive error")
                }
            }
        }
    }
}
