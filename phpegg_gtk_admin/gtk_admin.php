<?
/* 
	Copyright (c) 2001 Un-Thesis (Ted R. Smith)
	http://sourceforge.net/projects/phpegg
*/
require("gtk_authorize_user.php");
require('gtk_server_group.php');
require('gtk_servers.php');
require('gtk_module_binds.php');
require('gtk_modules.php');
require('gtk_channels.php');
require('gtk_users.php');

if (strtoupper(substr(PHP_OS, 0, 3)) == 'WIN')
	/* If this doesn't work, try putting the FULL path to php_gtk.dll
here... */
	dl('php_gtk.dll');
else
	dl('php_gtk.so');


function delete_event() {
	return false;
}

function destroy() {
	Gtk::main_quit();
}
	
function create_win_menu() {
	$buttons = array(
					 'Server Groups'	=> 'server_groups',
					 'Servers'			=> 'servers',
					 'Module Binds'		=> 'module_binds',
					 'Modules'			=> 'modules',
					 'Channels'			=> 'channels',
					 'User Management'	=> 'users',
					);
	$win_menu = &new GtkWindow();
	$win_menu->set_title("PHP-Egg GTK Admin");
	$win_menu->connect_object('destroy', array('gtk', 'main_quit'));

	$vbox = &new GtkVBox();
	$win_menu->add($vbox);

	foreach ($buttons as $label	=> $function) {
		$button = &new GtkButton($label);
		if ($function) {
//			$function = "load_$function";
			$button->connect('clicked', $function);
		} else {
			$button->set_sensitive(false);
		}
		$vbox->pack_start($button);
	}
	$win_menu->show_all();
}

function create_win_login() {
	$win_login = &new GtkWindow();
	$win_login->set_title("PHP-Egg Login");
	$win_login->set_uposition(0, 0);
	$win_login->connect_object('destroy', array('gtk', 'main_quit'));

	$vbox = &new GtkVBox();
	$win_login->add($vbox);

	$hbox = &new GtkHBox();
	$hbox->pack_start(new GtkLabel("Login: "));
	$txt_login = &new GtkEntry();
	$hbox->pack_start($txt_login);
	$vbox->pack_start($hbox);

	$hbox = &new GtkHBox();
	$hbox->pack_start(new GtkLabel("Password: "));
	$txt_password = &new GtkEntry();
	$txt_password->set_visibility(false);
	$hbox->pack_start($txt_password);
	$vbox->pack_start($hbox);

	$btn_submit = &new GtkButton("Submit");
	$vbox->pack_start($btn_submit);
	$btn_submit->connect('clicked', 'authorize_user',$txt_login,$txt_password,$win_login);

	$win_login->show_all();

}
create_win_login();
Gtk::main();

?>
