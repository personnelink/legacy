<%
n=1
While n < 10
   If request.form("matha" & n) = "" Then
   Else  matha = matha & request.form("matha" & n) & ","
   End IF
   n = n + 1
Wend

n=1
While n < 6
   If request.form("mathb" & n) = "" Then
   Else mathb = mathb & request.form("mathb" & n) & ","
   End If
   n = n + 1
Wend

n=1
While n < 11
   If request.form("alpha" & n) = "" Then
   Else  alpha = alpha & request.form("alpha" & n) & ","
   End If
   n = n + 1
Wend

rulera = Request.Form("ruleraa")  & "," & Request.Form("rulerab") & "," & Request.Form("rulerac")

n=1
While n < 58
   If request.form("rulerb" & n) = "" Then
   Else rulerb = rulerb & request.form("rulerb" & n) & ","
   End If
   n = n + 1
Wend

n=1
While n < 11
   If request.form("comparisona" & n) = "" Then
   Else comparisona = comparisona & request.form("comparisona" & n) & ","
   End If
   n = n + 1
Wend

n=1
While n < 21
   If request.form("comparisonb" & n) = "" Then
   Else comparisonb = comparisonb & request.form("comparisonb" & n) & ","
   End If
   n = n + 1
Wend

n=1
While n < 41
   If request.form("spelling" & n) = "" Then
   Else spelling = spelling & request.form("spelling" & n) & ","
   End IF
   n = n + 1
Wend
%>
Printing:<br>
matha:<%= matha %><br>
<br>
mathb:<%= mathb %><br>
<br>
alpha:<%= alpha %><br>
<br>
rulera:<%= rulera %><br>
<br>
rulerb:<%= rulerb %><br>
<br>
comparisona:<%= comparisona %><br>
<br>
comparisonb:<%= comparisonb %><br>
<br>
spelling:<%= spelling %><br>
<br>

<%
' DB Fields:
'   matha,mathb,alpha,rulera,rulerb,comparisona,comparisonb,spelling

 sql = "insert into dbtable (matha,mathb,alpha,rulera,rulerb,comparisona,comparisonb,spelling) Values ('" & matha & "','" & mathb & "','" & alpha & "','" & rulera & "','" & rulerb & "','" & comparisona & "','" & comparisonb & "','" & spelling & "')"

%>