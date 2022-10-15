//
//  ChangeJarNameView.swift
//  JarTest
//
//  Created by Oleh Titov on 08.10.2022.
//

import SwiftUI

struct ChangeJarNameView: View {
    @EnvironmentObject private var stateController: StateController
    @Binding var path: NavigationPath
    @State var jarName: String
    @State var showResult = false
    @FocusState var focusedTextField: Bool
    var body: some View {
        Form {
            TextField("Jar name", text: $jarName, axis: .vertical)
                .focused($focusedTextField)
        }
        .onAppear {
            focusedTextField = true
        }
        .toolbar {
            Button {
                stateController.renameJar(newName: jarName)
                showResult = true
                focusedTextField = false
            } label: {
                Text("Save")
            }
            .disabled(jarName == "")
        }
        .sheet(isPresented: $showResult) {
            VStack(spacing: 20) {
                Spacer()
                Image("penguin_waving")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .background(Color(UIColor.tertiarySystemFill))
                    .clipShape(Circle())
                Text("Successfuly renamed jar to:")
                Text(jarName)
                    .font(.title)
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {doneTapped()}, label: {})
                    .buttonStyle(MyButtonStyle(title: "Done"))
            }
            
        }
    }
    
    func doneTapped() {
        path.removeLast()
        showResult = false
    }
}

struct ChangeJarNameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeJarNameView(path: .constant(NavigationPath()), jarName: "For new home")
            .environmentObject(StateController.dummyData())
    }
}
