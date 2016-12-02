/* ====================================================================
 * The Apache Software License, Version 1.1
 *
 * Copyright (c) 2001 The Apache Software Foundation.  All rights
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The end-user documentation included with the redistribution,
 *    if any, must include the following acknowledgment:
 *       "This product includes software developed by the
 *        Apache Software Foundation (http://www.apache.org/)."
 *    Alternately, this acknowledgment may appear in the software itself,
 *    if and wherever such third-party acknowledgments normally appear.
 *
 * 4. The names "Apache" and "Apache Software Foundation" and
 *    "Apache Lucene" must not be used to endorse or promote products
 *    derived from this software without prior written permission. For
 *    written permission, please contact apache@apache.org.
 *
 * 5. Products derived from this software may not be called "Apache",
 *    "Apache Lucene", nor may "Apache" appear in their name, without
 *    prior written permission of the Apache Software Foundation.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals on behalf of the Apache Software Foundation.  For more
 * information on the Apache Software Foundation, please see
 * <http://www.apache.org/>.
 */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Windows.Forms.Design;
using System.Data;
using System.IO;

using DotnetPark.NLucene.Analysis;
using DotnetPark.NLucene.Analysis.Standard;
using DotnetPark.NLucene.Search;
using DotnetPark.NLucene.QueryParser;
using DotnetPark.NLucene.Index;
using DotnetPark.NLucene.Store;

namespace NLuceneClient
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class MainForm : System.Windows.Forms.Form
	{
		private System.Windows.Forms.MainMenu mainMenu;
		private System.Windows.Forms.MenuItem itmFile;
		private System.Windows.Forms.MenuItem itmFileExit;
		private System.Windows.Forms.MenuItem itmIndex;
		private System.Windows.Forms.MenuItem itmHelp;
		private System.Windows.Forms.MenuItem itmHelpAbout;
		private System.Windows.Forms.MenuItem itmIndexFiles;
		private System.Windows.Forms.MenuItem menuItem2;
		private System.Windows.Forms.MenuItem itmIndexSelect;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private System.Windows.Forms.StatusBar status;
		private System.Windows.Forms.Panel panel1;
		private System.Windows.Forms.ColumnHeader colPath;
		private System.Windows.Forms.ColumnHeader colScore;
		private System.Windows.Forms.Label lblQuery;
		private System.Windows.Forms.TextBox txtQuery;
		private System.Windows.Forms.Button btnSearch;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.ListView results;

		private string indexFolder = null;
		private long counter = 0;

		public MainForm()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
			RefreshIndex();
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.mainMenu = new System.Windows.Forms.MainMenu();
			this.itmFile = new System.Windows.Forms.MenuItem();
			this.itmFileExit = new System.Windows.Forms.MenuItem();
			this.itmIndex = new System.Windows.Forms.MenuItem();
			this.itmIndexFiles = new System.Windows.Forms.MenuItem();
			this.menuItem2 = new System.Windows.Forms.MenuItem();
			this.itmIndexSelect = new System.Windows.Forms.MenuItem();
			this.itmHelp = new System.Windows.Forms.MenuItem();
			this.itmHelpAbout = new System.Windows.Forms.MenuItem();
			this.status = new System.Windows.Forms.StatusBar();
			this.results = new System.Windows.Forms.ListView();
			this.panel1 = new System.Windows.Forms.Panel();
			this.colPath = new System.Windows.Forms.ColumnHeader();
			this.colScore = new System.Windows.Forms.ColumnHeader();
			this.lblQuery = new System.Windows.Forms.Label();
			this.txtQuery = new System.Windows.Forms.TextBox();
			this.btnSearch = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.panel1.SuspendLayout();
			this.SuspendLayout();
			// 
			// mainMenu
			// 
			this.mainMenu.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					 this.itmFile,
																					 this.itmIndex,
																					 this.itmHelp});
			// 
			// itmFile
			// 
			this.itmFile.Index = 0;
			this.itmFile.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					this.itmFileExit});
			this.itmFile.Text = "&File";
			// 
			// itmFileExit
			// 
			this.itmFileExit.Index = 0;
			this.itmFileExit.Text = "E&xit";
			this.itmFileExit.Click += new System.EventHandler(this.itmFileExit_Click);
			// 
			// itmIndex
			// 
			this.itmIndex.Index = 1;
			this.itmIndex.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					 this.itmIndexFiles,
																					 this.menuItem2,
																					 this.itmIndexSelect});
			this.itmIndex.Text = "&Index";
			// 
			// itmIndexFiles
			// 
			this.itmIndexFiles.Index = 0;
			this.itmIndexFiles.Text = "Index &Files...";
			this.itmIndexFiles.Click += new System.EventHandler(this.itmIndexFiles_Click);
			// 
			// menuItem2
			// 
			this.menuItem2.Index = 1;
			this.menuItem2.Text = "-";
			// 
			// itmIndexSelect
			// 
			this.itmIndexSelect.Index = 2;
			this.itmIndexSelect.Text = "&Select index...";
			this.itmIndexSelect.Click += new System.EventHandler(this.itmIndexSelect_Click);
			// 
			// itmHelp
			// 
			this.itmHelp.Index = 2;
			this.itmHelp.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					this.itmHelpAbout});
			this.itmHelp.Text = "&Help";
			// 
			// itmHelpAbout
			// 
			this.itmHelpAbout.Index = 0;
			this.itmHelpAbout.Text = "&About NLucene Client";
			this.itmHelpAbout.Click += new System.EventHandler(this.itmHelpAbout_Click);
			// 
			// status
			// 
			this.status.Location = new System.Drawing.Point(0, 288);
			this.status.Name = "status";
			this.status.Size = new System.Drawing.Size(488, 22);
			this.status.TabIndex = 0;
			this.status.Text = "Ready";
			// 
			// results
			// 
			this.results.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
																					  this.colPath,
																					  this.colScore});
			this.results.Dock = System.Windows.Forms.DockStyle.Fill;
			this.results.FullRowSelect = true;
			this.results.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
			this.results.Location = new System.Drawing.Point(0, 64);
			this.results.Name = "results";
			this.results.Size = new System.Drawing.Size(488, 224);
			this.results.TabIndex = 1;
			this.results.View = System.Windows.Forms.View.Details;
			// 
			// panel1
			// 
			this.panel1.Controls.AddRange(new System.Windows.Forms.Control[] {
																				 this.label1,
																				 this.btnSearch,
																				 this.txtQuery,
																				 this.lblQuery});
			this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
			this.panel1.Name = "panel1";
			this.panel1.Size = new System.Drawing.Size(488, 64);
			this.panel1.TabIndex = 2;
			// 
			// colPath
			// 
			this.colPath.Text = "Document path";
			this.colPath.Width = 371;
			// 
			// colScore
			// 
			this.colScore.Text = "Score";
			this.colScore.Width = 84;
			// 
			// lblQuery
			// 
			this.lblQuery.Location = new System.Drawing.Point(8, 16);
			this.lblQuery.Name = "lblQuery";
			this.lblQuery.Size = new System.Drawing.Size(40, 16);
			this.lblQuery.TabIndex = 0;
			this.lblQuery.Text = "Query:";
			// 
			// txtQuery
			// 
			this.txtQuery.Anchor = ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right);
			this.txtQuery.Location = new System.Drawing.Point(48, 16);
			this.txtQuery.Name = "txtQuery";
			this.txtQuery.Size = new System.Drawing.Size(352, 20);
			this.txtQuery.TabIndex = 1;
			this.txtQuery.Text = "";
			// 
			// btnSearch
			// 
			this.btnSearch.Anchor = (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.btnSearch.Location = new System.Drawing.Point(408, 16);
			this.btnSearch.Name = "btnSearch";
			this.btnSearch.Size = new System.Drawing.Size(64, 23);
			this.btnSearch.TabIndex = 2;
			this.btnSearch.Text = "Search";
			this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 48);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(80, 16);
			this.label1.TabIndex = 3;
			this.label1.Text = "Search results:";
			// 
			// MainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(488, 310);
			this.Controls.AddRange(new System.Windows.Forms.Control[] {
																		  this.results,
																		  this.panel1,
																		  this.status});
			this.Menu = this.mainMenu;
			this.Name = "MainForm";
			this.Text = "NLucene Client";
			this.panel1.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new MainForm());
		}

		private void itmFileExit_Click(object sender, System.EventArgs e)
		{
			this.Close();
		}

		private void itmHelpAbout_Click(object sender, System.EventArgs e)
		{
			AboutForm frmAbout = new AboutForm();
			frmAbout.ShowDialog(this);
		}

		private void RefreshIndex()
		{
			if(indexFolder != null)
				this.Text = "NLucene Client - [" + indexFolder + "]";
			else
				this.Text = "NLucene Client - [Index is not selected]";
		}

		private void itmIndexSelect_Click(object sender, System.EventArgs e)
		{
			string folder = BrowseFolders();
			if(folder.Length > 0)
			{
				indexFolder = folder;
				RefreshIndex();
			}
		}

		private void btnSearch_Click(object sender, System.EventArgs e)
		{
			if(indexFolder == null)
			{
				MessageBox.Show(this, "Click 'Index->Select index...' and select a folder where index files reside.", "Error");
				return;
			}

			if(txtQuery.Text.Trim() == "")
			{
				MessageBox.Show(this, "The query can not be empty.", "Error");
				return;
			}

			try
			{
				PerformSearch();
			}
			catch
			{
				MessageBox.Show(this, "Can't open index at the specified folder!", "Error");
			}
		}

		private void PerformSearch()
		{
			IndexReader reader = IndexReader.Open(indexFolder);
			Searcher searcher = new IndexSearcher(reader);
			Query q = QueryParser.Parse(txtQuery.Text, "path", new SimpleAnalyzer());
			Hits hits = searcher.Search(q);

			status.Text = String.Format("{0} documents were found.", hits.Length);
			results.Items.Clear();

			// Another way to iterate throw results
			/*for(int i=0; i<hits.Length; i++)
			{
				string val = results[i].Document["path"].Value;
				float score = results[i].Score;
			}*/
			foreach(Hit hit in hits)
			{
				ListViewItem item = new ListViewItem(hit.Document["path"].Value);
				item.SubItems.Add(hit.Score.ToString());

				results.Items.Add(item);
			}

			searcher.Close();
			//reader.Close();
		}

		private void itmIndexFiles_Click(object sender, System.EventArgs e)
		{
			string folder = BrowseFolders();

			//SelectDirectoryForm indexChooser = new SelectDirectoryForm();
			//indexChooser.Text = "Select folder to index";

			if(folder.Length > 0)
			{
				if(indexFolder == null)
				{
					MessageBox.Show(this, "Click 'Index->Select index...' and select a folder where index files reside.", "Error");
					return;
				}

				string fileName = folder;
				PerformIndexing(fileName);
			}
		}

		private void PerformIndexing(string fileName)
		{
			DateTime start = DateTime.Now;
			status.Text = "Indexing files...";

			DotnetPark.NLucene.Store.Directory directory = FsDirectory.GetDirectory("test", true);
			directory.Close();

			IndexWriter writer = new IndexWriter(indexFolder, new StandardAnalyzer(), true);
			writer.mergeFactor = 20;

			counter = 0;

			IndexDoc(writer, fileName);

			writer.Optimize();
			writer.Close();
			
			DateTime end = DateTime.Now;

			status.Text = String.Format("{0} files has been procesed for {1} total milliseconds",
				counter, ((TimeSpan) (end - start)).TotalMilliseconds);
		}

		private void IndexDoc(IndexWriter writer, string path) 
		{

			if(File.Exists(path)) 
			{
				// This path is a file
				ProcessFile(writer, new FileInfo(path)); 
			}               
			else if(System.IO.Directory.Exists(path)) 
			{
				// This path is a directory
				ProcessDirectory(writer, path);
			}
			else 
			{
				MessageBox.Show("'" + path + "' is not a valid file or directory.");
			}        
		}

		// Process all files in the directory passed in, and recurse on any directories 
		// that are found to process the files they contain
		private void ProcessDirectory(IndexWriter writer, string targetDirectory) 
		{
			// Process the list of files found in the directory
			string [] fileEntries = System.IO.Directory.GetFiles(targetDirectory, "*.txt");
			foreach(string fileName in fileEntries)
				ProcessFile(writer, new FileInfo(fileName));

			// Recurse into subdirectories of this directory
			string [] subdirectoryEntries = System.IO.Directory.GetDirectories(targetDirectory);
			foreach(string subdirectory in subdirectoryEntries)
				ProcessDirectory(writer, subdirectory);
		}

		// Real logic for processing found files would go here.
		private void ProcessFile(IndexWriter writer, FileInfo file) 
		{
			status.Text = "Indexing file'" + file.FullName + "'...";
			this.Update();
			writer.AddDocument(FileDocument.Document(file));
			counter++;
		}

		private string BrowseFolders()
		{
			FolderNameEditor ed = new FolderNameEditor();
			string name = "";
			return (string)ed.EditValue(null, name);
		}
	}
}
