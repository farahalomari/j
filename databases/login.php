<?php
    $db =mysqli_connect('localhost','root','','localconnect');
    if(!$db){
        echo "Database connection failed";
    }
    $phonenumber =$_POST['phonenumber'];
    $password = $_POST ['password'];

    $sql = "SELECT * FROM  user WHERE phonenumber= '".$phonenumber."' AND password = '".$password."'";
    $result =mysqli_query($db, $sql);
    $count = mysqli_num_rows($result);

    if($count >=1) {
        echo json_encode ("success");
    }

    else {
        echo json_encode ("error");
    }








?>