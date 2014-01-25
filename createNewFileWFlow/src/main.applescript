property defaultFileName : "���̖��ݒ�"
property defaultExt : ".txt"

-- �g���q�؂�o���v���O�����̕ۑ��ꏊ��ύX�����ꍇ�͂��̃p�X���ύX����
property fDivPath : "Macintosh HD:Users:����������:Desktop:divFileStrExt.app"

-- �v���O�����ő呖�s����(s) -- ������ƃv���Z�X�������������
property FinTime : 2 * 60


on run {input, parameters}
	
	-- �w�莞�Ԃ��o�߂���Ƃ��̕����̃v���O�����𔲂���
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
		--set addInfoPGraph to return & return & "���̂悤�Ȍ`���̃t�@�C���̍쐬�͂ł��܂���B" & return & "  -  .htpasswd�̂悤�ȉB���t�@�C��" & return & "  -  �g���q�̑��݂��Ȃ��t�@�C��" & return & "  �������A���̃��[�N�t���[���̊g���q�����Ȃ��ƃR�����g����Ă���s��L���ɂ���Ɗg���q����菜�����"
		set DLogInfo to "�V�K�t�@�C��������� (�L������ " & FinTime / 60 & "��)" & addInfoPGraph
		set directoryInfo to "�t�@�C���쐬�ꏊ : " & return & sourceFolder
		set Btn1 to "�L�����Z��"
		set Btn2 to "�쐬"
		
		
		
		
		
		try
			
			
			tell me
				activate
				set InfoDialog to (display dialog DLogInfo & return & return & directoryInfo default answer "" & defaultFileName & defaultExt buttons {Btn1, Btn2} default button 2 giving up after FinTime)
				set newFileName to text returned of InfoDialog
				set dialog_info to button returned of InfoDialog
			end tell
			
			-- ���͂��ꂽ�p�����[�^��divFileStrExt�֐��ɓn��
			set newExtend to run script file fDivPath with parameters {newFileName, 1} in "AppleScript"
			set newFileName to run script file fDivPath with parameters {newFileName, 0} in "AppleScript"
			-- ���͂��ꂽ�t�@�C�����Ɗg���q
			--display alert "file name is ( " & newFileName & " )" & return & "filename extension is ( " & newExtend & " )"
			
			
			
			
			-- �d������t�@�C�������݂���΃t�@�C�����̃C���f�b�N�X��+1����
			-- �������A�C���f�b�N�X��1�̏ꍇ�̓C���f�b�N�X���ȗ������
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
					set touchScript to "touch " & quoted form of (POSIX path of newFile)
					do shell script touchScript
					--���̃R�����g���O���ƃA�v�����N��
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