<?php
session_start();
if(empty($_SESSION['SESSION_USER']) && empty($_SESSION['SESSION_ID'])){
    header('location:../../login/');
 exit;}
else {
require_once'../../../sw-library/sw-config.php';
require_once'../../login/login_session.php';
include('../../../sw-library/sw-function.php'); 

switch (@$_GET['action']){
case 'absent':

if (empty($_POST['qrcode'])) {
      $error[] = 'QR Code tidak boleh kosong';
    } else {
      $qrcode= mysqli_real_escape_string($connection, $_POST['qrcode']);
}

if (empty($_POST['latitude'])) {
      $error[] = 'Lokasi tidak boleh kosong';
    } else {
      $latitude= mysqli_real_escape_string($connection, $_POST['latitude']);
}

if (empty($error)){  
    $query_u="SELECT employees.id,employees.employees_code,employees.employees_name,employees.shift_id,shift.shift_id,shift.time_in,shift.time_out FROM employees,shift WHERE employees.shift_id=shift.shift_id AND employees.employees_code='$qrcode'";
    $result_user = $connection->query($query_u);
    if($result_user->num_rows > 0){
    $row_user = $result_user->fetch_assoc();
    
    $time_out     = strtotime(''.$row_user['time_out'].' - 60 minute');
    $time_out     = date('H:i:s', $time_out);

        // Cek data Absen Berdasarkan tanggal sekarang
        $query  ="SELECT employees_id,time_in,time_out FROM presence WHERE employees_id='$row_user[id]' AND presence_date='$date'";
        $result = $connection->query($query);
        if($result->num_rows > 0){
          $row = $result->fetch_assoc();
          // Update Absensi Pulang
          if($time_out < $time){
              if($row['time_out']=='00:00:00'){
                  //Update Jam Pulang
                  $update ="UPDATE presence SET time_out='$time',latitude_longtitude_out='$latitude' WHERE employees_id='$row_user[id]' AND presence_date='$date'";
                  if($connection->query($update) === false) { 
                      die($connection->error.__LINE__); 
                      echo'Sepetinya sitem kami sedang error!';
                  } else{
                      //Jam Pulang
                      echo'success/Selamat "'.$row_user['employees_name'].'" berhasil Absen Pulang pada Tanggal '.tanggal_ind($date).' dan Jam : '.$time.', Hati-hati dijalan saat pulang "'.$row_user['employees_name'].'".!';
                  }
              }
              else{
                echo'Sebelumnya "'.$row_user['employees_name'].'" sudah pernah Absen Pulang pada Tanggal '.tanggal_ind($date).' dan Jam '.$row['time_out'].'.!';
            }
          }else{
            echo'Absen pulang belum diperbolehkan "'.$row_user['employees_name'].'", Absen pulang aktif 30 menit sebelum jam pulang.!';
          }
        // Else Absen Mmasuk
        }else{
            $add ="INSERT INTO presence (employees_id,
                              presence_date,
                              time_in,
                              time_out,
                              present_id,
                              latitude_longtitude_in,
                              latitude_longtitude_out,
                              information) values('$row_user[id]',
                              '$date',
                              '$time',
                              '00:00:00',
                              '1', /*hadir*/
                              '$latitude',
                              '',
                              '')";
                    
            if($connection->query($add) === false) { 
                die($connection->error.__LINE__); 
                echo'Sepertinya Sistem Kami sedang error!';
            } else{
                echo'success/Selamat Anda berhasil Absen Masuk pada Tanggal '.tanggal_ind($date).' dan Jam : '.$time.', Semangat bekerja "'.$row_user['employees_name'].'" !';
            }
          }
      }
      else{
        // Jika user tidak ditemukan
        echo'Data tidak ditemukan';
      }
    }
    else{
      foreach ($error as $key => $values) {            
          echo"$values\n";
        }
}


break;
case 'data':
echo'
<table class="table table-hover" id="swdatatable">
    <thead>
        <tr>
            <th class="align-middle text-center" width="10">No</th>
            <th class="align-middle">Nama</th>
            <th class="align-middle">Absen Masuk</th>
            <th class="align-middle">Absen Pulang</th>
        </tr>
    </thead>
    <tbody>';
    $no=0;
	$query_absen ="SELECT presence.employees_id,presence.time_in,presence.time_out,employees.employees_name FROM presence,employees WHERE presence.employees_id=employees.id AND presence.presence_date='$date' ORDER BY presence.presence_id";
    $result_absen = $connection->query($query_absen);
    if($result_absen->num_rows > 0){
        while ($row_absen = $result_absen->fetch_assoc()) {
           $no++;
     echo'
        <tr>
            <td class="text-center">'.$no.'</td>
            <td>'.strip_tags($row_absen['employees_name']).'</td>
            <td><span class="label label-success">'.$row_absen['time_in'].'</td>
            <td><span class="label label-danger">'.$row_absen['time_out'].'</td>
        </tr>';
    }}
    echo'
    </tbody>
</table>';?>
<script type="text/javascript">
	 $('#swdatatable').dataTable({
        "iDisplayLength": 20,
        "aLengthMenu": [[20, 30, 50, -1], [20, 30, 50, "All"]]
    });
</script>
<?php
break;
}

}
