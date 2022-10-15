//
//  CurrencySwipingSelector.swift
//  JarTest
//
//  Created by Oleh Titov on 02.07.2022.
//

import SwiftUI
import SwiftUIPager

struct CurrencySwipingSelector: View {
    @StateObject var page: Page = .first() // for SwiftUIPager
    @Binding var selectedCurrency : ForeignCurrency
//    @Binding var show : Bool
    var body: some View {
        Pager(page: page, data: ForeignCurrency.allCases, id: \.self) { item in
            Text(item.rawValue)
                .foregroundColor(.white)
                .font(.title)
                .bold()
                .frame(width: 100, height: 44, alignment: .center)
        }
        .onPageChanged({ (newIndex) in
            selectedCurrency = ForeignCurrency.allCases[newIndex] // updating currency property when there is a new index
        })
        .multiplePagination()
        .interactive(opacity: 0.4)
        .preferredItemSize(CGSize(width: 60, height: 40))
        .itemSpacing(20)
        .interactive(scale: 0.6)
        .itemAspectRatio(0, alignment: .center)
        .padding()
        .background(Color.black.opacity(0.1))
        .frame(height: 60, alignment: .center)
        .onAppear {
            self.page.update(.move(increment: 2))
            selectedCurrency = ForeignCurrency.allCases[page.index]
        }
    }
}

struct CurrencySwipingSelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySwipingSelector(selectedCurrency: .constant(ForeignCurrency.usd))
    }
}
