<?php

include("database.inc.php");
$sql="delete from user";
$result=mysql_query($sql,$db);
$sql="delete from user_host";
$result=mysql_query($sql,$db);
$sql="delete from chan_user";
$result=mysql_query($sql,$db);
$sql="delete from user_bot";
$result=mysql_query($sql,$db);
$sql="delete from chan_bans";
$result=mysql_query($sql,$db);


function get_access($str)
	{
	
	for ($i=0;$i<strlen($str);$i++)
		{
		
		$cur=substr($str,$i,1);
		
		switch ($cur)
			{
			
			case "v":
				$return_col[].=" v ";
				$return_val[].=" 'Y' ";
				
				break;
			case "o":
				$return_col[].=" o ";
				$return_val[].=" 'Y' ";
				
				break;
			case "m":
				$return_col[].=" m ";
				$return_val[].=" 'Y' ";
				
				break;
			case "n":
				$return_col[].=" n ";
				$return_val[].=" 'Y' ";
				break;
			case "f":
				$return_col[].=" f ";
				$return_val[].=" 'Y' ";
				break;
			case "p":
				$return_col[].=" p ";
				$return_val[].=" 'Y' ";
				break;
			case "b":
				$return_col[].=" b ";
				$return_val[].=" 'Y' ";
				break;
			case "h":
				$return_col[].=" h ";
				$return_val[].=" 'Y' ";
				break;
			case "j":
				$return_col[].=" j ";
				$return_val[].=" 'Y' ";
				break;
			case "t":
				$return_col[].=" t ";
				$return_val[].=" 'Y' ";
				break;
			case "x":
				$return_col[].=" x ";
				$return_val[].=" 'Y' ";
				break;			
			}
		
		
		
		}
	if ($return_col)
		{
		if (strlen($str)!=1)
			{	
			$cols=implode(",",$return_col);
			$val=implode(",",$return_val);
			}
		else
			{
			$cols=$return_col[0];
			$val=$return_val[0];
			}	
		$hold[0]=$cols;
		$hold[1]=$val;
		return $hold;
		}
	else
		{
		return 0;
		
		}	
	}

$fp=fopen("tclfiles/userfile.user","r");

if (!$fp)
	{
	echo "cant open file <br>";
	exit;
	}
while (!feof($fp))
	{
	
	
	$str=fgets($fp,4096);
	
	$str=explode(" ",trim($str));
	$hold_count=0;
	for ($i=0;$i<count($str);$i++)
		{
		
		if (trim($str[$i])!="")
			{
			
			$hold[$hold_count]=$str[$i];
			$hold_count++;
			}
		
		}
	$str=$hold;	
	
	switch ($str[0])
		{
		case "!":
			$access=get_access($str[3]);
			if ($access)
				{
			$sql= "insert into user_chan (user,chan, $access[0]) values ('$global_user','$str[1]',$access[1])";
				}
			else
				{
				$sql= "insert into user_chan (user,chan) values ('$global_user','$str[1]')";
			
				}	
			
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			break;
		case "--BOTFL":
			
			$sql= "insert into user_bot (user,h)values ('$global_user','Y')";
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			break;
		case "--HOSTS":	
			
			$sql= "insert into user_host (user,mask) values ('$global_user','$str[1]')";
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			break;
		case "--LASTON":
				
			$sql= "update user set last_on='$str[1]', last_chan='$str[2]' where user='$global_user'";
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			break;
		CASE "--PASS":
			$sql= "update user set password='$str[1]' where user='$global_user'";
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			break;
		case "--BOTADDR":
			
			$ip_port=explode(":",$str[1]);
			$ports=explode("/",$ip_port[1]);
			
			$sql= "update user_bot set botaddr='$ip_port[0]', telnet='$ports[0]', port2='$ports[1]' where user='$global_user'";
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			
			break;
		CASE "--XTRA":
			
			$sql= "update user set created='$str[2]' where user='$global_user'";
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			break;
		case "-":
			
			$data=explode(":",$str[1]);
			$data[2]=str_replace("+","",$data[2]);
			$sql= "insert into chan_bans (chan,host_mask,flag,created,last_used,set_by,reason) values ('$ban_chan','$data[0]','$data[1]','$data[2]','$data[3]','$data[4]','$data[5]')";
			$result=mysql_query($sql,$db);
			if (!$result)
				{
				echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
				
				}
			break;	
		default :
		
			if (substr($str[0],0,2)=="::")
				{
				
				$ban_chan=str_replace("::","",$str[0]);
				
				}
			else if (substr($str[0],0,2)=="&&")
				{
				
				
				}
			else if (substr($str[0],0,2)=="$$")
				{
				
				
				
				}	
			else
				{
				
				
				
				$global_user=$str[0];
				
				$access=get_access($str[2]);
				
				if ($access)
					{	
					$sql= "insert into user (user ,$access[0] ) values ('$str[0]',$access[1])";
					}
				else
					{
					$sql= "insert into user (user ) values ('$str[0]')";
					}	
				
				$result=mysql_query($sql,$db);
				if (!$result)
					{
					echo "mysql error: ".mysql_error($db)."<br>$sql<br>";
					
					}
				
				}	
			
			break;
		}
	
	
	}



?>