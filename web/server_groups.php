<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");

if ($new=="create")
	{
	
	
	
	$sql="insert into server_groups ( server_group  )  values ( '$server_group')";
				
		
	if ($sql)
		{	
		$result=$db_ctrl->query($sql,$db);
		if (!$result)
			{
			$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
			}
		else
			{
			$msg.="server_groups inserted<br>";
			
			}
		}
	}
if ($update=="update")	
	{

	
			
			
	$sql="update server_groups set server_group = '$server_group'  where server_groups_id = $server_groups_id ";
		
	
	
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
if (($delete=="delete") && $server_groups_id)	
	{
	$sql="delete from servers where server_group_id=$server_groups_id";
	$result=$db_ctrl->query($sql,$db);
	$sql="delete from server_groups where server_groups_id = $server_groups_id";
	$result=$db_ctrl->query($sql,$db);
	if (!$result)
		{
		$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
		}
	else
		{
		$msg.="server_groups deleted<br>";
		
		}
	unset($server_groups_id);
	}
	
	
	
include("table.inc.php");
//  create new news 

if (!$server_groups_id)
	{
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(300, "green","create server_groups");
	echo $str;
	
	


	echo "<form action=server_groups.php method=post  >";
	echo "<table width=100%>";
	
	





echo " server_group <br> 
			<input type=text name=server_group><br> "; 
                         




	echo "<tr><td><input type=hidden name=login_id value=$login_id><input type=submit name=new value=create>
	<input type=reset name=reset value=reset></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;

	}
else
	{
	// update existing news.
	$sql="select * from server_groups where server_groups_id=$server_groups_id ";
	$result=@$db_ctrl->query($sql,$db);
	$myrow=@$db_ctrl->fetch_array($result);
$server_group=$myrow["server_group"]; 
$server_groups_id=$myrow["server_groups_id"]; 
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(400, "green","Update server_groups");
	echo $str;
	echo "<form  action=server_groups.php method=post  >";
	echo "<table width=100%>";
	
echo " server_group <br> 
			<input type=text name=server_group value='$server_group'><br> "; 
                         	echo "<input type=hidden name=login_id value=$login_id>
	<input type=hidden name=server_groups_id value=$server_groups_id>
	<input type=submit name=update value=update>
	<input type=reset name=reset value=new onclick=\"javascript:document.location.href='server_groups.php?login_id=$login_id'\"></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;
	
	
	}	






echo "
</td><td VALIGN=top>";  

// show curent news in the system 

$str=create_table_top(300, "green","server_groups");
echo $str;
echo "<form acton=server_groups.php method=post>";
echo "<table width=100%>";

$sql="select * from server_groups order by server_groups_id desc";
$result=@$db_ctrl->query($sql,$db);
while ($myrow=$db_ctrl->fetch_array($result))
	{

$server_group=$myrow["server_group"]; 
$server_groups_id=$myrow["server_groups_id"]; 
	
	
	echo "<tr><td><input type=radio name=server_groups_id value=$server_groups_id></td><td><a href=server_groups.php?server_groups_id=$server_groups_id&login_id=$login_id>$server_group</a></td></tr>";
	
	
	}

echo "<tr><td><input type=hidden name=login_id value=$login_id><input type=submit name=delete value=delete></td></tr>";
echo "</table>";
echo "</form>";
echo "Warning: deleting a server group will delete all servers attached to that group.";
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