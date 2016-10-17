<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PBIE_RLS_Sample.WebForm1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <input type="hidden" id="accessTokenText" runat="server" value="" />
    <input type="hidden" id="embedUrlText" runat="server" value="" />

    <script type="text/javascript">

        window.onload = function () {
            var iframe = document.getElementById('iFrameEmbedReport');
            iframe.src = document.getElementById('MainContent_embedUrlText').value;
            iframe.onload = postActionLoadReport;

            function postActionLoadReport() {
                accessToken = document.getElementById('MainContent_accessTokenText').value;
                var m = { action: "loadReport", accessToken: accessToken };
                message = JSON.stringify(m);
                iframe = document.getElementById('iFrameEmbedReport');
                iframe.contentWindow.postMessage(message, "*");
            }
        };
    </script>

    <table style="font-family:'Segoe UI'; width:100%; height:100%; background-color:gold; border-spacing:0px 0px; text-space-collapse:collapse;">
        <tr>
            <td style="text-align: center; vertical-align:middle; background-color: #996633;height:80px; font-family:'Segoe UI';font-size:xx-large; color:white;" colspan="2">
                &nbsp;Sale Store XYZ - Reporting Module</td>
        </tr>
        <tr>
            <td style="width: 397px; text-align: center; font-size: x-large;">&nbsp;</td>
            <td style="text-align: center; font-size: x-large">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 397px; text-align: center; font-size: x-large; height: 45px;">Sellers</td>
            <td style="text-align: center; font-size: x-large; height: 45px;">Main Report - Sales Analysis</td>
        </tr>
        <tr>
            <td style="width: 397px; text-align: center; font-size: x-large;">&nbsp;</td>
            <td style="text-align: center; font-size: x-large">&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: center">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="All (Manager)" BackColor="Red" BorderStyle="None" ForeColor="White" style="align-self:center;" Height="100%" Width="100%"/>
            </td>
            <td rowspan="2">

                <iframe id="iFrameEmbedReport" height="700" width="933" seamless style="border:thin solid black; "></iframe>

            </td>
        </tr>
        <tr>
            <td style="vertical-align:top; width: 100px; align-items:center;align-content:center;align-self:center;">
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" Font-Bold="False" ForeColor="#996633">
                    <ItemTemplate>
                        <asp:LinkButton ID="SalesPersonLabel" runat="server" Text='<%# Eval("SalesPerson") %>' OnClick="LinkButton1_Click" />
                    </ItemTemplate>
                </asp:DataList>
                <br />
                <p style="text-align:center;">Sellers are here representing eventual users who should access the app to extract reports about their results.</p>

            </td>
        </tr>
    </table>
    <hr />
    <asp:HiddenField ID="selectedUser" runat="server" Value="" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DB4TestsConnectionString %>" SelectCommand="SELECT DISTINCT A.SalesPerson FROM SalesLT.Customer AS A INNER JOIN SalesLT.SalesOrderHeader AS B ON A.CustomerID = B.CustomerID WHERE (B.TotalDue &gt; 0)"></asp:SqlDataSource>


    <asp:LinkButton ID="LinkButton1" runat="server">LinkButton</asp:LinkButton>


</asp:Content>


