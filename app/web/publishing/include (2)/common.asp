<%

Dim adoCon 
Dim strCon
Dim strSQL
Dim rsconfiguration
Dim blnEmail ' verifica notifica email
Dim intRecordsPerPage ' numero di record per pagina
Dim emailamministratore ' indirizzo email amministratore
Dim blnCookieSet ' verifica funzione anti-spam
Dim Ublogtype ' tipologia di blog: "open" oppure "closed"
Dim Ublogname ' titolo delle pagine che ospitano Ublog
Dim MySQLSVR ' indirizzo IP oppure nome dell'host su cui risiede MySQL server
Dim MySQLPRT ' porta di MySQL (default 3306)
Dim MySQLUID ' nome utente MySQL
Dim MySQLPWD ' password MySQL
Dim MySQLDB ' nome del database MySQL
Dim MySQLOPT ' MyODBC valore opzionale
Dim StrPath  ' 'percorso fisico della cartella di upload immagini
Dim StrPathShort ' percorso virtuale della cartella di upload immagini
Dim kinkoffile ' tipo di file ammessi per l'upload
Dim maxsizefile ' dimensione massima ammessa per le immagini uploadate

'#######################################
' INIZIO MODIFICA
'#######################################

' imposta il numero di pagine che devono essere visualizzate in blocco nel menù riguardante la paginazione
PagesPerBlock=10

'parametri per la connessione al db
MySQLSVR = "xxx.xxx.xxx.xxx"
MySQLPRT = 3306
MySQLUID = "username"
MySQLPWD = "password"
MySQLDB  = "UblogMySQL"
MySQLOPT = 16386

'apertura connessione al db
Set adoCon = Server.CreateObject("ADODB.Connection")
strCon = "Driver={MySQL};server="&MySQLSVR&";port="&MySQLPRT&";uid="&MySQLUID&";pwd="&MySQLPWD&";database="&MySQLDB&";option="&MySQLOPT&""
adoCon.Open strCon

' definizione parametri upload immagini
kinkoffile = "jpg,gif,bmp,png"
maxsizefile = 50000 ' 50 kb
'Per conoscere percorso fisico della cartella di upload basta
' eseguire una pagina asp con il seguente codice: 
'Response.Write "Path: " & Server.MapPath("/public/images_upload")
StrPath = "d:\inetpub\webs\tuositocom\public\images_upload" 
StrPathShort = "/public/images_upload/"

'#######################################
' FINE MODIFICA
'#######################################

Set rsconfiguration = Server.CreateObject("ADODB.Recordset")
strSQL = "SELECT configurazione.* FROM configurazione;"

rsconfiguration.CursorType = 3
rsconfiguration.Open strSQL, adoCon
	
If NOT rsconfiguration.EOF Then 

	  Ublogname = rsconfiguration("nomeblog")
      emailamministratore = rsconfiguration("email_address")
      blnEmail = CBool(rsconfiguration("email_notify"))
      intRecordsPerPage = CInt(rsconfiguration("n_record"))
      blnCookieSet = CBool(rsconfiguration("cookie"))
      Ublogtype = rsconfiguration("tipologia")

End if
rsconfiguration.Close
Set rsconfiguration = Nothing

Function Anteprima(sText, nParole)

  Dim nTemp, nVolte

  'Eliminiamo gli eventuiali caratteri di CR ed LF
  sText = Replace(sText, vbCrLf, "")

  'Cerca la fine della prima parola
  nTemp = InStr(sText, " ")

  If nTemp <> 0 Then

     nVolte = 1
     'Finche` non abbiamo finito le parole o abbiamo 
     'raggiunto quelle massime
     While nTemp <> 0 And nVolte < nParole 

        'Incrementiamo il numero delle parole trovate
         nVolte = nVolte + 1

        'Cerchiamo la fine della parola successiva
         nTemp = InStr(nTemp + 1, sText, " ")
     Wend
  End If

  'Se abbiamo trovato qualche parola
  If nVolte > 0 Then


     'Se La variabile nTemp > 0 allora significa che 
     'abbiamo trovato le n parole che ci serivivano
     If nTemp > 0 Then

        'Le stampiamo insieme ai puntini
         Anteprima = Mid(sText, 1, nTemp - 1) & " ..."
     Else

        'Altrimenti abbiamo trovato meno delle n 
        'parole. Stampiamo la frase intera
         Anteprima = sText
     End If

  Else

     ' una sola parola
     If Len(sText) > 0 Then
         Anteprima = sText
     Else
         'La frase passata ha lunghezza 0
         Anteprima = "" 
     End If
  End If

End Function

Dim Ubloglanguage 
Ubloglanguage = Session("language") 
Select Case Ubloglanguage 
  Case "italian" 
%> 
<!--#include file="../language/language_italian.asp" --> 
<% 
  Case Else' default language 
%> 
<!--#include file="../language/language_english.asp" --> 
<% 
End Select 
%> 

