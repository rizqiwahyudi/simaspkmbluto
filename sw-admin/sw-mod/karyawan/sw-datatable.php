<?php session_start();
if(empty($_SESSION['SESSION_USER']) && empty($_SESSION['SESSION_ID'])){
    header('location:../../login/');
 exit;}
else{
require_once'../../../sw-library/sw-config.php';
require_once'../../login/login_session.php';
include('../../../sw-library/sw-function.php');

    $aColumns = ['id','employees_nip','employees_code','employees_email','employees_name','position_id','shift_id','building_id','created_login'];
    $sIndexColumn = "id";
    $sTable = "employees";
    $gaSql['user'] = DB_USER;
    $gaSql['password'] = DB_PASSWD;
    $gaSql['db'] = DB_NAME;
    $gaSql['server'] = DB_HOST;

    $gaSql['link'] =  new mysqli($gaSql['server'], $gaSql['user'], $gaSql['password'], $gaSql['db']);

    $sLimit = "";
    if (isset($_GET['iDisplayStart']) && $_GET['iDisplayLength'] != '-1')
    {
        $sLimit = "LIMIT ".mysqli_real_escape_string($gaSql['link'], $_GET['iDisplayStart']).", ".
            mysqli_real_escape_string($gaSql['link'], $_GET['iDisplayLength']);
    }

    $sOrder = "ORDER BY id DESC";
    if (isset($_GET['iSortCol_0']))
    {
        $sOrder = "ORDER BY id DESC";
        for ($i=0; $i<intval($_GET['iSortingCols']) ; $i++)
        {
            if ($_GET['bSortable_'.intval($_GET['iSortCol_'.$i])] == "true")
            {
                $sOrder .= $aColumns[ intval($_GET['iSortCol_'.$i])]."
                    ".mysqli_real_escape_string($gaSql['link'], $_GET['sSortDir_'.$i]) .", ";
            }
        }

        $sOrder = substr_replace($sOrder, "", -2);
        if ($sOrder == "ORDER BY id DESC")
        {
            $sOrder = "ORDER BY id DESC";
        }
    }

    $sWhere = "";
    if (isset($_GET['sSearch']) && $_GET['sSearch'] != "")
    {
        $sWhere = "WHERE (";
        for ($i=0; $i<count($aColumns); $i++)
        {
            $sWhere .= $aColumns[$i]." LIKE '%".mysqli_real_escape_string($gaSql['link'], $_GET['sSearch'])."%' OR ";
        }
        $sWhere = substr_replace($sWhere, "", -3);
        $sWhere .= ')';
    }

    for ($i=0 ; $i<count($aColumns); $i++)
    {
        if (isset($_GET['bSearchable_'.$i]) && $_GET['bSearchable_'.$i] == "true" && $_GET['sSearch_'.$i] != '')
        {
            if ($sWhere == "")
            {
                $sWhere = "WHERE ";
            }
            else
            {
                $sWhere .= " AND ";
            }
            $sWhere .= $aColumns[$i]." LIKE '%".mysqli_real_escape_string($gaSql['link'], $_GET['sSearch_'.$i])."%' ";
        }
    }

    $sQuery = " SELECT SQL_CALC_FOUND_ROWS ".str_replace(" , ", " ", implode(", ", $aColumns))."
        FROM $sTable
        $sWhere
        $sOrder
        $sLimit ";
    $rResult = mysqli_query($gaSql['link'], $sQuery);

    $sQuery = "SELECT FOUND_ROWS()";
    $rResultFilterTotal = mysqli_query($gaSql['link'], $sQuery);
    $aResultFilterTotal = mysqli_fetch_array($rResultFilterTotal);
    $iFilteredTotal = $aResultFilterTotal[0];

    $sQuery = "SELECT COUNT(".$sIndexColumn.") FROM   $sTable";
    $rResultTotal = mysqli_query($gaSql['link'], $sQuery);
    $aResultTotal = mysqli_fetch_array($rResultTotal);
    $iTotal = $aResultTotal[0];

    $output = array( 
       // "sEcho" => intval($_GET['sEcho']),
        "iTotalRecords" => $iTotal,
        "iTotalDisplayRecords" => $iFilteredTotal,
        "aaData" => array()
    );

    $no = 0;
    while ($aRow = mysqli_fetch_array($rResult)){$no++;
      extract($aRow);
        $row = array();

        $query_position  ="SELECT position_name FROM position WHERE position_id='$aRow[position_id]'";
        $result_position = $connection->query($query_position);
        $row_position    = $result_position->fetch_assoc();

        $query_shift    ="SELECT shift_name FROM shift WHERE shift_id='$aRow[shift_id]'";
        $result_shift   = $connection->query($query_shift);
        $row_shift      = $result_shift->fetch_assoc();

        $query_building  ="SELECT name FROM building WHERE building_id='$aRow[building_id]'";
        $result_building = $connection->query($query_building);
        $row_building    = $result_building->fetch_assoc();

        if($level_user==1){
        $button ='
        <a href="karyawan&op=edit&id='.epm_encode($aRow['id']).'" class="btn btn-warning btn-sm enable-tooltip" title="Edit"><i class="fa fa-pencil-square-o"></i></a>
        <buton data-id="'.epm_encode($aRow['id']).'" class="btn btn-sm btn-danger delete" title="Hapus"><i class="fa fa-trash-o"></i></button>';
        }else{
        $button='
        <button type="button" class="btn btn-warning btn-sm access-failed enable-tooltip" title="Edit"><i class="fa fa-pencil-square-o"></i></button>
                    <buton type="button" class="btn btn-sm btn-danger access-failed" title="Hapus"><i class="fa fa-trash-o"></i></button>';
        }

        for ($i=1 ; $i<count($aColumns) ; $i++){
            
            $row[] = '<div class="text-center">'.$no.'</div>';
            $row[] = '<div class="text-center">
                        <a class="open-popup-link" href="../sw-content/employees-code-qr/'.strip_tags(seo_title($aRow['employees_code'])).'.jpg" title="'.strip_tags($aRow['employees_name']).'">
                        <img src="../sw-content/employees-code-qr/'.strip_tags(seo_title($aRow['employees_code'])).'.jpg" class="imaged w100 rounded" height="50">
                        </a>
                    </div>';
            $row[] = strip_tags($aRow['employees_nip']);
            $row[] = strip_tags($aRow['employees_name']);
            $row[] = strip_tags($aRow['employees_email']);
            $row[] = strip_tags($row_position['position_name']);
            $row[] = strip_tags($row_shift['shift_name']);
            $row[] = strip_tags($row_building['name']);
            $row[] = '<div class="text-center">
                       '.$button.'
                      </div>';
        }
        $output['aaData'][] = $row;
        $no++;
    }
    echo json_encode($output);
  
}