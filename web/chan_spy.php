<html>
<body bgcolor=FFFFFF>
<?php
include("database.inc.php");
include("menu.inc.php");

if ($manager)
	{
	$sql="select chan_name from channels where active='Y'";
	}
else
	{
	
	$sql="select c.chan_name as chan_name from web_login wl, user_chan uc , channels c where wl.web_login_id=$user_id and wl.user=uc.user and uc.chan=c.chan_name and c.active='Y' and (uc.m='Y' or uc.o='Y')" ;

	}

$result=@mysql_query($sql,$db);
echo  "<form name=myform action=chan_spy.php method=post >";
echo "Curent active channels <br><select name=chan onchange=document.myform.submit()><option value=0>select a chan</option>";
while($myrow=@mysql_fetch_array($result))
	{
	$new_chan=$myrow["chan_name"];
	if ($new_chan==$chan)
		{
		$selected=" selected ";
		
		}
	else
		{
		unset($selected);
		}	
	echo "<option value=$new_chan $selected>$new_chan</option>";
	
	}

echo "</select><input type=hidden name=login_id value=$login_id></form><br>";


if ($chan && !$submit)
	{
	echo "<form action=chan_spy.php method=post>";
	echo "<table width=100%>";
	echo "<tr>
		<td>Nick</td>
		<td>op</td>
		<td>voice </td>
		<td>user</td>
		<td>date joined</td>
		<td>last_spoke</td>
		<td>ident</td>
		<td>hostmask</td>
		<td>ban</td>
		<td>kick</td>
		</tr>";
	$sql="select * from chan_users where reason is null and upper(chan_name)= upper('$chan') order by mode,nick";
	$result=@mysql_query($sql,$db);
	$i=0;
	while($myrow=@mysql_fetch_array($result))
		{
		$nick=$myrow["nick"];
		
		$mode=$myrow["mode"];
		$date=$myrow["date"];
		$ident=$myrow["ident"];
		$last_spoke=$myrow["last_spoke"];
		if ($mode=="o")
			{
			$op="checked ";
			unset($voice);
			unset($user);
			}
		else if ($mode=="v")
			{
			$voice="checked";
			unset($op);
			unset($user);
			}	
		else
			{
			$user="checked";
			unset($voice);
			unset($op);
			}	
		$host_mask=$myrow["host_mask"];
		echo "<tr>
		<td>";
		if ($ident && $host_mask)
			{
		$my_nick=rawurlencode($nick);
		$host=$ident."@".$host_mask;
		$add_chan=str_replace("#","",$chan);
		echo "<a href=add_user.php?user=$my_nick&add_host=$host&add_chan=$add_chan&login_id=$login_id>$nick </a>";
		
			}
		else
			{
			echo $nick;
			
			}	
		echo "<input type=hidden name=nick[$i] value=\"$nick\"><input type=hidden name=mode[$i] value=\"$mode\"></td>
		<td><input type=checkbox name=op_$i value=\"$nick\" $op></td>
		<td><input type=checkbox name=voice_$i value=\"$nick\" $voice></td>
		<td><input type=checkbox name=user_$i value=\"$nick\" $user></td>
		<td>$date</td>
		<td>$last_spoke</td>
		<td>$ident      <input type=hidden name=ident[$i] value=\"$ident\"></td>
		<td>$host_mask <input type=hidden name=host_mask[$i] value=\"$host_mask\"></td>
		<td><input type=checkbox name=ban[$i] value=\"$nick\"></td>
		<td><input type=checkbox name=kick[$i] value=\"$nick\"></td>
		<td><input type=checkbox name=whois[$i] value=\"$nick\"></td>
		</tr>";
		$i++;
		}
		echo "<tr><td colspan=7>Curently ".mysql_num_rows($result)." users in $chan</td></tr>";
echo "</table><input type=hidden name=login_id value=$login_id> <input type=hidden name=chan value=$chan><input type=submit name=submit></form>";
	}
else 
	{

	for ($i=0;$i<count($nick);$i++)
		{
		
		if($whois[$i])
			{
			
			$action=" WHOIS $nick[$i] ";
			$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
			
			$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
			
			}
		
		
		if ($ban[$i])
			{
			if ($ident[$i] && $host_mask[$i])
				{
				
				if (ereg("[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}",$host_mask[$i]))
					{
					
					$mask_array=explode(".",$host_mask[$i]);
					
					$ban="*!*@".$mask_array[0].".".$mask_array[1].".".$mask_array[2].".*";
					
					
				
					}
				else
					{
					$mask_array=explode(".",$host_mask[$i]);
					
					if (count($mask_array)==2)
						{
						
						$ban="*!*@".$host_mask[$i];
						
						
						}
					else
						{
						$last_mask=count($mask_array) - 1;
						$next_mask=count($mask_array) - 2;
						
						                                 $ban="*!*@*.".$mask_array[$next_mask].".".$mask_array[$last_mask];
						
						
						
						}	
					
					
					}	
					
				$action=  "MODE  $chan +b $ban  ";
				
				$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
			
			$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
				
				
				$action= "KICK  $chan $nick[$i]  ";
				
					$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
			
			$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
				
				}
			}
		if ($kick[$i])
			{
			
			echo "kick $nick[$i] from $chan<br>";
			$action="KICK $chan $nick[$i]";
			$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
			
			$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
			}	
		
		
		$op="op_".$i;
		$voice="voice_".$i;
		$user="user_".$i;
		
		switch ($mode[$i])
			{
			case "o":
				
				if (!$$op)
					{
					$action = "MODE $chan -o $nick[$i]";
						$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
					
					$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
					
					
					
					}
				if ($$voice)
					{
					$action = "MODE $chan +v $nick[$i]";
								$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
					
					$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
					
					}	
				
			
				break;
			case "v":
				if ($$op)
					{
					$action= "MODE $chan +o $nick[$i]";
								$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
					
					$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
					}
				if (!$$voice && !$$op)
					{
					
					$action = "MODE $chan -v $nick[$i]";
								$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
					
					$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
					}
				if ($$user)
					{
					$action=  "MODE $chan -v $nick[$i]";
								$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
					
					$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
					
					}			
			
				break;
			case "u":
				if ($$op)
					{
					$action = "MODE $chan +o $nick[$i]";
					
								$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
					
					$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
					}
				if ($$voice && !$$op)
					{
					$action= "MODE $chan +v $nick[$i]";
							$sql="insert into mode_data (chan_name,action,date_inserted) values ('$chan','$action','$now')";
					
					$result=@mysql_query($sql,$db);
					if (!$result)
						{
						
						echo mysql_error($db);
						
						}
					
					}
			
			
			
				break;
			
			}
		
		
		
		
		}


	}	



?>

</body>
</html>