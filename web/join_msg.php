<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");
include("database.inc.php");
echo $channel_name;
if ($channels_id)
	{
$sql="select * from channels where channels_id=$channels_id";
$result=@mysql_query($sql,$db);
$myrow=@mysql_fetch_array($result);
$channel_name=$myrow["chan_name"];
	}

if ($new=="create")
	{
	
	
	
	$sql="insert into join_msg ( chan_name,msg  )  values ( '$chan_name','$msg')";
				
		
	if ($sql)
		{	
		$result=mysql_query($sql,$db);
		if (!$result)
			{
			$msg.= "Mysql error: ".mysql_error($db)."<br>";
			}
		else
			{
			$msg.="join_msg inserted<br>";
			
			}
		}
	}
if ($update=="update")	
	{

	
			
			
	$sql="update join_msg set chan_name = '$chan_name',msg = '$msg'  where join_msg_id = $join_msg_id ";
		
	
	
	if ($sql)
		{	
		$result=mysql_query($sql,$db);
		if (!$result)
			{
			$msg.="Mysql error: ".mysql_error($db)."<br>";
			}
		else
			{
			$msg.="{$title} updated<br>";
			
			}
		}
	}
if (($delete=="delete") && $join_msg_id)	
	{
	
	$sql="delete from join_msg where join_msg_id = $join_msg_id";
	$result=mysql_query($sql,$db);
	if (!$result)
		{
		$msg.= "Mysql error: ".mysql_error($db)."<br>";
		}
	else
		{
		$msg.="join_msg deleted<br>";
		
		}
	unset($join_msg_id);
	}
	
	
	
include("table.inc.php");
//  create new news 

if (!$join_msg_id)
	{
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(300, "green","create join_msg");
	echo $str;
	
	


	echo "<form action=join_msg.php method=post  >";
	echo "<table width=100%>";
	
	





		echo " chan_name <br> 
			$channel_name<input type=hidden name=chan_name value='$channel_name'><br> "; 
                         echo " msg <br> 
			<input type=text name=msg><br> "; 
                         




	echo "<tr><td><input type=hidden name=login_id value=$login_id><input type=hidden name=channels_id value=$channels_id><input type=submit name=new value=create>
	<input type=reset name=reset value=reset></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;

	}
else
	{
	// update existing news.
	$sql="select * from join_msg where join_msg_id=$join_msg_id ";
	$result=@mysql_query($sql,$db);
	$myrow=@mysql_fetch_array($result);
$chan_name=$myrow["chan_name"]; 
$msg=$myrow["msg"]; 
$join_msg_id=$myrow["join_msg_id"]; 
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(400, "green","Update join_msg");
	echo $str;
	echo "<form  action=join_msg.php method=post  >";
	echo "<table width=100%>";
	
echo " chan_name <br>$chan_name 
			<input type=hidden name=chan_name value='$chan_name'><br> "; 
                         echo " msg <br> 
			<input type=text name=msg value='$msg'><br> "; 
                         	echo "
                         	<input type=hidden name=login_id value=$login_id>
                         	<input type=hidden name=channels_id value=$channels_id>
	<input type=hidden name=join_msg_id value=$join_msg_id>
	<input type=submit name=update value=update>
	<input type=reset name=reset value=new onclick=\"javascript:document.location.href='join_msg.php?channels_id=$channels_id&login_id=$login_id'\"></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;
	
	
	}	






echo "
</td><td VALIGN=top>";  

// show curent news in the system 

$str=create_table_top(300, "green","join_msg");
echo $str;
echo "<form acton=join_msg.php method=post>";
echo "<table width=100%>";

$sql="select * from join_msg where chan_name='$channel_name'order by join_msg_id ";
$result=@mysql_query($sql,$db);
while ($myrow=mysql_fetch_array($result))
	{

$chan_name=$myrow["chan_name"]; 
$msg=$myrow["msg"]; 
$join_msg_id=$myrow["join_msg_id"]; 
	
	
	echo "<tr><td><input type=radio name=join_msg_id value=$join_msg_id></td><td><a href=join_msg.php?join_msg_id=$join_msg_id&channels_id=$channels_id&login_id=$login_id>$msg</a></td></tr>";
	
	
	}

echo "<tr><td>
<input type=hidden name=login_id value=$login_id>
<input type=hidden name=channels_id value=$channels_id><input type=submit name=delete value=delete></td></tr>";
echo "</table>";
echo "</form>";
echo "Note: if you dont want someone to recieve the on join msg simply add them as a user giving them +f (friend) flag";
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