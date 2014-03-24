(*

入力変数 source : 拡張子を切り出すファイル
入力変数 pulse : 出力値を変更するための信号
	
pluseの数値が０の場合はsourceのファイル名（拡張子なし）を出力
pluseの数値が１の場合はsourceの拡張子（.html/.txt/.c  et cetera）を出力


*)


-- created by K.Misaki


-- メインルーチン
----モジュール結合度：制御結合（引数：pulse）
on run {source, pulse}
	try
		set fLength to length of source
		--逆順テキストを作成
		set fChar to characters of source
		set revText to (reverse of fChar) as string
		set revDot to "."
		set anOffset to offset of revDot in revText
		
		if pulse is 1 then -- filename extension
			set fRespns to text (fLength - anOffset + 1) thru -1 of source
			return fRespns
			
		else if pulse is 0 then -- file name
			set fRespns to text 1 thru (fLength - anOffset) of source
			return fRespns
			
		end if
		
		
	on error
		--display alert return & "Error"
		return ""
	end try
end run

(*
set s to "sample_int.php"
set str to function(s, 0)
set ext to function(s, 1)
set er to function(s, 2)
display alert str & return & ext & return & er
*)
