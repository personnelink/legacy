<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
set rsListings = Server.CreateObject("ADODB.RecordSet")
rsListings.Open "SELECT * FROM tbl_jobs WHERE emp_id = " & session("empID"),Connect,3,3
%>

<html>
<head>
<title>Billing Information - www.personnel.com - </title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" bgcolor="#000000"> 
      <!-- #INCLUDE VIRTUAL='/includes/top_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td width="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="EFEFEF"> 
          <td bgcolor="#5187CA"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td rowspan="2" width="216"><img src="/images/logo.gif" width="215" height="76"></td>
                <td width="100%"><img src="/images/pixel.gif" width="100%" height="72"></td>
              </tr>
              <tr> 
                <td height="4" width="100%" bgcolor="#FFFFFF"><img src="/images/pixel.gif" width="1" height="1"></td>
              </tr>
            </table>
          </td>
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_hms.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="E7E7E7"> 
                <td> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/billing.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td> 
                        <%
set rsEmployers = Server.CreateObject("ADODB.RecordSet")
rsEmployers.Open "SELECT * FROM employers WHERE userName = '" & session("employerUserName") & "'",Connect,3,3

if rsEmployers("accountType") = "small" then
%>
                        <table width="90%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td colspan="4" class="redHead">Job's Listed</td>
                          </tr>
                          <%
  do until rsListings.eof
  %>
                          <tr> 
                            <td width="33%"><%=rsListings("jobTitle")%></td>
                            <td width="29%"><%=FormatCurrency(rsListings("price"))%></td>
                            <td width="32%">Paid: <%=rsListings("paid")%></td>
                            <td width="6%">&nbsp;</td>
                          </tr>
                          <%
    if rsListings("paid") = "no" then totalBill = totalBill + rsListings("price")
    rsListings.MoveNext
  loop
  %>
                          <tr> 
                            <td class="redHead">Total Unpaid Bills</td>
                            <td class="redHead"><%=formatCurrency(totalBill)%></td>
                            <td width="32%">&nbsp;</td>
                            <td width="6%">&nbsp;</td>
                          </tr>
                        </table>
                        <% else %>
                        <table width="90%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td colspan="4" class="redHead">Monthly Invoices</td>
                          </tr>
                          <%
   daysDifference = DateDiff("d", rsEmployers("dateStarted"), date())
   if daysDifference < 30 then 
     totalMonths = 1
   else
     remainder = daysDifference mod 30
	 totalMonths = daysDifference \ 30
	 if remainder < 0 then totalMonths = totalMonths + 1
   end if
   paidMonths = cint(rsEmployers("monthsPaid"))
   unpaidMonths = totalMonths - paidMonths
   costPerMonth = cint(rsEmployers("pricePerMonth"))
   totalBill = costPerMonth * unpaidMonths
  %>
                          <tr> 
                            <td colspan="4" class="required">Total months (including 
                              current month): &nbsp;<%=totalMonths%></td>
                          </tr>
                          <tr> 
                            <td width="16%">Unpaid months:</td>
                            <td width="32%"><%=unpaidMonths%> </td>
                            <td width="15%">Cost per month:</td>
                            <td width="37%"><%=formatCurrency(costPerMonth)%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" class="redHead">Total Amount Due:&nbsp;&nbsp;&nbsp;<%=formatCurrency(totalBill)%></td>
                            <td width="15%">&nbsp;</td>
                            <td width="37%">&nbsp;</td>
                          </tr>
                        </table>
                          <% end if %>
                </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/hms_menu.asp' -->
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="100%" height="10" bgcolor="#5187CA"> 
      <!-- #INCLUDE VIRTUAL='/includes/bottom_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></td>
  </tr>
</table>
</body>
</html>
