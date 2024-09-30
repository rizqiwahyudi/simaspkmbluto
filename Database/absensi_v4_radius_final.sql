-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 01 Nov 2022 pada 06.25
-- Versi server: 10.4.11-MariaDB
-- Versi PHP: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `absensi_v4_radius_final`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `building`
--

CREATE TABLE `building` (
  `building_id` int(8) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `latitude_longtitude` varchar(150) NOT NULL,
  `radius` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `building`
--

INSERT INTO `building` (`building_id`, `code`, `name`, `address`, `latitude_longtitude`, `radius`) VALUES
(1, 'SWUKZ/2021', 'S-widodo.com', 'Jl. Zainal Abidin Labuhan ratu gg. harapn no. 18 Bandar Lampung', '-5.402816961029136,105.26013853271533', 3000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `business_card`
--

CREATE TABLE `business_card` (
  `id` int(5) NOT NULL,
  `name` varchar(30) NOT NULL,
  `photo` varchar(150) NOT NULL,
  `active` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `business_card`
--

INSERT INTO `business_card` (`id`, `name`, `photo`, `active`) VALUES
(1, 'Thema 1', '2021-09-14818db55ed84f450043ad72540c19d46e.jpg', '1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `cuty`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `employees`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `employees`
--

INSERT INTO `employees` (`id`, `employees_code`, `employees_nip`, `employees_email`, `employees_password`, `employees_name`, `position_id`, `shift_id`, `building_id`, `photo`, `created_login`, `created_cookies`) VALUES
(27, '2022/8FD6/SW2022-10-21', '123456', 'swidodo.com@gmail.com', 'acd2bcf0a751e78ba7a1904d55cb26b00b7b5c21ea1c7a91b373c2cf44ae0b29', 'Widodo', 2, 1, 1, '27-1a9d0a42736063ec60e8833614f44a6d-150408-.jpg', '2022-11-01 12:22:05', '4c6c453e7a58b5fc11908a3916f944e1'),
(28, '2022/B775/SW2022-10-21', '435438597', 'contohemail@gmail.com', '00f03f70968c0788843b2735310897d06936bb76572b98f344d04d32c6791c24', 'Example', 1, 1, 1, '', '2022-10-21 10:56:28', '-');

-- --------------------------------------------------------

--
-- Struktur dari tabel `holiday`
--

CREATE TABLE `holiday` (
  `holiday_id` int(11) NOT NULL,
  `holiday_date` date NOT NULL,
  `description` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `permission`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `position`
--

CREATE TABLE `position` (
  `position_id` int(5) NOT NULL,
  `position_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `position`
--

INSERT INTO `position` (`position_id`, `position_name`) VALUES
(1, 'STAFF'),
(2, 'ACCOUNTING'),
(7, 'MARKETING');

-- --------------------------------------------------------

--
-- Struktur dari tabel `presence`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `presence`
--

INSERT INTO `presence` (`presence_id`, `employees_id`, `presence_date`, `time_in`, `time_out`, `present_id`, `latitude_longtitude_in`, `latitude_longtitude_out`, `information`) VALUES
(28, 6, '2022-07-15', '14:54:44', '00:00:00', 1, '-5.3973627,105.2546003', '', ''),
(29, 27, '2022-10-21', '14:29:17', '21:34:13', 1, '-5.4027714,105.2601946', '-5.3971396,105.2667887', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `present_status`
--

CREATE TABLE `present_status` (
  `present_id` int(6) NOT NULL,
  `present_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `present_status`
--

INSERT INTO `present_status` (`present_id`, `present_name`) VALUES
(1, 'Hadir'),
(2, 'Sakit'),
(3, 'Izin'),
(4, 'Dinas Luar Kota'),
(5, 'Dinas Dalam Kota');

-- --------------------------------------------------------

--
-- Struktur dari tabel `shift`
--

CREATE TABLE `shift` (
  `shift_id` int(11) NOT NULL,
  `shift_name` varchar(20) NOT NULL,
  `time_in` time NOT NULL,
  `time_out` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `shift`
--

INSERT INTO `shift` (`shift_id`, `shift_name`, `time_in`, `time_out`) VALUES
(1, 'FULL TIME', '07:30:00', '17:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sw_site`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `sw_site`
--

INSERT INTO `sw_site` (`site_id`, `site_url`, `site_name`, `site_company`, `site_manager`, `site_director`, `site_phone`, `site_address`, `site_description`, `site_logo`, `site_email`, `site_email_domain`, `gmail_host`, `gmail_username`, `gmail_password`, `gmail_port`) VALUES
(1, 'http://localhost/absensi-v4-radius-oktober-2022', 'Absensi V.4 Radius', 'S widodo.com', 'Intan Permata Sari', 'S. Widodo', '083160901108', 'Jl. Zainal Bidin Labuhan Ratu gg. Harapan 1 No 18', 'Absensi V.4 Radius', 'whiteswlogowebpng.png', 'swidodo.com@gmail.com', 'info@domain.com', 'smtp.gmail.com', 'emailanda@gmail.com', 'passwordemailserver', '465');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`user_id`, `username`, `email`, `password`, `fullname`, `registered`, `created_login`, `last_login`, `session`, `ip`, `browser`, `level`) VALUES
(1, 'Widodo', 'swidodo.com@gmail.com', '9b2a3c62de66c2bd851b24f383bddcbcf3a1efe738ec5494a96b3fd4ccfe3ecb', 'Widodo', '2021-02-03 10:22:00', '2022-11-01 12:22:28', '2022-11-01 09:42:03', '-', '1', 'Google Crome', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_level`
--

CREATE TABLE `user_level` (
  `level_id` int(4) NOT NULL,
  `level_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_level`
--

INSERT INTO `user_level` (`level_id`, `level_name`) VALUES
(1, 'Administrator'),
(2, 'Operator');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `building`
--
ALTER TABLE `building`
  ADD PRIMARY KEY (`building_id`);

--
-- Indeks untuk tabel `business_card`
--
ALTER TABLE `business_card`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `cuty`
--
ALTER TABLE `cuty`
  ADD PRIMARY KEY (`cuty_id`);

--
-- Indeks untuk tabel `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `holiday`
--
ALTER TABLE `holiday`
  ADD PRIMARY KEY (`holiday_id`);

--
-- Indeks untuk tabel `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`permission_id`);

--
-- Indeks untuk tabel `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`position_id`);

--
-- Indeks untuk tabel `presence`
--
ALTER TABLE `presence`
  ADD PRIMARY KEY (`presence_id`);

--
-- Indeks untuk tabel `present_status`
--
ALTER TABLE `present_status`
  ADD PRIMARY KEY (`present_id`);

--
-- Indeks untuk tabel `shift`
--
ALTER TABLE `shift`
  ADD PRIMARY KEY (`shift_id`);

--
-- Indeks untuk tabel `sw_site`
--
ALTER TABLE `sw_site`
  ADD PRIMARY KEY (`site_id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks untuk tabel `user_level`
--
ALTER TABLE `user_level`
  ADD PRIMARY KEY (`level_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `building`
--
ALTER TABLE `building`
  MODIFY `building_id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `business_card`
--
ALTER TABLE `business_card`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `cuty`
--
ALTER TABLE `cuty`
  MODIFY `cuty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `holiday`
--
ALTER TABLE `holiday`
  MODIFY `holiday_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `permission`
--
ALTER TABLE `permission`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `position`
--
ALTER TABLE `position`
  MODIFY `position_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `presence`
--
ALTER TABLE `presence`
  MODIFY `presence_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT untuk tabel `present_status`
--
ALTER TABLE `present_status`
  MODIFY `present_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `shift`
--
ALTER TABLE `shift`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `sw_site`
--
ALTER TABLE `sw_site`
  MODIFY `site_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `user_level`
--
ALTER TABLE `user_level`
  MODIFY `level_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
