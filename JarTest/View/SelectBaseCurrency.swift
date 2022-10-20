//
//  SelectBaseCurrency.swift
//  JarTest
//
//  Created by Oleh Titov on 19.10.2022.
//

import SwiftUI

struct SelectBaseCurrency: View {
    @State var selectedCurrency: ForeignCurrency
    var body: some View {
        NavigationView {
            Form {
                Section("bla bla") {
                    Picker("Select base currency", selection: $selectedCurrency) {
                        ForEach(ForeignCurrency.allCases, id: \.self) { currency in
                            Text(currency.longDescription)
                        }
                    }
                    //.pickerStyle(.navigationLink)
                }
            }
            .navigationTitle("Select")
        }
    }
}

struct SelectBaseCurrency_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectBaseCurrency(selectedCurrency: .usd)
        }
    }
}
