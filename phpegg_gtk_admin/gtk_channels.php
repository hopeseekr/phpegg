<?
/* 
	Copyright (c) 2001 Un-Thesis (Ted R. Smith)
	http://sourceforge.net/projects/phpegg
*/
function create_channel($widget,$txt_create_channel,$txt_create_topic,$txt_create_topic_by,
						$txt_create_topic_date,$lbl_create_channel,$lst_channels) {
	$chan_name = $txt_create_channel->get_text();
	$topic = $txt_create_topic->get_text();
	$topic_set_by = $txt_create_topic_by->get_text();
	$topic_set_date = $txt_create_topic_date->get_text();
	$sql="insert into channels ( chan_name,topic,topic_set_by,topic_set_date  )  values ( '$chan_name','$topic','$topic_set_by',$topic_set_date)";
	print "$sql\n";
	$result=mysql_query($sql);
	if (!$result) 
	{
			$lbl_create_channel->set_text("Mysql error: ".mysql_error());
	}
	else
	{
			$lbl_create_channel->set_text("channel inserted");
			$list = $lst_channels->list; 
			$list->append_items(array(new GtkListItem($channel)));
			/* can't figure out how to refresh the combo box! */
	}
}

function delete_channel($widget,$lst_channel,$lbl_delete_channel) {
	$entry = $lst_channel->entry; 
	$chan_name = $entry->get_text();
	$sql="delete from channels where chan_name='$chan_name'";
	$result=mysql_query($sql);
	if (!$result)
	{
		$lbl_delete_channel->set_text("Mysql error: ".mysql_error());
	}
	else
	{
		$lbl_delete_channel->set_text("channel deleted");
		$entry->set_text("");
	}
	/* Can't figure out how to refresh the combo box! */
}

function channels() {
	$win_channels = &new GtkWindow();
	$win_channels->set_title("Module channels");
	
	$hbox = &new GtkHBox();
	$win_channels->add($hbox);

	$frm_group = &new GtkFrame('Create Channel');
		$vbox = &new GtkVBox();

		$lst_channels = &new GtkCombo();
		$txt_create_channel = &new GtkEntry();
		$txt_create_topic = &new GtkEntry();
		$txt_create_topic_by = &new GtkEntry();
		$txt_create_topic_date = &new GtkEntry();
		$btn_create_channel = &new GtkButton("Create");
		$lbl_create_channel = &new GtkLabel();

		$btn_create_channel->connect('clicked','create_channel',$txt_create_channel,$txt_create_topic,$txt_create_topic_by,
									$txt_create_topic_date,$lbl_create_channel,$lst_channels);
			$hbox2 = new GtkHBox();
			$hbox2->pack_start(new GtkLabel("Channel name: "));
			$hbox2->pack_start($txt_create_channel);
		$vbox->pack_start($hbox2);
			$hbox2 = new GtkHBox();
			$hbox2->pack_start(new GtkLabel("Topic: "));
			$hbox2->pack_start($txt_create_topic);
		$vbox->pack_start($hbox2);
			$hbox2 = new GtkHBox();
			$hbox2->pack_start(new GtkLabel("Topic set by: "));
			$hbox2->pack_start($txt_create_topic_by);
		$vbox->pack_start($hbox2);
			$hbox2 = new GtkHBox();
			$hbox2->pack_start(new GtkLabel("Topic set date: "));
			$hbox2->pack_start($txt_create_topic_date);
		$vbox->pack_start($hbox2);
		$vbox->pack_start($btn_create_channel);
		$vbox->pack_start($lbl_create_channel);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);

	$frm_group = &new GtkFrame('Channels');
		$vbox = &new GtkVBox();
		$sql="select chan_name from channels order by chan_name";
		$result=mysql_query($sql);
		while ($myrow=mysql_fetch_array($result)) {
			$channels[]=$myrow['chan_name'];
		}
		if (count($channels) > 0) {
			$lst_channels->set_popdown_strings($channels);
		}
		$btn_delete_channel = &new GtkButton("Delete");
		$lbl_delete_channel = &new GtkLabel();

		$btn_delete_channel->connect('clicked','delete_channel',$lst_channels,$lbl_delete_channel);
		
		$vbox->pack_start($lst_channels);
		$vbox->pack_start($btn_delete_channel);
		$vbox->pack_start($lbl_delete_channel);
		$frm_group->add($vbox);
	$hbox->pack_start($frm_group);
	$win_channels->show_all();
}

?>
