//
//  ShopsViewModel.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import SwiftUI
import Combine

final class ShopsViewModel: ObservableObject{
    
    enum Input{
        //ユーザーの入力操作が終了した
        case onCommit(text: String)     //テキストフィールドの中身をテキストに入れる
        
        //TODO: タップ時店舗詳細を見る
        case tappedCardView(shopState: CardView.Input)
    }
    
    @Published private(set) var cardViewInputs: [CardView.Input] = []
    
    //テキストフィールドに入力された値
    @Published var inputText: String = ""
    
    //エラーアラート(読み込み中)表示フラグ
    @Published var isShowError = false
    
    //cancellable群,AnyCancellableは購読をキャンセルするときに利用します。AnyCancellabeにはcancel()メソッドが生えており、
    //このメソッドを呼び出すことでSubscriberはPublisherの購読を終了することができます。
    private var cancellable = Set<AnyCancellable>()
    
    //TODO: 読み込みテキストの表示フラグ、インジケーターに変更する
    @Published var isLoading = false
    
    //詳細画面遷移フラグ
    @Published var isShowSheet = false
    
    //表示するshopの詳細
    @Published var shopState: CardView.Input?
    
    //通信する処理が入っている
    private let apiService: APIServiceType
    
    //Publisher
    private let onCommitSubject = PassthroughSubject<String, Never>()
    //JSONを分解したもの
    private let responseSubject = PassthroughSubject<SearchRepositoryResponse, Never>()
    //エラー
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    init(apiService: APIServiceType){
        self.apiService = apiService
        bind()
    }
    
    func bind(){
        onCommitSubject
            .flatMap { query in //query→検索文字
                self.apiService.request(with: SearchRepositoryRequest(query: query))
            }
            .catch{ error -> Empty<SearchRepositoryResponse, Never> in
                self.errorSubject.send(error)
                return Empty()
            }
        
            .map{$0.results.shop}
        //サブスクライバー
            .sink{ repositories in
                //CardViewが欲しい
                self.cardViewInputs = self.convertInput(repositories: repositories)
                self.isLoading = false
            }
            .store(in: &cancellable)
        
        //ocCommitSubjectが動いている状態
        onCommitSubject
            .map{_ in true }
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellable)
        
        errorSubject
            .sink { [weak self] (error) in
                guard let self = self else {return}
                self.isShowError =  true
                self.isLoading = false
            }
            .store(in: &cancellable)
    }
    
    private func convertInput(repositories: [Repository]) -> [CardView.Input]{
        var inputs: [CardView.Input] = []
        for repository in repositories {
            guard let url = URL(string: repository.photo.pc.m) else{ continue }
        
        
        let data = try? Data(contentsOf: url)
        let image = UIImage(data: data ?? Data()) ?? UIImage()
        
            inputs.append(CardView.Input(name: repository.name, address: repository.address, shopImage: image, access: repository.access, genre: repository.genre.name, open: repository.open, stationName: repository.stationName))
        }
        return inputs
    }
    
    
    func apply(input: Input){
        switch input {
        
        case .onCommit(text: let text):
            //検索して欲しい
            onCommitSubject.send(text)
//        case .tappedCardView(urlString: let urlString):
//            //SafariViewを起動して欲しい
//            repositoryURL =  urlString
//            isShowSheet = true
            //TODO: タップされたら詳細画面へ
        case .tappedCardView(shopState: let shopState):
            self.shopState = shopState
            isShowSheet = true
        }
    }
}
