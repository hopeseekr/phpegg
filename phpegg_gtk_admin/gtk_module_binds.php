<?
/* 
	Copyright (c) 2001 Un-Thesis (Ted R. Smith)
	http://sourceforge.net/projects/phpegg
*/
function create_module_bind($widget,$txt_create_bind,$lbl_create_bind,$lst_module_bind) {
	$module_bind = $txt_create_bind->get_text();
	$sql="insert into module_binds ( bind  )  values ( '$module_bind')";
	$result=mysql_query($sql);
	if (!$result) 
	{
			$lbl_create_bind->set_text("Mysql error: ".mysql_error());
	}
	else
	{
			$lbl_create_bind->set_text("module bind inserted");
			$list = $lst_module_bind->list; 
			$list->append_items(array(new GtkListItem($module_bind)));
			/* can't figure out how to refresh the combo box! */
	}
}

function delete_module_bind($widget,$lst_module_bind,$lbl_delete_bind) {
	$entry = $lst_module_bind->entry; 
	$module_bind = $entry->get_text();
	$sql="delete from module_binds where bind='$module_bind'";
	$result=mysql_query($sql);
	if (!$result)
	{
		$lbl_delete_bind->set_text("Mysql error: ".mysql_error());
	}
	else
	{
		$lbl_delete_bind->set_text("module bind deleted");
		$entry->set_text("");
	}
	/* Can't figure out how to refresh the combo box! */
}

function module_binds() {
	$win_module_binds = &new GtkWindow();
	$win_module_binds->set_title("Module Binds");
	
	$hbox = &new GtkHBox();
	$win_module_binds->add($hbox);

	$frm_group = &new GtkFrame('Create Module Bind');
		$vbox = &new GtkVBox();

		$lst_binds = &new GtkCombo();
		$txt_create_bind = &new GtkEntry();
		$btn_create_bind = &new GtkButton("Create");
		$lbl_create_bind = &new GtkLabel();

		$btn_create_bind->connect('clicked','create_module_bind',$txt_create_bind,$lbl_create_bind,$lst_binds);

		$vbox->pack_start($txt_create_bind);
		$vbox->pack_start($btn_create_bind);
		$vbox->pack_start($lbl_create_bind);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);

	$frm_group = &new GtkFrame('Module Binds');
		$vbox = &new GtkVBox();
		$sql="select bind from module_binds order by module_binds_id asc";
		$result=mysql_query($sql);
		while ($myrow=mysql_fetch_array($result)) {
			$binds[]=$myrow['bind'];
		}
		
		$lst_binds->set_popdown_strings($binds);
		$btn_delete_bind = &new GtkButton("Delete");
		$lbl_delete_bind = &new GtkLabel();

		$btn_delete_bind->connect('clicked','delete_module_bind',$lst_binds,$lbl_delete_bind);
		
		$vbox->pack_start($lst_binds);
		$vbox->pack_start($btn_delete_bind);
		$vbox->pack_start($lbl_delete_bind);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);
	$win_module_binds->show_all();
}
?>
