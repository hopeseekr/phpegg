<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");

if (($new=="create") && ($manager==1))
	{
	
	
	
	$sql="insert into channels ( chan_name,topic,topic_set_by,topic_set_date  )  values ( '$chan_name','$topic','$topic_set_by',$topic_set_date)";
				
		
	if ($sql)
		{	
		$result=$db_ctrl->query($sql,$db);
		if (!$result)
			{
			$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
			}
		else
			{
			$msg.="channels inserted<br>";
			
			}
		}
	}
if ($update=="update")	
	{

	if (!$on_join)
		{
		
		$on_join="0";
		}
	if (!$on_part)
		{
		
		$on_part="0";
		}	
			
			
	$sql="update channels set on_join='$on_join', on_part='$on_part', active='$active', chan_name = '$chan_name',topic = '$topic',topic_set_by = '$topic_set_by',topic_set_date =  $topic_set_date  where channels_id = $channels_id ";
		
	
	
	if ($sql)
		{	
		$result=$db_ctrl->query($sql,$db);
		if (!$result)
			{
			$msg.="Mysql error: ".$db_ctrl->error($db)."<br>";
			}
		else
			{
			$msg.="{$title} updated<br>";
			
			}
		}
	}
if (($delete=="delete") && $channels_id && ($manager==1))	
	{
	
	$sql="delete from channels where channels_id = $channels_id";
	$result=$db_ctrl->query($sql,$db);
	if (!$result)
		{
		$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
		}
	else
		{
		$msg.="channels deleted<br>";
		
		}
	unset($channels_id);
	}
	
	
	
include("table.inc.php");
//  create new news 

if (!$channels_id )
	{
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(300, "green","create channels");
	echo $str;
	
	


	echo "<form action=channels.php method=post  >";
	echo "<table width=100%>";
	
	





echo " chan_name <br> 
			<input type=text name=chan_name><br> "; 
                         echo " topic <br> 
			<input type=text name=topic><br> "; 
                         echo " topic_set_by <br> 
			<input type=text name=topic_set_by><br> "; 
                         echo " topic_set_date <br> 
			<input type=text name=topic_set_date><br> "; 
                         



	if ($manager==1)
	{
	echo "<tr><td><input type=hidden name=login_id value=$login_id><input type=submit name=new value=create>
	<input type=reset name=reset value=reset></td></tr>";
	}
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;

	}
else
	{
	// update existing news.
	$sql="select * from channels where channels_id=$channels_id ";
	$result=@$db_ctrl->query($sql,$db);
	$myrow=@$db_ctrl->fetch_array($result);
$chan_name=$myrow["chan_name"]; 
$topic=$myrow["topic"]; 
$topic_set_by=$myrow["topic_set_by"]; 
$topic_set_date=$myrow["topic_set_date"]; 
$channels_id=$myrow["channels_id"]; 
$active=$myrow["active"];
$on_join=$myrow["on_join"];
$on_part=$myrow["on_part"];
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(400, "green","Update channels");
	echo $str;
	echo "<form  action=channels.php method=post  >";
	echo "<table width=100%>";
	
echo " chan_name <br> 
			<input type=text name=chan_name value='$chan_name'><br> "; 
                         echo " topic <br> 
			<input type=text name=topic value='$topic'><br> "; 
                         echo " topic_set_by <br> 
			<input type=text name=topic_set_by value='$topic_set_by'><br> "; 
                         echo " topic_set_date <br> 
			<input type=text name=topic_set_date value='$topic_set_date'><br> "; 
         if ($active=="1")
         	{
         	
         	$yes=" checked ";
         	}              
         else
         	{
         	$no="checked";
         	}	  	
                         	echo "Active <br>
         <input type=radio name=active value=1 $yes>yes<br>
         <input type=radio name=active value=0 $no>    No   <br>         	
	<input type=hidden name=channels_id value=$channels_id>
	<input type=submit name=update value=update>
	<input type=reset name=reset value=new onclick=\"javascript:document.location.href='channels.php?login_id=$login_id'\"></td></tr>";
	
if ($on_join=="1")
	{
	$onjoin_yes=" checked ";
	}	
	
echo "<tr><td><input type=checkbox name=on_join value='1' $onjoin_yes> On Join active</td></tr> ";	
	
if ($on_part=="1")
	{
	$onpart_yes=" checked ";
	}	
	
echo "<tr><td><input type=checkbox name=on_part value='1' $onpart_yes> On Part active</td></tr> ";	
		
	
	
	echo "<tr><td><input type=hidden name=login_id value=$login_id>
	<a href=join_msg.php?channels_id=$channels_id&login_id=$login_id>ON join msgs</a>
	<a href=part_msg.php?channels_id=$channels_id&login_id=$login_id>ON part msgs</a></td></tr>";
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;
	
	}	






echo "
</td><td VALIGN=top>";  

// show curent news in the system 

$str=create_table_top(300, "green","channels");
echo $str;
echo "<form acton=channels.php method=post>";
echo "<table width=100%>";
if ($manager)
	{
	$sql="select chan_name ,channels_id from channels ";
	}
else
	{
	
	$sql="select c.chan_name as chan_name,channels_id from web_login wl, user_chan uc , channels c where wl.web_login_id=$user_id and wl.user=uc.user and uc.chan=c.chan_name  and (uc.m='1' or uc.o='1')" ;

	}
//$sql="select * from channels order by channels_id desc";
$result=@$db_ctrl->query($sql,$db);
while ($myrow=$db_ctrl->fetch_array($result))
	{

$chan_name=$myrow["chan_name"]; 
$topic=$myrow["topic"]; 
$topic_set_by=$myrow["topic_set_by"]; 
$topic_set_date=$myrow["topic_set_date"]; 
$channels_id=$myrow["channels_id"]; 
	
	
	echo "<tr><td><input type=radio name=channels_id value=$channels_id></td><td><a href=channels.php?channels_id=$channels_id&login_id=$login_id>$chan_name</a></td></tr>";
	
	
	}
if ($manager==1)
	{
echo "<tr><td><input type=hidden name=login_id value=$login_id>
<input type=submit name=delete value=delete></td></tr>";
	}
echo "</table>";
echo "</form>";
$str=create_table_bottom();
echo $str;


	
if ($msg)
	{
	echo "<br><br><br>";
	
	$str=create_table_top(300, "red", "System Message");
	echo $str;
	echo $msg;
	$str=create_table_bottom();
	echo $str;
	
	
	
	
	
	}	
echo "</td></tr>";







echo "
</table>";




?>
</body>
</html>
