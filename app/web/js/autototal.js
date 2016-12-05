<script type="text/javascript">

function ShowExample()
	{	alert("When entering the date, use the following format:\n\n08/02/05  (August 2, 2005)\n\nWhen entering the hours worked, use the following format:\n\n6.25  (6 1/4 hours)\nremember to round to the nearest 1/4 hour.")
	}
</script>
<script type="text/javascript">
function startCalc(){
  interval = setInterval("Calc()",1);
}
function Calc(){
  monday0 = document.TimeSheet.Monday0.value;
  tuesday0 = document.TimeSheet.Tuesday0.value; 
  wednesday0 = document.TimeSheet.Wednesday0.value;
  thursday0 = document.TimeSheet.Thursday0.value;
  friday0 = document.TimeSheet.Friday0.value;
  saturday0 = document.TimeSheet.Saturday0.value;
  sunday0 = document.TimeSheet.Sunday0.value;
  
  monday1 = document.TimeSheet.Monday1.value;
  tuesday1 = document.TimeSheet.Tuesday1.value; 
  wednesday1 = document.TimeSheet.Wednesday1.value;
  thursday1 = document.TimeSheet.Thursday1.value;
  friday1 = document.TimeSheet.Friday1.value;
  saturday1 = document.TimeSheet.Saturday1.value;
  sunday1 = document.TimeSheet.Sunday1.value;
  
  monday2 = document.TimeSheet.Monday2.value;
  tuesday2 = document.TimeSheet.Tuesday2.value; 
  wednesday2 = document.TimeSheet.Wednesday2.value;
  thursday2 = document.TimeSheet.Thursday2.value;
  friday2 = document.TimeSheet.Friday2.value;
  saturday2 = document.TimeSheet.Saturday2.value;
  sunday2 = document.TimeSheet.Sunday2.value;
  
  monday3 = document.TimeSheet.Monday3.value;
  tuesday3 = document.TimeSheet.Tuesday3.value; 
  wednesday3 = document.TimeSheet.Wednesday3.value;
  thursday3 = document.TimeSheet.Thursday3.value;
  friday3 = document.TimeSheet.Friday3.value;
  saturday3 = document.TimeSheet.Saturday3.value;
  sunday3 = document.TimeSheet.Sunday3.value;
  
  monday4 = document.TimeSheet.Monday4.value;
  tuesday4 = document.TimeSheet.Tuesday4.value; 
  wednesday4 = document.TimeSheet.Wednesday4.value;
  thursday4 = document.TimeSheet.Thursday4.value;
  friday4 = document.TimeSheet.Friday4.value;
  saturday4 = document.TimeSheet.Saturday4.value;
  sunday4 = document.TimeSheet.Sunday4.value;
  
  regular0 = eval(40);
  overtime0 = eval(40.25);

  regular1 = eval(40);
  overtime1 = eval(40.25);

  regular2 = eval(40);
  overtime2 = eval(40.25);

  regular3 = eval(40);
  overtime3 = eval(40.25);

  regular4 = eval(40);
  overtime4 = eval(40.25);
    		
  Total0 = (monday0*1)+(tuesday0*1)+(wednesday0*1)+(thursday0*1)+(friday0*1)+(saturday0*1)+(sunday0*1);
  Total1 = (monday1*1)+(tuesday1*1)+(wednesday1*1)+(thursday1*1)+(friday1*1)+(saturday1*1)+(sunday1*1);
  Total2 = (monday2*1)+(tuesday2*1)+(wednesday2*1)+(thursday2*1)+(friday2*1)+(saturday2*1)+(sunday2*1);
  Total3 = (monday3*1)+(tuesday3*1)+(wednesday3*1)+(thursday3*1)+(friday3*1)+(saturday3*1)+(sunday3*1);
  Total4 = (monday4*1)+(tuesday4*1)+(wednesday4*1)+(thursday4*1)+(friday4*1)+(saturday4*1)+(sunday4*1);
 
//First Employee
	if (Total0 >= eval(40.25))
		{
			overtime0 = Total0-regular0;
			document.TimeSheet.otTime0.value = overtime0;
			document.TimeSheet.regTime0.value = Total0-overtime0;
		}
	if (Total0 <= eval(40))
		{
			document.TimeSheet.regTime0.value = Total0;
			document.TimeSheet.otTime0.value = "0";
		}

//Second Employee
	if (Total1 >= eval(40.25))
		{
			overtime1 = Total1-regular1;
			document.TimeSheet.otTime1.value = overtime1;
			document.TimeSheet.regTime1.value = Total1-overtime1;
		}
	if (Total1 <= eval(40))
		{
			document.TimeSheet.regTime1.value = Total1;
			document.TimeSheet.otTime1.value = "0";
		}

//Third Employee
	if (Total2 >= eval(40.25))
		{
			overtime2 = Total2-regular2;
			document.TimeSheet.otTime2.value = overtime2;
			document.TimeSheet.regTime2.value = Total2-overtime2;
		}
	if (Total2 <= eval(40))
		{
			document.TimeSheet.regTime2.value = Total2;
			document.TimeSheet.otTime2.value = "0";
		}

//Fourth Employee
	if (Total3 >= eval(40.25))
		{
			overtime3 = Total3-regular3;
			document.TimeSheet.otTime3.value = overtime3;
			document.TimeSheet.regTime3.value = Total3-overtime3;
		}
	if (Total3 <= eval(40))
		{
			document.TimeSheet.regTime3.value = Total3;
			document.TimeSheet.otTime3.value = "0";
		}

//Fifth Employee
	if (Total4 >= eval(40.25))
		{
			overtime4 = Total4-regular4;
			document.TimeSheet.otTime4.value = overtime4;
			document.TimeSheet.regTime4.value = Total4-overtime4;
		}
	if (Total4 <= eval(40))
		{
			document.TimeSheet.regTime4.value = Total4;
			document.TimeSheet.otTime4.value = "0";
		}
	
//Total Time
	document.TimeSheet.TotalregTime.value = eval(document.TimeSheet.regTime0.value) + eval(document.TimeSheet.regTime1.value) + eval(document.TimeSheet.regTime2.value) + eval(document.TimeSheet.regTime3.value) + eval(document.TimeSheet.regTime4.value);
	document.TimeSheet.TotalOTTime.value = eval(document.TimeSheet.otTime0.value) + eval(document.TimeSheet.otTime1.value) + eval(document.TimeSheet.otTime2.value) + eval(document.TimeSheet.otTime3.value) + eval(document.TimeSheet.otTime4.value);
}
function stopCalc(){
  clearInterval(interval);
}
</script>