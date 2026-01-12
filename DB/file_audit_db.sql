-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 12, 2026 at 12:50 PM
-- Server version: 9.1.0
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `file_audit_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auditor_auditreport`
--

DROP TABLE IF EXISTS `auditor_auditreport`;
CREATE TABLE IF NOT EXISTS `auditor_auditreport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `has_exif` tinyint(1) NOT NULL,
  `exif_software` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exif_datetime_original` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exif_datetime_modified` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exif_anomalies` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `pdf_creator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pdf_producer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pdf_creation_date` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pdf_modification_date` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pdf_page_count` int DEFAULT NULL,
  `pdf_anomalies` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadata_mismatch` tinyint(1) NOT NULL,
  `suspicious_software` tinyint(1) NOT NULL,
  `hash_collision` tinyint(1) NOT NULL,
  `detection_summary` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `confidence_score` decimal(5,2) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `uploaded_file_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uploaded_file_id` (`uploaded_file_id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auditor_auditreport`
--

INSERT INTO `auditor_auditreport` (`id`, `has_exif`, `exif_software`, `exif_datetime_original`, `exif_datetime_modified`, `exif_anomalies`, `pdf_creator`, `pdf_producer`, `pdf_creation_date`, `pdf_modification_date`, `pdf_page_count`, `pdf_anomalies`, `metadata_mismatch`, `suspicious_software`, `hash_collision`, `detection_summary`, `confidence_score`, `created_at`, `uploaded_file_id`) VALUES
(50, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 12:35:31.923718', 60),
(51, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-17 05:38:38.451873', 61),
(52, 0, '', '', '', '', 'Microsoft® Word for Microsoft 365', '4-Heights™ PDF Library 3.4.0.6904 (http://www.pdf-tools.com)', 'D:20251113184245+05\'30\'', 'D:20251118094721Z', 1, '[\"Creation and modification dates differ\"]', 1, 0, 0, 'PDF shows signs of possible editing', 70.00, '2025-11-18 09:50:10.388481', 62),
(49, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 12:33:52.185643', 59),
(48, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 11:44:09.313312', 58),
(47, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 11:42:31.489444', 57),
(46, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 11:33:21.034897', 56),
(62, 0, '', '', '', '', '3-Heights™ Image to PDF Converter 6.16.0.2 (www.pdf-tools.com)', '3-Heights(TM) PDF Optimization Shell 5.9.1.5 (http://www.pdf-tools.com)', 'D:20230913195632+02\'00\'', 'D:20230913195659+02\'00\'', 1, '[\"Creation and modification dates differ\"]', 1, 0, 0, 'PDF shows signs of possible editing', 70.00, '2025-11-19 13:42:39.755032', 72),
(60, 0, '', '', '', '', 'PDFium', 'PDFium', 'D:20251003223153', '', 1, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-18 10:17:09.820487', 70),
(43, 0, '', '', '', '', '3-Heights™ Image to PDF Converter 6.16.0.2 (www.pdf-tools.com)', '3-Heights(TM) PDF Optimization Shell 5.9.1.5 (http://www.pdf-tools.com)', 'D:20230913195635+02\'00\'', 'D:20230913195704+02\'00\'', 1, '[\"Creation and modification dates differ\"]', 1, 0, 0, 'PDF shows signs of possible editing', 70.00, '2025-11-05 11:11:30.126845', 53),
(42, 0, '', '', '', '', '', 'iOS Version 18.3.2 (Build 22D82) Quartz PDFContext', 'D:20250418223439Z00\'00\'', 'D:20250418223439Z00\'00\'', 1, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-05 11:10:26.116685', 52),
(40, 0, '', '', '', '', 'Scanner System', 'Scanner System Image Conversion', 'D:20241029095902-06\'00\'\'', 'D:20241029095902-06\'00\'\'', 2, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-05 11:09:45.834084', 50),
(41, 0, '', '', '', '', '', 'Microsoft: Print To PDF', 'D:20250626164231-04\'00\'', 'D:20250626164231-04\'00\'', 2, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-05 11:09:54.208123', 51),
(39, 0, '', '', '', '', 'KM_458e', 'KONICA MINOLTA bizhub 458e', 'D:20231011133302-05\'00\'', 'D:20231011133302-05\'00\'', 2, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-05 11:08:51.287807', 49),
(38, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 11:01:36.044559', 48),
(37, 1, '', '', '', '[]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 100.00, '2025-11-05 11:00:26.334791', 47),
(36, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 11:00:15.345473', 46),
(35, 1, '', '', '', '[]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 100.00, '2025-11-05 10:59:56.888410', 45),
(33, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-05 10:59:24.047773', 43),
(34, 0, '', '', '', '', 'Adobe Photoshop CS6 (Windows)', 'Adobe Photoshop for Windows -- Image Conversion Plug-in', 'D:20210428232411+05\'30\'', 'D:20230913140811-04\'00\'', 1, '[\"PDF editing software detected: Adobe Photoshop CS6 (Windows) / Adobe Photoshop for Windows -- Image Conversion Plug-in\", \"Creation and modification dates differ\"]', 1, 1, 0, 'PDF likely edited or manipulated', 30.00, '2025-11-05 10:59:42.757247', 44),
(32, 0, '', '', '', '', 'Chromium', 'Skia/PDF m93', 'D:20250307094108+00\'00\'', 'D:20250307094108+00\'00\'', 3, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-05 10:58:59.692344', 42),
(31, 0, '', '', '', '', 'Adobe Photoshop 22.5 (Windows)', 'Adobe Photoshop for Windows -- Image Conversion Plug-in', 'D:20231004102021-04\'00\'', 'D:20250221112903-05\'00\'', 1, '[\"PDF editing software detected: Adobe Photoshop 22.5 (Windows) / Adobe Photoshop for Windows -- Image Conversion Plug-in\", \"Creation and modification dates differ\"]', 1, 1, 0, 'PDF likely edited or manipulated', 30.00, '2025-11-05 10:55:38.027544', 41),
(30, 0, '', '', '', '', '', 'Microsoft: Print To PDF', 'D:20230302122825-05\'00\'', 'D:20230302122825-05\'00\'', 2, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-05 10:55:23.997447', 40),
(53, 0, '', '', '', '', '', 'iText® Core 8.0.1 (production version), pdfCalligraph 4.0.0 (production version) ©2000-2023 iText Group NV, Election Commission of India', 'D:20251116124957+05\'30\'', 'D:20251116124957+05\'30\'', 1, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-18 09:50:44.272062', 63),
(56, 0, '', '', '', '', '', 'jsPDF 2.5.1', 'D:20251115132832+05\'30\'', '', 1, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-18 09:58:57.044080', 66),
(59, 0, '', '', '', '', '', 'iOS Version 16.6 (Build 20G75) Quartz PDFContext', 'D:20230814190353Z00\'00\'', 'D:20230814190353Z00\'00\'', 1, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-11-18 10:11:53.343300', 69),
(63, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-11-21 10:11:28.104569', 73),
(64, 0, '', '', '', '[\"No EXIF data found - metadata may have been stripped\"]', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-12-16 05:47:30.244571', 74),
(65, 0, '', '', '', '', '', 'Oracle BI Publisher 11.1.1.9.0', '', '', 7, '[]', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-12-16 06:10:01.858683', 75),
(66, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-12-18 09:31:10.469719', 76),
(67, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-12-18 09:31:46.163067', 77),
(68, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-12-18 09:31:58.693730', 78),
(69, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-12-18 09:49:56.487730', 79),
(70, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'PDF likely edited or manipulated', 0.00, '2025-12-18 09:50:19.999499', 80),
(71, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'PDF likely edited or manipulated', 0.00, '2025-12-18 09:50:31.863987', 81),
(72, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'PDF appears unmodified', 100.00, '2025-12-18 09:51:02.066101', 82),
(73, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'File appears unmodified', 80.00, '2025-12-19 12:55:00.922768', 83),
(74, 0, '', '', '', '', '', '', '', '', NULL, '', 0, 0, 0, 'PDF appears unmodified', 100.00, '2026-01-12 06:43:01.745783', 84);

-- --------------------------------------------------------

--
-- Table structure for table `auditor_uploadedfile`
--

DROP TABLE IF EXISTS `auditor_uploadedfile`;
CREATE TABLE IF NOT EXISTS `auditor_uploadedfile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` bigint NOT NULL,
  `sha256_hash` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `perceptual_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `integrity_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `analyzed_at` datetime(6) DEFAULT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `admin_notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `reviewed_by_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_file_per_user` (`user_id`,`sha256_hash`),
  KEY `auditor_upl_user_id_290d8c_idx` (`user_id`,`uploaded_at`),
  KEY `auditor_upl_integri_8df524_idx` (`integrity_status`),
  KEY `auditor_upl_sha256__9ed151_idx` (`sha256_hash`),
  KEY `auditor_uploadedfile_reviewed_by_id_783b940b` (`reviewed_by_id`),
  KEY `auditor_uploadedfile_user_id_13c5f856` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auditor_uploadedfile`
--

INSERT INTO `auditor_uploadedfile` (`id`, `file`, `original_filename`, `file_type`, `file_size`, `sha256_hash`, `perceptual_hash`, `integrity_status`, `uploaded_at`, `analyzed_at`, `reviewed_at`, `admin_notes`, `reviewed_by_id`, `user_id`) VALUES
(83, 'uploads/2025/12/19/HDFC_LOAN.png', 'HDFC LOAN.png', 'image', 110996, '011f032d05f80ccb137767ae1917875ef591e006982a901be3927031560b0612', '00e7e7ffffffffe7', 'clean', '2025-12-19 12:55:00.512686', '2025-12-19 12:55:00.915326', NULL, '', NULL, 3),
(84, 'uploads/2026/01/12/TKT1.pdf', 'TKT1.pdf', 'pdf', 2054221, 'b257872726af217ec7286ccb81effa53a2046739cee7c2ba4e62acecf7dc4214', NULL, 'clean', '2026-01-12 06:43:01.711019', '2026-01-12 06:43:01.745783', NULL, '', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add uploaded file', 7, 'add_uploadedfile'),
(26, 'Can change uploaded file', 7, 'change_uploadedfile'),
(27, 'Can delete uploaded file', 7, 'delete_uploadedfile'),
(28, 'Can view uploaded file', 7, 'view_uploadedfile'),
(29, 'Can add audit report', 8, 'add_auditreport'),
(30, 'Can change audit report', 8, 'change_auditreport'),
(31, 'Can delete audit report', 8, 'delete_auditreport'),
(32, 'Can view audit report', 8, 'view_auditreport');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1000000$SB9gzperBVKeP4UWprtHjm$Il2vJK/jE5IxZFh1RS9N4uqn/feSlHkS7Ol272PLZSo=', NULL, 1, 'saravanak', '', '', '', 1, 1, '2025-10-30 09:49:05.343155'),
(2, 'pbkdf2_sha256$1000000$Wt6W9exh5pMFD0b0r7XXom$z5O/8pU3xh2BgbsoCzntaGQCttAJx598iiWRWf0ow5I=', '2025-12-18 09:51:25.420948', 1, 'saravanank', '', '', 'saravanan.k@lorventech.com', 1, 1, '2025-10-30 09:59:14.165353'),
(3, 'pbkdf2_sha256$1000000$1cykzMeGm6FYSjxZp3gAI9$vwj40pV/3iP3MHzgw7C8/CGjLCB/jHkWkKtNW2F+vzo=', '2026-01-12 06:28:22.193317', 0, 'welcome', '', '', '', 0, 1, '2025-10-30 10:00:37.820407'),
(4, 'pbkdf2_sha256$1000000$RsywAATxodYPtVytq9SchG$9Cd27YPnEbprAL6kQ9ZiuhFcD5QFgWtJQfhGOjuY3/U=', '2025-11-05 11:41:50.431633', 0, 'lorven', '', '', '', 0, 1, '2025-11-05 06:40:54.297341');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-11-05 11:22:41.801518', '41', 'DL back (1) - Copy.pdf - welcome', 2, '[{\"changed\": {\"fields\": [\"Reviewed at\", \"Admin notes\"]}}]', 7, 2);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'auditor', 'uploadedfile'),
(8, 'auditor', 'auditreport');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-10-30 09:48:09.241887'),
(2, 'auth', '0001_initial', '2025-10-30 09:48:09.612819'),
(3, 'admin', '0001_initial', '2025-10-30 09:48:09.739833'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-10-30 09:48:09.746297'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-10-30 09:48:09.750432'),
(6, 'auditor', '0001_initial', '2025-10-30 09:48:09.957664'),
(7, 'contenttypes', '0002_remove_content_type_name', '2025-10-30 09:48:10.008894'),
(8, 'auth', '0002_alter_permission_name_max_length', '2025-10-30 09:48:10.036625'),
(9, 'auth', '0003_alter_user_email_max_length', '2025-10-30 09:48:10.064752'),
(10, 'auth', '0004_alter_user_username_opts', '2025-10-30 09:48:10.074122'),
(11, 'auth', '0005_alter_user_last_login_null', '2025-10-30 09:48:10.104302'),
(12, 'auth', '0006_require_contenttypes_0002', '2025-10-30 09:48:10.105511'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2025-10-30 09:48:10.111876'),
(14, 'auth', '0008_alter_user_username_max_length', '2025-10-30 09:48:10.139071'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2025-10-30 09:48:10.172510'),
(16, 'auth', '0010_alter_group_name_max_length', '2025-10-30 09:48:10.197746'),
(17, 'auth', '0011_update_proxy_permissions', '2025-10-30 09:48:10.205987'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2025-10-30 09:48:10.233048'),
(19, 'sessions', '0001_initial', '2025-10-30 09:48:10.254220'),
(20, 'auditor', '0002_uploadedfile_unique_file_per_user', '2025-12-16 06:06:53.765159'),
(21, 'auditor', '0003_alter_uploadedfile_sha256_hash', '2025-12-16 12:40:13.086262');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('984bqmj0qjwdsykrk9rv797ncepb3mse', '.eJxVjDkOwjAURO_iGlk28UpJzxks_8U4gBwpTirE3UmkFNCN5r2Zt0h5XWpaO89pJHERZ3H67SDjk9sO6JHbfZI4tWUeQe6KPGiXt4n4dT3cv4Oae93WnigiBWRnCwQV0Shm1GCd0sVAATShsB48WT8Ea0yJCOSiLQHdFsTnCw_VOOQ:1vLiTw:F2EKzr7GRqQSxHVi4K7__Si25yQdzS7pioWr9STDrUs', '2025-12-03 13:44:24.567718'),
('2jnh9ltquajih2b0d3t6qvu18wl6xxc1', '.eJxVjDsOwjAQBe_iGln-yNmYkp4zWLtZLw4gR4qTKuLuJFIKaN_MvE0lXJeS1pbnNLK6Kq8uvxvh8Mr1APzE-pj0MNVlHkkfij5p0_eJ8_t2un8HBVvZazDMHfreA1uIEDq22QpkCCSOrIseyIQovRiwEpA4CIADs3NPgOrzBdVON7Y:1vEPxz:BpkJY8f3RBR89xb0znoaAkcriYjC-PxszDt9QYkUmQM', '2025-11-13 10:33:15.202081'),
('e1x9z5q5b99haxgn43wej614o81qwkx5', '.eJxVjDsOwjAQBe_iGln-yNmYkp4zWLtZLw4gR4qTKuLuJFIKaN_MvE0lXJeS1pbnNLK6Kq8uvxvh8Mr1APzE-pj0MNVlHkkfij5p0_eJ8_t2un8HBVvZazDMHfreA1uIEDq22QpkCCSOrIseyIQovRiwEpA4CIADs3NPgOrzBdVON7Y:1vElCO:4-wBY8loCbbR92FaojM8NRCSCabjAJ2JV97OJWow0BI', '2025-11-14 09:13:32.134095'),
('w8yt20z0jdfe4a7it43gxjafydlulpi3', '.eJxVjDkOwjAURO_iGlk28UpJzxks_8U4gBwpTirE3UmkFNCN5r2Zt0h5XWpaO89pJHERZ3H67SDjk9sO6JHbfZI4tWUeQe6KPGiXt4n4dT3cv4Oae93WnigiBWRnCwQV0Shm1GCd0sVAATShsB48WT8Ea0yJCOSiLQHdFsTnCw_VOOQ:1vOwGV:Mpm5khvVswccD4JplqRxP5mhHcHYviV9gwJ94Z05Zcc', '2025-12-12 11:03:51.542486'),
('rvbmlyc5c2brrhuxfj9em42332rjtvxp', '.eJxVjDsOwjAQBe_iGln-yNmYkp4zWLtZLw4gR4qTKuLuJFIKaN_MvE0lXJeS1pbnNLK6Kq8uvxvh8Mr1APzE-pj0MNVlHkkfij5p0_eJ8_t2un8HBVvZazDMHfreA1uIEDq22QpkCCSOrIseyIQovRiwEpA4CIADs3NPgOrzBdVON7Y:1vWAl8:ZsqfxYFnJJT1a_FRQez9AUYahfNP9c7PbBMjAJeuymg', '2026-01-01 09:57:22.382098'),
('acy0kyz54z6xbqkunwmui5yeime5a4q8', '.eJxVjDsOwjAQBe_iGln-yNmYkp4zWLtZLw4gR4qTKuLuJFIKaN_MvE0lXJeS1pbnNLK6Kq8uvxvh8Mr1APzE-pj0MNVlHkkfij5p0_eJ8_t2un8HBVvZazDMHfreA1uIEDq22QpkCCSOrIseyIQovRiwEpA4CIADs3NPgOrzBdVON7Y:1vfBPa:QXNgiv0anONJDPAqWQmM3tJE--URY1BLDqma_07NUwU', '2026-01-26 06:28:22.193317');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
