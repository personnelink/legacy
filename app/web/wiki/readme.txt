LATEST CHANGES:

1.  A search option is now on top for searching database.
2.  A common wiki text for all pages at the top can be set up in the config.asp
3.  To prepare page for printing, You can now hide the footer and other unnecessary details of the page.
4.  The icon is now searched on the db folder first before the root folder. and also gif, jpg, png are now possible.
5.  Banner is now templated, you can entirely replace it.

These are the latest variables added

gBannerTemplate    = ""                               ' Banner html is now replaceable you need to remember $$icon$$, $$banner_text$$ variable though
gWikiBodyPrefix    = ""
gHideTopSearch     = false



------
WIKI Stylesheet.

The default wiki.css makes pages look better on  Internet Explorer 6 or above. This is because it uses gradient and  shadowing DHTML capabilities.

If you wish to use an alternate style sheet( making uniform look across various browsers), just use the provided style sheet file. OR   type the following in the command line (under the directory of WikiAsp)


  copy wiki.css  wiki.css.allbrowser

  copy wiki.css.normal  wiki.css


For questions write to:  lambda326@hotmail.com


YOU MAY MODIFY -> config.asp    to suit your configuration setup

Please see config.asp for additional codes there.....


Some Secret  Tips for Administrators 

  1.  gPassword       value   is used to create a new database or delete page.  Therefore only Admin must know this.
  2.  gEditPassword   value   is used to edit pages.   Therefore only allowed and trusted users should know this.
  3.  Some variables affect the visiblity of certain parts, please read the code documentation.
  4.  CSS can be specific to tha MDB file.  CSS can now be in the root or DB folder.
  5.  local://  and img:local://  is now working.
  6.  DISABLING LOGINS FOR EDIT 
  
      In the config.asp, the admin will enter true for gHideLogin.  He must also set his own secret login flag
      
          gLoginFlag   =  "GoLogin"
          gHideLogin   =  true
          gIsOpenWiki  =  false
          
      The visitor of his website will not able to edit pages because the settings above.
      
      But the administrator can edit again by just adding the flag in the UR, just like this.
      
           http://site.com/Wiki.asp?o=MyPage&GoLogin
           
      Then the edit login will now be enabled.  The Admin must enter his editpassword or password to proceed.
      
      By default this   secret flag is "log" but it can be overriden in the config.asp
      Admin should create his own secret flag  instead of using the default ("log")
      
   7. New referecence formatting added such as  
   
   img:sample.jpg           display the image based on doc root
   local:hg/image.txt       display the link based on doc root
   [Hello There=WikiAsp]    reference to wikipage
   
   8.   #@91; for [  
        #@93; for ]
        #@3C; for <
        #@3E; for >   which is useful in imbedding HTML
        
        also
        You can insert HTML or remove HTML in the text via  gRemoveHtml variable in
        the config.asp
   
   9.  See the new Inter-wiki notations for links to pages of other mdb databases
   
  10.  If you have file system object working in your IIS, you can re-create the Wikiasp.mdb from
       the *.wik file, by deleting WikiAsp.mdb and browsing the wiki.asp.   MS access file
       Wikiasp.mdb will be AUTOMATICALLY created with default values  from *.wik files.


  11. A little experiment.  If you really have adox and fso object, try deleting the folder 'db' and 
      access WikiAsp.  See if it creates the database by itself