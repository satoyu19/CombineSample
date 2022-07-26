//
//  SearchView.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: ShopsViewModel
    
    @State var text: String = ""
    var body: some View {
       
        NavigationView {
            if viewModel.isLoading{
                Text("読み込み中...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .offset(x: 0, y: 200)
            } else{
                List{
                    ForEach (viewModel.cardViewInputs) { input in
                        Button{
                            //TODO: タプ時の処理
                            viewModel.apply(input: .tappedCardView(shopState: input))
                        }label: {
                            CardView(input: input)
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        TextField("和食", text: $text, onCommit:  {
                            // 編集完了後に呼ばれるクロージャー
                            viewModel.apply(input: .onCommit(text: text))
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.asciiCapable)
                        .frame(width: UIScreen.main.bounds.width - 40)
                    }
                }
            }
            }
           
        .navigationViewStyle(StackNavigationViewStyle())

            .sheet(isPresented: $viewModel.isShowSheet){
                DetailView(shopState: viewModel.shopState!)
            }
            .alert(isPresented: $viewModel.isShowError){
                Alert(title:  Text("通信時にエラーが発生しました "))
            }        }
    }


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel:  ShopsViewModel(apiService: APIService()))
    }
}
