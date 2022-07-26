//
//  DetailView.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/25.
//

import SwiftUI

struct DetailView: View {
    
    private var shopState: CardView.Input
    
    init(shopState: CardView.Input){
        self.shopState = shopState
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 50){
            Image(uiImage: shopState.shopImage)
                .resizable()
                .frame(height: 180)
                .aspectRatio(contentMode: .fill)
            
            Spacer()
            
            HStack{
                Text(shopState.name)
                    .font(.title)
                    .underline(true, color: Color.blue)
            }
                        
            HStack{
                Text("住所：")
                Text(shopState.address)
                Spacer()
            }


            HStack{
                Text("交通アクセス：")
                Text(shopState.access)
                Spacer()
            }
            
            HStack{
                Text ("ジャンル：")
                Text(shopState.genre)
                Spacer()
            }
            HStack{
                Text("開店時間：")
                Text(shopState.open)
                Spacer()
            }
            
            HStack{
                Text("最寄駅：")
                Text(shopState.stationName)
                Spacer()
            }
            Spacer()

        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(shopState: .init(name: "店名", address: "住所", shopImage: UIImage(named: "shop")!, access: "交通アクセス", genre: "ジャンル", open: "開店時間", stationName: "最寄駅"))
    }
}

