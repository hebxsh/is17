﻿<?php
	//include 'link.php';
	$link=mysqli_connect("127.0.0.1","root","","test");	
	//$username=$_POST['username'];
	$password=$_POST['password'];
	
	
	$sql = "SELECT * FROM user WHERE  mima='$password'"; 
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