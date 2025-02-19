//
//  ServerView.swift
//  Connectable
//
//  Created by 구태호 on 2/17/25.
//

import SwiftUI

struct ServerView: View {
    @State var isConnect: Bool = false
    @State var textEditor: String = ""
    
    let server = Server(port: .http)
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Connectable")
            TextEditor(text: $textEditor)
                .border(Color.gray, width: 1)
                .padding()
                .font(.custom(.semiBold600, size: 18))
            
            HStack {
                Button(isConnect ? "중지" : "대기 시작") {
                    do {
                        try server.startConnect()
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                }
                .onChange(of: isConnect) { _, _ in
                    if isConnect {
                        print()
                    } else {
                        
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ServerView(textEditor: "adadawfawfawd")
}
