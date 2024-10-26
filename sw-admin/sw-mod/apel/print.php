<?php session_start(); error_reporting(0);
    require_once'../../../sw-library/sw-config.php'; 
    require_once'../../../sw-library/sw-function.php';
    include_once'../../../sw-library/vendor/autoload.php';
if(empty($_SESSION['SESSION_USER']) && empty($_SESSION['SESSION_ID'])){
    //Kondisi tidak login
   header('location:../login/');
}

else{
  //kondisi login
switch (@$_GET['action']){
/* -------  CETAK PDF-----------------------------------------------*/
case 'pdf':
  if (empty($_GET['id'])) {
      $error[] = 'ID tidak boleh kosong';
    } else {
      $id = mysqli_real_escape_string($connection, $_GET['id']);
  }

if (empty($error)) {
  $query ="SELECT employees.id,employees.employees_name,employees.employees_nip,employees.position_id,position.position_name,employees.shift_id FROM employees,position WHERE employees.position_id=position.position_id AND employees.id='$id'";
  $result = $connection->query($query);

  $query_jam_apel ="SELECT time_in FROM jam_apel LIMIT 1";
  $result_jam_apel = $connection->query($query_jam_apel);
  if ($result_jam_apel->num_rows > 0) {
    $row_jam_apel = $result_jam_apel->fetch_assoc();
  }else{
    $row_jam_apel = array(['time_in'=>'08:30:00']);
  }

  if($result->num_rows > 0){
      $row            = $result->fetch_assoc();
      $employees_name = $row['employees_name'];

      if(isset($_GET['from']) OR isset($_GET['to'])){
          $bulan   = date ($_GET['from']);
      } 
      else{
          $bulan  = date ("m");
      }
        $hari       = date("d");
        $tahun      = date("Y");
        $jumlahhari = date("t",mktime(0,0,0,$bulan,$hari,$tahun));
        $s          = date ("w", mktime (0,0,0,$bulan,1,$tahun));
        $sum        = 0;

        $shift_time_in  = $row_jam_apel['time_in'];

        //$mpdf = new \Mpdf\Mpdf();
        $mpdf = new \Mpdf\Mpdf(['mode' => 'utf-8', 'format' => 'Legal-L']);
        ob_start();
    
  $mpdf->SetHTMLFooter('
      <table width="100%" style="border-top:solid 1px #333;font-size:11px;">
          <tr>
              <td width="60%" style="text-align:left;">Simpanlah lembar Absensi ini.</td>
              <td width="35%" style="text-align: right;">Dicetak tanggal '.tgl_indo($date).'</td>
          </tr>
      </table>');
echo'<!DOCTYPE html>
<html>
<head>
    <title>Cetak Data Apel '.$employees_name.'</title>
    <style>
    body{font-family:Arial,Helvetica,sans-serif}.container_box{position:relative}.container_box .row h3{line-height:25px;font-size:20px;margin:0px 0 10px;text-transform:uppercase}.container_box .text-center{text-align:center}.container_box .content_box{position:relative}.container_box .content_box .des_info{margin:20px 0;text-align:right}.container_box h3{font-size:30px}table.customTable{width:100%;background-color:#fff;border-collapse:collapse;border-width:1px;border-color:#b3b3b3;border-style:solid;color:#000}table.customTable td,table.customTable th{border-width:1px;border-color:#b3b3b3;border-style:solid;padding:5px;text-align:left}table.customTable thead{background-color:#f6f3f8}.text-center{text-align:center}
    .label {display: inline;padding: .2em .6em .3em;font-size: 75%;font-weight: 700;line-height: 1;color: #fff;text-align: center;white-space: nowrap; vertical-align: baseline;border-radius: .25em;}
    .label-success{background-color: #00a65a !important;}.label-warning {background-color: #f0ad4e;}.label-info {background-color: #5bc0de;}.label-danger{background-color: #dd4b39 !important;}
    p{line-height:20px;padding:0px;margin: 5px;}.pull-right{float:right}
    </style>
</head>
<body>';
echo'
    <section class="container_box">
      <div class="row">';
      if(isset($_GET['from']) OR isset($_GET['to'])){
        echo'<h3 class="text-center">LAPORAN APEL DETAIL HARIAN<br>PERIODE WAKTU '.bulan_indo2((int)$_GET['from']).' - '.$_GET['to'].'</h3>';}
        else{
        echo'<h3 class="text-center">LAPORAN APEL DETAIL BULAN<br>'.bulan_indo2((int)$month).' - '.$year.'</h3>';
       }
        echo'
        <p>NIP     : '.$row['employees_nip'].'</p>
        <p>Nama    : '.$row['employees_name'].'</p>
        <p>Jabatan : '.$row['position_name'].'</p><br>
      <div class="content_box">
        <table class="customTable">
          <thead>
            <tr>
              <th class="text-center">No.</th>
              <th>Tanggal</th>
              <th class="text-center">Jam Apel</th>
              <th class="text-center">Scan Apel</th>
              <th>Terlambat</th>
              <th>Status</th>
            </tr>
          </thead>
        <tbody>';
        $sum = 0; $libur = 0;
         for ($d=1;$d<=$jumlahhari;$d++) {
            $warna      = '';
            $background = '';
            $status     = 'Tidak Hadir';
          if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
            $warna='black';
            $background ='white';
            $status ='Libur Akhir Pekan';
            $sum++;
          }else{
            $date_month_year = ''.$year.'-'.$bulan.'-'.$d.'';
            $query_holiday="SELECT holiday_date FROM holiday WHERE holiday_date='$date_month_year'";
            $result_holiday = $connection->query($query_holiday);
              if($result_holiday->num_rows > 0){
                $warna='#ffffff';
                $background ='#FF0000';
                $libur++;
              }
          }
      $date_month_year = ''.$year.'-'.$bulan.'-'.$d.'';

      if(isset($_GET['from']) OR isset($_GET['to'])){
        $month = $_GET['from'];
        $year  = $_GET['to'];
        $filter ="employees_id='$id' AND apel_date='$date_month_year' AND MONTH(apel_date)='$month' AND year(apel_date)='$year'";
      } 
      else{
        $filter ="employees_id='$id' AND  apel_date='$date_month_year' AND MONTH(apel_date) ='$month'";
      }


      // $query_shift ="SELECT time_in,time_out FROM shift WHERE shift_id='$row[shift_id]'";
      // $result_shift = $connection->query($query_shift);
      // $row_shift = $result_shift->fetch_assoc();
      // $shift_time_in = $row_shift['time_in'];
      // $shift_time_out = $row_shift['time_out'];
      // $newtimestamp = strtotime(''.$shift_time_in.' + 05 minute');
      // $newtimestamp = date('H:i:s', $newtimestamp);

      $query_absen ="SELECT apel_id,apel_date,time_in,`status` AS present_id,latlng,TIMEDIFF(TIME(time_in),'$shift_time_in') AS selisih,if (time_in>'$shift_time_in','Telat',if(time_in='00:00:00','Tidak Masuk','Tepat Waktu')) AS status FROM apel WHERE $filter ORDER BY apel_id DESC";
      $result_absen = $connection->query($query_absen);
      $row_absen = $result_absen->fetch_assoc();

      $querya ="SELECT present_id,present_name FROM present_status WHERE present_id='$row_absen[present_id]'";
      $resulta= $connection->query($querya);
      $rowa =  $resulta->fetch_assoc();

         if($row_absen['time_in'] == NULL){
            if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
              $status ='Libur Akhir Pekan';
            }else{
              $status ='<span class="label label-danger">Tidak Hadir</span>';
            }
            $time_in = $row_absen['time_in']; 
          }
          else{
              $status = $rowa['present_name'];
              $time_in = $row_absen['time_in']; 
          }

         // Status Absensi Jam Masuk
        if($row_absen['status']=='Telat'){
          $status_time_in ='<label class="label label-danger pull-right">'.$row_absen['status'].'</label>';
        }
          elseif ($row_absen['status']=='Tepat Waktu') {
          $status_time_in ='<label class="label label-info pull-right">'.$row_absen['status'].'</label>';
          $terlamat 	= '';
        }
        else{
          $status_time_in ='';
          $terlamat 	= '';
        }

        echo'
         <tr style="background:'.$background.';color:'.$warna.'">
            <td class="text-center">'.$d.'</td>
            <td>'.format_hari_tanggal($date_month_year).'</td>';
            if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
              if($row_absen['time_in'] ==''){
                echo'
                <td class="text-center" colspan="3">Libur Akhir Pekan</td>';
              }
              else{
                echo'
                <td class="text-center">'.$row_absen['time_in'].'</td>
                <td class="text-center">'.$row_absen['time_in'].'</td>
              	<td class="text-center">'.$row_absen['selisih'].'</td>';
              }

            }
            else{
            echo'
              <td class="text-center">'.$shift_time_in.'</td>
              <td class="text-center">'.$row_absen['time_in'].'</td>
              <td class="text-center">'.$row_absen['selisih'].'</td>';
            }

            echo'
              <td>'.$status.' '.$status_time_in.'</td>
          </tr>';
        }
  
      echo'<tbody>
      </table>';
      if(isset($_GET['from']) OR isset($_GET['to'])){
        $month = $_GET['from'];
        $year  = $_GET['to'];
        $filter ="employees_id='$id' AND MONTH(apel_date)='$month' AND year(apel_date)='$year' AND employees_id='$id'";
      } 
      else{
        $filter ="employees_id='$id' AND MONTH(apel_date) ='$month' AND employees_id='$id'";
      }

    $query_hadir="SELECT apel_id FROM apel WHERE $filter AND `status`='1' ORDER BY apel_id DESC";
    $hadir= $connection->query($query_hadir);

    $query_telat ="SELECT apel_id FROM apel WHERE $filter AND time_in>'$shift_time_in'";
    $telat = $connection->query($query_telat);

    $query_alpha="SELECT apel_id FROM apel WHERE $filter";
    $alpha = $connection->query($query_alpha);
    $alpha = $jumlahhari - $alpha->num_rows - $sum - $libur;

      echo'<p>Alpha : <span class="label label-danger">'.$alpha.'</span></p>
          <p>Hadir : <span class="label label-success">'.$hadir->num_rows.'</span></p>
          <p>Telat : <span class="label label-danger">'.$telat->num_rows.'</span></p>

      </div>
    </div>
  </section>
</body>
</html>';
  $html = ob_get_contents(); 
  ob_end_clean();
  $mpdf->WriteHTML(utf8_encode($html));
  $mpdf->Output("Apel-$employees_name-$date.pdf" ,'I');
}else{
  echo'<center><h3>Data Tidak Ditemukan</h3></center>';
}
}else{
  echo'Data tidak boleh ada yang kosong!';
}

//Explore to Excel -------------------------------------------------------
break;
case 'excel':
  
if (empty($_GET['id'])) {
      $error[] = 'ID tidak boleh kosong';
    } else {
      $id = mysqli_real_escape_string($connection, $_GET['id']);
  }

if (empty($error)) {
  $query ="SELECT employees.id,employees.employees_name,employees.employees_nip,employees.position_id,position.position_name,employees.shift_id FROM employees,position WHERE employees.position_id=position.position_id AND employees.id='$id'";
  $result = $connection->query($query);

  $query_jam_apel ="SELECT time_in FROM jam_apel LIMIT 1";
  $result_jam_apel = $connection->query($query_jam_apel);
  if ($result_jam_apel->num_rows > 0) {
    $row_jam_apel = $result_jam_apel->fetch_assoc();
  }else{
    $row_jam_apel = array(['time_in'=>'08:30:00']);
  }

  if($result->num_rows > 0){
      $row            = $result->fetch_assoc();
      $employees_name = $row['employees_name'];

      if(isset($_GET['from']) OR isset($_GET['to'])){
          $bulan   = date ($_GET['from']);
      } 
      else{
          $bulan  = date ("m");
      }

      $hari       = date("d");
      $tahun      = date("Y");
      $jumlahhari = date("t",mktime(0,0,0,$bulan,$hari,$tahun));
      $s          = date ("w", mktime (0,0,0,$bulan,1,$tahun));
      $sum        = 0;

      $shift_time_in  = $row_jam_apel['time_in'];      

if (empty($_GET['print'])) {
  header("Content-type: application/vnd-ms-excel");
  header("Content-Disposition: attachment; filename=Data-Apel-$employees_name-$date.xls");
    }
else {
echo'<script>
      window.onafterprint = window.close;
      window.print();
    </script>';  
}
    

echo'<!DOCTYPE html>
<html>
<head>
    <title>Cetak Data Apel '.$employees_name.'</title>
    <style>
    body{font-family:Arial,Helvetica,sans-serif}.container_box{position:relative}.container_box .row h3{line-height:25px;font-size:20px;margin:0px 0 10px;text-transform:uppercase}.container_box .text-center{text-align:center}.container_box .content_box{position:relative}.container_box .content_box .des_info{margin:20px 0;text-align:right}.container_box h3{font-size:30px}table.customTable{width:100%;background-color:#fff;border-collapse:collapse;border-width:1px;border-color:#b3b3b3;border-style:solid;color:#000}table.customTable td,table.customTable th{border-width:1px;border-color:#b3b3b3;border-style:solid;padding:5px;text-align:left}table.customTable thead{background-color:#f6f3f8}.text-center{text-align:center}
    .label {display: inline;padding: .2em .6em .3em;font-size: 75%;font-weight: 700;line-height: 1;color: #fff;text-align: center;white-space: nowrap; vertical-align: baseline;border-radius: .25em;}
    .label-success{background-color: #00a65a !important;}.label-warning {background-color: #f0ad4e;}.label-info {background-color: #5bc0de;}.label-danger{background-color: #dd4b39 !important;}
    p{line-height:20px;padding:0px;margin: 5px;}.pull-right{float:right}
    </style>
</head>
<body>';
echo'
    <section class="container_box">
      <div class="row">';
      if(isset($_GET['from']) OR isset($_GET['to'])){
        echo'<h3 class="text-center">LAPORAN APEL DETAIL HARIAN<br>PERIODE WAKTU '.bulan_indo2((int)$_GET['from']).' - '.$_GET['to'].'</h3>';}
        else{
        echo'<h3 class="text-center">LAPORAN APEL DETAIL BULAN<br>'.bulan_indo2((int)$month).' - '.$year.'</h3>';
        }
        echo'
        <p>NIP   : '.$row['employees_nip'].'</p>
        <p>Nama   : '.$row['employees_name'].'</p>
        <p>Jabatan : '.$row['position_name'].'</p><br>
        <div class="content_box">
        <table class="customTable">
          <thead>
            <tr>
              <th class="text-center">No.</th>
              <th>Tanggal</th>
              <th class="text-center">Jam Apel</th>
              <th class="text-center">Scan Apel</th>
              <th>Terlambat</th>
              <th>Status</th>
            </tr>
          </thead>
        <tbody>';
          $sum = 0; $libur = 0;
         for ($d=1;$d<=$jumlahhari;$d++) {
            $warna      = '';
            $background = '';
            $status     = 'Tidak Hadir';
          if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
            $warna='black';
            $background ='white';
            $status ='Libur Akhir Pekan';
            $sum++;
          }else{
            $date_month_year = ''.$year.'-'.$bulan.'-'.$d.'';
            $query_holiday="SELECT holiday_date FROM holiday WHERE holiday_date='$date_month_year'";
            $result_holiday = $connection->query($query_holiday);
              if($result_holiday->num_rows > 0){
                $warna='#ffffff';
                $background ='#FF0000';
                $libur++;
              }
          }
      $date_month_year = ''.$year.'-'.$bulan.'-'.$d.'';

      if(isset($_GET['from']) OR isset($_GET['to'])){
        $month = $_GET['from'];
        $year  = $_GET['to'];
        $filter ="employees_id='$id' AND apel_date='$date_month_year' AND MONTH(apel_date)='$month' AND year(apel_date)='$year'";
      } 
      else{
        $filter ="employees_id='$id' AND  apel_date='$date_month_year' AND MONTH(apel_date) ='$month'";
      }


      // $query_shift ="SELECT time_in,time_out FROM shift WHERE shift_id='$row[shift_id]'";
      // $result_shift = $connection->query($query_shift);
      // $row_shift = $result_shift->fetch_assoc();
      // $shift_time_in = $row_shift['time_in'];
      // $shift_time_out = $row_shift['time_out'];
      // $newtimestamp = strtotime(''.$shift_time_in.' + 05 minute');
      // $newtimestamp = date('H:i:s', $newtimestamp);

      $query_absen ="SELECT apel_id,apel_date,time_in,`status` AS present_id,latlng,TIMEDIFF(TIME(time_in),'$shift_time_in') AS selisih,if (time_in>'$shift_time_in','Telat',if(time_in='00:00:00','Tidak Masuk','Tepat Waktu')) AS status FROM apel WHERE $filter ORDER BY apel_id DESC";
      $result_absen = $connection->query($query_absen);
      $row_absen = $result_absen->fetch_assoc();

      $querya ="SELECT present_id,present_name FROM present_status WHERE present_id='$row_absen[present_id]'";
      $resulta= $connection->query($querya);
      $rowa =  $resulta->fetch_assoc();

         if($row_absen['time_in'] == NULL){
            if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
              $status ='Libur Akhir Pekan';
            }else{
              $status ='<span class="label label-danger">Tidak Hadir</span>';
            }
            $time_in = $row_absen['time_in']; 
          }
          else{
              $status = $rowa['present_name'];
              $time_in = $row_absen['time_in']; 
          }

         // Status Absensi Jam Masuk
        if($row_absen['status']=='Telat'){
          $status_time_in ='<label class="label label-danger pull-right">'.$row_absen['status'].'</label>';
        }
          elseif ($row_absen['status']=='Tepat Waktu') {
          $status_time_in ='<label class="label label-info pull-right">'.$row_absen['status'].'</label>';
          $terlamat 	= '';
        }
        else{
          $status_time_in ='';
          $terlamat 	= '';
        }

        echo'
         <tr style="background:'.$background.';color:'.$warna.'">
            <td class="text-center">'.$d.'</td>
            <td>'.format_hari_tanggal($date_month_year).'</td>';
            if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday"){
              if($row_absen['time_in'] ==''){
                echo'
                <td class="text-center" colspan="3">Libur Akhir Pekan</td>';
              }
              else{
                echo'
                <td class="text-center">'.$row_absen['time_in'].'</td>
                <td class="text-center">'.$row_absen['time_in'].'</td>
              	<td class="text-center">Terlambat</td>';
              }

            }
            else{
            echo'
              <td class="text-center">'.$shift_time_in.'</td>
              <td class="text-center">'.$row_absen['time_in'].'</td>
              <td class="text-center">'.$row_absen['selisih'].'</td>';
            }
            echo'
              <td>'.$status.' '.$status_time_in.'</td>
          </tr>';
        }
  
      echo'<tbody>
      </table>';
      if(isset($_GET['from']) OR isset($_GET['to'])){
        $month = $_GET['from'];
        $year  = $_GET['to'];
        $filter ="employees_id='$id' AND MONTH(apel_date)='$month' AND year(apel_date)='$year' AND employees_id='$id'";
      } 
      else{
        $filter ="employees_id='$id' AND MONTH(apel_date) ='$month' AND employees_id='$id'";
      }

      $query_hadir="SELECT apel_id FROM apel WHERE $filter AND `status`='1' ORDER BY apel_id DESC";
      $hadir= $connection->query($query_hadir);

      $query_telat ="SELECT apel_id FROM apel WHERE $filter AND time_in>'$shift_time_in'";
      $telat = $connection->query($query_telat);

      $query_alpha="SELECT apel_id FROM apel WHERE $filter";
      $alpha = $connection->query($query_alpha);
      $alpha = $jumlahhari - $alpha->num_rows - $sum;

      echo'<p>Alpha : <span class="label label-danger">'.$alpha.'</span></p>
          <p>Hadir : <span class="label label-success">'.$hadir->num_rows.'</span></p>
          <p>Telat : <span class="label label-danger">'.$telat->num_rows.'</span></p>

        </div>
      </div>
    </section>
</body>
</html>';
    }else{
      echo'<center><h3>Data Tidak Ditemukan</h3></center>';
    }
    }else{
      echo'Data tidak boleh ada yang kosong!';
    }


/* ------------------------------------------------------
    ......................
    CETAK ALL Karyawan
    ......................
// ------------------------------------------------------*/
break;
case 'allexcel':
  $query ="SELECT employees.id,employees.employees_name,employees.employees_nip,employees.position_id,position.position_name,shift.time_in,shift.time_out FROM employees,position,shift WHERE employees.position_id=position.position_id AND employees.shift_id=shift.shift_id ORDER BY employees.id DESC";
  $result = $connection->query($query);
  $query_jam_apel ="SELECT time_in FROM jam_apel LIMIT 1";
  $result_jam_apel = $connection->query($query_jam_apel);
  if ($result_jam_apel->num_rows > 0) {
    $row_jam_apel = $result_jam_apel->fetch_assoc();
  }else{
    $row_jam_apel = array(['time_in'=>'08:30:00']);
  }

  if($result->num_rows > 0){
  
echo'<!DOCTYPE html>
<html>
<head>
    <title>Cetak Data Apel '.$employees_name.'</title>
    <style>
    body{font-family:Arial,Helvetica,sans-serif}.container_box{position:relative}.container_box .row h3{line-height:25px;font-size:20px;margin:0px 0 10px;text-transform:uppercase}.container_box .text-center{text-align:center}.container_box .content_box{position:relative}.container_box .content_box .des_info{margin:20px 0;text-align:right}.container_box h3{font-size:30px}table.customTable{width:100%;background-color:#fff;border-collapse:collapse;border-width:1px;border-color:#b3b3b3;border-style:solid;color:#000}table.customTable td,table.customTable th{border-width:1px;border-color:#b3b3b3;border-style:solid;padding:5px;text-align:left}table.customTable thead{background-color:#f6f3f8}.text-center{text-align:center}
    .label {display: inline;padding: .2em .6em .3em;font-size: 75%;font-weight: 700;line-height: 1;color: #fff;text-align: center;white-space: nowrap; vertical-align: baseline;border-radius: .25em;}
    .label-success{background-color: #00a65a !important;}.label-warning {background-color: #f0ad4e;}.label-info {background-color: #5bc0de;}.label-danger{background-color: #dd4b39 !important;}
    p{line-height:20px;padding:0px;margin: 5px;}.pull-right{float:right}
    </style>';
  if (empty($_GET['print'])) {
      header("Content-type: application/vnd-ms-excel");
      header("Content-Disposition: attachment; filename=Data-Apel-$date.xls");
  } else {
    echo'
    <script type="text/javascript">
      //window.onafterprint = window.close;
      //window.print();
    </script>';
  }
  echo'
</head>
<body>';
while ($row= $result->fetch_assoc()) {
      $employees_name = $row['employees_name'];
      $id             = $row['id'];

      if(isset($_GET['from']) OR isset($_GET['to'])){
          $bulan   = date ($_GET['from']);
      } 
      else{
          $bulan  = date ("m");
      }
        $hari       = date("d");
        $tahun      = date("Y");
        $jumlahhari = date("t",mktime(0,0,0,$bulan,$hari,$tahun));
        $s          = date ("w", mktime (0,0,0,$bulan,1,$tahun));
        $sum        = 0;


      $shift_time_in  = $row_jam_apel['time_in'];
echo'
    <section class="container_box">
      <div class="row">';
      if(isset($_GET['from']) OR isset($_GET['to'])){
        echo'<h3>DATA APEL BULAN '.bulan_indo2((int)$_GET['from']).' - '.$_GET['to'].'</h3>';}
        else{
        echo'<h3>DATA APEL BULAN '.bulan_indo2((int)$month).' - '.$year.'</h3>';
      }
        echo'
        <p>NIP   : '.$row['employees_nip'].'</p>
        <p>Nama   : '.$row['employees_name'].'</p>
        <p>Jabatan : '.$row['position_name'].'</p><br>
      <div class="content_box">
        <table class="customTable">
          <thead>
            <tr>
              <th class="text-center">No.</th>
              <th>Tanggal</th>
              <th class="text-center">Jam Apel</th>
              <th class="text-center">Scan Apel</th>
              <th>Terlambat</th>
              <th>Status</th>
            </tr>
          </thead>
        <tbody>';
        $sum = 0; $libur = 0;
         for ($d=1;$d<=$jumlahhari;$d++) {
            $warna      = '';
            $background = '';
            $status     = 'Tidak Hadir';
          if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
            $warna='black';
            $background ='white';
            $status ='Libur Akhir Pekan';
            $sum++;
          }else{
            $date_month_year = ''.$year.'-'.$bulan.'-'.$d.'';
            $query_holiday="SELECT holiday_date FROM holiday WHERE holiday_date='$date_month_year'";
            $result_holiday = $connection->query($query_holiday);
              if($result_holiday->num_rows > 0){
                $warna='#ffffff';
                $background ='#FF0000';
                $libur++;
              }
          }
      $date_month_year = ''.$year.'-'.$bulan.'-'.$d.'';

      if(isset($_GET['from']) OR isset($_GET['to'])){
        $month = $_GET['from'];
        $year  = $_GET['to'];
        $filter ="employees_id='$id' AND apel_date='$date_month_year' AND MONTH(apel_date)='$month' AND year(apel_date)='$year'";
      } 
      else{
        $filter ="employees_id='$id' AND  apel_date='$date_month_year' AND MONTH(apel_date) ='$month'";
      }


      $query_absen ="SELECT apel_id,apel_date,time_in,`status` AS present_id,latlng,TIMEDIFF(TIME(time_in),'$shift_time_in') AS selisih,if (time_in>'$shift_time_in','Telat',if(time_in='00:00:00','Tidak Masuk','Tepat Waktu')) AS status FROM apel WHERE $filter ORDER BY apel_id DESC";
      $result_absen = $connection->query($query_absen);
      $row_absen = $result_absen->fetch_assoc();

      $querya ="SELECT present_id,present_name FROM present_status WHERE present_id='$row_absen[present_id]'";
      $resulta= $connection->query($querya);
      $rowa =  $resulta->fetch_assoc();

         if($row_absen['time_in'] == NULL){
           if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
              $status ='Libur Akhir Pekan';
            }else{
              $status ='<span class="label label-danger">Tidak Hadir</span>';
            }
            $time_in = $row_absen['time_in']; 
          }
          else{
              $status = $rowa['present_name'];
              $time_in = $row_absen['time_in']; 
          }

         // Status Absensi Jam Masuk
        if($row_absen['status']=='Telat'){
          $status_time_in ='<label class="label label-danger pull-right">'.$row_absen['status'].'</label>';
        }
        elseif ($row_absen['status']=='Tepat Waktu') {
          $status_time_in ='<label class="label label-info pull-right">'.$row_absen['status'].'</label>';
          $terlamat   = '';
        }
        else{
          $status_time_in ='';
          $terlamat   = '';
        }

        echo'
         <tr style="background:'.$background.';color:'.$warna.'">
            <td class="text-center">'.$d.'</td>
            <td>'.format_hari_tanggal($date_month_year).'</td>';
            if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday"){
              if($row_absen['time_in'] ==''){
                echo'
                <td class="text-center" colspan="3">Libur Akhir Pekan</td>';
              }
              else{
                echo'
                <td class="text-center">'.$row_absen['time_in'].'</td>
                <td class="text-center">'.$row_absen['time_in'].'</td>
                <td class="text-center">Terlambat</td>';
              }

            }
            else{
            echo'
              <td class="text-center">'.$shift_time_in.'</td>
              <td class="text-center">'.$row_absen['time_in'].'</td>
              <td class="text-center">'.$row_absen['selisih'].'</td>';
            }

            echo'
              <td>'.$status.' '.$status_time_in.'</td>
          </tr>';
        }
  
      echo'<tbody>
      </table>';
      if(isset($_GET['from']) OR isset($_GET['to'])){
        $month = $_GET['from'];
        $year  = $_GET['to'];
        $filter ="employees_id='$id' AND MONTH(apel_date)='$month' AND year(apel_date)='$year' AND employees_id='$id'";
      } 
      else{
        $filter ="employees_id='$id' AND MONTH(apel_date) ='$month' AND employees_id='$id'";
      }

      $query_hadir="SELECT apel_id FROM apel WHERE $filter AND `status`='1' ORDER BY apel_id DESC";
      $hadir= $connection->query($query_hadir);

      $query_telat ="SELECT apel_id FROM apel WHERE $filter AND time_in>'$shift_time_in'";
      $telat = $connection->query($query_telat);

      $query_alpha="SELECT apel_id FROM apel WHERE $filter";
      $alpha = $connection->query($query_alpha);
      $alpha = $jumlahhari - $alpha->num_rows - $sum - $libur;

      echo'<p>Alpha : <span class="label label-danger">'.$alpha.'</span></p>
          <p>Hadir : <span class="label label-success">'.$hadir->num_rows.'</span></p>
          <p>Telat : <span class="label label-danger">'.$telat->num_rows.'</span></p>

      </div>
    </div>
  </section>';
  }
echo'
</body>
</html>';
}else{
  echo'<center><h3>Data Tidak Ditemukan</h3></center>';
}

break;
}
}?>