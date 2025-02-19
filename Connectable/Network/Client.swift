//
//  Client.swift
//  Connectable
//
//  Created by 구태호 on 2/17/25.
//

import Foundation
import Network


class Client {
    let serverIP: String
    let port: NWEndpoint.Port
    var connection: NWConnection?
    
    var sendHandler: ((String) -> ())?
    var receiveHandler: ((String) -> ())?
    
//    init(serverIP: String, port: NWEndpoint.Port, sendHandler: @escaping (String) -> (), receiveHandler: @escaping (String) -> ()) {
//        self.serverIP = serverIP
//        self.port = port
//        self.sendHandler = sendHandler
//        self.receiveHandler = receiveHandler
//        
//        connection = NWConnection(host: NWEndpoint.Host(serverIP), port: port, using: .tcp)
//        bind()
//    }
    
    init(serverIP: String, port: NWEndpoint.Port) {
        self.serverIP = serverIP
        self.port = port
        
        connection = NWConnection(host: NWEndpoint.Host(serverIP), port: port, using: .tcp)
        bind()
    }
    
    func startConnect() {
        connection?.start(queue: .main)
//        RunLoop.main.run()
    }
    
    func bind() {
        connection?.stateUpdateHandler = { [weak self] state in
            switch state {
            case .ready:
                print("🟢 Connected to server!")

                // 서버에 메시지 전송
                let message = "Hello from Client!"
                self?.connection?.send(content: message.data(using: .utf8), completion: .contentProcessed { error in
                    if let error = error {
                        print("⚠️ Send error: \(error)")
                    } else {
                        self?.sendHandler?(message)
                        print("📤 Message sent!")
                    }
                })

                // 서버의 응답 받기
                self?.connection?.receiveMessage { (data, context, isComplete, error) in
                    if let data = data, let response = String(data: data, encoding: .utf8) {
                        self?.receiveHandler?(response)
                        print("📩 Server response: \(response)")
                    }
                }
            case .failed(let error):
                print("❌ Connection failed: \(error.localizedDescription)")
            case .waiting(let error):
                print("Connection Wating... : \(error.localizedDescription)")
            default:
                break
            }
        }
    }
}
