-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2018 at 01:21 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reservation_kich`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `shift` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hall` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `admin_id`, `date`, `shift`, `name`, `mail`, `number`, `hall`, `type`, `address`, `created_at`, `updated_at`) VALUES
(1, 1, '2018-12-22', 1, 'Md. Nurul Islam Habib', NULL, '01710904046', 'both', 'wedding', 'M/S Haji Tayyab Ullah & Sons, Commercial Building, Station Road, Vorthkhola, Sylhet', '2018-09-20 02:27:31', '2018-09-20 02:37:37'),
(2, 1, '2018-12-28', 1, 'Mohammed Oliur Rahman', 'info@alharamainhospitalbd.com', '019 3122 5555', 'both', 'reciption', 'Kazi Tower, Samato-30, Chali Bandar, Bishwa Road, Subhani Ghat, Sylhet-3100, Bangladesh.', '2018-09-20 02:39:45', '2018-09-20 02:39:45'),
(3, 1, '2018-12-28', 2, 'Mohammed Oliur Rahman', 'info@alharamainhospitalbd.com', '019 3122 5555', 'both', 'reciption', 'Kazi Tower, Samato-30, Chali Bandar, Bishwa Road, Subhani Ghat, Sylhet-3100, Bangladesh.', '2018-09-20 02:39:46', '2018-09-20 02:39:46'),
(5, 1, '2018-12-21', 1, 'Haji Motosir Ali', NULL, '01718672920', 'both', 'wedding', 'Gangu,Boroikandi, Sylhet', '2018-09-26 02:40:32', '2018-09-29 01:26:32'),
(7, 1, '2018-12-20', 2, 'Dr. Naseem Ahmed', 'info@noorjahanhospital.com', '+8801672 200000', 'both', 'wedding', 'Waves 1, Ritz Tower, Dargah gate, Sylhet', '2018-09-20 02:59:20', '2018-09-26 02:40:06'),
(8, 1, '2019-02-10', 2, 'Dr Naseem Ahmed', 'info@noorjahanhospital.com', '+8801672 200000', 'both', 'reciption', 'Waves 1, Ritz Tower, Dargah gate, Sylhet', '2018-09-27 08:05:28', '2018-09-27 08:06:18'),
(9, 1, '2018-12-27', 2, 'Mohammed Oliur Rahman', 'info@alharamainhospitalbd.com', '019 3122 5555', 'both', 'reciption', 'Kazi Tower, Samato-30, Chali Bandar, Bishwa Road, Subhani Ghat, Sylhet-3100, Bangladesh.', '2018-09-20 02:39:46', '2018-09-20 02:39:46'),
(10, 1, '2018-12-27', 1, 'Mohammed Oliur Rahman', 'info@alharamainhospitalbd.com', '019 3122 5555', 'both', 'reciption', 'Kazi Tower, Samato-30, Chali Bandar, Bishwa Road, Subhani Ghat, Sylhet-3100, Bangladesh.', '2018-09-20 02:39:46', '2018-09-20 02:39:46'),
(13, 1, '2018-12-23', 1, 'Hafiz Ahmed', 'findshahadat@gmail.com', '+971588374083', 'both', 'reciption', '16 Moushumi, Mirabazar, Sylhet', '2018-10-27 06:41:08', '2018-10-27 06:41:08'),
(14, 1, '2018-12-21', 2, 'Mr. Abul Kalam,', NULL, '00000000', 'both', 'wedding', 'Chairman, Kuchai Union Porishod, Sylhet', '2018-11-03 04:01:13', '2018-11-03 04:01:13'),
(15, 1, '2018-12-08', 2, 'Zubaer Ahmed', NULL, '01712109583', 'large', 'corporate', 'Rotary Club of Sylhet South', '2018-11-06 06:04:59', '2018-11-06 06:04:59'),
(16, 1, '2019-08-02', 2, 'Al Zahi Chowdhury', 'jahichowdhury.007@gmail.com', '01771853999', 'both', 'wedding', 'Aftab Manzil, Moktob Golli, Kazitula, Sylhet', '2018-11-15 03:15:01', '2018-11-15 03:15:01'),
(17, 1, '2019-04-14', 2, 'Riyad Uddin', NULL, '01712995106', 'both', 'wedding', 'Prottoy 107, Raynogor, Doptoripara, Sylhet', '2018-11-15 03:16:39', '2018-11-15 03:16:39'),
(18, 1, '2018-12-24', 1, 'Azman Uddin', NULL, '0', 'both', 'wedding', 'Chadni ghta, Dakshin Surma, Sylhet', '2018-11-22 02:53:28', '2018-11-22 02:53:28'),
(19, 1, '2019-04-12', 1, 'Joynul Haque', NULL, '01776220285', 'both', 'wedding', '+4407908548240\nChokidikhi, Sylhet\nPending', '2018-11-24 08:14:10', '2018-11-26 06:21:20'),
(20, 1, '2019-01-01', 1, 'Mr. Helal Ahmed', NULL, '01789686568', 'small', 'reciption', 'Dakshin Surma', '2018-11-29 00:05:29', '2018-11-29 00:07:21'),
(21, 1, '2019-01-18', 1, 'M.A Samad', NULL, '01711668407', 'both', 'wedding', 'Uposhohor', '2018-11-29 00:10:18', '2018-11-29 00:10:18'),
(22, 1, '2019-01-19', 1, 'Emdadur Rahman', 'amdadurrahman08@gmail.com', '0000', 'small', 'reciption', 'Ref SajonVai', '2018-11-29 00:11:27', '2018-11-29 00:11:27'),
(23, 1, '2019-04-10', 1, 'Monsur Ali', NULL, '01739214683', 'large', 'wedding', '47/3 Baghbai, Sylhet', '2018-11-29 04:09:32', '2018-11-29 04:09:32');

-- --------------------------------------------------------

--
-- Table structure for table `cashes`
--

CREATE TABLE `cashes` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(4, '2014_10_12_000000_create_users_table', 1),
(5, '2014_10_12_100000_create_password_resets_table', 1),
(6, '2018_08_16_081206_create_bookings_table', 1),
(7, '2018_11_08_121551_create_services_table', 2),
(8, '2018_11_08_121604_create_cashes_table', 2),
(9, '2018_11_25_152540_create_payments_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Zubaer', 'zubaer.haque@gmail.com', '$2y$10$0uZ4Na3.SCV21Wam.6L3dev9xlMNYSPTUwykyEvgRLpk5CQh4R/6m', 'QIWFYHxZheX7Zc5Wv0uoYnZipIIbOumkyMe6cpxQrOWP7B29lj5iSbwEsQYf', '2018-09-20 02:18:07', '2018-09-20 02:18:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cashes`
--
ALTER TABLE `cashes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `cashes`
--
ALTER TABLE `cashes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
