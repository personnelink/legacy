<%  
    oldDB = Server.MapPath("/accessTest.mdb") 
    bakDB = Server.MapPath("/accessTestBack.mdb") 
    newDB = Server.MapPath("/accessCompact.mdb") 
 
    Set FSO = CreateObject("Scripting.FileSystemObject") 
 
    ' back up database 
 
    FSO.CopyFile oldDB, bakDB, true 
 
    ' compact database 
 
    Set Engine = CreateObject("JRO.JetEngine") 
    prov = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" 
    Engine.CompactDatabase prov & OldDB, prov & newDB 
    set Engine = nothing 
 
    ' delete original database 
 
    FSO.DeleteFile oldDB 
 
    ' move / rename our new, improved, compacted database 
 
    FSO.MoveFile newDB, oldDB 
    set FSO = nothing  
%>