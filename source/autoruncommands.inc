<?php

function auto_run($irc_connect) {
    global $db;
    // this is included once in connect.inc irc_idle function run every time the bot gets something.
    // checks for new channels if it finds any active channels that its not in it joins them

    $sql="select chan_name from channels where active='Y' and in_chan='N' ";
    $result=@mysql_query($sql,$db);
    while($myrow=@mysql_fetch_array($result)) {
	//echo "found new chan joining $myrow[0]\n";
	fputs($irc_connect,"JOIN $myrow[0]\n");
	$now=time();	
	$sql="update channels set last_in='$now', in_chan='Y' where upper(chan_name)=upper('$myrow[0]')";
	$result=@mysql_query($sql,$db);				
    }

    // checks for deactivated channels if the bot is in a channel that is not active it leaves it.
    $sql="select chan_name from channels where active='N' and in_chan='Y'";
    $result=@mysql_query($sql,$db);
    while($myrow=@mysql_fetch_array($result)) {
	//echo "found deactivated chan $myrow[0] leaving \n";
	fputs($irc_connect,"PART $myrow[0]\n");
	$sql="update channels set last_in='$now', in_chan='N' where upper(chan_name)=upper('$myrow[0]')";
	$result=@mysql_query($sql,$db);	
    }
	
	
    // deals with anything comming from chan spy on the webpage
    $sql="select action, mode_data_id from mode_data mc ";
    $result=@mysql_query($sql,$db);
    while($myrow=@mysql_fetch_array($result)){
	$mode_data_id=$myrow["mode_data_id"];
	$action=$myrow["action"];
	//echo "found action $action \n";
						
	fputs($irc_connect,"$action\n");
						
	$sql_del="delete from mode_data where mode_data_id=$mode_data_id";
	$result_del=@mysql_query($sql_del,$db);
    }

}
?>