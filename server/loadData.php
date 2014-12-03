<?php
	//include 'link.php';
	$link=mysqli_connect("127.0.0.1","root","","test");	
	//$link=mysql_connect(SAE_MYSQL_HOST_M.':'.SAE_MYSQL_PORT,SAE_MYSQL_USER,SAE_MYSQL_PASS,SAE_MYSQL_DB);
	$tablename=$_POST['tablename'];
	$sql = "SELECT * FROM $tablename "; 
	$query = mysqli_query($link,$sql); 
	
	//返回json
	$rows = array();
	while ($row=mysqli_fetch_array($query,MYSQL_ASSOC)) {
		$rows[] = $row; 
	}
	if($rows)
	echo json_encode($rows);
	else
	echo "load filed!";
	
?>