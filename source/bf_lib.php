<script language="php">
include ('bf_init.php');

function checkOverflow($a)
{
	if ($a<-pow(2,31)) $a+=pow(2,32);
	if ($a>pow(2,32)) $a-=pow(2,32);
	return($a);
}

function myxor($a,$b)
{
	if ($a>pow(2,31)) $a-=pow(2,32);
	if ($b>pow(2,31)) $b-=pow(2,32);

	$r=$a^$b;
	if ($r<0) $r+=pow(2,32);
	return($r);
}

function myrsh($n,$a)
{
	return(Floor($n/pow(2,$a)));
}

function myand($a,$b)
{
	if ($a>pow(2,31)) $a-=pow(2,32);
	if ($b>pow(2,31)) $b-=pow(2,32);

	$r=$a&$b;
	if ($r<0) $r+=pow(2,32);
	return($r);
}

function bf_init($key)
{
	global $db_ctrl,$initbf_P,$initbf_S,$bf_P,$bf_S,$bf_N;
	
	$bf_P=$initbf_P;$bf_S=$initbf_S;
	$len=strlen($key);
	preg_match_all("/(.)/",$key,$key);
	$key=$key[0];
	for ($i=0;$i<count($key);$i++) $key[$i]=ord($key[$i]);
	
	$j=0;
	for ($i=0;$i<$bf_N+2;++$i)
	{
		$w=new aword();
		$w->setValues($key[$j],$key[($j+1)%$len],$key[($j+2)%$len],$key[($j+3)%$len]);
		$data=$w->getUWORD32();
		$bf_P[$i]=myxor($bf_P[$i],$data);
		$j=($j+4)%$len;
	}

	$datal=new aword();
	$datar=new aword();

//	print "init(datal,datar)\n";

	for ($i=0;$i<$bf_N+2;$i+=2)
	{
// PROBLEM
		bf_encipher($datal,$datar);

		$a=$datar;
		$datar=$datal;
		$datal=$a;

		$bf_P[$i]=$datal->getUWORD32();
		$bf_P[$i+1]=$datar->getUWORD32();
	}

	//for ($i=0;$i<$bf_N+2;$i++)
	//	print "bf_P[$i]=".$bf_P[$i]."\n";

	//print "Filling S\n";
	for ($i=0;$i<4;$i++)
		for ($j=0;$j<256;$j+=2)
		{
			bf_encipher($datal,$datar);

			$a=$datar;
			$datar=$datal;
			$datal=$a;

			$bf_S[$i][$j]=$datal->getUWORD32();
			$bf_S[$i][$j+1]=$datar->getUWORD32();
//			if ($j>20)exit(-1);
		}
//	exit(-1);
}

function bf_encrypt_pass($clear)
{
	global $db_ctrl,$base64;
	bf_init($clear);

	$left=new aword();
	$right=new aword();
	$left->setUWORD32(SALT1);
	$right->setUWORD32(SALT2);
//	print $right->getUWORD32()."\n";

	bf_encipher($left,$right);
	
	$a=$left;$left=$right;$right=$a;

	$n=32;$p="+";
	while($n>0)
	{
//		print $right->getUWORD32()."\n";
		$p.=$base64[myand($right->getUWORD32(),0x3f)];
		$right->setUWORD32(myrsh($right->getUWORD32(),6));
		$n-=6;
	}
	$n=32;
	while($n>0)
	{
		$p.=$base64[myand($left->getUWORD32(),0x3f)];
		$left->setUWORD32(myrsh($left->getUWORD32(),6));
		$n-=6;
	}

	return($p);
}

/* add $bf_P */
function bf_round(&$w1,&$w2,$n)
{
	global $db_ctrl,$bf_P;
//	print $w1->getUWORD32()."^".$w2->bf_F()."^".$bf_P[$n]."\n";
	
	$w1->setUWORD32(myxor(myxor($w1->getUWORD32(),$w2->bf_F()),$bf_P[$n]));
}

function bf_encipher(&$wl,&$wr)
{
	global $db_ctrl,$bf_P;
	$wl->setUWORD32(myxor($wl->getUWORD32(),$bf_P[0]));
	// bf_round e futut
	bf_round($wr,$wl,1);
//	print "Round 1: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,2);
//	print "Round 2: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wr,$wl,3);
//	print "Round 3: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,4);
//	print "Round 4: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wr,$wl,5);
//	print "Round 5: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,6);
//	print "Round 6: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wr,$wl,7);
//	print "Round 7: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,8);
//	print "Round 8: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wr,$wl,9);
//	print "Round 9: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,10);
//	print "Round 10: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wr,$wl,11);
//	print "Round 11: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,12);
//	print "Round 12: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wr,$wl,13);
//	print "Round 13: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,14);
/*	print "Round 14: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	print "S0(wl): ".$wl->S(0)."\n";
	print "S1(wl): ".$wl->S(1)."\n";
	print "S2(wl): ".$wl->S(2)."\n";
	print "S3(wl): ".$wl->S(3)."\n";
	print "bf_F(wl): ".$wl->bf_F()." (".($wl->bf_F()-pow(2,32)).")\n";
	print "bf_P[4]: ".$bf_P[4]."\n";
	print "wr: ".$wl->getUWORD32()."\n";
	print "P: ".($wl->S(0)+$wl->S(1))."\n";*/
	bf_round($wr,$wl,15);
//	print "Round 15: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	bf_round($wl,$wr,16);
//	print "Round 16: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
	$wr->setUWORD32(myxor($wr->getUWORD32(),$bf_P[17]));
// in progr. orig. aici erau inversate drepta cu stanga
//	print "Round 18: ".$wl->getUWORD32().",".$wr->getUWORD32()."\n";
}

class aword
{
	var $bytes;
	
	function aword($v1=0,$v2=0,$v3=0,$v4=0)
	{
		$this->setValues($v1,$v2,$v3,$v4);
	}

	function setValues($v1,$v2,$v3,$v4)
	{
//		print "Setting: $v1,$v2,$v3,$v4\n";
		$this->bytes=array($v1,$v2,$v3,$v4);
		if (ARCH==ARCH_LITTLENDIAN) $this->bytes=array_reverse($this->bytes);
	}

	function setUWORD32($v)
	{
//		print "Value: $v\n";
		if ($v<0) {print "got a -\n";exit();}
		$v1=Floor($v/0x1000000);
		$v-=$v1*0x1000000;	// 
		$v2=Floor($v/0x10000);
		$v-=$v2*0x10000;
		$v3=Floor($v/0x100);
		$v-=$v3*0x100;
		$v4=$v;
		$this->setValues($v1,$v2,$v3,$v4);
	}

	function getUWORD32()
	{
		return(((256*$this->bytes[0]+$this->bytes[1])*256+$this->bytes[2])*256+$this->bytes[3]);
	}
	
	//astea trei sa-mi returneze signed
	function S($i)
	{
		global $db_ctrl,$bf_S;
		$r=$bf_S[$i][$this->bytes[$i]];
		if ($r>pow(2,31)) $r-=pow(2,32);
		return($r);
	}

	function bf_F()
	{
		$r=checkOverflow(myxor(checkOverflow($this->S(0)+$this->S(1)),$this->S(2))+$this->S(3));
		if ($r<0) $r+=pow(2,32);
		return($r);
	}
}
</script>
