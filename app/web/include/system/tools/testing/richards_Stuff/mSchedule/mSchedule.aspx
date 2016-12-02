<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Schedule</title>
</head>
<body>
    <form id="schedule" runat="server">
    <div>
    <h1>Manage Schedule</h1>
        <p>
            <asp:CheckBox ID="lCheck" runat="server" />
            <asp:Label ID="aLunch" runat="server" Text="Automatic Lunch Deduction"></asp:Label>
        </p>
        <p style="margin-left: 40px">
            <asp:RadioButtonList ID="lunchDed" runat="server">
                <asp:ListItem Value="thirtyMinL">30 min</asp:ListItem>
                <asp:ListItem Value="sixtyMinL">60 Min</asp:ListItem>
            </asp:RadioButtonList>
        </p>
        <p>
            <asp:CheckBox ID="eCheck" runat="server" />
            <asp:Label ID="eClock" runat="server" Text="Allow Early Clock In's"></asp:Label>
        </p>
        <p>
            <asp:CheckBox ID="roundCheck" runat="server" />
            <asp:Label ID="roundTime" runat="server" Text="Round Time to the Nearest:"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="none">---</asp:ListItem>
                <asp:ListItem Value="roundTenth">0.1</asp:ListItem>
                <asp:ListItem Value="nearestQuart">0.25</asp:ListItem>
                <asp:ListItem Value="nearestHalf">0.5</asp:ListItem>
            </asp:DropDownList>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" style="text-align: right" Text="Button" />
        </p>
    </div>
    </form>
    <p style="text-align: center">
        &nbsp;</p>
</body>
</html>
