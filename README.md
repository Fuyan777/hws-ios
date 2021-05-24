# hws-ios

## Image
<img width="192" alt="スクリーンショット 2021-05-24 21 05 25" src="https://user-images.githubusercontent.com/29572313/119345980-8d05fa80-bcd4-11eb-99ee-f7585ba9e97b.png">  <img width="198" alt="スクリーンショット 2021-05-24 21 05 36" src="https://user-images.githubusercontent.com/29572313/119345972-8b3c3700-bcd4-11eb-8eaa-ac0fcc0de9ad.png">

## Architecture
<img width="639" alt="スクリーンショット 2021-05-24 21 48 51" src="https://user-images.githubusercontent.com/29572313/119350075-d9a00480-bcd9-11eb-826c-d7285615025e.png">

- BehaviorRelayとPublishRelayのみを利用
- ModelからViewに向けた一方向のみ

### MVVMの採用理由
- ViewControllerの肥大化を防ぎ、責務が明確になるため
- Rxの導入より状態管理がシンプルになるため

### 得られるメリット
- 依存関係がシンプルになる
- RxSwiftを最低限使用することで複雑化を防ぐ
- SwiftUIの移行に向けての変更容易性が向上する

### 責務
- View（ViewController）
  - UI出力
  - ViewModelへのバインディング
- ViewModel
  - UIに依存するロジック / エラーハンドリング
  - Viewからのアクションを元にデータをModelから取得
- Model
  - UIに依存しないビジネスロジック　/ エラーハンドリング
  - 通信処理
