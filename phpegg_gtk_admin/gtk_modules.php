<?
/* 
	Copyright (c) 2001 Un-Thesis (Ted R. Smith)
	http://sourceforge.net/projects/phpegg
*/
function create_module($widget,$txt_create_mod_name,$txt_create_mod_desc,
					   $txt_create_mod_file,$lbl_create_mod,$lst_binds) {
	$entry = $lst_binds->entry; 
	$module_binds_info = split(" - ",$entry->get_text());

	$module_name = $txt_create_mod_name->get_text();
	$module_desc = $txt_create_mod_desc->get_text();
	$module_file_name = $txt_create_mod_file->get_text();
	$sql="insert into modules ( bind  )  values ( '$modules')";
	$sql="insert into modules ( module_binds_id,module_name,module_desc,module_file_name  )  values ( $module_binds_info[0],'$module_name','$module_desc','$module_file_name')";
	$result=mysql_query($sql);
	if (!$result) 
	{
			$lbl_create_mod->set_text("Mysql error: ".mysql_error());
	}
	else
	{
			$lbl_create_mod->set_text("module inserted");
			$list = $lst_binds->list; 
			$list->append_items(array(new GtkListItem($modules)));
			/* can't figure out how to refresh the combo box! */
	}
}

function delete_module($widget,$lst_mods,$lbl_delete_mod) {
	$entry = $lst_mods->entry; 
	$module_info = split(" - ",$entry->get_text());
	$sql="delete from modules where module_name='$module_info[0]'";
	$result=mysql_query($sql);
	if (!$result)
	{
		$lbl_delete_mod->set_text("Mysql error: ".mysql_error());
	}
	else
	{
		$lbl_delete_mod->set_text("module deleted");
		$entry->set_text("");
	}
	/* Can't figure out how to refresh the combo box! */
}

function modules() {
	$win_modules = &new GtkWindow();
	$win_modules->set_title("Modules");
	
	$hbox = &new GtkHBox();
	$win_modules->add($hbox);

	$frm_group = &new GtkFrame('Create Modules');
		$vbox = &new GtkVBox();

		$lst_binds = &new GtkCombo();
		$lst_mods = &new GtkCombo();
		$txt_create_mod_name = &new GtkEntry();
		$txt_create_mod_desc = &new GtkEntry();
		$txt_create_mod_file = &new GtkEntry();
		$btn_create_mod = &new GtkButton("Create");
		$lbl_create_mod = &new GtkLabel();

		$sql="select * from module_binds order by module_binds_id asc";
		$result=mysql_query($sql);
		while ($myrow=mysql_fetch_array($result)) {
			$temp = "$myrow[module_binds_id] - $myrow[bind]";
			$binds[]=$temp;
		}
		$vbox->pack_start($lst_binds);
		$vbox->pack_start(new GtkLabel("Module name"));
		$vbox->pack_start($txt_create_mod_name);
		$vbox->pack_start(new GtkLabel("Module desc"));
		$vbox->pack_start($txt_create_mod_desc);
		$vbox->pack_start(new GtkLabel("Module filename"));
		$vbox->pack_start($txt_create_mod_file);
		
		$lst_binds->set_popdown_strings($binds);

		$btn_create_mod->connect('clicked','create_module',$txt_create_mod_name,$txt_create_mod_desc,
			$txt_create_mod_file,$lbl_create_mod,$lst_binds);

		$vbox->pack_start($btn_create_mod);
		$vbox->pack_start($lbl_create_mod);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);

	$frm_group = &new GtkFrame('Modules');
		$vbox = &new GtkVBox();
		$sql="select * from modules order by module_binds_id asc";
		$module_result = mysql_query($sql);
		while ($myrow=mysql_fetch_array($module_result)) {
			$sql="select bind from module_binds where module_binds_id='$myrow[module_binds_id]'";
			$bind_q = mysql_query($sql);
			$myrow2 = mysql_fetch_array($bind_q);

			$temp = "$myrow[module_name] - $myrow2[bind]";
			$mods[]=$temp;
		}
		
		$lst_mods->set_popdown_strings($mods);

		$btn_delete_mod = &new GtkButton("Delete");
		$lbl_delete_mod = &new GtkLabel();

		$btn_delete_mod->connect('clicked','delete_module',$lst_mods,$lbl_delete_mod);
		$vbox->pack_start($lst_mods);
		$vbox->pack_start($btn_delete_mod);
		$vbox->pack_start($lbl_delete_mod);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);
	$win_modules->show_all();
}
?>
