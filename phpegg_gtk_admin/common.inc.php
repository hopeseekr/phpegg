<?php

function crypt_login($db,$login_id,$now="0")
	{
	
	if ($now!=0)
		{
		$front=substr($now,0,4);
		$end=substr($now,4,strlen($now));
		
		$crypt=md5($end.$login_id.$front);
		return $crypt;
		
		
		}
	
	
	}
//
//	This function takes teh crypted login id and uses it to test against the database
//	to find the user id that it would belong to.
//  	
//	
function decrypt_login($db,$crypt)
	{
	
	
	$sql="select web_login_id from web_login where md5(concat(SUBSTRING(login_time,5,9),web_login_id,substring(login_time,1,4))) = '$crypt' ";
	
	$result=@mysql_query($sql,$db);
	
	if (!$result)
		{
		return 0;
		
		}
	else
		{	
		$myrow=@mysql_fetch_array($result);
		return  $myrow[0];
		}
	
	}
	
function check_nm($db,$user_id)
	{
	
	 $sql="select wl.user from web_login wl, user where web_login_id=$user_id and wl.user=user.user and (user.m='Y' or user.n='Y')";
	 $result=@mysql_query($sql,$db);
	 if (mysql_num_rows($result)!=0)
	 	{
	 	return 1;
	 	
	 	}
	 else
	 	{
	 	return 0;
	 	
	 	}	
	
	}	
function check_chan_mo($db,$user_id)
	{
	
	 $sql="select distinct wl.user from web_login wl, user_chan uc where web_login_id=$user_id and wl.user=uc.user and (uc.m='Y' or uc.o='Y')";
	 $result=@mysql_query($sql,$db);
	 if (mysql_num_rows($result)!=0)
	 	{
	 	return 1;
	 	
	 	}
	 else
	 	{
	 	return 0;
	 	
	 	}	
	
	}		
	
?>