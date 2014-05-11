property defaultFileName : "���̖��ݒ�"
property defaultExt : ".txt"

-- �z�[���f�B���N�g���̃p�X
property HomePath : "Macintosh HD:Users:��������:"

-- �g���q�؂�o���v���O�����̕ۑ��ꏊ��ύX�����ꍇ�͂��̃p�X���ύX����
property fDivPath : "Macintosh HD:Users:��������:Desktop:divFileStrExt.app"

-- �ő�A�C�h������(s) -- ������ƃv���Z�X�������������
-- �f�t�H���g�F2��
property FinTime : 2 * 60


on run {input, parameters}
	
	-- �w��A�C�h�����Ԃ��o�߂���Ƃ��̕����̃v���O�����𔲂���
	with timeout of FinTime seconds
		
		
		
		-- setting path & parameters
		try
			tell application "Finder"
				set the sourceFolder to (folder of the front window) as alias
			end tell
			set finder_window_flag to true
		on error
			-- no open folder windows
			set the sourceFolder to path to desktop folder as alias
			set finder_window_flag to false
		end try
		set flagFileExists to true
		set indexFile to ""
		set indexPoint to " "
		set addInfoPGraph to ""
		--set addInfoPGraph to return & return & "���̂悤�Ȍ`���̃t�@�C���̍쐬�͂ł��܂���B" & return & "  -  .htpasswd�̂悤�ȉB���t�@�C��" & return & "  -  �g���q�̑��݂��Ȃ��t�@�C��" & return & "  �������A���̃��[�N�t���[���̊g���q�����Ȃ��ƃR�����g����Ă���s��L���ɂ���Ɗg���q����菜�����"
		set DLogInfo to "�V�K�t�@�C��������� (�L������ " & FinTime / 60 & "��)" & addInfoPGraph
		set directoryInfo to "�t�@�C���쐬�ꏊ : " & return & POSIX path of sourceFolder
		---------- button definition ----------
		set Btn1 to "�L�����Z��"
		set Btn2 to "�쐬"
		set BtnMore to "�쐬�ꏊ��ύX"
		----------------------------------------
		set chgpathmsg to "�t�@�C�����쐬����t�H���_���w�肵�ĉ�����"
		set fstloop_flag to true
		set newFileName to defaultFileName & defaultExt
		
		
		
		
		try
			
			
			repeat while fstloop_flag
				
				
				tell me
					activate
					set InfoDialog to (display dialog DLogInfo & return & return & directoryInfo default answer "" & newFileName buttons {Btn1, BtnMore, Btn2} default button 3 giving up after FinTime)
					set newFileName to text returned of InfoDialog
					set dialog_info to button returned of InfoDialog
				end tell
				
				set fstloop_flag to false
				
				if dialog_info is "�쐬�ꏊ��ύX" then
					try
						set sourceFolder to choose folder with prompt chgpathmsg
						set directoryInfo to "�t�@�C���쐬�ꏊ : " & return & POSIX path of sourceFolder
					end try
					set fstloop_flag to true
				end if
				
				
			end repeat
			
			
			
			
			-- ���͂��ꂽ�p�����[�^��divFileStrExt�֐��ɓn��
			set newExtend to run script file fDivPath with parameters {newFileName, 1} in "AppleScript"
			set newFileName to run script file fDivPath with parameters {newFileName, 0} in "AppleScript"
			-- ���͂��ꂽ�t�@�C�����Ɗg���q
			--display alert "file name is ( " & newFileName & " )" & return & "filename extension is ( " & newExtend & " )"
			
			
			
			
			-- �d������t�@�C�������݂���΃t�@�C�����̃C���f�b�N�X��+1����
			-- �������A�C���f�b�N�X��1�̏ꍇ�̓t�@�C���쐬���ɃC���f�b�N�X���ȗ������
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
			
			
			-- �t�@�C�������d������ꍇ
			if indexFile is not 1 then
				set DlogInfo2 to "���̃t�@�C�����͊��ɑ��݂��܂��B���̃t�@�C�����ō쐬���܂����H (�L������ " & FinTime / 60 & "��)"
				
				set dialog_info to button returned of (display dialog DlogInfo2 & return & return & "�ύX�O :" & tab & newFileName & newExtend & return & "�ύX�� :" & tab & newFileName & indexPoint & indexFile & newExtend buttons {Btn1, Btn2} default button 2 giving up after FinTime)
				set newFileName to (newFileName & indexPoint & indexFile)
				
				
				
			end if
			
			
			
			
			
			
			
			if newFileName is not equal to "" & defaultFileName & indexFile then
				set defaultFileName to newFileName
			end if
			
			
			
			-- �V�K�t�@�C�������}�[�W����
			set newFile to "" & sourceFolder & newFileName & newExtend --�g���q��t����
			--set newFile to "" & sourceFolder & newFileName --�g���q��t���Ȃ�
			
			
			
			
			-- "�쐬"�{�^���������ꂽ�ꍇ
			if dialog_info is "�쐬" then
				-- create new file
				if not flagFileExists then
					--display dialog newFile & return & HomePath
					if newFile begins with HomePath then
						set touchScript to "touch " & quoted form of (POSIX path of newFile)
						do shell script touchScript
						
						--���̃R�����g���O���ƃA�v�����N��
						--set openScript to "open " & quoted form of (POSIX path of newFile)
						--do shell script openScript
						
					else
						set touchScriptAdmin to "touch " & quoted form of (POSIX path of newFile)
						do shell script touchScriptAdmin password "" with administrator privileges
						
						--���̃R�����g���O���ƃA�v�����N��
						--set openScriptAdmin to "open " & quoted form of (POSIX path of newFile)
						--do shell script openScriptAdmin password "" with administrator privileges
						
					end if
				else
					display dialog "file already exists"
				end if
			end if
			
			
			
		end try
		
		
		-- Finder���őO�Ɉړ�
		-- �쐬����t�H���_�̃p�X��ύX�����ꍇ�́A�V����Finder�̃E�B���h�E���J��
		if finder_window_flag then
			tell application "Finder"
				activate
				-- �쐬�����t�@�C��������ΑI��
				try
					select file newFile
				end try
			end tell
			--else
			
		end if
		
		
		
		
	end timeout
	
	
	return input
end run