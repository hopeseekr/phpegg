<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");
include("table.inc.php");
$user=rawurldecode($user);
if ($add)
	{
	
	echo "$user";
	if ($x)
		{
	
		$x="1";
	
	
		}
		else
		{
	
		$x="0";
	
	
		}	
	if ($t)
	{
	
		$t="1";
	
	
		}
		else
		{
	
		$t="0";
	
	
		}	
if ($j)
	{
	
		$j="1";
	
	
		}
		else
		{
	
		$j="0";
	
	
		}	
if ($h)
	{
	
		$h="1";
	
	
		}
		else
		{
	
		$h="0";
	
	
		}	
if ($b)
	{
	
	$b="1";
	
	$sql_bot="insert into user_bot (user) values ('$user')";
	
	$result=@$db_ctrl->query($sql_bot,$db);	
	if ($password)
		{
		$tcl_password="'$password'";
		$mysql_password="'$password'";
		
		
		}
	else
		{
		
		$tcl_password="NULL";
		$mysql_password="NULL";
		
		}
	
	}
else
	{
	
	$b="0";
	if ($password)
		{
		include_once("bf_lib.php");
		$pass=bf_encrypt_pass($password);
	
		$tcl_password="'$pass'";
		$mysql_password="password('$password')";
	
		}
	else
		{
		
		$tcl_password="NULL";
		$mysql_password="NULL";
		
		}	
	
	}	
if ($p)
	{
	
	$p="1";
	
		
		
		
	
	
	}
else
	{
	
	$p="0";
	
	
	
	
	}	
if ($f)
	{
	
	$f="1";
	
	
	}
else
	{
	
	$f="0";
	
	
	}	
if ($n)
	{
	
	$n="1";
	
	
	}
else
	{
	
	$n="0";
	
	
	}	
if ($m)
	{
	
	$m="1";
	
	
	}
else
	{
	
	$m="0";
	
	
	}	
if ($o)
	{
	
	$o="1";
	
	
	}
else
	{
	
	$o="0";
	
	
	}	
if ($v)
	{
	
	$v="1";
	
	}
else
	{
	
	$v="1";
	
	
	}	
$now=time();	
$sql="insert into user (user,v,o,m,n,f,p,b,h,j,t,x,created,password,mysql_password) values ( 	
	'$user','$v','$o','$m','$n','$f','$p','$b','$h','$j','$t','$x',$now,$tcl_password,$mysql_password)";
$result=@$db_ctrl->query($sql,$db);	
	
	if ($add_chan)
		{
		
		$v="add_v";
		$o="add_o";
		$m="add_m";
		$f="add_f";
		if ($$v)
			{
			
			$v="1";
			
			}
		else
			{
			
			$v="0";
			}
		if ($$f)
			{
			
			$f="1";
			
			}
		else
			{
			
			$f="0";
			}	
		if ($$o)
			{
			
			$o="1";
			
			}
		else
			{
			
			$o="0";
			}
		if ($$m)
			{
			$m="1";
			
			}
		else
			{
			
			$m="0";
			}
			
			
			
			$sql="insert user_chan (user,chan,v,f,o,m) values ('$user','$add_chan','$v','$f','$o','$m')";
			
		
		$result=@$db_ctrl->query($sql,$db);	
		
		
		
			}	
	if ($add_host)
		{
		$sql="insert into user_host (user,mask) values ('$user','$add_host')";
		
		$result=@$db_ctrl->query($sql,$db);	
		}		
			
			
	}


echo "<a href=import_file.php?login_id=$login_id>import tcl userfile </a>";
	echo "<form action=add_user.php method=post>";
	
	
	
	
	$str=create_table_top("500", "green", "EGG USER " );
	echo $str;
	echo "<tr><td colspan=12>
	User:<br>
	<input type=text name=user value='$user'>
	</td></tr>";
	
	
	
	echo "<tr><td colspan=12>
	Change Password:<br>
	<input type=password name=password size=30>
	</td></tr>";		
	
	
	echo "<td>Global Modes</td><td >
        v:<br>
        <input type=checkbox name=v value='1' >
        </td><td >
        o:<br>
        <input type=checkbox name=o value='1' >
        </td><td >
        m:<br>
        <input type=checkbox name=m value='1' >
        </td><td >
        n:<br>
        <input type=checkbox name=n value='1' >
        </td><td >
        f:<br>
        <input type=checkbox name=f value='1' >
        </td><td >
        p:<br>
        <input type=checkbox name=p value='1' >
        </td><td >
        b:<br>
        <input type=checkbox name=b value='1' >
        </td><td >
        h:<br>
        <input type=checkbox name=h value='1' >
        </td><td >
        j:<br>
        <input type=checkbox name=j value='1' >
        </td><td >
        t:<br>
        <input type=checkbox name=t value='1' >
        </td><td >
        x:<br>
        <input type=checkbox name=x value='1' >
</td></tr>";
	
			

		
		

	echo "</tr>";
	
	echo "<tr><td colspan=12>Channels</td></tr>";
	
	
  echo "<tr><td colspan=12>Add a chan</td></tr>";	
  $sql="select * from channels order by chan_name";
  $result=@$db_ctrl->query($sql,$db);
  echo "<tr><td colspan=1><select name=add_chan ><option value=0>add chan </option>";	
  while ($myrow=$db_ctrl->fetch_array($result))
  	{
  	$chan=$myrow["chan_name"];
  	
  	if ($chan=="#".$add_chan)
  		{
  		$selected =" selected";
  		}
  	else
  		{
  		unset($selected);
  		
  		}	
  	echo "<option value=$chan $selected>$chan </option>";
  
  	}
  	echo "</select></td>";
  	
  echo "<td>v <br>
  <input type=checkbox name=add_v value=1></td>
   ";	
    echo "<td>f <br>
  <input type=checkbox name=add_f value=1></td>
   ";	
    echo "<td>o <br>
  <input type=checkbox name=add_o value=1></td>
   ";	
    echo "<td colspan=8>m <br>
  <input type=checkbox name=add_m value=1></td>
   ";	
  echo "</tr>";		
  echo "<tr><td colspan=12>Host Masks</td></tr>";
 
 echo "<tr><td colspan=12>Add a host: <br><input type=text name=add_host value='$add_host' size=60></td></tr>";
	
	
	
	 echo "<tr><td colspan=12><input type=hidden name=login_id value=$login_id><input type=submit name=add value='Add User'></td>
	 
	
	 </tr>";	
	
	$str=create_table_bottom();
  	echo $str;
	echo "</form>";
	
	
?>	

</body></html>