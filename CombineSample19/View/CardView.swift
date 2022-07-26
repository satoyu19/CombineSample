//
//  CardView.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import SwiftUI

struct CardView: View {
    // CardView.Input
    // 表示のための入れ物（= JSON用の入れ物)
    struct Input: Identifiable {
        let id: UUID = UUID()
        let name: String        //店名
        let address: String     //住所
        let shopImage: UIImage   //ロゴ
        let access: String       //交通アクセス
        let genre: String    //ジャンル
        let open: String    //営業時間
        let stationName: String //最寄駅
    }

    let input: Input
    
    let screen: CGSize = UIScreen.main.bounds.size

    var body: some View {
        HStack{
            icon
            shopState
        }
        .padding(20)
        // 角丸矩形
        .frame(minWidth: 300, minHeight: 150)

    }
    
    var icon: some View {

        Image(uiImage: input.shopImage)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            // 画像を丸くクリップする
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            // おしゃれ
            // 影を付ける
            .shadow(color: .gray, radius: 1, x: 0, y: 0)
    }

    var shopState: some View{
        VStack{
            name
            address
        }
    }

    var name: some View {
        Text(input.name)
            .foregroundColor(.black)
            .font(.title3)
            .fontWeight(.bold)
    }

    var address: some View {
            Text(input.address)
                .font(.footnote)
                .foregroundColor(.gray)
    }

}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(input: CardView.Input(name: "店名", address: "住所", shopImage: UIImage(named: "shop")!, access: "交通アクセス", genre: "ジャンル", open: "開店時間", stationName: "最寄駅"))
    }
}
