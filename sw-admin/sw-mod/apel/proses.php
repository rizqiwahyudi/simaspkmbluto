<?php session_start(); error_reporting(0);
if(empty($_SESSION['SESSION_USER']) && empty($_SESSION['SESSION_ID'])){
    header('location:../../login/');
 exit;}
else {
require_once'../../../sw-library/sw-config.php';
require_once'../../login/login_session.php';
include('../../../sw-library/sw-function.php'); 

switch (@$_GET['action']){
/* -------  LOAD DATA ABSENSI----------*/
case 'absensi':
  $error = array();

   if (empty($_GET['id'])) {
      $error[] = 'ID tidak boleh kosong';
    } else {
      $id = mysqli_real_escape_string($connection, $_GET['id']);
  }

  if(isset($_POST['month']) OR isset($_POST['year'])){
      $bulan   = date ($_POST['month']);} 
  else{
      $bulan  = date ("m");
  }

  $hari       = date("d");
  //$bulan      = date ("m");
  $tahun      = date("Y");
  $jumlahhari = date("t",mktime(0,0,0,$bulan,$hari,$tahun));
  $s          = date ("w", mktime (0,0,0,$bulan,1,$tahun));
  $sum        = 0;
if (empty($error)) { 
echo'
<div class="table-responsive">
<table class="table table-bordered table-hover" id="swdatatable">
        <thead>
            <tr>
                <th class="align-middle" width="20">No</th>
                <th class="align-middle">Tanggal</th>
                <th class="align-middle text-center">Jam Apel</th>
                <th class="align-middle text-center">Scan Apel</th>
                <th class="align-middle text-center">Terlambat</th>
                <th class="align-middle">Status</th>
                <th class="align-middle text-right">Aksi</th>
            </tr>
        </thead>
        <tbody>';
        $sum = 0; $libur = 0;
      for ($d=1;$d<=$jumlahhari;$d++) {
            $warna      = '';
            $background = '';
            $status_hadir     = 'Tidak Hadir';
      if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
            $warna='black';
            $background ='white';
            $status_hadir ='Libur Akhir Pekan';
            $sum++;
      }
      else{
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

      if(isset($_POST['month']) OR isset($_POST['year'])){
        $month = $_POST['month'];
        $year  = $_POST['year'];
        $filter ="employees_id='$id' AND apel_date='$date_month_year' AND MONTH(apel_date)='$month' AND year(apel_date)='$year' AND employees_id='$id'";
      } 
      else{
        $filter ="employees_id='$id' AND apel_date='$date_month_year' AND MONTH(apel_date) ='$month' AND employees_id='$id'";
      }

      $query ="SELECT employees.id,shift.shift_id,shift.time_in,shift.time_out FROM employees,shift WHERE employees.shift_id=shift.shift_id AND employees.id='$id'";
      $result = $connection->query($query);
      $row    = $result->fetch_assoc();


      // $query_shift ="SELECT time_in,time_out FROM shift WHERE shift_id='$row[shift_id]'";
      // $result_shift = $connection->query($query_shift);
      // $row_shift = $result_shift->fetch_assoc();
      // $shift_time_in = $row_shift['time_in'];
      // $shift_time_out = $row_shift['time_out'];
      // $newtimestamp = strtotime(''.$shift_time_in.' + 05 minute');
      // $newtimestamp = date('H:i:s', $newtimestamp);

      $query_jam_apel ="SELECT time_in FROM jam_apel LIMIT 1";
      $result_jam_apel = $connection->query($query_jam_apel);
      if ($result_jam_apel->num_rows > 0) {
        $row_jam_apel = $result_jam_apel->fetch_assoc();
      }else{
        $row_jam_apel = array(['time_in'=>'08:30:00']);
      }

      $shift_time_in  = $row_jam_apel['time_in'];

      $query_absen ="SELECT apel_id,apel_date,time_in,`status` AS present_id,latlng,TIMEDIFF(TIME(time_in),'$shift_time_in') AS selisih,if (time_in>'$shift_time_in','Telat',if(time_in='00:00:00','Tidak Masuk','Tepat Waktu')) AS status FROM apel WHERE $filter ORDER BY apel_id DESC";
      $result_absen = $connection->query($query_absen);
      $row_absen = $result_absen->fetch_assoc();
      // Status Kehadiran
      $querya ="SELECT present_id,present_name FROM present_status WHERE present_id='$row_absen[present_id]'";
      $resulta= $connection->query($querya);
      $rowa =  $resulta->fetch_assoc();
        // Status Kehadiran
        if($row_absen['time_in'] == NULL){
          if (date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Sunday" OR date("l",mktime (0,0,0,$bulan,$d,$tahun)) == "Saturday") {
            $status_hadir ='Libur Akhir Pekan';
          }else{
            $status_hadir ='<span class="label label-danger">Tidak Hadir</span>';
          }
            $time_in = $row_absen['time_in']; 
        }
        else{
          $status_hadir ='<a href="javascript:void(0);" data-id="'.$row_absen['apel_id'].'" data-present-id="'.$row_absen['present_id'].'" class="label label-warning btn-modal-status">'.$rowa['present_name'].'</a>';
          $time_in = $row_absen['time_in']; 
        }

        // Status Absensi Jam Masuk
        if($row_absen['status']=='Telat'){
          $status_time_in ='<label class="label label-danger">Terlambat</label>';
        }
          elseif ($row_absen['status']=='Tepat Waktu') {
          $status_time_in ='<label class="label label-info">'.$row_absen['status'].'</label>';
        }
        else{
          $status_time_in ='<label class="label label-danger">'.$row_absen['status'].'</label>';
        }

        list($latitude,  $longitude) = explode(',', $row_absen['latlng']);
        echo'
        <tr style="background:'.$background.';color:'.$warna.'">
          <td class="text-center">'.$d.'</td>
          <td>'.format_hari_tanggal($date_month_year).'</td>
          <td class="text-center">'.$row['time_in'].'</td>
          <td class="text-center"><span class="text-primary">'.$row_absen['time_in'].'</span> '.$status_time_in.'</td>
          <td class="text-center">'.$row_absen['selisih'].'</td>
          <td>'.$status_hadir.'</td>

          <td class="text-right">';
            if(!$latitude == NULL){
              echo'
              <button type="button" class="btn btn-primary btn-xs btn-modal enable-tooltip" title="Lokasi" data-latitude="'.$latitude.'" data-longitude="'.$longitude.'"><i class="fa fa-map-marker"></i> Masuk</button>';}
            echo'
          </td>
        </tr>';
      }
        echo'
        </tbody>
      </table>
  </div>';
      if(isset($_POST['month']) OR isset($_POST['year'])){
        $month = $_POST['month'];
        $year  = $_POST['year'];
        $filter ="employees_id='$id' AND MONTH(apel_date)='$month' AND year(apel_date)='$year' AND employees_id='$id'";
      } 
      else{
        $filter ="employees_id='$id' AND MONTH(apel_date) ='$month' and employees_id='$id'";
      }

      $query_hadir="SELECT apel_id FROM apel WHERE $filter AND `status`='1' ORDER BY apel_id DESC";
      $hadir= $connection->query($query_hadir);

      $query_sakit="SELECT apel_id FROM apel WHERE $filter AND `status`='2' ORDER BY apel_id";
      $sakit = $connection->query($query_sakit);

      $query_izin="SELECT apel_id FROM apel WHERE $filter AND `status`='3'  ORDER BY apel_id";
      $izin = $connection->query($query_izin);


      $query_telat ="SELECT apel_id FROM apel WHERE $filter AND time_in>'$shift_time_in'";
      $telat = $connection->query($query_telat);

      $query_alpha="SELECT apel_id FROM apel WHERE $filter AND employees_id='$row[id]'";
      $alpha = $connection->query($query_alpha);
      $alpha = $jumlahhari - $alpha->num_rows - $sum - $libur;

      echo'<hr>
      <div class="row">
        <div class="col-md-2">
          <p>Alpha : <span class="label label-danger">'.$alpha.'</span></p>
        </div>


        <div class="col-md-2">
          <p>Hadir : <span class="label label-success">'.$hadir->num_rows.'</span></p>
        </div>

        <div class="col-md-2">
          <p>Terlambat : <span class="label label-danger">'.$telat->num_rows.'</span></p>
        </div>

        <div class="col-md-2">
          <p>Sakit : <span class="label label-warning">'.$sakit->num_rows.'</span></p>
        </div>

        <div class="col-md-2">
          <p>Izin : <span class="label label-info">'.$izin->num_rows.'</span></p>
        </div>

      </div>';
    echo'
<script>
  $("#swdatatable").dataTable({
      "iDisplayLength":35,
      "aLengthMenu": [[35, 40, 50, -1], [35, 40, 50, "All"]]
  });
 $(".image-link").magnificPopup({type:"image"});
</script>';?>
<script type="text/javascript">
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
</script>
<?php
}else{
  echo'Data tidak ditemukan';
}

break;
case 'update':
$error = array();
   if (empty($_POST['id'])) {
      $error[] = 'ID tidak boleh kosong';
    } else {
      $id = mysqli_real_escape_string($connection, $_POST['id']);
  }

  if (empty($_POST['status'])) {
      $error[] = 'tidak boleh kosong';
    } else {
      $status = mysqli_real_escape_string($connection, $_POST['status']);
  }

  if (empty($error)) { 
    $update="UPDATE presence SET present_id='$status' WHERE presence_id='$id'"; 
    if($connection->query($update) === false) { 
        die($connection->error.__LINE__); 
        echo'Data tidak berhasil disimpan!';
    } else{
        echo'success';
    }}
    else{           
        echo'Bidang inputan tidak boleh ada yang kosong..!';
    }
break;
}

}
