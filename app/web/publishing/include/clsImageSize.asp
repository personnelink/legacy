<%
'******************************************************************
' Classe ImageSize
'   Data una immagine restituisce le dimensioni X,Y e numero di
'   colori
'
'   Proprietà:
'     ImageFile = path fisico completo dell'immagine
'     ImageName = restituisce il nome del file
'     ImageType = restituisce il tipo di immagine
'     ImageWidth = restituisce la larghezza in pixel dell'immagine
'     ImageHeight = restituisce l'altezza in pixel dell'immagine
'     ImageDepth = restituisce il numero di colori dell'immagine
'     IsImage = restituisce TRUE se il file è una immagine
'
' Author:
' 2002 Luciani Massimiliano
' http://www.byluciani.com
' webmaster@byluciani.com
'
' Original code:
' http://www.4guysfromrolla.com/webtech/011201-1.shtml
' Author: Mike Shaffer - mshaffer@nkn.net
'
' This script is FREEWARE
'******************************************************************

Class ImageSize

  Public Dimensioni(2)
  Public bolIsImage, strPathFile, strImageType
  
  Private Sub Class_Initialize()

  End Sub
  
  Private Sub Class_Terminate()

  End Sub

  Public Property Get ImageName
  	ImageName = doName(ImageFile)
  End Property
  
  Public Property Get ImageFile
  	ImageFile = strPathFile
  End Property
  
  Public Property Let ImageFile(strImageFile)
  	strPathFile = strImageFile
  	gfxSpex(strPathFile)
  End Property
  
  Public Property Get ImageWidth
  	ImageWidth = Dimensioni(1)
  End Property
  
  Public Property Get ImageHeight
  	ImageHeight = Dimensioni(0)
  End Property
  
  Public Property Get ImageDepth
  	ImageDepth = Dimensioni(2)
  End Property 
  
  Public Property Get ImageType
  	ImageType = strImageType
  End Property      
  
  Public Property Get IsImage
  	IsImage = bolIsImage
  End Property     

  Public Function GetBytes(flnm, offset, bytes)
    Dim objFSO
    Dim objFTemp
    Dim objTextStream
    Dim lngSize
    
    on error resume next
    
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    
    ' First, we get the filesize
    Set objFTemp = objFSO.GetFile(flnm)
    lngSize = objFTemp.Size
    set objFTemp = nothing
    
    fsoForReading = 1
    Set objTextStream = objFSO.OpenTextFile(flnm, fsoForReading)
    
    if offset > 0 then
      strBuff = objTextStream.Read(offset - 1)
    end if
    
    if bytes = -1 then		' Get All!
    
      GetBytes = objTextStream.Read(lngSize)  'ReadAll
    
    else
    
      GetBytes = objTextStream.Read(bytes)
    
    end if
    
    objTextStream.Close
    set objTextStream = nothing
    set objFSO = nothing
  end function

  Public function lngConvert(strTemp)
    lngConvert = clng(asc(left(strTemp, 1)) + ((asc(right(strTemp, 1)) * 256)))
  end function

  Public function lngConvert2(strTemp)
    lngConvert2 = clng(asc(right(strTemp, 1)) + ((asc(left(strTemp, 1)) * 256)))
  end function
  
  Public Sub gfxSpex(flnm)

     dim strPNG 
     dim strGIF
     dim strBMP
     dim strType
     strType = ""
     strImageType = "(unknown)"

     bolIsImage = False

     strPNG = chr(137) & chr(80) & chr(78)
     strGIF = "GIF"
     strBMP = chr(66) & chr(77)

     strType = GetBytes(flnm, 0, 3)

     if strType = strGIF then				' is GIF

        strImageType = "GIF"
        lngWidth = lngConvert(GetBytes(flnm, 7, 2))
        lngHeight = lngConvert(GetBytes(flnm, 9, 2))
        lngDepth = 2 ^ ((asc(GetBytes(flnm, 11, 1)) and 7) + 1)
        bolIsImage = True

     elseif left(strType, 2) = strBMP then		' is BMP

        strImageType = "BMP"
        lngWidth = lngConvert(GetBytes(flnm, 19, 2))
        lngHeight = lngConvert(GetBytes(flnm, 23, 2))
        lngDepth = 2 ^ (asc(GetBytes(flnm, 29, 1)))
        bolIsImage = True

     elseif strType = strPNG then			' Is PNG

        strImageType = "PNG"
        lngWidth = lngConvert2(GetBytes(flnm, 19, 2))
        lngHeight = lngConvert2(GetBytes(flnm, 23, 2))
        lngDepth = getBytes(flnm, 25, 2)

        select case asc(right(lngDepth,1))
           case 0
              lngDepth = 2 ^ (asc(left(lngDepth, 1)))
              bolIsImage = True
           case 2
              lngDepth = 2 ^ (asc(left(lngDepth, 1)) * 3)
              bolIsImage = True
           case 3
              lngDepth = 2 ^ (asc(left(lngDepth, 1)))  '8
              bolIsImage = True
           case 4
              lngDepth = 2 ^ (asc(left(lngDepth, 1)) * 2)
              bolIsImage = True
           case 6
              lngDepth = 2 ^ (asc(left(lngDepth, 1)) * 4)
              bolIsImage = True
           case else
              lngDepth = -1
        end select
 
     else
 
        strBuff = GetBytes(flnm, 0, -1)		' Get all bytes from file
        lngSize = len(strBuff)
        flgFound = 0

        strTarget = chr(255) & chr(216) & chr(255)
        flgFound = instr(strBuff, strTarget)

        if flgFound = 0 then
           exit sub
        end if
 
        strImageType = "JPG"
        lngPos = flgFound + 2
        ExitLoop = false
 
        do while ExitLoop = False and lngPos < lngSize
 
           do while asc(mid(strBuff, lngPos, 1)) = 255 and lngPos < lngSize
              lngPos = lngPos + 1
           loop
 
           if asc(mid(strBuff, lngPos, 1)) < 192 or asc(mid(strBuff, lngPos, 1)) > 195 then
              lngMarkerSize = lngConvert2(mid(strBuff, lngPos + 1, 2))
              lngPos = lngPos + lngMarkerSize  + 1
           else
              ExitLoop = True
           end if
 
       loop
 
       if ExitLoop = False then
 
          lngWidth = -1
          lngHeight = -1
          lngDepth = -1
 
       else
 
          lngHeight = lngConvert2(mid(strBuff, lngPos + 4, 2))
          lngWidth = lngConvert2(mid(strBuff, lngPos + 6, 2))
          lngDepth = 2 ^ (asc(mid(strBuff, lngPos + 8, 1)) * 8)
          bolIsImage = True
 
       end if
                   
     end if

     Dimensioni(0) = lngHeight
     Dimensioni(1) = lngWidth
     Dimensioni(2) = lngDepth
  end Sub  

  Public Function doName(strPath)
    Dim arrSplit
    arrSplit = Split(strPath, "\")
    doName = arrSplit(UBound(arrSplit))
  End Function
  
End Class

Function IsImage(strImageName)
  Set objImageSize = New ImageSize
  With objImageSize
    .ImageFile = Server.MapPath(strImageName)
    If .IsImage Then
      IsImage = True
    Else
      IsImage = False
    End If  
  End With
  Set objImageSize = Nothing
End Function
%> 