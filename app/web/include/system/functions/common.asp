<%
const field_name = 0, field_label = 1, field_value = 2, field_tindex = 3

function make_input(this_item, visible_label, init_value, tab_index, wrap_with)
	if len(wrap_with) = 0 then
		make_input = "<label for=""" & this_item & """>" & visible_label & "</label>" &_
			"<input type=""text"" name=""" & this_item & """ size=""25"" value=""" & init_value & """ tabindex=""" & tab_index & """>"
	else
		make_input = "<" & wrap_with & "><label for=""" & this_item & """>" & visible_label & "</label>" &_
			"<input type=""text"" name=""" & this_item & """ size=""25"" value=""" & init_value & """ tabindex=""" & tab_index & """></"& wrap_with & ">"
	end if
end function

function make_inputs(input_array)
	dim i, str
	for i = 0 to ubound(input_array)
		str = str & make_input(input_array(i, f_name), input_array(i, f_label), input_array(i, f_value), input_array(i, f_tindex), f_wrap)
	next
	make_inputs = str
end function

function topPageRecords ()

end function

function bottomPageRecords (nPageCount, oldQueryString)
	dim strTempVal
	strTempVal = "</div><div id=""bottomPageRecords"" class=""navPageRecords"">" &_
				 "<A HREF=""/include/system/tools/search/?Page=1&" & oldQueryString & """>First</A>"
				 
	dim i
	For i = 1 to nPageCount
		strTempVal = strTempVal & "<A HREF=""/include/system/tools/search/?Page="& i & "&" & oldQueryString & """>&nbsp;"
		if i = nPage then
			strTempVal = strTempVal & "<span style=""color:red"">" & i & "</span>"
		Else
			strTempVal = strTempVal & i
		end if
		strTempVal = strTempVal & "&nbsp;</A>"
	Next
	
	strTempVal = strTempVal &_
	"<A HREF=""/include/system/tools/search/?Page=" & nPageCount & "&" & oldQueryString & """>Last</A>" &_
	"</div>"
	
	bottomPageRecords = strTempVal
	
end function

%>
