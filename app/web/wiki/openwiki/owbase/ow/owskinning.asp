<%
Dim NameArray(10)
'        // SKIN NAMES SHIPPED WITH OWNG
NameArray(0)="default"
NameArray(1)="default_left"
NameArray(2)="evolution"
NameArray(3)=""
NameArray(4)="" '"plastic"
NameArray(5)="" '"myrthful"
NameArray(6)="" '"default_css"
NameArray(7)="" '"graphical"
NameArray(8)="" '"blog"
NameArray(9)=""

Function GetSkinCSS()
        If OPENWIKI_ACTIVESKIN = "" Then
                GetSkinCSS = "ow/skins/default/ow.css"
        Else
                If NOT gTransformer.SkinExists then OPENWIKI_ACTIVESKIN="default"
                GetSkinCSS = "ow/skins/" & OPENWIKI_ACTIVESKIN & "/ow.css"
        End If
End Function

Function GetSkinDir()
        If OPENWIKI_ACTIVESKIN = "" Then
                GetSkinDir = "ow/skins/default"
        Else
                If NOT gTransformer.SkinExists then OPENWIKI_ACTIVESKIN="default"
                GetSkinDir = "ow/skins/" & OPENWIKI_ACTIVESKIN
        End If
End Function

Function GetSkinnames()
'        // Used in owdb to populate <ow:wiki/ow:availableskins/ow:skinname
Dim Result,ct
Result=""
        For ct=0 to UBound(NameArray)
                if NameArray(ct) <> "" then
                        Result=Result & "<ow:skin name=""" & NameArray(ct) & """></ow:skin>"
                end if
        next
GetSkinnames=Result
End Function

%>