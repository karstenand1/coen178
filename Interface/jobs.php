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
    $sql="begin :r := showJobs(); end;";
    $sqlParse = OCIParse($con, $sql);
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
