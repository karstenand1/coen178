<?php

  modDatabase();

  function modDatabase() {

    ini_set('display_errors','On');
    error_reporting(E_ALL);
    $db_host = "//dbserver.engr.scu.edu/db11g";
    $db_user = "kanderse";
    $db_pass = "00000918652";
    $con = oci_connect($db_user, $db_pass, $db_host);
    // Check connection
    if (!$con){
        $e = oci_error;
  	    print "<br> connection failed:";
  	    print htmlentities($e['message']);
  	    exit;
    }

    $sql="SELECT * FROM Users WHERE email = '$_POST[email]'";
    $sqlParse = OCIParse($conn, $sql);
    $result = OCIExecute($sqlParse);

    if (!$result){
      $e = oci_error;
      print "<br> connection failed:";
      print htmlentities($e['message']);
      exit;
    }

    if ($result->num_rows == 0) {
      echo "invalid";
      return;
    }

    $sql="INSERT INTO Contract (contractId,startDate,endDate) VALUES ('$_POST[product]',date '$_POST[date]', date '$_POST[eDate]')";
    $sqlParse = OCIParse($conn, $sql);
    $result = OCIExecute($sqlParse);

    if (!$result){
      $e = oci_error;
      print "<br> connection failed:";
      print htmlentities($e['message']);
      exit;
    }
    echo "success";
    OCILogoff($con);

  }


?>
