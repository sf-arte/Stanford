### Lecture 1で扱った内容
#### ボタンの使い方
#### @IBAction, @IBOutletの設定
@IBActionの設定はtypeを`AnyObject`から`UIxxx`に変える．
#### Optional, forced unwrap
#### if let構文
#### DoubleからStringへのキャスト
### Lecture 2で扱った内容
#### get, set, read-only
#### private
カプセル化．
#### Dictionary
#### enum, associated value
#### closure
#### stack view
#### アンカーの設定
ctrl+右ドラッグで設定する．ctrl+shift+左クリックでレイヤーになっているviewを選択できる．
### Lecture 3で扱った内容
#### Optionalの詳細，??演算子
#### Tuple
#### Range
#### Data structures
`struct`と`enum`はvalue，`class`はreference．
#### willSet, didSet
#### lazy
#### Array
`filter`, `map`, `reduce`
#### Dictionary
#### String
#### NS classes
#### Initialization
#### AnyObject
### Lecture 4で扱った内容
#### Views
#### 図形，テキストの描画
`UIBezierPath`, `UILabel`
#### フォント
#### 画像の描画
### Lecture 5で扱った内容
#### `@IBDesignable`, `@IBInspectable`
#### Gesture
`addGestureRecognizer`でコードからハンドラを設定する方法と，`@IBAction`でStoryboardから設定する方法．
#### Multiple MVCs
### Lecture 6で扱った内容
#### Segues
#### Tab Bar Controller, Split View Controller, Navigation Controller
#### View Controller Lifecycle
### Lecture 7で扱った内容
#### Memory Management
`strong`, `weak`, `unowned`
#### Closures
`[weak self]`
#### Extensions
#### Protocols
#### UIScrollView
### Lecture 8で扱った内容
#### Multithreading
dispatch queue
#### Delegate
#### Activity Indicator View
#### Viewの再利用
segueはviewを作り直してしまうので，`@IBAction`を使う．
