<?
/* 
	Copyright (c) 2001 Un-Thesis (Ted R. Smith)
	http://sourceforge.net/projects/phpegg
*/
function create_server_group($widget,$txt_create_group,$lbl_create_group,$lst_server_group) {
	$server_group = $txt_create_group->get_text();
	$sql="insert into server_groups ( server_group  )  values ( '$server_group')";
	$result=mysql_query($sql);
	if (!$result) 
	{
			$lbl_create_group->set_text("Mysql error: ".mysql_error());
	}
	else
	{
			$lbl_create_group->set_text("server group inserted");
			$list = $lst_server_group->list; 
			$list->append_items(array(new GtkListItem($server_group)));
			/* can't figure out how to refresh the combo box! */
	}
}

function delete_server_group($widget,$lst_server_group,$lbl_delete_group) {
	$entry = $lst_server_group->entry; 
	$server_group = $entry->get_text();
	$sql="select server_groups_id from server_groups where server_group='$server_group'";
	$r = mysql_fetch_array(mysql_query($sql));
	$server_groups_id = $r[0];
	$sql="delete from servers where server_group_id=$server_groups_id";
	$result=mysql_query($sql);
	$sql="delete from server_groups where server_groups_id = $server_groups_id";
	$result=mysql_query($sql);
	if (!$result)
	{
		$lbl_delete_group->set_text("Mysql error: ".mysql_error());
	}
	else
	{
		$lbl_delete_group->set_text("server group deleted");
		$entry->set_text("");
	}
	/* Can't figure out how to refresh the combo box! */
}

function server_groups() {
	$win_server_groups = &new GtkWindow();
	$win_server_groups->set_title("Server Groups");
	
	$hbox = &new GtkHBox();
	$win_server_groups->add($hbox);

	$frm_group = &new GtkFrame('Create Server Group');
		$vbox = &new GtkVBox();

		$lst_server_group = &new GtkCombo();
		$txt_create_group = &new GtkEntry();
		$btn_create_group = &new GtkButton("Create");
		$lbl_create_group = &new GtkLabel();

		$btn_create_group->connect('clicked','create_server_group',$txt_create_group,$lbl_create_group,$lst_server_group);

		$vbox->pack_start($txt_create_group);
		$vbox->pack_start($btn_create_group);
		$vbox->pack_start($lbl_create_group);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);

	$frm_group = &new GtkFrame('Server Groups');
		$vbox = &new GtkVBox();
		$sql="select * from server_groups order by server_groups_id desc";
		$result=mysql_query($sql);

		while ($myrow=mysql_fetch_array($result)) {
			$server_group[]=$myrow['server_group'];
		}
		
		$lst_server_group->set_popdown_strings($server_group);
		$btn_delete_group = &new GtkButton("Delete");
		$lbl_delete_group = &new GtkLabel();

		$btn_delete_group->connect('clicked','delete_server_group',$lst_server_group,$lbl_delete_group);
		
		$vbox->pack_start($lst_server_group);
		$vbox->pack_start($btn_delete_group);
		$vbox->pack_start($lbl_delete_group);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);
	$win_server_groups->show_all();
}
?>
