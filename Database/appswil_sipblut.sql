-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 14, 2024 at 04:42 AM
-- Server version: 10.4.34-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

START TRANSACTION;

SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8mb4 */
;

--
-- Database: `appswil_sipblut`
--

-- --------------------------------------------------------

--
-- Table structure for table `apel`
--

CREATE TABLE `apel` (
    `apel_id` int(11) NOT NULL,
    `employees_id` int(11) NOT NULL,
    `apel_date` date NOT NULL,
    `time_in` time NOT NULL,
    `status` varchar(100) NOT NULL,
    `latlng` varchar(100) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

-- --------------------------------------------------------

--
-- Table structure for table `building`
--

CREATE TABLE `building` (
    `building_id` int(8) NOT NULL,
    `code` varchar(20) NOT NULL,
    `name` varchar(50) NOT NULL,
    `address` varchar(100) NOT NULL,
    `latitude_longtitude` varchar(150) NOT NULL,
    `radius` int(5) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `building`
--

INSERT INTO
    `building` (
        `building_id`,
        `code`,
        `name`,
        `address`,
        `latitude_longtitude`,
        `radius`
    )
VALUES (
        1,
        'SWUKZ/2021',
        'Kantor Induk',
        'Jl. Raya Bluto No.13, Tajjan, Bungbungan, Kec. Bluto, Kabupaten Sumenep, Jawa Timur 69466',
        '-7.105058528417027,113.81160722435962',
        30
    ),
    (
        7,
        'SWUKZ/2022',
        'Polindes Aengdake',
        'Aengdake',
        '-7.007639839639795,113.85579366963688',
        30
    );

-- --------------------------------------------------------

--
-- Table structure for table `business_card`
--

CREATE TABLE `business_card` (
    `id` int(5) NOT NULL,
    `name` varchar(30) NOT NULL,
    `photo` varchar(150) NOT NULL,
    `active` varchar(1) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `business_card`
--

INSERT INTO
    `business_card` (
        `id`,
        `name`,
        `photo`,
        `active`
    )
VALUES (
        1,
        'Thema 1',
        '2021-09-14818db55ed84f450043ad72540c19d46e.jpg',
        '1'
    );

-- --------------------------------------------------------

--
-- Table structure for table `cuty`
--

CREATE TABLE `cuty` (
    `cuty_id` int(11) NOT NULL,
    `employees_id` int(11) NOT NULL,
    `cuty_start` date NOT NULL,
    `cuty_end` date NOT NULL,
    `date_work` date NOT NULL,
    `cuty_total` int(5) NOT NULL,
    `cuty_description` varchar(100) NOT NULL,
    `cuty_status` int(2) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `cuty`
--

INSERT INTO
    `cuty` (
        `cuty_id`,
        `employees_id`,
        `cuty_start`,
        `cuty_end`,
        `date_work`,
        `cuty_total`,
        `cuty_description`,
        `cuty_status`
    )
VALUES (
        4,
        91,
        '2024-10-07',
        '2024-10-09',
        '2024-10-10',
        3,
        'ada kepentingan mendesak',
        1
    ),
    (
        5,
        47,
        '2024-10-28',
        '2024-10-28',
        '2024-10-29',
        1,
        'Cuti',
        1
    );

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
    `id` int(11) NOT NULL,
    `employees_code` varchar(35) NOT NULL,
    `employees_nip` varchar(30) NOT NULL,
    `employees_email` varchar(30) NOT NULL,
    `employees_password` varchar(100) NOT NULL,
    `employees_name` varchar(50) NOT NULL,
    `position_id` int(5) NOT NULL,
    `shift_id` int(11) NOT NULL,
    `building_id` int(11) NOT NULL,
    `photo` varchar(100) NOT NULL,
    `created_login` datetime NOT NULL,
    `created_cookies` varchar(70) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO
    `employees` (
        `id`,
        `employees_code`,
        `employees_nip`,
        `employees_email`,
        `employees_password`,
        `employees_name`,
        `position_id`,
        `shift_id`,
        `building_id`,
        `photo`,
        `created_login`,
        `created_cookies`
    )
VALUES (
        30,
        '2024/4D6D86/2024-09-30',
        '19760826 200501 2 008',
        'rifmiutami@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'dr. RIFMI UTAMI, M.Kes',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        31,
        '2024/BD2FD3/2024-09-30',
        '9860113 201101 2 012',
        'rusliyananuarita@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'drg. RUSLIYANA NUARITA',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        32,
        '2024/04F041/2024-09-30',
        '19710424 199102 2 001',
        'sumiatun@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SUMIATUN, Amd.Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        33,
        '2024/FE4621/2024-09-30',
        '19690101 199203 2 014',
        'mardiyana@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'MARDIYANA, Amd. Kep',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        34,
        '2024/969E45/2024-09-30',
        '9680226 199003 2 002',
        'istiyani@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' ISTIYANI, Amd Ke',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        35,
        '2024/E452EB/2024-09-30',
        ' 19750611 199503 2 002',
        'nurulkhairati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'NURUL KHAIRIYATI, A.Md. Farm',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        36,
        '2024/AACFA0/2024-09-30',
        '19710510 199703 1 010',
        'arovahbahtiar@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' AROVAH BAHTIAR RAHMAN, S.Gz',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        37,
        '2024/AE01DF/2024-09-30',
        ' 19801001 200604 2 034',
        'rukmiyatiikac@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' RUKMIYATI IKA C, S.Kep.Ns',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        38,
        '2024/FD93C7/2024-09-30',
        ' 19761225 200604 2 019',
        ' sulastri@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SULASTRI, Amd.Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        39,
        '2024/C4BFE7/2024-09-30',
        '9760706 200604 2 023',
        'pujisetyaningsih@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'PUJI SETYANINGSIH, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        40,
        '2024/A99F75/2024-09-30',
        ' 19751113 200604 2 018',
        ' yuswaningsih@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'YUSWANINGSIH , Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        41,
        '2024/3D664C/2024-09-30',
        ' 19770427 200604 2 013',
        ' musrifadiana@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'MUSRIFA DIANA, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        42,
        '2024/925887/2024-09-30',
        ' 19810327 200801 2 018',
        ' sitinurhayati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' SITI NURHAYATI, Amd. Kep',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        43,
        '2024/97DDBE/2024-09-30',
        ' 19681120 198803 1 002',
        'hermanto@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' HERMANTO',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        44,
        '2024/07D842/2024-09-30',
        ' 19851215 201001 2 033',
        'dewiwijayanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' DEWI WIJAYANTI, AMG',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        45,
        '2024/32E1E3/2024-09-30',
        ' 19891023 201903 2 001',
        ' taniawidyaeka@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' dr.TANIA WIDYA EKAYANTI',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        46,
        '2024/9DE22B/2024-09-30',
        '19881101 202204 2 0001',
        ' femiastutik@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' dr. FEMIASTUTIK EKANOVA',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        47,
        '2024/4F1FB3/2024-09-30',
        '19820707 200604 1 022',
        'purnomowirawan@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' PURNOMO WIRAWAN, S.Kep.Ns',
        7,
        5,
        1,
        '47-0043e80ae52a8e0a094d42e4a5ba2991-074020-.jpg',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        48,
        '2024/1333AF/2024-09-30',
        ' 19750110 200501 2 011',
        'endangsulastri@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'ENDANG SULASTRI, S.Tr.Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        49,
        '2024/221574/2024-09-30',
        ' 19810309 200701 2 003',
        ' hannymarika@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'HANNY MARIKA F, Amd. Kep',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        50,
        '2024/34CCBA/2024-09-30',
        ' 19811002 200801 2 020',
        'kholifaturriskiyah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'KHOLIFATUR RISKIYAH, Amd. Kep',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        51,
        '2024/BA91E1/2024-09-30',
        '19801223 200801 1 005',
        'khairilanwar@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'KHAIRIL ANWAR, Amd. Kep',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        52,
        '2024/FEE8D6/2024-09-30',
        '19830421 200801 1 006',
        'kartono@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' KARTONO, S. Kep. Ns',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        53,
        '2024/C4A9AA/2024-09-30',
        '19831110 200901 2 007',
        ' ekanoviasanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'EKA NOVIASANTI, S.Kep.Ns',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        54,
        '2024/1836E4/2024-09-30',
        '19790123 200501 2 010',
        'hernawati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'HERNAWATI, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        55,
        '2024/019156/2024-09-30',
        ' 19790407 200801 2 017',
        'robiyatuladawiyah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' ROBIYATUL ADAWIYAH, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        56,
        '2024/22DA82/2024-09-30',
        '19790824 200801 2 017',
        'triagus@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' TRI AGUS F, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        57,
        '2024/4DE089/2024-09-30',
        ' 19750921 200801 2 007',
        ' idasusanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' IDA SUSANTI, Amd.Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        58,
        '2024/41B712/2024-09-30',
        '19740222 200604 2 012',
        'dianafebiyanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'DIANA FEBIYANTI, Amd.Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        59,
        '2024/B04FD3/2024-09-30',
        ' 197903132005012009',
        ' nurlaily@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'NUR LAILY, Amd.Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        60,
        '2024/B7466A/2024-09-30',
        '19890405 201101 1 002',
        ' hermanhidayat@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'HERMAN HIDAYAT, Amd.KL',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        61,
        '2024/5EED96/2024-09-30',
        '19950726 202321 1 001',
        'tadjularifin@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'drg. TADJUL ARIFIN',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        62,
        '2024/2C5004/2024-09-30',
        ' 19900920 202012 2 003',
        'ekaseptian@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' EKA SEPTIANA WULANDARI, S.Farm., Apt.',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        63,
        '2024/6CAD32/2024-09-30',
        '19790906 200501 2 012',
        'kriswantirahayu@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'KRISWANTI RAHAYU, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        64,
        '2024/24F307/2024-09-30',
        ' 19921024 202321 2 001',
        'noradilla@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'NORADILLA DWI OKTAVIA, S.KM.',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        65,
        '2024/3CA450/2024-09-30',
        ' 19841227 201704 2 010',
        ' erikamayasari@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' ERIKA MAYASARI, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        66,
        '2024/94F5BE/2024-09-30',
        '9841212 201704 2 013',
        'lianasutriningsih@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' LIANA SUTRININGSIH, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        67,
        '2024/B4712F/2024-09-30',
        ' 19880315 201704 2 002',
        'indahsofiyanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' INDAH SOFIYANTI, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        68,
        '2024/1E89F4/2024-09-30',
        '19850405 201704 2 008',
        'deviwellyawi@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'DEVI WELLYANA SATRIA DEWI, Amd Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        69,
        '2024/A229AA/2024-09-30',
        '19850218 201704 2 005',
        'febrihandiyani@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'FEBRI HANDIYANI SUSANTIN, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        70,
        '2024/530A60/2024-09-30',
        ' 19841112 201704 2 008',
        'durotunnavisah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'DUROTUN NAVISAH, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        71,
        '2024/1D86EE/2024-09-30',
        '19861005 201704 2 014',
        'sriendangmegawati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' SRI ENDANG MEGAWATI, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        72,
        '2024/BCEBA1/2024-09-30',
        '19780726 201905 2 001',
        'dalilatunnaliyah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' DALILATUN NALIYAH, Amd. Keb',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        73,
        '2024/6F86D4/2024-09-30',
        ' 19920818 202421 1 007',
        'darulhidayat@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'DARUL HIDAYAT, A.Md.Kep.Gi',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        75,
        '2024/3A9923/2024-09-30',
        '20000315 202421 2 001',
        ' ayusoviana@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' AYU SOVIANA, A.Md.RMIK.',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        76,
        '2024/93E1E2/2024-09-30',
        '19730509 200701 1 008',
        'mohsyadik@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' MOH. SYADIK',
        7,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        79,
        '2024/F6A589/2024-09-30',
        '35290410016',
        ' merlyaprita@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' MERLY APRITA, Amd. Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        80,
        '2024/901FAE/2024-09-30',
        ' 35290410017',
        'diankriswanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'DIAN KRISWANTI, S.Kep. Ns',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        81,
        '2024/8833A6/2024-09-30',
        ' 35290410018',
        ' triagitawahyuni@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'TRIA GITA WAHYUNI, Amd. Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        82,
        '2024/388735/2024-09-30',
        ' 35290410014',
        'akfar@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' JAKFAR, Amd. Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        83,
        '2024/CACB82/2024-10-01',
        ' 35290411008',
        'annawulandari@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' ANNA WULANDARI, Amd.Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        84,
        '2024/145AA2/2024-10-01',
        '35290412011',
        'evanursanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'EVA NURSANTI, Amd. Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        85,
        '2024/2B4D04/2024-10-01',
        ' 352904120010',
        ' adisuryono@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' ADI SURYONO,Amd.Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        86,
        '2024/35C0A6/2024-10-01',
        ' 352904120007',
        ' mohfajriyadi@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        ' MOH. FAJRIYADI, Amd. Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        87,
        '2024/676F27/2024-10-01',
        ' 35290412009',
        ' firmanalamsyah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'FIRMAN ALAMSYAH, Amd. Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        88,
        '2024/8BE9BB/2024-10-01',
        '35290410100',
        'qamaidahqusmi@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'QAM AIDAH QUSMI, Amd. Kep',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        91,
        '2024/326557/2024-10-01',
        '21213143243242',
        'rahman@bluto.com',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'Ainor Rahman',
        7,
        12,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        92,
        '2024/628A57/2024-10-02',
        '30207012019064',
        'agusbaki@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'AGUS BAKI',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        95,
        '2024/97E4BE/2024-10-02',
        '3529911862016020',
        'mohammaddoni@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'MOHAMMAD DONI ALIYANSYAH',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        96,
        '2024/591254/2024-10-02',
        '30207032019068',
        'habibi@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'HABIBI',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        97,
        '2024/7B7554/2024-10-02',
        '30207032019069',
        'indrawanrizqifauzi@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'INDRAWAN RIZQI FAUZI',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        98,
        '2024/E32BBE/2024-10-02',
        '30207032019070',
        'jokoagustiono@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'JOKO AGUSTIONO',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        99,
        '2024/D8813A/2024-10-02',
        '30207032019071',
        'yanuarrekyganisa@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'YANUAR REKY GANISA',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        100,
        '2024/8CA6EE/2024-10-02',
        '3529310362023002',
        'ridamagfirarohma@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'RIDA MAGFIRA ROHMA, S.Farm.apt.',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        101,
        '2024/C5B43E/2024-10-02',
        '3529910662021001',
        'taufikhidayat@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'TAUFIK HIDAYAT, S.E',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        102,
        '2024/862F34/2024-10-02',
        '3529910662021002',
        'arifahnurutami@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'ARIFAH NUR UTAMI, S.Tr. Gz',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        103,
        '2024/EDE293/2024-10-02',
        '3529910662021003',
        'elitawidyautama@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'ELITA WIDYAUTAMA Amd,AK',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        104,
        '2024/3A0D36/2024-10-02',
        '3529910662021004',
        'hauziyahnurhayati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'HAUZIYAH NURHAYATI,Amd.Keb.',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        105,
        '2024/7AD7FD/2024-10-02',
        '3529910662021005',
        'evidianapramayanti@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'EVI DIANA PRAMAYANTI, Amd Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        106,
        '2024/068DE4/2024-10-02',
        '3529910662021006',
        'ekoyudiarafikur@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'EKO YUDIA RAFIKUR ROHIM, Amd. Kep',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        107,
        '2024/F01816/2024-10-02',
        '3529910662021007',
        'yenirasmawati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'YENI RASMAWATI,Amd.Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        108,
        '2024/401342/2024-10-02',
        '3529910662021008',
        'titikharini@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'TITIK HARINI,Amd.Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        109,
        '2024/2EDFA5/2024-10-02',
        '3529910662021009',
        'memengkhasimatun@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'MEMENG KHASIMATUN, S.Kep. Ns',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        110,
        '2024/E9D805/2024-10-02',
        '3529910662021010',
        'linanfmusa@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'LINA NF MUSA, Amd. Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        111,
        '2024/530927/2024-10-02',
        '3529910662021011',
        'salametmohainolh@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SALAMET MOH.AINOL H,Amd.Kep',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        112,
        '2024/03B7D5/2024-10-02',
        '3529910662021012',
        'nurulkamrimah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'NURUL KARIMA,Amd.Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        113,
        '2024/3059BC/2024-10-02',
        '3529910662021013',
        'tutikmardiana@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'TUTIK MARDIANA,S.Tr.Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        114,
        '2024/75AA73/2024-10-02',
        '3529910662021014',
        'rafitasari@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'RAFITA SARI.Amd.Ak',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        115,
        '2024/316DCD/2024-10-02',
        '3529910662021015',
        'sumiyati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SUMIYATI, Amd Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        116,
        '2024/634E86/2024-10-02',
        '3529910662021016',
        'khairilfirdaus@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'KHAIRUL FIRDAUS S.Kom',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        117,
        '2024/2E0E33/2024-10-02',
        '3529910662021017',
        'dianatulasfiyah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'DIANATUL ASFIYAH, Amd.Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        118,
        '2024/F425BA/2024-10-02',
        '3529910662021018',
        'nurlailyrochim@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'NUR LAILY ROCHIM S.Kep.NS',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        119,
        '2024/2DC230/2024-10-02',
        '3529910662021019',
        'rendiamiruddin@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'RENDI AMIRUDDIN, S.Kep.NS',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        120,
        '2024/1BC59E/2024-10-02',
        '3529910662021020',
        'lailatulqodriyah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'LAILATUL QODRIYAH S.Kep.NS',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        121,
        '2024/69F91E/2024-10-02',
        '3529910662021021',
        'sitiamina@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SITI AMINA Amd.Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        122,
        '2024/E4C622/2024-10-02',
        '3529910662021022',
        'aminahraudatul@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'AMINAH RAUDATUL JANNAH A.Md. Battra',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        123,
        '2024/43B770/2024-10-02',
        '3529910662021023',
        'mohammadbustami@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'MOHAMMAD BUSTAMI AFFANDI',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        124,
        '2024/BB63F7/2024-10-02',
        '3529910662021024',
        'jackyfahrihozaini@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'JACKY FAHRI HOZAINI, S.Kep. Ns',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        125,
        '2024/59058A/2024-10-02',
        '3529910662021025',
        'yuliawati@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'YULIAWATI S.Kep. Ns',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        126,
        '2024/5444C7/2024-10-02',
        '3529910662021026',
        'mohsupriyadi@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'MOH. SUPRIYADI, S.Kep. Ns',
        1,
        5,
        1,
        '126-40ae3b3d7914a45ae1028f8635978903-101947-.jpg',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        127,
        '2024/165A2B/2024-10-02',
        '3529910662021027',
        'syamsularifin@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SYAMSUL ARIFIN, S.Kep. Ns',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        128,
        '2024/E06293/2024-10-02',
        '3529910662021028',
        'ansoriyah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'ANSORIYAH, A.md. Kep',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        129,
        '2024/CAF928/2024-10-02',
        '3529910662021029',
        'sitikhatija@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SITI KHATIJA, A.md. Keb',
        1,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        130,
        '2024/56B19E/2024-10-14',
        '35290415048',
        'qurniadinurullah@pkmbluto.id',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'QURNIADI NURULLAH, S.Kep. Ns',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        131,
        '2024/18D1FC/2024-10-14',
        '35292102112019018',
        'ahmadafandi@pkmbluto.id ',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'AHMAD AFANDI. S.Kep N.s',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        132,
        '2024/FBB2AF/2024-10-14',
        '30207032019067',
        'abdgani@pkmbluto.id ',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'ABD. GANI',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        133,
        '2024/547B28/2024-10-14',
        '19711115 200901 2 001',
        'sariya@pkmbluto.id ',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'SARIYA',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    ),
    (
        134,
        '2024/F11739/2024-10-14',
        '3529110162024002 ',
        'findriadiasyari@pkmbluto.id ',
        '60bdc2bb69e8b04343921b83ffe7d01e140ae3eaf2cb3ac988462067ff4546ff',
        'dr. FINDRI ADI ASY ARI',
        2,
        5,
        1,
        '',
        '2024-10-14 11:21:09',
        'd44e4ddc8203df707c8c834704f70c63'
    );

-- --------------------------------------------------------

--
-- Table structure for table `holiday`
--

CREATE TABLE `holiday` (
    `holiday_id` int(11) NOT NULL,
    `holiday_date` date NOT NULL,
    `description` varchar(150) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
    `permission_id` int(11) NOT NULL,
    `employees_id` int(11) NOT NULL,
    `permission_name` varchar(35) NOT NULL,
    `permission_date` date NOT NULL,
    `permission_date_finish` date NOT NULL,
    `permission_description` text NOT NULL,
    `files` varchar(150) NOT NULL,
    `type` varchar(20) NOT NULL,
    `date` date NOT NULL,
    `status` varchar(2) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO
    `permission` (
        `permission_id`,
        `employees_id`,
        `permission_name`,
        `permission_date`,
        `permission_date_finish`,
        `permission_description`,
        `files`,
        `type`,
        `date`,
        `status`
    )
VALUES (
        23,
        47,
        ' PURNOMO WIRAWAN, S.Kep.Ns',
        '2024-10-12',
        '2024-10-12',
        'Cek',
        '2024-10-10-47-img20241010wa0019jpg.jpg',
        'Izin',
        '2024-10-10',
        '1'
    );

-- --------------------------------------------------------

--
-- Table structure for table `position`
--

CREATE TABLE `position` (
    `position_id` int(5) NOT NULL,
    `position_name` varchar(30) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `position`
--

INSERT INTO
    `position` (
        `position_id`,
        `position_name`
    )
VALUES (1, 'SUKWAN'),
    (2, 'KONTRAK'),
    (7, 'PNS');

-- --------------------------------------------------------

--
-- Table structure for table `presence`
--

CREATE TABLE `presence` (
    `presence_id` int(11) NOT NULL,
    `employees_id` int(11) NOT NULL,
    `presence_date` date NOT NULL,
    `time_in` time NOT NULL,
    `time_out` time NOT NULL,
    `present_id` int(11) NOT NULL COMMENT 'Masuk,Pulang,Tidak Hadir',
    `latitude_longtitude_in` varchar(100) NOT NULL,
    `latitude_longtitude_out` varchar(100) NOT NULL,
    `information` varchar(50) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `presence`
--

INSERT INTO
    `presence` (
        `presence_id`,
        `employees_id`,
        `presence_date`,
        `time_in`,
        `time_out`,
        `present_id`,
        `latitude_longtitude_in`,
        `latitude_longtitude_out`,
        `information`
    )
VALUES (
        28,
        6,
        '2022-07-15',
        '14:54:44',
        '00:00:00',
        1,
        '-5.3973627,105.2546003',
        '',
        ''
    ),
    (
        29,
        27,
        '2022-10-21',
        '14:29:17',
        '21:34:13',
        1,
        '-5.4027714,105.2601946',
        '-5.3971396,105.2667887',
        ''
    ),
    (
        31,
        91,
        '2024-10-01',
        '19:30:47',
        '19:32:50',
        1,
        '-7.1081324,113.6738685',
        '-7.1081324,113.6738685',
        ''
    ),
    (
        32,
        47,
        '2024-10-05',
        '04:58:14',
        '00:00:00',
        1,
        '-7.3007104,112.6694912',
        '',
        ''
    ),
    (
        33,
        116,
        '2024-10-05',
        '10:54:47',
        '00:00:00',
        1,
        '-7.1050966,113.8116175',
        '',
        ''
    ),
    (
        34,
        91,
        '2024-10-07',
        '00:00:00',
        '00:00:00',
        4,
        '',
        '',
        ''
    ),
    (
        35,
        91,
        '2024-10-08',
        '00:00:00',
        '00:00:00',
        4,
        '',
        '',
        ''
    ),
    (
        36,
        91,
        '2024-10-09',
        '00:00:00',
        '00:00:00',
        1,
        '',
        '',
        ''
    ),
    (
        37,
        47,
        '2024-10-07',
        '11:12:51',
        '11:12:52',
        1,
        '-7.1051086,113.8115971',
        '-7.1051086,113.8115971',
        ''
    ),
    (
        38,
        47,
        '2024-10-08',
        '08:09:42',
        '00:00:00',
        1,
        '-7.1050939,113.8115818',
        '',
        ''
    ),
    (
        39,
        123,
        '2024-10-08',
        '09:09:33',
        '00:00:00',
        1,
        '-7.0990707,113.8227676',
        '',
        ''
    ),
    (
        40,
        47,
        '2024-10-10',
        '10:37:21',
        '10:44:03',
        1,
        '-7.1051205,113.8116148',
        '-7.1051205,113.8116148',
        ''
    ),
    (
        41,
        47,
        '2024-10-28',
        '00:00:00',
        '00:00:00',
        4,
        '',
        '',
        ''
    ),
    (
        42,
        47,
        '2024-10-12',
        '10:47:09',
        '13:55:44',
        3,
        '',
        '-7.1050831,113.8115847',
        'Izin'
    ),
    (
        43,
        116,
        '2024-10-10',
        '11:13:05',
        '00:00:00',
        1,
        '-7.1050804,113.8116116',
        '',
        ''
    ),
    (
        44,
        47,
        '2024-10-11',
        '07:49:49',
        '22:39:10',
        1,
        '-7.1050761,113.8115916',
        '-7.12704,112.1058816',
        ''
    ),
    (
        45,
        127,
        '2024-10-12',
        '14:14:23',
        '19:55:14',
        1,
        '-7.1050561,113.8116454',
        '-7.105051,113.8116396',
        ''
    ),
    (
        46,
        118,
        '2024-10-12',
        '14:21:39',
        '19:53:52',
        1,
        '-7.1050477,113.811651',
        '-7.1050486,113.8116317',
        ''
    ),
    (
        47,
        124,
        '2024-10-12',
        '14:35:19',
        '00:00:00',
        1,
        '-7.1051199,113.8116079',
        '',
        ''
    ),
    (
        48,
        98,
        '2024-10-12',
        '16:12:02',
        '16:12:38',
        1,
        '-7.1050628,113.8116389',
        '-7.1050628,113.8116389',
        ''
    ),
    (
        49,
        118,
        '2024-10-13',
        '07:01:14',
        '00:00:00',
        1,
        '-7.1050554,113.8116271',
        '',
        ''
    ),
    (
        50,
        124,
        '2024-10-13',
        '07:37:24',
        '00:00:00',
        1,
        '-7.1050603,113.8116309',
        '',
        ''
    ),
    (
        51,
        127,
        '2024-10-14',
        '07:05:36',
        '00:00:00',
        1,
        '-7.1050675,113.8116223',
        '',
        ''
    ),
    (
        52,
        83,
        '2024-10-14',
        '07:19:15',
        '00:00:00',
        1,
        '-7.1050588,113.8116237',
        '',
        ''
    ),
    (
        53,
        119,
        '2024-10-14',
        '07:21:43',
        '00:00:00',
        1,
        '-7.1050564,113.811639',
        '',
        ''
    ),
    (
        54,
        124,
        '2024-10-14',
        '08:14:07',
        '00:00:00',
        1,
        '-7.105059,113.8116268',
        '',
        ''
    ),
    (
        55,
        47,
        '2024-10-14',
        '09:18:34',
        '00:00:00',
        1,
        '-7.1050936,113.811607',
        '',
        ''
    ),
    (
        56,
        123,
        '2024-10-14',
        '10:22:41',
        '00:00:00',
        1,
        '-7.1051925,113.811719',
        '',
        ''
    ),
    (
        57,
        116,
        '2024-10-14',
        '10:36:55',
        '00:00:00',
        1,
        '-7.1053064,113.8116993',
        '',
        ''
    ),
    (
        58,
        128,
        '2024-10-14',
        '10:43:13',
        '00:00:00',
        1,
        '-7.1050853,113.8116185',
        '',
        ''
    ),
    (
        59,
        100,
        '2024-10-14',
        '10:52:48',
        '10:52:48',
        1,
        '-7.105221781865306,113.81163552053623',
        '-7.105221781865306,113.81163552053623',
        ''
    );

-- --------------------------------------------------------

--
-- Table structure for table `present_status`
--

CREATE TABLE `present_status` (
    `present_id` int(6) NOT NULL,
    `present_name` varchar(30) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `present_status`
--

INSERT INTO
    `present_status` (`present_id`, `present_name`)
VALUES (1, 'Hadir'),
    (2, 'Sakit'),
    (3, 'Izin'),
    (4, 'Dinas Luar Kota'),
    (5, 'Dinas Dalam Kota');

-- --------------------------------------------------------

--
-- Table structure for table `shift`
--

CREATE TABLE `shift` (
    `shift_id` int(11) NOT NULL,
    `shift_name` varchar(20) NOT NULL,
    `time_in` time NOT NULL,
    `time_out` time NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `shift`
--

INSERT INTO
    `shift` (
        `shift_id`,
        `shift_name`,
        `time_in`,
        `time_out`
    )
VALUES (
        1,
        'APEL',
        '06:30:00',
        '07:30:00'
    ),
    (
        5,
        'KERJA NORMAL',
        '07:00:00',
        '14:00:00'
    ),
    (
        9,
        'SHIFT PAGI',
        '07:00:00',
        '14:00:00'
    ),
    (
        10,
        'SHIFT SORE',
        '14:00:00',
        '21:00:00'
    ),
    (
        12,
        'JUM\'AT',
        '07:00:00',
        '19:40:00'
    ),
    (
        13,
        'SHIFT MALAM',
        '21:00:00',
        '07:00:00'
    ),
    (
        14,
        'JUM\'AT',
        '07:30:00',
        '10:30:00'
    );

-- --------------------------------------------------------

--
-- Table structure for table `sw_site`
--

CREATE TABLE `sw_site` (
    `site_id` int(4) NOT NULL,
    `site_url` varchar(100) NOT NULL,
    `site_name` varchar(50) NOT NULL,
    `site_company` varchar(30) NOT NULL,
    `site_manager` varchar(30) NOT NULL,
    `site_director` varchar(30) NOT NULL,
    `site_phone` char(12) NOT NULL,
    `site_address` text NOT NULL,
    `site_description` text NOT NULL,
    `site_logo` varchar(50) NOT NULL,
    `site_email` varchar(30) NOT NULL,
    `site_email_domain` varchar(50) NOT NULL,
    `gmail_host` varchar(50) NOT NULL,
    `gmail_username` varchar(50) NOT NULL,
    `gmail_password` varchar(50) NOT NULL,
    `gmail_port` varchar(10) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `sw_site`
--

INSERT INTO
    `sw_site` (
        `site_id`,
        `site_url`,
        `site_name`,
        `site_company`,
        `site_manager`,
        `site_director`,
        `site_phone`,
        `site_address`,
        `site_description`,
        `site_logo`,
        `site_email`,
        `site_email_domain`,
        `gmail_host`,
        `gmail_username`,
        `gmail_password`,
        `gmail_port`
    )
VALUES (
        1,
        'https://pkmbluto.apps.wilcorp.co.id',
        'SIMAS PKM BLUTO',
        'Puskesmas Bluto',
        'Purnomo Irawan',
        'Bu Kapus',
        '081931021707',
        'Jl. Raya Bluto No.13, Tajjan, Bungbungan, Kec. Bluto, Kabupaten Sumenep, Jawa Timur 69466',
        'Sistem Informasi Absensi Online Puskesmas Bluto',
        'logo-pkm-bluto-11png.png',
        'puskbluto@gmail.com',
        'puskbluto@gmail.com',
        'smtp.gmail.com',
        'puskbluto@gmail.com',
        'passwordemailserver',
        '465'
    );

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
    `user_id` int(11) NOT NULL,
    `username` varchar(40) NOT NULL,
    `email` varchar(50) NOT NULL,
    `password` varchar(100) NOT NULL,
    `fullname` varchar(40) NOT NULL,
    `registered` datetime NOT NULL,
    `created_login` datetime NOT NULL,
    `last_login` datetime NOT NULL,
    `session` varchar(100) NOT NULL,
    `ip` varchar(20) NOT NULL,
    `browser` varchar(30) NOT NULL,
    `level` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO
    `user` (
        `user_id`,
        `username`,
        `email`,
        `password`,
        `fullname`,
        `registered`,
        `created_login`,
        `last_login`,
        `session`,
        `ip`,
        `browser`,
        `level`
    )
VALUES (
        4,
        'adminsimas',
        'admin@simas.id',
        'f19dbdd9461d06a2043f3ce1f8b4a336efaadcc3925cfb57f32b35cd6104d361',
        'Admin Simas',
        '2024-09-30 13:41:12',
        '2024-10-14 11:20:42',
        '2024-10-14 10:49:49',
        '-',
        '1',
        'Google Crome',
        1
    ),
    (
        5,
        'operatorsimas',
        'opsimas@pkmbluto.id',
        'e21b8d8ecf7a6505cd3cb3b14fe0956990784afc6d6d536b87dd8519c472e91b',
        'Operator Simas',
        '2024-09-30 13:45:39',
        '2024-10-13 20:28:09',
        '2024-09-30 13:48:40',
        '-',
        '1',
        'Google Crome',
        2
    );

-- --------------------------------------------------------

--
-- Table structure for table `user_level`
--

CREATE TABLE `user_level` (
    `level_id` int(4) NOT NULL,
    `level_name` varchar(20) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `user_level`
--

INSERT INTO
    `user_level` (`level_id`, `level_name`)
VALUES (1, 'Administrator'),
    (2, 'Operator');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apel`
--
ALTER TABLE `apel` ADD PRIMARY KEY (`apel_id`);

--
-- Indexes for table `building`
--
ALTER TABLE `building` ADD PRIMARY KEY (`building_id`);

--
-- Indexes for table `business_card`
--
ALTER TABLE `business_card` ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cuty`
--
ALTER TABLE `cuty` ADD PRIMARY KEY (`cuty_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees` ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holiday`
--
ALTER TABLE `holiday` ADD PRIMARY KEY (`holiday_id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission` ADD PRIMARY KEY (`permission_id`);

--
-- Indexes for table `position`
--
ALTER TABLE `position` ADD PRIMARY KEY (`position_id`);

--
-- Indexes for table `presence`
--
ALTER TABLE `presence` ADD PRIMARY KEY (`presence_id`);

--
-- Indexes for table `present_status`
--
ALTER TABLE `present_status` ADD PRIMARY KEY (`present_id`);

--
-- Indexes for table `shift`
--
ALTER TABLE `shift` ADD PRIMARY KEY (`shift_id`);

--
-- Indexes for table `sw_site`
--
ALTER TABLE `sw_site` ADD PRIMARY KEY (`site_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user` ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_level`
--
ALTER TABLE `user_level` ADD PRIMARY KEY (`level_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `building`
--
ALTER TABLE `building`
MODIFY `building_id` int(8) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 8;

--
-- AUTO_INCREMENT for table `business_card`
--
ALTER TABLE `business_card`
MODIFY `id` int(5) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 2;

--
-- AUTO_INCREMENT for table `cuty`
--
ALTER TABLE `cuty`
MODIFY `cuty_id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 135;

--
-- AUTO_INCREMENT for table `holiday`
--
ALTER TABLE `holiday`
MODIFY `holiday_id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 5;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 24;

--
-- AUTO_INCREMENT for table `position`
--
ALTER TABLE `position`
MODIFY `position_id` int(5) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 8;

--
-- AUTO_INCREMENT for table `presence`
--
ALTER TABLE `presence`
MODIFY `presence_id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 60;

--
-- AUTO_INCREMENT for table `present_status`
--
ALTER TABLE `present_status`
MODIFY `present_id` int(6) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 6;

--
-- AUTO_INCREMENT for table `shift`
--
ALTER TABLE `shift`
MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 15;

--
-- AUTO_INCREMENT for table `sw_site`
--
ALTER TABLE `sw_site`
MODIFY `site_id` int(4) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 6;

--
-- AUTO_INCREMENT for table `user_level`
--
ALTER TABLE `user_level`
MODIFY `level_id` int(4) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 3;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;