using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Microsoft.PowerBI.Api.V1;
using Microsoft.PowerBI.Security;
using System.Configuration;
using Microsoft.Rest;

namespace PBIE_RLS_Sample
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private static string workspaceCollection = ConfigurationManager.AppSettings["powerbi:WorkspaceCollection"];
        private static string workspaceId = ConfigurationManager.AppSettings["powerbi:WorkspaceId"];
        private static string accessKey = ConfigurationManager.AppSettings["powerbi:AccessKey"];
        private static string apiUrl = ConfigurationManager.AppSettings["powerbi:ApiUrl"];
        private static string reportID = string.Empty;


        private IPowerBIClient CreatePowerBIClient()
        {
            var credentials = new TokenCredentials(accessKey, "AppKey");
            var client = new PowerBIClient(credentials)
            {
                BaseUri = new Uri(apiUrl)
            };
            return client;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                renderReport();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            selectedUser.Value = ((LinkButton)sender).Text;
            renderReport();
        }

        protected void renderReport()
        {
            using (var client = this.CreatePowerBIClient())
            {

                string myUserID = selectedUser.Value.ToString();
                var reportsResponse = client.Reports.GetReports(workspaceCollection, workspaceId);
                var report = reportsResponse.Value.FirstOrDefault();

                var embedToken = (myUserID != "" ? PowerBIToken.CreateReportEmbedToken(workspaceCollection, workspaceId, report.Id, myUserID, new string[] { "SalesPerson" }) : PowerBIToken.CreateReportEmbedToken(workspaceCollection, workspaceId, report.Id, "adventure-works\\linda3", null));
                string myTok = embedToken.Generate(accessKey);

                accessTokenText.Value = myTok;  //input on the report page.

                embedUrlText.Value = "https://embedded.powerbi.com/appTokenReportEmbed?reportId=" + report.Id; //input on the report page.
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            selectedUser.Value = "";
            renderReport();
        }
    }
}