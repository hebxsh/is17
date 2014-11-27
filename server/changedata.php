<?php
	//include 'link.php';
	$link=mysqli_connect("127.0.0.1","root","","test");	
	
	$tablename=$_POST['tablename'];
	$sqltype=$_POST['sqltype'];
	$sqldata=$_POST['sqldata'];
	//暴率表
	$itemArr = array("0"=> array(300,150,50,5,1),
					"1"=> array(400,200,70,10,2),
					"2"=> array(350,180,100,40,5),
					"3"=> array(150,200,300,100,10),
					"4"=> array(50,150,200,200,50));
											
	switch($sqltype){
		case "sel":
			$sql = "SELECT * FROM $tablename "; 
			sqlecho($sql);
			break;
		case "updat"://保存修改属性
			//$arr = get_object_vars($sqldata);
			//echo  is_array($sqldata)."****";
			//var_dump($sqldata);echo  "/////";
			//echo ($sqldata);
			$arr = json_decode($sqldata, true);
			//var_dump($arr);
			if($tablename=="user"){
				$tstr = "UPDATE user SET ".$sqldata['type']."='".$sqldata['show']."'";
			}else if($tablename=="userskill"){
				$tstr = "UPDATE userskill SET ".$arr[0]['type']."='".$arr[0]['show']."'" . " WHERE " . $arr[0]['typeName']."='".$arr[0]['nameShow']."'";				
			}//echo($tstr);
			$query = mysqli_query($link,$tstr); 
			break;
		case "inser":
			if($tablename == "bag"){
				$tstr = "insert into from bag where mainid='".$sqldata."';";
			}else if($tablename == "userskill"){
				$tstr = "insert into userskill (id,nowlevel,exp,useing,xiulian) values (".$insdata['id'].",0,0,0,0);";
			}
			$query = mysqli_query($link,$tstr); 
			break;
		case "unloa"://取下装备或者技能
			$arr = json_decode($sqldata, true);
			if($tablename=="equip"){
				$tstr = "UPDATE user SET ".$arr[0]['type']."='".$arr[0]['show']."'"; //. " WHERE " . $arr[0]['typeName']."='".$arr[0]['nameShow']."';";
				$query =  mysqli_query($link,$tstr); 				
				$tstr = "insert into bag (id,num) values (".$arr[0]['nameShow'].",1)";
			}else if($tablename=="skill"){
				$tstr = "UPDATE user SET ".$arr[0]['type']."='".$arr[0]['show']."'";// . " WHERE " . $arr[0]['typeName']."='".$arr[0]['nameShow']."'";	
				echo $tstr;
				$query =  mysqli_query($link,$tstr); 	
				$tstr = "UPDATE userskill SET useing = 0 where id='".$arr[0]['nameShow']."'";				
			}//echo($tstr);
			$query = mysqli_query($link,$tstr); 
			break;
		case "puton"://穿上装备或者技能
			$arr = json_decode($sqldata, true);
			if($tablename=="equip"){
				$typename = $arr[0]['type'];
				$tstr = "SELECT ".$typename." FROM user  "; 
				$query =  mysqli_query($link,$tstr); 
				$row = mysqli_fetch_array($query);
				$item = $row[$typename];
				if($item!="0"){//如果该部位有装备取下放入背包
					//echo $item;
					$tstr = "insert into bag (id,num) values (".$item.",1)";
					$query =  mysqli_query($link,$tstr); 	
				}
				$tstr = "UPDATE user SET ".$arr[0]['type']."='".$arr[0]['show']."'" ;//. " WHERE " . $arr[0]['typeName']."='".$arr[0]['nameShow']."';";
				$query =  mysqli_query($link,$tstr);//给玩家装备上该物品 		
				$tstr = "delete from bag  WHERE mainid ='".$arr[0]['nameShow']."'";//从背包干掉该物品
			}else if($tablename=="skill"){ 
				$typename = $arr[0]['type'];
				$tstr = "SELECT ".$typename." FROM user  "; 
				$query =  mysqli_query($link,$tstr); 
				$row = mysqli_fetch_array($query);
				$item = $row[$typename];
				if($item!="0"){//如果该部位更新技能列表该装备using属性
					//echo $item;
					$tstr = "UPDATE userskill SET useing = 0 where id='".$arr[0]['show']."'";
					$query =  mysqli_query($link,$tstr); 	
				}
				$tstr = "UPDATE user SET ".$arr[0]['type']."='".$arr[0]['show']."'" ;//. " WHERE " . $arr[0]['typeName']."='".$arr[0]['nameShow']."';";
				$query =  mysqli_query($link,$tstr);//给玩家装备上该物品 		
				$tstr = "UPDATE userskill SET useing = 1 where id='".$arr[0]['show']."'";//从背包干掉该物品			
			}//echo($tstr);
			$query = mysqli_query($link,$tstr); 
			break;
		case "delet"://删除物品
			if($tablename == "bag"){
				$tstr = "delete from ".$tablename . " where mainid='".$sqldata."';";
			}else if($tablename == "userskill"){
				$tstr = "delete from ".$tablename . " where mainid='".$sqldata."';";
			}
			$query = mysqli_query($link,$tstr); 
			break;
		case "award"://获得奖励
			$awardarr = array();
			for ($i = 0;$i <count($itemArr[$sqldata]);$i++){
				$tablename = "";
				if(rand(0,1000)<$itemArr[$sqldata][$i]){
					if(rand(0,100)<50){
						$tablename = "equip";
						$instab = "bag";
					}else if(rand(0,100)<60){
						$tablename = "book";
						$instab = "bag";
					}else if(rand(0,100)<60){
						$tablename = "skill";
						$instab = "userskill";
					}else{
						$tablename = "";
					}
				}
				if ($tablename!=""){
					$sql = "select * from $tablename WHERE level=$i ";
					$query = mysqli_query($link,$sql); 
					$rows = array();
					while ($row=mysqli_fetch_array($query,MYSQL_ASSOC)) {
						$rows[] = $row; 
					}
					$key = array_rand($rows);
					addItem($instab,$rows[$key]);
					//echo  ($rows[$key]['id']);
					array_push($awardarr,$rows[$key]);
				}
			}
			echo json_encode($awardarr);
			break;
	}
	
	function sqlecho($str){
		$query = mysqli_query($link,$str); 			
		$rows = array();
		while ($row=mysqli_fetch_array($query,MYSQL_ASSOC)) {
			$rows[] = $row; 
		}
		if($rows)
		echo json_encode($rows);
		else
		echo "load filed!";
	}
	//向用户表插入数据
	function addItem($table,$insdata,$num=1){
		switch($table){
			case "bag":
				$tstr = "insert into bag (id,num) values (".$insdata['id'].",".$num.");";
				break;
			case "userskill":
				$tstr = "insert into userskill (id,nowlevel,exp,useing,xiulian) values (".$insdata['id'].",0,0,0,0);";
				break;
		}
		global $link;
		$query = mysqli_query($link,$tstr); 
	}
?>