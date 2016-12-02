<%
function RemoveEntersAndSpaces (strToWorkWith)

	if not isnull(strToWorkWith) then
		do until(instr(strToWorkWith, vbCrLf) = 0)
			strToWorkWith = replace(strToWorkWith, vbCrLf, " ")
		loop

		dim ds 'Double Space
		ds = Space(2)
		do until(instr(strToWorkWith, ds) = 0)
			strToWorkWith = Replace(strToWorkWith, ds, " ")
		loop
		
		RemoveEntersAndSpaces = strToWorkWith
	end if
	
end function
%>