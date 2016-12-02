<%
session("required_user_level") = 1024 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%
dim working_path, file_name
	working_path = "\\personnelplus.net\net_docs\payments\received\"
	file_name = "test_name_" & file_was_created() & ".txt"

Set fso = CreateObject("Scripting.FileSystemObject")

dim ppd_file_data(12)

const record_type 	= 0 'Record Type. This is a Standard Field. Use “1”. 
const priority_code	= 1 'Priority Code. Use “1”.
const idestination 	= 2 'Immediate Destination. Use “124000054” (Zions Bank’s Routing & Transit Number preceded by a space).
const i_origin		= 3	'Immediate Origin. Usually the Tax ID Number preceded by a “1”. 
const file_created	= 4 'Transmission/File Date. Date file was created. Use YYMMDD format.
const file_time 	= 5 'Transmission/File Time. Time file was created. Use HHMM format.
const fileid	 	= 6 'File ID modifier. Use “A”.
const record_size 	= 7 'Record Size. Block at 94 characters. Use “094”.
const block_factor 	= 8 'Blocking Factor. Use “10”.
const format_code	= 9 'Format Code. Use “1”
const desti_name	= 10 'Destination ACH (NAME).  Use “ZIONS BANK”.
const origin_name	= 11 'Origin ACH (NAME). Originating Company Name.
const reference_code= 12 'Reference Code. Leave blank, this is assigned when the file is run.

ppd_file_data(record_type) 	= "1"
ppd_file_data(priority_code)= "01"
ppd_file_data(idestination)	= "124000054"
ppd_file_data(i_origin)		= "1841370996"
ppd_file_data(file_created)	= file_was_created()
ppd_file_data(file_time) 	= and_the_time()
ppd_file_data(fileid)	 	= "A"
ppd_file_data(record_size) 	= "094"
ppd_file_data(block_factor)	= "10"
ppd_file_data(format_code)	= "1"
ppd_file_data(desti_name)	= "ZIONS BANK" & Space(23 - Len("ZIONS BANK"))
ppd_file_data(origin_name)	= "ORIGIN COMPANY NAME" & Space(23 - Len("ORIGIN COMPANY NAME"))
ppd_file_data(reference_code)= Space(8)

'assemble the final file
dim final_file
for i = 0 to 12
	final_file = final_file & ppd_file_data(i)
next

set nacha_file = fso.CreateTextFile(working_path & file_name)
	nacha_file.write final_file
	nacha_file.close
	
set nacha_file = nothing
set fso = nothing


function file_was_created()
	dim this_month, this_day, this_year

	this_day = Day(Date)
	if len(this_day) = 1 then
		this_day = "0" & this_day
	end if
	
	this_month = Month(Date)
	if len(this_month) = 1 then
		this_month = "0" & this_month
	end if
	this_year = right(Year(Date), 2)

	file_was_created = this_year & this_month & this_day
end function

function and_the_time()
	and_the_time = left(FormatDateTime(now, 4), 2) & right(FormatDateTime(now, 4), 2)
end function
%>


