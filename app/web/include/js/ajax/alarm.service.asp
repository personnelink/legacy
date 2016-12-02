<%
session("required_user_level") = 4096 'userLevelSupervisor
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<!-- #include file='alarm.classes.asp' -->
<%

dim Alarm
set Alarm = new cAlarm

Alarm.GetAppointment()



' Print Alarm.Site
' print Alarm.ForUser
' print Alarm.Appointment.id              
' print Alarm.Appointment.Comment       
' print Alarm.Appointment.ApplicantPhone 
' print Alarm.Appointment.CustomerPhone  
' print Alarm.Appointment.WorkSitePhone 
' print Alarm.Appointment.ApplicantId   
' print Alarm.Appointment.LastnameFirst 
' print Alarm.Appointment.ApptDate
' print Alarm.Appointment.ApptTypeCode     
' print Alarm.Appointment.DispTypeCode  
' print Alarm.Appointment.EnteredBy     
' print Alarm.Appointment.AssignedTo     
' print Alarm.Appointment.CustomerCode  
' print Alarm.Appointment.CustomerName   
' print Alarm.Appointment.CustomerContact
' print Alarm.Appointment.JobSupervisor  
' print Alarm.Appointment.ReferenceId   
' print Alarm.Appointment.JobDescription


ServiceEnd

%>
