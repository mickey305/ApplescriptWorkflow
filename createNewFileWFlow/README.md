creatNewFileWFlow
=======
Finderの右クリック（副ボタン）で新規フォルダは作成できるけれど、新規ファイルの作成ができなかったのでワークフローを作ってみた。  
* ディレクトリ`subRoutine`内の`divFileStrExt.app`をデスクトップにコピペする
* ディレクトリ`src`内の`main.applescript`の内容の**以下の部分を修正**する  
`property fDivPath : `以降のパス指定を上記の関数プログラム`divFileStrExt.app`を置いた箇所までの絶対パスで記述する  
デスクトップ上に置いた場合は、◯の部分のみだけ修正する  
```ruby
property defaultFileName : "名称未設定"
property defaultExt : ".txt"
-- 拡張子切り出しプログラムの保存場所を変更した場合はこのパスも変更する
property fDivPath : "Macintosh HD:Users:◯◯◯◯◯:Desktop:divFileStrExt.app"
-- プログラム最大走行時間(s) -- 超えるとプロセスが無効化される
property FinTime : 2 * 60
```