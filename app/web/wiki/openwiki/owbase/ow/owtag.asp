<%

'*********************************************************
'File: 			ow/owTag.asp
'Description:	Tags Plugins For openwiking.
'Author: 		by1mmm ( 1mmmmmm@gmail.com ) 
'Copyright:		http://
'*********************************************************
'        $Log: owtag.asp,v $
'        Revision 1.4  2007/02/04 09:47:22  piixiiees
'        Small change to improve the performance when the number of pages is very high and tags are actived.
'
'        Revision 1.3  2007/01/30 14:33:25  sansei
'        added 'inline' CVS log to the file in order to better track changes
'
'
'*********************************************************
' Settings moved to owconfig_default.asp for userfriendlyness /sEi'2007
'const cUseTags = 1  
'const cTagsSplit=1 '1=" ",split by blank.; 0=",", premise  " " in tag
'const cCacheTags=0 '1=Cache Tagsxml,update when act; 0=update only a new day
'const cTagSizeStyle=1 '1="px";0="%"
'const OPENWIKI_TagsName="tags" '//If cUseTags=1 and pPageName=OPENWIKI_TagsName then call ActionTagsIndex

gMacros = gMacros & "|TagsIndex"

Sub MacroTagsIndex()
	gMacroReturn = gMacroReturn & GetTagsXml(GetTagsArr)
         'Response.Write Server.HTMLEncode (gMacroReturn) 
         'Response.end


End Sub

Sub MacroTagsIndexP()
	gMacroReturn = gMacroReturn & GetTagsXml(GetTagsArr)
End Sub

Sub MacroTagsIndexPP()
	gMacroReturn = gMacroReturn & GetTagsXml(GetTagsArr)
End Sub

'*********************************************************
'//all Function used by "Sub ActionTagsIndex" is here

Sub ActionTagSearch ''//move it to owactions.asp ?
    Dim vXmlStr
    vXmlStr = gNamespace.GetIndexSchemes.GetTagSearch(gTxt) 
	'     //owindex.asp:GetTagSearch( 
	'     //owdb.asp:TagSearch(

         'Response.Write Server.HTMLEncode (vXmlStr) 
         'Response.end

    If cAllowRSSExport And Request("v") = "rss" Then
        Call gTransformer.TransformXmlStr(vXmlStr, "ow/skins/common/owsearchrss10export.xsl")
    Else
        Call gTransformer.Transform(vXmlStr)
    End If
    gActionReturn = True
End Sub
'*********************************************************

'*********************************************************
'//all Function used by "Sub ActionTagsIndex" is here

Sub ActionTagsIndex '//move it to owactions.asp ?

    Dim vXmlStr,vGoOnFlag
	vGoOnFlag=1

	If cCacheTags = 1 Then
		dim vDayFlag
		vDayFlag = application("TagsXmlChangeDate_By1mmm")
		If vDayFlag <> Day(Date) or isNumeric(vDayFlag) = False or vDayFlag = "" Then 'cache the date
			Application.Lock
			application("TagsXmlChangeDate_By1mmm") = Day(Date)
			Application.UnLock
			vDayFlag = 0
		End If

		If vDayFlag <> 0 and Application("TagsXml_By1mmm") <> "" Then 'do it once a day,or not admin update
				vXmlStr = Application("TagsXml_By1mmm")
				vGoOnFlag=0
		End If
	End If

	If vGoOnFlag=1 Then
		vXmlStr = GetTagsXml(GetTagsArr)
		If cCacheTags = 1 Then CacheTagsXml(vXmlStr)
	End If
 

         'Response.Write Server.HTMLEncode (vXmlStr) 
         'Response.end

    'If cAllowRSSExport And Request("v") = "rss" Then
    '    Call gTransformer.TransformXmlStr(vXmlStr, "ow/skins/common/owsearchrss10export.xsl")
    'Else
        Call gTransformer.Transform(vXmlStr)
    'End If

    gActionReturn = True
End Sub

Function CacheTagsXml(pXmlStr)

			Application.Lock
			Application("TagsXml_By1mmm") = pXmlStr
			Application.UnLock

End Function

Function GetTagsXml(pGetTagsArr)

	dim vTagsArr
	vTagsArr=pGetTagsArr

	If isArray(vTagsArr)= False Then
		GetTagsXml=""
		Exit Function
	End If

	' ~~~~~~~~~ PiiXiieeS 20070204 
	' This code is replaced for the inmediately below to improve the performance.
	'Dim vResult,u,i,inum
	'u = ubound(vTagsArr)
	'inum=0
	'For i = 1 To u
	'	if vTagsArr(i,0)<>"" then
	'		vResult = vResult & "<ow:tag name='" & vTagsArr(i,0) & "' count='" & vTagsArr(0,i) & "' size='" & GetTagSize(vTagsArr(0,i)) & "'/>"
	'		inum=inum+1
	'	end if
	'Next
	'GetTagsXml = "<ow:tagsindex num='" & inum & "'>" & vResult & "</ow:tagsindex>"

    ' New code improved
    Dim vResult,u,i,inum
    u = ubound(vTagsArr,2)
    For i = 0 To u
        if vTagsArr(0,i)<>"" then
            vResult = vResult & "<ow:tag name='" & vTagsArr(0,i) & "' count='" & vTagsArr(1,i) & "' size='" & GetTagSize(vTagsArr(1,i)) & "'/>"
        end if
    Next
    GetTagsXml = "<ow:tagsindex num='" & u & "'>" & vResult & "</ow:tagsindex>"
	' ~~~~~~~~~ PiiXiieeS 20070204 

End Function

Function GetTagSize(pCount) 'GetTagSize(vTagsArr(0,i))

	dim iFont,iFontSize

	iFont=pCount Mod 100

	if cTagSizeStyle=1 then '1="px";0="%"
		If iFont=0 Then iFontSize=10
		If iFont>-1 And iFont<40 Then iFontSize=12 + iFont
		If iFont >40 Then iFontSize=42
		GetTagSize=iFontSize&"px"
	else
		If iFont=0 Then iFontSize=90
		If iFont>-1 And iFont<100 Then iFontSize=100 + iFont
		If iFont >200 Then iFontSize=200
		'iFontSize=180
		GetTagSize=iFontSize&"%"
	end if
	'<xsl:attribute name="style">font-size:<xsl:value-of select="@size"/>;line-height:0.9em</xsl:attribute>
End Function

Function GetTagsArr() '//move it to owdb.asp ?
		   dim  BeginTimer,EndTimer  'for test
           BeginTimer  =  Timer()    'for test

	dim vTags
'====
	Dim vConn,vRs,vQuery
	Set vConn = Server.CreateObject("ADODB.Connection")
	vConn.Open OPENWIKI_DB
	Set vRS = Server.CreateObject("ADODB.Recordset")
'======
	vQuery = "SELECT wrv_tag FROM openwiki_revisions WHERE wrv_current = 1"
	
	vRS.Open vQuery, vConn, adOpenForwardOnly
	Do While Not vRS.EOF
				vTags = vTags&Trim(vRS("wrv_tag"))
		vRS.MoveNext
	Loop
	vRS.Close
'========
	vConn.Close()
	Set vRs = Nothing
	Set vConn = Nothing
'======
			'//for test  
			'vTags="{aaa}{bbb}{ccc}{aaa}{aaa}{bbb}{a}{b}{c}{a}{b}{a}"
			'vTags=vTags&vTags
			'vTags=""

	If vTags="" Then Exit Function

	dim vTagsArr(),u
	dim  A,S,i,aaa

	A = mid(vTags,2,len(vTags)-2) 
	A = split(A,"}{")  
	u=ubound(A)+1
	
	' ~~~~~~~~~ PiiXiieeS 20070204 
	' This code is replaced for the inmediately below to improve the performance.
	'redim vTagsArr(u,u)
	'S = ""
	'i=0
	'for  each  aaa  in  A 
	'	if aaa<>"" and instr(S,"{" & aaa & "}") < 1 then
	'		i=i+1
	'		S = S & "{" & aaa & "}"
	'		vTagsArr(i,0) = aaa
	'		vTagsArr(0,i) = Ubound(split(vTags,"{"&aaa&"}"))
	'	end if					
	'next  
    
    ' New code improved
    redim vTagsArr(1,u)
    S = ""
    i=0
    for each aaa in A
        if aaa<>"" and instr(S,"{" & aaa & "}") < 1 then
            S = S & "{" & aaa & "}"
            vTagsArr(0,i) = aaa
            vTagsArr(1,i) = Ubound(split(vTags,"{"&aaa&"}"))
            i=i+1
            end if
    next 
	' ~~~~~~~~~ PiiXiieeS 20070204 


	GetTagsArr=vTagsArr

				if 1=0 then 'for test
					endTimer  =  Timer()
					Response.Write "<br/>i="  & i &  "in u="  & u &  ""  
					Response.Write "<br/>time:"  &  (endTimer  -  BeginTimer)  *  1000    &  "ms<br/>"  
					Response.END 
				end if
End Function
'*********************************************************

'*********************************************************
Function Xmltags(strTag)
'        // Used in owpage.asp:Function ToXML()
'        //If cUseTags = 1 and vTag <> "" then ToXML = ToXML & Xmltags(vTag)
	Dim vResult

	Dim s
	Dim t
	Dim i

	s=strTag
	s=Replace(s,"}","")
	t=Split(s,"{")
	if cTagsSplit=1 then s=Trim(Join(t)) & " "
	if cTagsSplit=0 then s=Trim(Join(t)) & ","
	If s=" " Then s=""

	vResult="<ow:tags tags=""" & PCDATAEncode(Trim(s)) & """>"

		For i=LBound(t) To UBound(t)
			If t(i)<>"" Then
					vResult=vResult & "<ow:tag name=""" & PCDATAEncode(t(i)) & """/>"
			End If
		Next

	vResult = vResult & "</ow:tags>"	

	Xmltags=vResult

End Function

Function getpostTag(strTag)
'        // Used in owdb.asp:Function SavePage(...)
'        //If cUseTags = 1 then  vRS("wrv_tag") = getpostTag(Request.Form("edtTag"))

	Dim s
	Dim t
	Dim i
	Dim objTag

	strTag=Trim(strTag)
	strTag=Replace(strTag,"{","")
	strTag=Replace(strTag,"}","")
	strTag=Replace(strTag,"<","")
	strTag=Replace(strTag,">","")
	strTag=Replace(strTag,"&","")

if cTagsSplit=1 then
	strTag=Replace(strTag,",","")
	'strTag=TransferHTML(strTag)
	t=Split(strTag," ")

	For i=LBound(t) To UBound(t)
		If t(i)<>"" Then
			t(i)="{"&t(i)&"}" 
			If instr(s,t(i)) < 1 then s=s & t(i)
		end if
	Next

	s=Replace(s," ","")
else
	t=Split(strTag,",")
	For i=LBound(t) To UBound(t)
		If t(i)<>"" Then t(i)="{"&t(i)&"}" 
	Next
	s=Join(t)
end if

	getpostTag=s

End Function
'*********************************************************

%>