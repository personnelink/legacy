<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
  <!-- Revised: 11.22.2008 -->


  <style type="text/css">
input
{
text-align:right
color: #003466;
border: 1px solid #C7D2E0;
padding: .2em .2em .1em;
margin-bottom:.5em;
height:1.5em;
background:url(file://///x/include/style/images/normalTitleBackground.gif) repeat-x bottom;
}
textarea
{
text-align:right
color: #003466;
border: 1px solid #C7D2E0;
padding: .2em .2em .1em;
margin-bottom:.5em;
height:15em;
background:url(file://///x/include/style/images/normalTitleBackground.gif) repeat-x bottom;
}
fieldset
{
border: none;
margin: 0 .9em .9em;
width: auto;
}
fieldset legend {
color: #fff;
background: #ffa20c;
padding: 2px 6px
} 
   span.checkbox {
    width: 19px;
    height: 25px;
    padding: 0 5px 0 0;
	margin:-5px 0 0;
    background: url('/include/style/images/forms/checkbox.gif') no-repeat;
    display: block;
    clear: left;
    float: left;
  }
  span.radio {
   width: 19px;
     height: 25px;
    padding: 0 5px 0 0;
	margin:-5px 0 0;
    background: url('/include/style/images/forms/radio.gif') no-repeat;
     display: block;
    clear: left;
	float: right;
  }
   span.select {
     position: absolute;
     width: 158px; /* With the padding included, the width is 190 pixels: the actual width of the image. */
     height: 21px;
     padding: 0 24px 0 8px;
     color: #fff;
  font: 12px/21px arial,sans-serif;
   background: url(../select.gif) no-repeat;
  overflow: hidden;
 }

fieldset ul {
display:block;
float:left; 
clear:both;
margin:0 auto 1em;
}

fieldset li {display: block;clear: right;float:left;
}

label
{
float: left;
text-align: left;
margin-right: 0.5em;
display: block
}
p, label {color:#003466}

ul li {width:45em; display:block; vertical-align:middle;}
label, input, textarea {width:45em}

</style>

  <div class="tb">
    <div>
      <div></div>
    </div>
  </div>
  <div class="mb clearfix">
    <h4> Post new blog </h4>
    <form action="blog_add.asp" method="post" name="addBlog">
<fieldset>
      <ul><li>
	  <label for="blog_title">Blog Title</label>
      <input name="blog_title" type="text" maxlength="50" /></li>
	  <li><label for="blog_text">Blog Text</label>
      <textarea name="blog_text" cols="" rows=""></textarea>
	  </li></ul>
</fieldset>
    </form>
  </div>
  <div class="bb">
    <div>
      <div></div>
    </div>
  </div>
  <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:;" style="margin-left: 6px" onclick="document.createNewUser.formAction.value='true';document.createNewUser.submit();"><span>Complete Enrollment</span></a> <a class="squarebutton" style="margin-left: 6px" href="javascript:document.forms[0].reset()"><span>Start Over</span></a> <a class="squarebutton" href="/userHome.asp" onclick="history.back();"><span>Return To Sign-In</span></a> </div>
  <!-- End of Site content -->
</div>
<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
