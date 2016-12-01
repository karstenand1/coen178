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
    $r='';
    $sDate=$_POST['sDate'];
    $eDate=$_POST['endDate'];
    $sql="begin :r := generateRevenue(to_date(:sDate, 'YYYY-MM-DD'),to_date(:eDate, 'YYYY-MM-DD')); end;";
    $sqlParse = OCIParse($con, $sql);
    oci_bind_by_name($sqlParse, ':sDate', $sDate);
    oci_bind_by_name($sqlParse, ':eDate', $eDate);
    oci_bind_by_name($sqlParse, ':r', $r, 300);
    $result = OCIExecute($sqlParse);

    if (!$result){
      echo "invalid";
      exit;
    }
    echo $r;

    OCILogoff($con);

  }


?>
