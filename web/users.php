<html>
<body bgcolor=ffffff>
<?php




include("table.inc.php");
include("menu.inc.php");
include("database.inc.php");

if ($delete)
	{
	$sql="delete from user where user='$user'";
	
	if (($result=@mysql_query($sql,$db))!=0)
		{
		$sql="delete from user_bot where user='$user'";
		$result=@mysql_query($sql,$db);
		$sql="delete from user_chan where user='$user'";
		$result=@mysql_query($sql,$db);
		$sql="delete from user_host where user='$user'";
		$result=@mysql_query($sql,$db);
		
		echo "Deleted user $user <br>";
		}
	
	}
else if ($update)
	{
	if ($user!=$old_user)
		{
		
		$sql_check="select * from user where user='$user'";
		$result=@mysql_query($sql_check,$db);
		if(mysql_num_rows($result)==0)
			{
		// run a check to makes sure that this isnt a dup user name
		// then update all the tables changing the user
		
		$sql="update user set user='$user' where user='$old_user'";
		$result=@mysql_query($sql,$db);
		$sql="update user_bot set user='$user' where user='$old_user'";
		$result=@mysql_query($sql,$db);
		$sql="update user_chan set user='$user' where user='$old_user'";
		$result=@mysql_query($sql,$db);
		$sql="update user_host set user='$user' where user='$old_user'";
		$result=@mysql_query($sql,$db);
		}
	else
		{
		echo "$user already exsists cant change $old_user to $user <br>";
			
		$user=$old_user;
		}	
		
		
		
		}
$v ="global_v";
$o ="global_o";
$m    ="global_m";
$n  ="global_n";
$f    ="global_f";
$p  ="global_p";
$b   ="global_b";
$h  ="global_h";
$j="global_j";
$t ="global_t";
$x="global_x";
$sql="update user set ";
if ($$x)
	{
	
	$sql.=" x='Y'";
	
	
	}
else
	{
	
	$sql.=" x='N'";
	
	
	}	
if ($$t)
	{
	
	$sql.=", t='Y'";
	
	
	}
else
	{
	
	$sql.=", t='N'";
	
	
	}	
if ($$j)
	{
	
	$sql.=", j='Y'";
	
	
	}
else
	{
	
	$sql.=", j='N'";
	
	
	}	
if ($$h)
	{
	
	$sql.=", h='Y'";
	
	
	}
else
	{
	
	$sql.=", h='N'";
	
	
	}	
if ($$b)
	{
	
	$sql.=", b='Y'";
	if ($change_pass)
		{
		$pass_change_sql="update user set password='$change_pass', mysql_pass='$change_pass' where user='$user'";
		$result=@mysql_query($pass_change_sql,$db);
		echo "$pass_change_sql <br>";
	
	}
else
	{
	
	$sql.=", b='N'";
	if ($change_pass)
		{
		include_once("bf_lib.php");
		$pass=bf_encrypt_pass($change_pass);
	
		$pass_change_sql="update user set password='$pass' ,mysql_pass=password('$change_pass') where user='$user'";
		$result=@mysql_query($pass_change_sql,$db);
	
		}
	
	}	
if ($$p)
	{
	
	$sql.=", p='Y'";
	
		
		
		
		}
	
	}
else
	{
	
	$sql.=", p='N'";
	
	
	
	
	}	
if ($$f)
	{
	
	$sql.=", f='Y'";
	
	
	}
else
	{
	
	$sql.=", f='N'";
	
	
	}	
if ($$n)
	{
	
	$sql.=", n='Y'";
	
	
	}
else
	{
	
	$sql.=", n='N'";
	
	
	}	
if ($$m)
	{
	
	$sql.=", m='Y'";
	
	
	}
else
	{
	
	$sql.=", m='N'";
	
	
	}	
if ($$o)
	{
	
	$sql.=", o='Y'";
	
	
	}
else
	{
	
	$sql.=", o='N'";
	
	
	}	
if ($$v)
	{
	
	$sql.=", v='Y'";
	
	
	}
else
	{
	
	$sql.=", v='N'";
	
	
	}	

	
$sql.=" where user='$user'";		
echo "Global modes ".$sql."<br>";		
$result=@mysql_query($sql,$db);	
	
		
	
	for ($i=0;$i<count($clean_chan);$i++)
		{
		
		$remove="remove_".$clean_chan[$i];
		
		if ($$remove)
			{
			
			$sql="delete from user_chan where user='$user' and chan='#".$clean_chan[$i]."'";	
			$result=@mysql_query($sql,$db);	
			echo "$sql <br>";
			}
		else
			{	
		$sql="update user_chan set ";
		$f="f_".$clean_chan[$i];
		$v="v_".$clean_chan[$i];
		$o="o_".$clean_chan[$i];
		$m="m_".$clean_chan[$i];
		
		if ($$v)
			{
			
			$sql.=" v='Y' ";
			
			}
		else
			{
			
			$sql.=" v='N' ";
			}
				
		if ($$o)
			{
			
			$sql.=", o='Y' ";
			
			}
		else
			{
			
			$sql.=", o='N' ";
			}
		if ($$f)
			{
			
			$sql.=", f='Y' ";
			
			}
		else
			{
			
			$sql.=", f='N' ";
			}	
		if ($$m)
			{
			echo $$m;
			$sql.=", m='Y' ";
			
			}
		else
			{
			
			$sql.=",m='N' ";
			}
			
		$sql.=" where user='$user' and chan='#".$clean_chan[$i]."'";	
		$result=@mysql_query($sql,$db);	
		echo "Channel modes ".$sql."<bR>";
		
		}
	
		}
		
	for($i=0;$i<count($mask);$i++)
		{
		
		if (trim($mask[$i])!="")
			{
		$sql="update user_host set mask='$mask[$i]' where host_id=$host_id[$i]";
		$result=@mysql_query($sql,$db);	
			}
		else
			{
			
			$sql="delete from user_host where host_id=$host_id[$i]";
			$result=@mysql_query($sql,$db);	
			}	
		
		
		echo "host modes ".$sql."<bR>";
		
		}	
	
	if ($add_chan)
		{
		$sql_check="select * from user_chan where chan='$add_chan' and user='$user'";
		$result=@mysql_query($sql_check,$db);
		if (mysql_num_rows($result)==0)
			{
			$v="add_v";
		$o="add_o";
		$m="add_m";
		$f="add_f";
		if ($$v)
			{
			
			$v="Y";
			
			}
		else
			{
			
			$v="N";
			}
		if ($$f)
			{
			
			$f="Y";
			
			}
		else
			{
			
			$f="N";
			}	
		if ($$o)
			{
			
			$o="Y";
			
			}
		else
			{
			
			$o="N";
			}
		if ($$m)
			{
			$m="Y";
			
			}
		else
			{
			
			$m="N";
			}
			
			
			
			$sql="insert user_chan (user,chan,v,f,o,m) values ('$user','$add_chan','$v','$f','$o','$m')";
			$result=@mysql_query($sql,$db);	
			echo $sql."<br>";
		
		
		
		
			}
		}
	
	if ($add_host)
		{
		$sql="insert into user_host (user,mask) values ('$user','$add_host')";
		$result=@mysql_query($sql,$db);	
		
		}
		
		
		
		
		
		
		
	}



if (!$alter)
	{
echo "<form name=chan_select action=users.php method=post>";	
echo "<select name=find_chan onchange=document.chan_select.submit()>";

if ($manager)
	{
$sql="select distinct chan from user_chan";
	}
else
	{
	$sql="select c.chan_name as chan from web_login wl, user_chan uc , channels c where web_login_id=$user_id and wl.user=uc.user and uc.chan=c.chan_name and c.active='Y' and (uc.m='Y' or uc.o='Y')" ;
	
	
	}	

$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result))
	{
	$chan=$myrow["chan"];
	
	if ($find_chan)
		{
		$selected=" selected";
		
		}
	else
		{
		unset($selected);
		}	
	echo "<option value=$chan $selected>$chan</option>";
	}

echo "</select>";	
echo "<input type=hidden name=login_id value=$login_id></form>";
	
if (!$find_chan)
	{
	$sql="select * from user limit 10";
	}
else
	{	
$sql="select * from user ,user_chan uc where user.user=uc.user and uc.chan='$find_chan'";

	}
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result))
	{
echo "<form user.php method=post>";	
echo "<table><tr><td>";
$str=create_table_top("500", "blue", "EGG USER " );
echo $str;
echo "<tr>
	<td>HANDLE</td>
	<td>TCL PASS</td>
	<td>MYSQL PASS</td>
	<td>NOTES</td>
	<td>FLAGS </td>
	<td>LAST</td>
  </tr>";
	$user=$myrow["user"];
	$pass=$myrow["password"];
	
	$mysql_pass=$myrow["mysql_password"];
	if ($pass)
		{
		$pass="YES";
		
		}
	if ($mysql_pass)
		{
		$mysql_pass="YES";
		
		}	
	unset($modes);
	for($i=2;$i<13;$i++)
		{
		
		$name[$i]=mysql_field_name($result,$i);
		
		if ($myrow[$i]=="Y")
			{
			
			$modes.=$name[$i];
			
			}
		
		
		}
	
	
	echo "<tr>
	<td>$user</td>
	<td>$pass.</td>
	<td>$mysql_pass.</td>
	<td>0.</td>
	<td>$modes.</td>
	<td>LAST</td>
  </tr>";
  
  $sql_chans="select * from user_chan where user='$user'";
  $result_chan=mysql_query($sql_chans,$db);
  while ($myrow=mysql_fetch_array($result_chan))
  	{
  	
  	$chan=$myrow["chan"];
  	unset($modes);
	for($i=2;$i<4;$i++)
		{
		
		$name[$i]=mysql_field_name($result,$i);
		
		if ($myrow[$i]=="Y")
			{
			
			$modes.=$name[$i];
			
			}
		
		
		}
	if ($myrow["m"]=="Y")
			{
			
			$modes.=$name[$i];
			
			}	
	if ($myrow["f"]=="Y")
			{
			
			$modes.='f';
			
			}			
	echo "<tr>
	<td>$chan</td>
	<td><br></td>
	<td><br></td>
	<td><br></td>
	<td>$modes</td>
	<td>LAST</td>
  </tr>";		
  	}
  
  $sql_hosts="select * from user_host where user='$user'";
  $result_hosts=@mysql_query($sql_hosts,$db);
  while ($myrow=mysql_fetch_array($result_hosts))
  	{
  	
  	$all.=$myrow["mask"].", ";
  	
  	
  	}
  echo "<tr><td colspan=6>HOSTS $all</td><td>";	
  $str=create_table_bottom();
  echo $str;
 echo "</td><td><input type=hidden name=login_id value=$login_id><input type=hidden name=user value=$user>
  <input type=submit name=delete value='Delete User'><br>
  <input type=submit name=alter value='Alter User'>
  
  </td></tr></table>";
  echo "</form>";
echo "<br>";	
	unset($all);
	
	
	
	}


	}
else
	{
	// this is for alter user.
	
	echo "<form action=users.php method=post>";
	$sql="select * from user where user='$user'";
	$result=@mysql_query($sql,$db);
	$myrow=@mysql_fetch_array($result);
	$user=$myrow["user"];
	$password=$myrow["password"];
	
	if ($password)
		{
		$password="YES";
		
		}
	else
		{
		
		$password="NO";
		}	
	$mysql_password=$myrow["mysql_password"];
	if ($mysql_password)
		{
		$mysql_password="YES";
		
		}
	else
		{
		
		$mysql_password="NO";
		}	
	
	
	
	$str=create_table_top("500", "green", "EGG USER " );
	echo $str;
	echo "<tr><td colspan=12>
	User:<br>
	<input type=text name=user value='$user'>
	</td></tr>";
	
	echo "<tr><td colspan=6>
	Tcl password:<br>
	$password
	</td><td colspan=6>
	Mysql password:<br>
	$mysql_password
	</td></tr>";
	
	echo "<tr><td colspan=12>
	Change Password:<br>
	<input type=password name=change_pass size=30>
	</td></tr>";		
	
	
	echo "<tr><td>Global Modes</td>";
	for($i=2;$i<13;$i++)
		{
		
		$name[$i]=mysql_field_name($result,$i);
		
		if ($myrow[$i]=="Y")
			{
			$checked=" checked ";
			
			}
		else
			{
			
			unset($checked);
			}	
			
	
			
	echo "<td >
	$name[$i]:<br>
	<input type=checkbox name=global_$name[$i] value='Y' $checked>
	</td>";
			
			
		
		
		}
	echo "</tr>";
	
	echo "<tr><td colspan=12>Channels</td></tr>";
	
	 $sql_chans="select * from user_chan where user='$user'";
  $result_chan=mysql_query($sql_chans,$db);
  $chans=0;
  while ($myrow=mysql_fetch_array($result_chan))
  	{
  	
  	$chan=$myrow["chan"];
  	$clean_chan=str_replace("#","",$myrow["chan"]);
  	unset($modes);
  	
  	echo "<tr><td colspan=1><input type=hidden name=clean_chan[$chans] value=$clean_chan>$chan</td>";
	if ($myrow["f"]=="Y")
			{
			$checked=" checked ";
			
			}
		else
			{
			
			unset($checked);
			}				
	echo "<td colspan=1>
	f <br>
	<input type=checkbox name=f_$clean_chan value='Y' $checked> 
	</td>";
	for($i=2;$i<4;$i++)
		{
		
		$name[$i]=mysql_field_name($result,$i);
		
		if ($myrow[$i]=="Y")
			{
			$checked=" checked ";
			
			}
		else
			{
			
			unset($checked);
			}	
	echo "<td >
	$name[$i]:<br>
	<input type=checkbox name=$name[$i]_$clean_chan value='Y' $checked>
	</td>";
		
		
		}
	if ($myrow["m"]=="Y")
			{
			$checked=" checked ";
			
			}
		else
			{
			
			unset($checked);
			}
	echo "<td colspan=1>
	$name[$i]:<br>
	<input type=checkbox name=m_$clean_chan value='Y' $checked> 
	</td>";				
	
	echo "
	<td colspan=7>
	
	<input type=checkbox name=remove_$clean_chan value='Y' >Remove $chan 
	</td>
	</tr>";	
	
	$chans++;
  	}
  echo "<tr><td colspan=12>Add a chan</td></tr>";	
  $sql="select * from channels order by chan_name";
  $result=@mysql_query($sql,$db);
  echo "<tr><td colspan=1><select name=add_chan ><option value=0>add chan </option>";	
  while ($myrow=mysql_fetch_array($result))
  	{
  	$chan=$myrow["chan_name"];
  	echo "<option value=$chan>$chan</option>";
  
  	}
  	echo "</select></td>";
  	
  echo "<td>v <br>
  <input type=checkbox name=add_v value=Y></td>
   ";	
    echo "<td>f <br>
  <input type=checkbox name=add_f value=Y></td>
   ";	
    echo "<td>o <br>
  <input type=checkbox name=add_o value=Y></td>
   ";	
    echo "<td colspan=8>m <br>
  <input type=checkbox name=add_m value=Y></td>
   ";	
  echo "</tr>";		
  echo "<tr><td colspan=12>Host Masks</td></tr>";
  $sql_hosts="select * from user_host where user='$user'";
  $result_hosts=@mysql_query($sql_hosts,$db);
  $i=0;
  while ($myrow=mysql_fetch_array($result_hosts))
  	{
  	$host_id=$myrow["host_id"];
  	$host=$myrow["mask"];
  	echo "<tr><td colspan=12><input type=hidden name=host_id[$i] value=$host_id><input type=text name=mask[$i] value=$host size=60></td></tr>";
  	
  	$i++;
  	}
 echo "<tr><td colspan=12>Add a host: <br><input type=text name=add_host  size=60></td></tr>";
	
	
	
	 echo "<tr><td colspan=6><input type=hidden name=login_id value=$login_id><input type=hidden name=old_user value=$user><input type=submit name=update value='Update User'></td>
	 
	 <td colspan=6><input type=submit name=delete value='Delete User'></td>
	 </tr>";	
	
	$str=create_table_bottom();
  	echo $str;
	echo "</form>";
	}	


	
	


?>
</body>
</html>