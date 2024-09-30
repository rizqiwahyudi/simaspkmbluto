<?php
session_start();
if(empty($_SESSION['SESSION_USER']) && empty($_SESSION['SESSION_ID'])){
    header('location:../../login/');
 exit;}
else {
require_once'../../../sw-library/sw-config.php';
require_once'../../login/login_session.php';
require_once'../../../sw-library/sw-function.php';
require_once'../../../sw-library/qr_code/qrlib.php';

$max_size = 2000000; //2MB
$salt = '$%DEf0&TTd#%dSuTyr47542"_-^@#&*!=QxR094{a911}+';

switch (@$_GET['action']){

case 'add':
  $error = array();
  
  if (empty($_POST['employees_nip'])) {
      $error[] = 'Nip tidak boleh kosong';
    } else {
      $employees_nip= anti_injection($_POST['employees_nip']);
  }

  if (empty($_POST['employees_email'])) {
      $error[] = 'Email tidak boleh kosong';
    } else {
      $employees_email= strip_tags($_POST['employees_email']);
  }


  if (empty($_POST['employees_password'])) {
      $error[] = 'Password tidak boleh kosong';
    } else {
      $employees_password= strip_tags(hash('sha256',$salt.$_POST['employees_password']));
  }

  if (empty($_POST['employees_name'])) {
      $error[] = 'Nama tidak boleh kosong';
    } else {
      $employees_name= anti_injection($_POST['employees_name']);
  }


  if (empty($_POST['position_id'])) {
      $error[] = 'Posisi tidak boleh kosong';
    } else {
      $position_id = anti_injection($_POST['position_id']);
  }

  if (empty($_POST['shift_id'])) {
      $error[] = 'Shift Kerja tidak boleh kosong';
    } else {
      $shift_id = anti_injection($_POST['shift_id']);
  }

  if (empty($_POST['building_id'])) {
      $error[] = 'Lokasi tidak boleh kosong';
    } else {
      $building_id = anti_injection($_POST['building_id']);
  }


  $photo = $_FILES["photo"]["name"];
    if($photo ==''){
      if (empty($error)){

        /* --  Membuat Random Karakter ---- */
        $random_karakter = md5($employees_name);
        $shuffle  = substr(str_shuffle($random_karakter),0,6);
        $qrcode   = ''.$year.'/'.strtoupper($shuffle).'/'.$date.'';
        /* --  End Random Karakter ---- */

        $codeContents = $qrcode;
        $tempdir = '../../../sw-content/employees-code-qr/';
        $namafile = ''.seo_title($codeContents).'.jpg';

        $add ="INSERT INTO employees (employees_code,
                      employees_nip,
                      employees_email,
                      employees_password,
                      employees_name,
                      position_id,
                      shift_id,
                      building_id,
                      photo,
                      created_login,
                      created_cookies) values('$qrcode',
                      '$employees_nip',
                      '$employees_email',
                      '$employees_password',
                      '$employees_name',
                      '$position_id',
                      '$shift_id',
                      '$building_id',
                      '',
                      '$date $time',
                      '-')";
            if($connection->query($add) === false) { 
                die($connection->error.__LINE__); 
                echo'Data tidak berhasil disimpan!';
            } else{
                echo'success';
                if(file_exists('../../../sw-content/employees-code-qr/'.$namafile.'')){}else{
                    $quality = 'QR_ECLEVEL_Q'; //ada 4 pilihan, L (Low), M(Medium), Q(Good), H(High)
                    $ukuran = 10; //batasan 1 paling kecil, 10 paling besar
                    $padding = 1;
                    QRCode::png($codeContents,$tempdir.$namafile,$quality,$ukuran,$padding);
                }
            }}
            
            else{           
                 foreach ($error as $key => $values) {            
                    echo $values;
                  }
            }

    }else{
        $lokasi_file = $_FILES['photo']['tmp_name'];  
        $ukuran_file = $_FILES['photo']['size'];
        $extension = getExtension($photo);
        $extension = strtolower($extension);
        $photo = strip_tags(md5($photo));
        $photo ="".$date."".$photo.".".$extension."";

        if (($extension != "jpg") && ($extension != "jpeg") && ($extension != "gif")) { 
            echo'Gambar/Foto yang di unggah tidak sesuai dengan format, Berkas harus berformat JPG,JPEG,GIF..!';
        }

        else{
        if($extension=="jpg" || $extension=="jpeg" ){
        $src = imagecreatefromjpeg($lokasi_file);}
        else if($extension=="png"){$src = imagecreatefrompng($lokasi_file);}
        else {$src = imagecreatefromgif($lokasi_file);}
        list($width,$height)=getimagesize($lokasi_file);

        $width_size =400;
        $k = $width / $width_size;
        // menentukan width yang baru
        $newwidth = $width / $k;
        // menentukan height yang baru
        $newheight = $height / $k;
        $tmp=imagecreatetruecolor($newwidth,$newheight);
        //imagefill ( $thumb_p, 0, 0, $bg );
        imagecopyresampled($tmp,$src,0,0,0,0,$newwidth,$newheight,$width,$height);


        
        if ($ukuran_file <= $max_size) {
        $directory='../../../sw-content/karyawan/'.$photo.'';

        /* --  Membuat Random Karakter ---- */
        $random_karakter = md5($employees_name);
        $shuffle  = substr(str_shuffle($random_karakter),0,4);
        $qrcode   = ''.$year.'/'.strtoupper($shuffle).'/SW'.$date.'';
        /* --  End Random Karakter ---- */
        $codeContents = $qrcode;
        $tempdir = '../../../sw-content/employees-code-qr/';
        $namafile = ''.seo_title($codeContents).'.jpg';

        $add ="INSERT INTO employees (employees_code,
                      employees_nip,
                      employees_email,
                      employees_password,
                      employees_name,
                      position_id,
                      shift_id,
                      building_id,
                      photo,
                      created_login,
                      created_cookies) values('$qrcode',
                      '$employees_nip',
                      '$employees_email',
                      '$employees_password',
                      '$employees_name',
                      '$position_id',
                      '$shift_id',
                      '$building_id',
                      '$photo',
                      '$date $time',
                      '-')";
            if($connection->query($add) === false) { 
                die($connection->error.__LINE__); 
                echo'Data tidak berhasil disimpan!';
            } else{
                echo'success';
                imagejpeg($tmp,$directory,90);
                if(file_exists('../../../sw-content/employees-code-qr/'.$namafile.'')){}else{
                    $quality = 'QR_ECLEVEL_Q'; //ada 4 pilihan, L (Low), M(Medium), Q(Good), H(High)
                    $ukuran = 10; //batasan 1 paling kecil, 10 paling besar
                    $padding = 1;
                    QRCode::png($codeContents,$tempdir.$namafile,$quality,$ukuran,$padding);
                }
            }}
            else{
                echo'Gambar yang di unggah terlalu besar Maksimal Size 2MB..!';
            }}
          }
    



/* ------------------------------
    Update
---------------------------------*/
break;
case 'update':
 $error = array();
   if (empty($_POST['id'])) {
      $error[] = 'ID tidak boleh kosong';
    } else {
      $id = anti_injection($_POST['id']);
  }

  if (empty($_POST['employees_nip'])) {
      $error[] = 'Nip tidak boleh kosong';
    } else {
      $employees_nip= anti_injection($_POST['employees_nip']);
  }


  if (empty($_POST['employees_name'])) {
      $error[] = 'Nama tidak boleh kosong';
    } else {
      $employees_name= anti_injection($_POST['employees_name']);
  }


  if (empty($_POST['position_id'])) {
      $error[] = 'Posisi tidak boleh kosong';
    } else {
      $position_id = anti_injection($_POST['position_id']);
  }

  if (empty($_POST['shift_id'])) {
      $error[] = 'Shift Kerja tidak boleh kosong';
    } else {
      $shift_id = anti_injection($_POST['shift_id']);
  }

  if (empty($_POST['building_id'])) {
      $error[] = 'Lokasi tidak boleh kosong';
    } else {
      $building_id = anti_injection($_POST['building_id']);
  }


  $photo = $_FILES["photo"]["name"];
  $lokasi_file = $_FILES['photo']['tmp_name'];  
  $ukuran_file = $_FILES['photo']['size'];
  if($photo ==''){
  if (empty($error)) { 
    $update="UPDATE employees SET employees_nip='$employees_nip',
            employees_name='$employees_name',
            position_id='$position_id',
            shift_id='$shift_id',
            building_id='$building_id' WHERE id='$id'"; 
    if($connection->query($update) === false) { 
        die($connection->error.__LINE__); 
        echo'Data tidak berhasil disimpan!';
    } else{
        echo'success';
    }}
    else{           
        foreach ($error as $key => $values) {            
                    echo $values;
                  }
    }
  }

  else{
    $query= mysqli_query($connection,"SELECT photo from employees where id='$id'");
    $data   = mysqli_fetch_assoc($query);
    $images_delete = strip_tags($data['photo']);
    $tmpfile = "../../../sw-content/karyawan/".$images_delete;
   if(file_exists("../../../sw-content/karyawan/$images_delete")){
      unlink ($tmpfile);
    }

    $extension = getExtension($photo);
    $extension = strtolower($extension);
    $photo = strip_tags(md5($photo));
    $photo ="".$date."".$photo.".".$extension."";

    if (($extension != "jpg") && ($extension != "jpeg") && ($extension != "gif")) { 
        echo'Gambar/Foto yang di unggah tidak sesuai dengan format, Berkas harus berformat JPG,JPEG,GIF..!';
    }

    else{
    if($extension=="jpg" || $extension=="jpeg" ){
    $src = imagecreatefromjpeg($lokasi_file);}
    else if($extension=="png"){$src = imagecreatefrompng($lokasi_file);}
    else {$src = imagecreatefromgif($lokasi_file);}
    list($width,$height)=getimagesize($lokasi_file);

    $width_size   = 400;
    $k            = $width / $width_size;
    $newwidth     = $width / $k;
    $newheight    = $height / $k;
    $tmp          = imagecreatetruecolor($newwidth,$newheight);
    imagecopyresampled($tmp,$src,0,0,0,0,$newwidth,$newheight,$width,$height);

  if (empty($error)) {
    if ($ukuran_file <= $max_size) {
    $directory='../../../sw-content/karyawan/'.$photo.'';

    $update="UPDATE employees SET employees_nip='$employees_nip',
            employees_name='$employees_name',
            position_id='$position_id',
            shift_id='$shift_id',
            building_id='$building_id',
            photo='$photo' WHERE id='$id'"; 
    if($connection->query($update) === false) { 
        die($connection->error.__LINE__); 
        echo'Data tidak berhasil disimpan!';
    } else{
        echo'success';
        imagejpeg($tmp,$directory,90);
    }}
    else{
        echo'Gambar yang di unggah terlalu besar Maksimal Size 2MB..!';
    }}
  }}



/* --------------- Update Password ------------*/
break;
case 'update-password':
include('../../../sw-library/PHPMailer/PHPMailerAutoload.php');

$error = array();
  if (empty($_POST['id'])) {
      $error[] = 'ID tidak boleh kosong';
    } else {
      $id = anti_injection($_POST['id']);
  }

  if (empty($_POST['employees_email'])) {
      $error[] = 'tidak boleh kosong';
    } else {
      $employees_email= anti_injection($_POST['employees_email']);
  }

  if (empty($_POST['employees_password'])) {
      $error[] = 'tidak boleh kosong';
    } else {
      $employees_password= anti_injection($_POST['employees_password']);
      $password_baru = strip_tags(hash('sha256',$salt.$employees_password));
  }

  if (empty($error)) { 
    
    $query="SELECT  employees_name,employees_email from employees where id='$id'";
    $result= $connection->query($query);
    if($result ->num_rows >0){
      $row = $result->fetch_assoc();

  // Konfigurasi SMTP
    $mail = new PHPMailer;
    $mail->isSMTP();
    $mail->Host = $gmail_host;
    $mail->Username = $gmail_username; // Email Pengirim
    $mail->Password = $gmail_password; // Isikan dengan Password email pengirim
    $mail->Port = $gmail_port;
    $mail->SMTPAuth = true;
    $mail->SMTPSecure = 'ssl';
    //$mail->SMTPDebug = 2; // Aktifkan untuk melakukan debugging

    $mail->setFrom($gmail_username, $site_name);  //Email Pengirim
    $mail->addAddress($employees_email, $row['employees_name']); // Email Penerima

    $mail->isHTML(true); // Aktifkan jika isi emailnya berupa html
   // Subjek email
    $mail->Subject = 'Resset password Baru | '.$site_name.'';

    $mailContent = '<h1>'.$site_name.'</h1><br>
        <h3>Halo, '.$row['employees_email'].'</h3><br>
        <p>Kamu baru saja mengirim permintaan reset password akun '.$site_name.'.<br>
        <b>Password Baru Anda : '.$employees_password.'</b><br><br><br>Harap simpan baik-baik akun Anda.<br><br>
        Hormat Kami,<br>'.$site_name.'<br>Email otomatis, Mohon tidak membalas email ini</p>';
    
    $mail->Body = $mailContent;
    //$mail->AddEmbeddedImage('image/logo.png', ''.$site_name.'', '.sw-content/'.$site_logo.''); //Logo 

          $update="UPDATE employees SET employees_password='$password_baru' WHERE id='$id'"; 
          if($connection->query($update) === false) { 
              die($connection->error.__LINE__); 
              echo'Data tidak berhasil disimpan!';
          } else{
              echo'success';
              if($mail->send()){
                  //echo 'Pesan telah terkirim';
                }else{
                  echo 'Mailer Error: ' . $mail->ErrorInfo;
                }
          }}
          else{           
              echo'Bidang inputan tidak boleh ada yang kosong..!';
          }
    }

break;


/* --------------- Delete ------------*/
case 'delete':
  $id       = anti_injection(epm_decode($_POST['id']));

    $cari =mysqli_query($connection,"SELECT photo,employees_code from employees WHERE id='$id'");
    $data =mysqli_fetch_assoc($cari);
    $images_delete = strip_tags($data['photo']);
    $directory='../../../sw-content/karyawan/'.$images_delete.'';

  $deleted  = "DELETE FROM employees WHERE id='$id'";
    if($connection->query($deleted) === true) {
        echo'success';
        if(file_exists("../../../sw-content/karyawan/$images_delete")){
          unlink ($directory);
        }

        if(file_exists("../../../sw-content/employees-code-qr/$data[employees_code]")){
          $qrcode ='../../../sw-content/employees-code-qr/'.$data['employees_code'].'';
          unlink ($qrcode);
        }

      } else { 
        //tidak berhasil
        echo'Data tidak berhasil dihapus.!';
        die($connection->error.__LINE__);
  }


/* ------------- IMPORT --------------*/
break;
case 'import':
// Allowed mime types
$csvMimes = array('text/x-comma-separated-values', 'text/comma-separated-values', 'application/octet-stream', 'application/vnd.ms-excel', 'application/x-csv', 'text/x-csv', 'text/csv', 'application/csv', 'application/excel', 'application/vnd.msexcel', 'text/plain');

if(!empty($_FILES['files']['name']) && in_array($_FILES['files']['type'], $csvMimes)){
        // If the file is uploaded
        if(is_uploaded_file($_FILES['files']['tmp_name'])){
            // Open uploaded CSV file with read-only mode
            $csvFile = fopen($_FILES['files']['tmp_name'], 'r');
    
            // Skip the first line
            fgetcsv($csvFile);
            
            // Parse data from CSV file line by line
            while(($line = fgetcsv($csvFile)) !== FALSE){
                // Get row data
                $employees_nip      = $line[0];
                $employees_email    = $line[1];
                $employees_password = hash('sha256',$salt.$line[2]);
                $employees_name     = $line[3];
                $position_id        = $line[4];
                $shift_id           = $line[5];
                $building_id        = $line[6];
                // Check berdasa  rkan code
                $query  = "SELECT id FROM employees WHERE employees_nip='$employees_nip' OR employees_email='$employees_email'";
                $result = $connection->query($query);
               
                if($result->num_rows > 0){
                // Update member data in the database
                    $update="UPDATE employees SET employees_name='$employees_name',
                      position_id='$position_id',
                      shift_id='$shift_id',
                      building_id='$building_id' WHERE employees_code='$employees_code'";
                    $connection->query($update);
                }else{

                    /* --  Membuat Random Karakter ---- */
                        $random_karakter = md5($employees_name);
                        $shuffle  = substr(str_shuffle($random_karakter),0,4);
                        $qrcode   = ''.$year.'/'.strtoupper($shuffle).'/SW'.$date.'';
                    /* --  End Random Karakter ---- */
                        $codeContents = $qrcode;
                        $tempdir = '../../../sw-content/employees-code-qr/';
                        $namafile = ''.seo_title($codeContents).'.jpg';
                    
                    if(file_exists('../../../sw-content/employees-code-qr/'.$namafile.'')){}else{
                        $quality = 'QR_ECLEVEL_Q'; //ada 4 pilihan, L (Low), M(Medium), Q(Good), H(High)
                        $ukuran = 10; //batasan 1 paling kecil, 10 paling besar
                        $padding = 1;
                        QRCode::png($codeContents,$tempdir.$namafile,$quality,$ukuran,$padding);
                    }

                    // Insert KARYAWAN data in the database
                    $add ="INSERT INTO employees (employees_code,
                                      employees_nip,
                                      employees_email,
                                      employees_password,
                                      employees_name,
                                      position_id,
                                      shift_id,
                                      building_id,
                                      photo,
                                      created_login,
                                      created_cookies) values('$qrcode',
                                      '$employees_nip',
                                      '$employees_email',
                                      '$employees_password',
                                      '$employees_name',
                                      '$position_id',
                                      '$shift_id',
                                      '$building_id',
                                      '', /*Photo kosong*/
                                      '$date $time',
                                      '-')";
                        if($connection->query($add) === false) {
                            echo'Data Pegawai Tidak dapat di Import.!';
                        }else{
                            //echo'success';
                        }
                }
            }
            
            // Close opened CSV file
            fclose($csvFile);
            echo'success';
        }else{
            echo'Data Pegawai tidak berhasil di import.!';
        }
    }else{
          echo'File tidak sesuai format, Upload file CSV.!';

    }

break;

}

}
