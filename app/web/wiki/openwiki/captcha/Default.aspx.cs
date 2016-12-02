using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace CaptchaImage
{
	public class _Default : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.TextBox CodeNumberTextBox;
		protected System.Web.UI.WebControls.Button SubmitButton;
		protected System.Web.UI.WebControls.Label MessageLabel;
		protected System.Web.UI.HtmlControls.HtmlInputHidden Hidden1;
 
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			if ( IsPostBack)

			 
	{
		 
		string theCode=Request.Form["Hidden1"].ToString();
		string newText=String.Empty;
          
		int y=0;
		for(int i=0;i<theCode.Length;i++)
	{
			// poor man's decryption algorithm...
		y =   Int32.Parse(theCode.Substring(i,1)) +1; 
		newText+= y.ToString(); 
	}

		if (this.CodeNumberTextBox.Text == newText)
	{
		 
		this.MessageLabel.CssClass = "info";
		this.MessageLabel.Text = "Correct!";
	}
	else
{
	// Display an error message.
	this.MessageLabel.CssClass = "error";
	this.MessageLabel.Text = "ERROR: Incorrect, try again.";

	// Clear the input and create a new random code.
	this.CodeNumberTextBox.Text = "";
	 
}
}
		}
 

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
