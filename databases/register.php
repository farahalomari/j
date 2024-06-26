<?php
    $db =mysqli_connect('localhost','root','','localconnect');
    if(!$db){
        echo "Database connection failed";
    }
    $phonenumber =$_POST['phonenumber'];
    $password = $_POST ['password'];

    $sql = "INSERT INTO user(phonenumber,password) VALUES ('".$phonenumber."','".$password."')";
    $query =mysqli_query($db, $sql);

    if($query) {
        echo json_encode ("success");
    }








?>