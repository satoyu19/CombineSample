//
//  ShopsView.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import SwiftUI

struct ShopsView: View {
    @StateObject private var viewModel = ShopsViewModel(apiService: APIService())
    
    var body: some View {
        SearchView(viewModel: viewModel)
    }
}

struct ShopsView_Previews: PreviewProvider {
    static var previews: some View {
        ShopsView()
    }
}
