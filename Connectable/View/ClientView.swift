//
//  ClientView.swift
//  Connectable
//
//  Created by 구태호 on 2/17/25.
//

import SwiftUI

struct ClientView: View {
    @State var isLoading: Bool = false
    @State var textEditor: String = ""
    
    let client = Client(serverIP: "", port: .http)
    
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
                Button(isLoading ? "수락 대기중" : "연결 시작") {
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    ClientView(textEditor: "adadawfawfawd")
}
