<?php

  modDatabase();

  function modDatabase() {

    ini_set('display_errors','On');
    error_reporting(E_ALL);
    $db_host = "//dbserver.engr.scu.edu/db11g";
    $db_user = "kanderse";
    $db_pass = "kanne987";
    $con = oci_connect($db_user, $db_pass, $db_host);
    // Check connection
    if (!$con){
        $e = oci_error;
  	    print "<br> connection failed:";
  	    print htmlentities($e['message']);
  	    exit;
    }
    $today = date("H:i:s");
    $one="1";
    $sql="call createRepairJob('$_POST[contract]', '$_POST[rId]', '$_POST[cust]' , '$_POST[product]' , $today , $one , '$_POST[employee]' , '$_POST[prob]' , '$_POST[model]')";
    $sqlParse = OCIParse($con, $sql);
    $result = OCIExecute($sqlParse);

    if (!$result){
      echo "invalid";
      exit;
    }
    echo "success";
    OCILogoff($con);

  }


?>
