(*

���͕ϐ� source : �g���q��؂�o���t�@�C��
���͕ϐ� pulse : �o�͒l��ύX���邽�߂̐M��
	
pluse�̐��l���O�̏ꍇ��source�̃t�@�C�����i�g���q�Ȃ��j���o��
pluse�̐��l���P�̏ꍇ��source�̊g���q�i.html/.txt/.c  et cetera�j���o��


*)


-- created by K.Misaki


-- ���C�����[�`��
----���W���[�������x�F���䌋���i�����Fpulse�j
on run {source, pulse}
	try
		set fLength to length of source
		--�t���e�L�X�g���쐬
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
