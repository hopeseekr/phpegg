<?php
set_time_limit(999999);
include_once("bf_lib.inc");


function check_global_access($nick)
{
	global $db_ctrl,$db;
	
	$sql="select m,n from user where user='$nick'";
	$result=$db_ctrl->query($sql,$db);
	$myrow=$db_ctrl->fetch_array($result);
	$m=$myrow["m"];
	$n=$myrow["n"];
	if (($m=="Y") || ($n=="Y"))
	{
		return 1;
	}
}

function check_chan_access($nick,$chan)
{
	
	global $db_ctrl,$db;
	
	$sql="select * from user_chan where chan='$chan' and user='$nick' and o='1' limit 1";
	$result=$db_ctrl->query($sql,$db);
		
	if ($db_ctrl->num_rows($result)==1)
	{
		return 1;
	}
}

function check_db_login($test,$pass)
{
    global $db_ctrl,$db;
	
    // first we test if the mysql_password matches  with the hostmask 
    $sql="select user.user from user_host uh, user where '$test' like replace(replace(mask,'*','%'),'!','') and uh.user=user.user and user.mysql_password=password('$pass')";
	
    $result=$db_ctrl->query($sql,$db);
    if ($myrow=$db_ctrl->fetch_array($result)) {
		$user=$myrow["user"];
		return $user;
    }
    if ($db_ctrl->num_rows($result)==0) {
		
		// if the mysqlpassword doesnt match then we check if its null if it is then we will
		// assume that they havent loged into the php bot before so we check there tcl bot
		// encrypted password.
		$sql="select user.user from user_host uh, user where '$test' like replace(replace(mask,'*','%'),'!','') and uh.user=user.user and user.mysql_password is null";
	
		$result=$db_ctrl->query($sql,$db);
		if ($db_ctrl->num_rows($result)==0) {
		    $login_access=check_login($test,$pass);
		    return $login_access;
		}	
    }
}

function check_login($test,$pass)
{
	global $db_ctrl,$db;
	//echo "test is and pass is $test $pass \n";
	$old_pass=$pass;
	$pass=bf_encrypt_pass($pass);
	$test_array=explode("@",$test);
	if ($debug==1)
	{
		echo "the crypted pass is $pass \n";
	}
	$sql="select user.user from user_host uh, user where '$test' like replace(replace(mask,'*','%'),'!','') and uh.user=user.user and user.password='$pass'";
	$result=$db_ctrl->query($sql,$db);
	if ($myrow=$db_ctrl->fetch_array($result))
	{
		$user=$myrow["user"];
		// this is the first time this user has loged in so we are going to 
		// use mysql encryption on there password to speed up all future logoins.
		
		$update="update user set mysql_password=password('$old_pass') where user='$user'";
		$result_update=$db_ctrl->query($update,$db);
		
		return $user;
	}
}
	
function check_host_mask($test_mask,$host_mask)
{
	echo "$test_mask , $host_mask <br>";
	//if (substr($host_mask,0,1)=="*")
	//	{
		$test_mask_array=explode(".",$test_mask);
		$host_mask_array=explode(".",$host_mask);
			
		for ($i=count($test_mask_array);$i>=0;$i--)
		{
			if (trim($host_mask_array[$i]) && trim($test_mask_array[$i]))
			{
				if (($host_mask_array[$i]==$test_mask_array[$i])  || ($host_mask_array[$i]=="*"))
				{
					if ($debug==1)
					{
						echo "MATCH ON - $host_mask_array[$i] vs $test_mask_array[$i]  \n";
					}
				}
				else
				{
					if ($debug==1)
					{
						echo "NO MATCH ON - $host_mask_array[$i] vs $test_mask_array[$i]  \n";
					}
					$no_match=1;
					break;
				}	
			}
		}
	//}	
		
	if (!$no_match)
	{
		return 1;
	}
	else
	{
		return 2;
	}	
}

function ident_check($test_ident,$host_ident)
{
	if (strstr($host_ident,"*"))
	{
		// matches the ~
		if ($debug==1)
		{
			echo "host ident is $host_ident \n";
			echo "in the thing \n";
		}
		if (strstr($test_ident,"~"))
		{
			echo "got the ~ \n";
		}
		else
		{
			$host_ident=substr($host_ident,1,strlen($host_ident));
			
			if (strcmp ($test_ident,$host_ident))
			{
				return 0;
				//echo "there is no ~ we have an ident match \n";
			}
			else
			{
				return 1;
				
				//echo "there is no ~ we have an ident match \n";
			}	
		}	
	}
	else
	{
		if (strcmp($test_ident,$host_ident))
		{
			return 0;
			echo "there is no ~ we have an ident match \n";
		}
		else
		{
			return 1;
			echo "there is no ~ we have an ident match \n";
		}	
	}	
}

function op_check($chan,$who)
{
	
	global $db_ctrl,$db;
	
	
	$sql="select mode from chan_users where nick='$who' and chan_name='$chan' and mode='o' and reason is null";
	
	$result=$db_ctrl->query($sql,$db);
	if ($db_ctrl->num_rows($result)!=0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

function voice_check($chan,$who) {
	global $db_ctrl,$db;
	
	$sql="select mode from chan_users where nick='$who' and chan_name='$chan' and mode='v' and reason is null";
	
	$result=$db_ctrl->query($sql,$db);
	if ($db_ctrl->num_rows($result)!=0)
	{
		return 1;
		
	}
	else
	{
		return 0;
	}
}

function dcc_check($host)
{
	
	global $db_ctrl,$db;
	
	$sql="select user.user from user , user_host uh where user.user=uh.user and user.p='1' and '$host' like replace(replace(mask,'*','%'),'!','')";
	
	$result=@$db_ctrl->query($sql,$db);
	if ($db_ctrl->num_rows($result)!=0)
	{
		// global $db_ctrl,party line access.
		$myrow=@$db_ctrl->fetch_array($result);
		$user=$myrow["user"];
		return $user;
	}
	else
	{
		$sql="select user.user from chan_user cu , user_host uh where cu.user=uh.user and cu.p='1' and '$host' like replace(replace(mask,'*','%'),'!','')";
		$result=@$db_ctrl->query($sql,$db);
		if ($db_ctrl->num_rows($result)!=0)
		{
		
		$myrow=@$db_ctrl->fetch_array($result);
		$user=$myrow["user"];
		return $user;
		
		}
		else
		{
		
		return 0;
		}
	}
}		

?>