<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");

if ($new=="create")
	{
	
	
	
	$sql="insert into servers ( server_group_id,server_name,port  )  values ( $server_group_id,'$server_name',$port)";
				
		
	if ($sql)
		{	
		$result=$db_ctrl->query($sql,$db);
		if (!$result)
			{
			$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
			}
		else
			{
			$msg.="servers inserted<br>";
			
			}
		}
	}
if ($update=="update")	
	{

	
			
			
	$sql="update servers set server_group_id =  $server_group_id,server_name = '$server_name',port =  $port  where servers_id = $servers_id ";
		
	
	
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
if (($delete=="delete") && $servers_id)	
	{
	
	$sql="delete from servers where servers_id = $servers_id";
	$result=$db_ctrl->query($sql,$db);
	if (!$result)
		{
		$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
		}
	else
		{
		$msg.="servers deleted<br>";
		
		}
	unset($servers_id);
	}
	
	
	
include("table.inc.php");
//  create new news 

if (!$servers_id)
	{
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(300, "green","create servers");
	echo $str;
	
	


	echo "<form action=servers.php method=post  >";
	echo "<table width=100%>";
	
	





$select_server_group_id="select * from server_groups";  

			$result_select=@$db_ctrl->query($select_server_group_id,$db);
			echo "<select name=server_group_id >  ";
			while ($myrow=$db_ctrl->fetch_array($result_select))
				{
				$server_group_id=$myrow[0];
				$temp=$myrow[1];
				echo "<option value=$server_group_id>$temp</option>   ";

				}
			echo "</select>";
				echo " server_name <br> 
			<input type=text name=server_name><br> "; 
                         echo " port <br> 
			<input type=text name=port><br> "; 
                         




	echo "<tr><td><input type=hidden name=login_id values=$login_id><input type=submit name=new value=create>
	<input type=reset name=reset value=reset></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;

	}
else
	{
	// update existing news.
	$sql="select * from servers where servers_id=$servers_id ";
	$result=@$db_ctrl->query($sql,$db);
	$myrow=@$db_ctrl->fetch_array($result);
$server_group_id=$myrow["server_group_id"]; 
$server_name=$myrow["server_name"]; 
$port=$myrow["port"]; 
$servers_id=$myrow["servers_id"]; 
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(400, "green","Update servers");
	echo $str;
	echo "<form  action=servers.php method=post  >";
	echo "<table width=100%>";
	
$select_server_group_id="select * from server_groups";  

			$result_select=@$db_ctrl->query($select_server_group_id,$db);
			echo "<select name=server_group_id >  ";
			while ($myrow2=$db_ctrl->fetch_array($result_select))
				{
				$new_server_group_id=$myrow2[0];
				$temp=$myrow2[1];
				
				if ($new_server_group_id==$server_group_id)
					{
					$checked=1;

					}
				else
					{
					unset($checked);

					}

				echo "<option value=server_group_id $checked > $temp</option>   ";

				}
			echo "</select>";
				echo " server_name <br> 
			<input type=text name=server_name value='$server_name'><br> "; 
                         echo " port <br> 
			<input type=text name=port value='$port'><br> "; 
                         	echo "<input type=hidden name=login_id values=$login_id>
	<input type=hidden name=servers_id value=$servers_id>
	<input type=submit name=update value=update>
	<input type=reset name=reset value=new onclick=\"javascript:document.location.href='servers.php?login_id=$login_id'\"></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;
	
	
	}	






echo "
</td><td VALIGN=top>";  

// show curent news in the system 

$str=create_table_top(400, "green","servers");
echo $str;

$select_server_group_id="select * from server_groups";  

			
$result_select=@$db_ctrl->query($select_server_group_id,$db);
echo "<form name=myselect method=post>";
echo "<select name=my_server_group_id onchange=document.myselect.submit()>  ";
while ($myrow=$db_ctrl->fetch_array($result_select))
	{
	$new_server_group_id=$myrow[0];
	$temp=$myrow[1];
	if ($my_server_group_id==$new_server_group_id)
		{
		
		$selected =" selected ";
		}
	else
		{
		unset($selected);
		}	
	echo "<option value=$new_server_group_id $selected>$temp</option>   ";

	}
if (!$my_server_group_id)
	{
	$my_server_group_id=$new_server_group_id;
	}	
	
echo "</select>";
echo "</form>";
echo "<form acton=servers.php method=post>";
echo "<table width=100%>";

$sql="select * from servers s, server_groups sg where s.server_group_id=sg.server_groups_id and sg.server_groups_id=$my_server_group_id order by server_group, server_name desc ";
$result=@$db_ctrl->query($sql,$db);

while ($myrow=$db_ctrl->fetch_array($result))
	{

$server_group_id=$myrow["server_group_id"]; 
$server_group=$myrow["server_group"]; 
$server_name=$myrow["server_name"]; 
$port=$myrow["port"]; 
$servers_id=$myrow["servers_id"]; 
	
	
	echo "<tr><td><input type=radio name=servers_id value=$servers_id></td><td><a href=servers.php?servers_id=$servers_id&login_id=$login_id>$server_group - $server_name - $port</a></td></tr>";
	
	
	}

echo "<tr><td><input type=hidden name=login_id values=$login_id><input type=submit name=delete value=delete></td></tr>";
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