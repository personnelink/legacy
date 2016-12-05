<html>
<script>
  var objXmlHTTP,objXmlDOM;
  var aQuest; //to store question ids
  var aAnswer = new Array(); // to track the result
  var aSelected = new Array(); // to store user's response
  var count = 0; //to store the current question no
  var ansSel = 0; //to store user's selection
  var ExamDuration = 10 * 60 ; // 10 minutes
  var timerID; //to store the setInterval fun's id
  var radIndex = -1; //to store the selected radio's index

  //constructor like function
  //here XML objects are created and
  //No of questions as well as question ids list
  //are fetched from the server.
  function init(){
    objXmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
    objXmlDOM = new ActiveXObject("Microsoft.XMLDOM");
    objXmlHTTP.open("POST","officeExam.asp?Action=Start",false);
    objXmlHTTP.send("");
    temp =objXmlHTTP.ResponseText;
    aQuest = temp.split(",");

    //initialize the user's answers list
    for(i=0;i<aQuest.length; i++){
      aAnswer[i] = 0; // 0 for wrong; 1 for right answer
      aSelected[i] = -1; // to store the radio's index
    }

    if(count < aQuest.length) {
      url = "officeExam.asp?Action=NextQ&QNo=" + aQuest[count];
      objXmlHTTP.open("POST", url ,false);
      objXmlHTTP.send("");
      objXmlDOM.loadXML(objXmlHTTP.ResponseText);
      
      //parse the response content fetched from the server
      //and display the question
      parseQ();
    }
    
    //change the Start button's caption and its click event
    document.frm.btnFinish.value = "Finish the Exam";
    document.frm.btnFinish.onclick = showResult; //function
    
    //start the timer
    timerID = setInterval("timer()",1000);
  }

  function getPreQ() {
    //update the user's answers list
    checkAnswer();
    
    //decrement the question no - i.e. to previous Question
    count--;
    
    //stop the timer
    clearInterval(timerID);
    
    //fetch the question for the aQuest[count] id
    url = "officeExam.asp?Action=NextQ&QNo=" + aQuest[count];
    objXmlHTTP.open("POST",url ,false);
    objXmlHTTP.send("");
    objXmlDOM.loadXML(objXmlHTTP.ResponseText);

    //parse the response content fetched from the server
    //and display the question
    parseQ();
    
    //start the timer
    timerID = setInterval("timer()",1000);
  }

  function getNextQ() {
    //update the user's answers list
    checkAnswer();

    //increment the question no - i.e. to next Question
    count++;

    //stop the timer
    clearInterval(timerID);

    url = "officeExam.asp?Action=NextQ&QNo=" + aQuest[count];
    objXmlHTTP.open("POST", url ,false);
    objXmlHTTP.send("");
    objXmlDOM.loadXML(objXmlHTTP.ResponseText);

    //parse the response content fetched from the server
    //and display the question
    parseQ();

    //start the timer
    timerID = setInterval("timer()",1000);
  }

  function parseQ(){
    //fetch the question from theXML Object
    //format the display 	
    strOut  = "<table border=0 align=center width=80%>";
    strOut += "<tr><td colspan=2><b>";
    strOut += "Question No: " + (count+1) + " of ";
    strOut += aQuest.length + "</b></td></tr>";
    strOut += "<tr><td colspan=2>&nbsp;</td></tr>";

    temp = objXmlDOM.selectSingleNode("data/qtext").text;

    strOut += "<tr><td colspan=2><b>"+temp+"</b></td></tr>";
    strOut += "<tr><td colspan=2>&nbsp;</td></tr>";

    Nodes = objXmlDOM.selectNodes("data/choice");

    for(i=0;i<Nodes.length;i++){
      strOut += "<tr><td align=center width=10%>";
      strOut += "<input type=radio name=ansUsr ";
      strOut += " onClick='ansSel=" + (i+1);
      strOut += ";radIndex=" + i + "' ";
      strOut += "value=" + (i+1) + "></td><td>";
      strOut +=  Nodes.item(i).text + "</td></tr>";		
    }

    //set ansNo (hidden field) to the actual answer
    temp = objXmlDOM.selectSingleNode("data/answer").text;
    document.frm.ansNo.value = temp;

    strOut += "<tr><td colspan=2>&nbsp;</td></tr>";
    strOut += "<tr><td colspan=2>";

    if(count != 0 ){
      strOut += "<input type=button value=Previous ";
      strOut += " onClick='getPreQ()'> ";
    }

    if(count < aQuest.length-1){
      strOut += " <input type=button value=Next";
      strOut += " onClick='getNextQ()'>";			
    }

    strOut += "</td></tr></table>";

    //set the strOut content to <P> tag named QArea
    QArea.innerHTML = strOut;

    //set the default value to ansSel
    ansSel = 0;
    radIndex = -1;

    //check the radio if user has selected previously
    if (aSelected[count] != -1) {
      radIndex = aSelected[count];
      ansSel = radIndex + 1;
      document.frm.ansUsr[radIndex].checked = true;
    }
  }

  function checkAnswer(){
    //store the selected radio's index
    aSelected[count] = radIndex;

    //if the user selection matches the actual answer
    if (ansSel == document.frm.ansNo.value)
      aAnswer[count] = 1;
    else
      aAnswer[count] = 0;
  }

  function showResult() {
    rights = 0;

    //stop the timer
    clearInterval(timerID);

    //update the user's answers list
    checkAnswer();

    //count no of answers
    for(i=0;i<aAnswer.length;i++){
      if(aAnswer[i] == 1)
      rights++;
    }
    
    strRes = "<form name='emailresults' method='post' action='/orientation/company/OSHA/tests/emailresult.asp'>";    
    strRes += "<h2 align=center><br>";
    strRes += "<% response.write request.cookies("OSHA")("fname") %>&nbsp;<% response.write request.cookies("OSHA")("lname") %>,&nbsp;here are your Office Test Results...<br>";

    //if all the answers are correct then greet
    if(rights == aAnswer.length)
      strRes += "<br><br>Congratulations...!";

    strRes += "<br><br>your score is " + rights;
    strRes += " out of " + aAnswer.length + "</h2><br><br>";
    strRes += "<center><input type='submit' value='Continue'></center></form>";

	//Create a cookie to hold the test results
	{
	var cookieStr0 = "result" + "="+ rights;	
	var cookieStr1 = "answer" + "="+ aAnswer.length;
	var cookieStr2 = "test" + "="+ "Office";
	document.cookie = cookieStr0;
	document.cookie = cookieStr1;
	document.cookie = cookieStr2;
	}

    document.write(strRes);
  }

  var timeCount = 0;
  function timer(){
    timeCount++;  //increment the time by one second

    //to display the time in the status bar,
    // uncomment the next line
    //window.status = "..." + timeCount + " secs" ;

    //to display the time
    temp =  "Time:   " + parseInt(timeCount/60);
    temp += "  min : " + (timeCount%60) + " sec ";
    TBlock.innerText = temp;

    //if the time is up
    if (timeCount == ExamDuration) {
      alert("Sorry, time is up");
      showResult();
    }
  }
</script>

<body>
<h2 align=center><font color=green>Office Orientation Test</font></h2>

<form name=frm >
<table border=1 width=95% bgcolor=DarkSeaGreen align=center>
<tr><td align=right><b id=TBlock></b></td></tr>
<tr><td>
<p id="QArea">
<center>
<br>
Relax...! The duration of this test is 10 minutes, and consists of 20 questions.
<br>
These questions are Multiple Choice and True/false.
<br><br>
There is no order to answer a question. You may use Next as
well as Previous button to get a question to answer.
<br>
<br>
<input type=button name=btnFinish value="Start the Test"
onClick="init()">
</center>
</p>
<input type=hidden name=ansNo>
</td></tr></table>
</form>

</body>
</html>