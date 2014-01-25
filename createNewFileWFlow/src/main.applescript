property defaultFileName : "名称未設定"
property defaultExt : ".txt"

-- 拡張子切り出しプログラムの保存場所を変更した場合はこのパスも変更する
property fDivPath : "Macintosh HD:Users:◯◯◯◯◯:Desktop:divFileStrExt.app"

-- プログラム最大走行時間(s) -- 超えるとプロセスが無効化される
property FinTime : 2 * 60


on run {input, parameters}
	
	-- 指定時間が経過するとこの部分のプログラムを抜ける
	with timeout of FinTime seconds
		
		-- setting path
		try
			tell application "Finder" to set the sourceFolder to (folder of the front window) as alias
		on error
			-- no open folder windows
			set the sourceFolder to path to desktop folder as alias
		end try
		
		
		-- setting parameters
		set flagFileExists to true
		set indexFile to ""
		set indexPoint to " "
		set addInfoPGraph to ""
		--set addInfoPGraph to return & return & "次のような形式のファイルの作成はできません。" & return & "  -  .htpasswdのような隠しファイル" & return & "  -  拡張子の存在しないファイル" & return & "  ただし、このワークフロー中の拡張子をつけないとコメントされている行を有効にすると拡張子が取り除かれる"
		set DLogInfo to "新規ファイル名を入力 (有効時間 " & FinTime / 60 & "分)" & addInfoPGraph
		set directoryInfo to "ファイル作成場所 : " & return & sourceFolder
		set Btn1 to "キャンセル"
		set Btn2 to "作成"
		
		
		
		
		
		try
			
			
			tell me
				activate
				set InfoDialog to (display dialog DLogInfo & return & return & directoryInfo default answer "" & defaultFileName & defaultExt buttons {Btn1, Btn2} default button 2 giving up after FinTime)
				set newFileName to text returned of InfoDialog
				set dialog_info to button returned of InfoDialog
			end tell
			
			-- 入力されたパラメータをdivFileStrExt関数に渡す
			set newExtend to run script file fDivPath with parameters {newFileName, 1} in "AppleScript"
			set newFileName to run script file fDivPath with parameters {newFileName, 0} in "AppleScript"
			-- 入力されたファイル名と拡張子
			--display alert "file name is ( " & newFileName & " )" & return & "filename extension is ( " & newExtend & " )"
			
			
			
			
			-- 重複するファイルが存在すればファイル名のインデックスを+1する
			-- ただし、インデックスが1の場合はインデックスが省略される
			repeat while flagFileExists
				set indexFile to (indexFile + 1)
				tell application "Finder"
					if indexFile is 1 then
						set flagFileExists to (exists file (newFileName & newExtend) in sourceFolder)
					else
						set flagFileExists to (exists file (newFileName & indexPoint & indexFile & newExtend) in sourceFolder)
					end if
				end tell
			end repeat
			
			
			-- ファイル名が重複する場合
			if indexFile is not 1 then
				set DlogInfo2 to "このファイル名は既に存在します。次のファイル名で作成しますか？ (有効時間 " & FinTime / 60 & "分)"
				
				set dialog_info to button returned of (display dialog DlogInfo2 & return & return & "変更前 :" & tab & newFileName & newExtend & return & "変更後 :" & tab & newFileName & indexPoint & indexFile & newExtend buttons {Btn1, Btn2} default button 2 giving up after FinTime)
				set newFileName to (newFileName & indexPoint & indexFile)
				
				
				
			end if
			
			
			
			
			
			
			
			if newFileName is not equal to "" & defaultFileName & indexFile then
				set defaultFileName to newFileName
			end if
			
			
			
			-- 新規ファイル情報をマージする
			set newFile to "" & sourceFolder & newFileName & newExtend --拡張子を付ける
			--set newFile to "" & sourceFolder & newFileName --拡張子を付けない
			
			
			
			
			
			-- "作成"ボタンが押された場合
			if dialog_info is "作成" then
				-- create new file
				if not flagFileExists then
					set touchScript to "touch " & quoted form of (POSIX path of newFile)
					do shell script touchScript
					--このコメントを外すとアプリを起動
					--set openScript to "open " & quoted form of (POSIX path of newFile)
					--do shell script openScript
				else
					display dialog "file already exists"
				end if
			end if
			
			
		end try
		
		
	end timeout
	
	
	return input
end run