<?php
function make_ban($ident,$host_mask) {
    if (ereg("[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}",$host_mask)) {
	$mask_array=explode(".",$host_mask);
					
	$ban="*!*$ident@".$mask_array[0].".".$mask_array[1].".".$mask_array[2].".*";
    } else {
	$mask_array=explode(".",$host_mask);
					
	if (count($mask_array)==2) {
	    $ban="*!*$ident@".$host_mask;
	} else {
	    $last_mask=count($mask_array) - 1;
	    $next_mask=count($mask_array) - 2;
	    $ban="*!*$ident@*.".$mask_array[$next_mask].".".$mask_array[$last_mask];
	}	
    }	
    return $ban;			
}
	
?>