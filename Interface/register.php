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

    $sql="insert into Customer values('$_POST[custId]','$_POST[name]','$_POST[number]')";
    $sqlParse = OCIParse($con, $sql);
    $result = OCIExecute($sqlParse);

    $sql="call createContract('$_POST[conId]','$_POST[product]',date '$_POST[date]',date '$_POST[eDate]')";
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
