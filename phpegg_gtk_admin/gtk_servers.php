<?
/* 
	Copyright (c) 2001 Un-Thesis (Ted R. Smith)
	http://sourceforge.net/projects/phpegg
*/
function create_server($widget,$txt_create_server,$txt_create_port,$lbl_create_server,$lst_server) {
	$entry = $lst_server->entry; 
	$server_group = $entry->get_text();
	$sql="select server_groups_id from server_groups where server_group='$server_group'";
	$r = mysql_fetch_array(mysql_query($sql));
	$server_group_id = $r[0];	
	$server_name = $txt_create_server->get_text();
	$port = $txt_create_port->get_text();

	$sql="insert into servers ( server_group_id,server_name,port  )  values ( $server_group_id,'$server_name',$port)";
	$result=mysql_query($sql);
	if (!$result) 
	{
			$lbl_create_server->set_text("Mysql error: ".mysql_error());
	}
	else
	{
			$lbl_create_server->set_text("server inserted");
			$list = $lst_server->list; 
			$list->append_items(array(new GtkListItem($server_name)));
			/* can't figure out how to refresh the combo box! */
	}
}

function delete_server($widget,$lst_servers,$lbl_delete_server) {
	$entry = $lst_servers->entry; 
	$server = $entry->get_text();
	$server_info = split(" - ", $server);

	$sql="delete from servers where server_name='$server_info[0]' and port='$server_info[1]'";
	$result=mysql_query($sql);
	if (!$result)
	{
		$lbl_delete_server->set_text("Mysql error: ".mysql_error());
	}
	else
	{
		$lbl_delete_server->set_text("server group deleted");
		$entry->set_text("");
	}
	/* Can't figure out how to refresh the combo box! */
}

function fill_servers($list, $server_group_id,$lst_servers) {
	$sql = "select server_name,port from servers where server_group_id='$server_group_id'";
	$result = mysql_query($sql);
	$servers = array();
	
	if (mysql_num_rows($result) == 0) {
		$lst_servers->set_popdown_strings(array(""));
	}

	while ($myrow=mysql_fetch_array($result)) {
			$temp = "$myrow[server_name] - $myrow[port]";
			$servers[]=$temp;
			unset($temp);
	}
	if (count($servers) > 0) {
		$lst_servers->set_popdown_strings($servers);
	}
}

function servers() {
	$win_servers = &new GtkWindow();
	$win_servers->set_title("Servers");
		
	$hbox = &new GtkHBox();
	$win_servers->add($hbox);

	$frm_group = &new GtkFrame('Create Server Group');
		$vbox = &new GtkVBox();

		$lst_server_groups = &new GtkCombo();
		$lst_server_groups2 = &new GtkCombo();
		$lst_servers = &new GtkCombo();
		$txt_create_server = &new GtkEntry();
		$txt_create_port = &new GtkEntry();
		$btn_create_server = &new GtkButton("Create");
		$lbl_create_server = &new GtkLabel();

		$btn_create_server->connect('clicked','create_server',$txt_create_server,$txt_create_port,$lbl_create_server,$lst_server_groups);

		$vbox->pack_start($lst_server_groups);
		$vbox->pack_start(new GtkLabel("Server Name"));
		$vbox->pack_start($txt_create_server);
		$vbox->pack_start(new GtkLabel("Port"));
		$vbox->pack_start($txt_create_port);
		$vbox->pack_start($btn_create_server);
		$vbox->pack_start($lbl_create_server);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);

	$frm_group = &new GtkFrame('Servers');
		$vbox = &new GtkVBox();
		$sql="select * from server_groups order by server_groups_id asc";
		$result=mysql_query($sql);

		while ($myrow=mysql_fetch_array($result)) {
			$temp = "$myrow[server_groups_id]::$myrow[server_group]";
			$server_group[]=$temp;
		}
		if (count($server_group)) {
//			$lst_server_groups->set_popdown_strings($server_group);
		}
		for ($a=0; $a<count($server_group); $a++) {
			$server_info = split("::",$server_group[$a]);
			$list_items[$a] = &new GtkListItem($server_info[1]);
			$list_items2[$a] = &new GtkListItem($server_info[1]);
			$list_items2[$a]->connect('select','fill_servers',$server_info[0],$lst_servers);
			$list_items[$a]->show();
			$list_items2[$a]->show();
		}
		$list = $lst_server_groups->list;
		$list2 = $lst_server_groups2->list;
		if (count($list_items) > 0) {
			$list->append_items($list_items);
			$list2->append_items($list_items2);
		}
		$list->set_selection_mode(GTK_SELECTION_SINGLE);
//		$list->connect('select-child','fill_servers',$listed,$server_group,$lst_servers);

		$btn_delete_server = &new GtkButton("Delete");
		$lbl_delete_server = &new GtkLabel();

		$btn_delete_server->connect('clicked','delete_server',$lst_servers,$lbl_delete_server);
		
		$vbox->pack_start($lst_server_groups2);
		$vbox->pack_start($lst_servers);
		$vbox->pack_start($btn_delete_server);
		$vbox->pack_start($lbl_delete_server);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);
	$win_servers->show_all();

}
?>
