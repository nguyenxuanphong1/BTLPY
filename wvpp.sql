-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 23, 2024 lúc 05:50 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `wvpp`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `app_customer`
--

CREATE TABLE `app_customer` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `app_customer`
--

INSERT INTO `app_customer` (`id`, `name`, `email`, `user_id`) VALUES
(1, 'Phong', NULL, 1),
(2, 'Nguyen Xuan Phong', 'n.x.pphong13@gmail.com', 3),
(3, 'nguyen xuan phong 123', 'n.x.pphong13@gmail.com', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `app_order`
--

CREATE TABLE `app_order` (
  `id` bigint(20) NOT NULL,
  `date_order` datetime(6) NOT NULL,
  `complete` tinyint(1) NOT NULL,
  `transaction_id` varchar(200) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `app_order`
--

INSERT INTO `app_order` (`id`, `date_order`, `complete`, `transaction_id`, `customer_id`) VALUES
(1, '2024-06-14 02:04:51.665266', 1, NULL, NULL),
(2, '2024-06-14 02:08:35.897487', 0, '0002', 2),
(3, '2024-06-17 15:47:45.285789', 0, '0001', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `app_orderitem`
--

CREATE TABLE `app_orderitem` (
  `id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `date_added` datetime(6) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `app_orderitem`
--

INSERT INTO `app_orderitem` (`id`, `quantity`, `date_added`, `order_id`, `product_id`) VALUES
(1, 72, '2024-06-17 15:48:40.925798', 3, 1),
(2, 4, '2024-06-17 15:48:52.353871', 3, 2),
(3, 2, '2024-06-17 16:38:57.881158', 3, 3),
(4, 3, '2024-06-18 18:36:00.675092', 3, 6),
(5, 5, '2024-06-22 16:03:41.444250', 3, 9),
(6, 1, '2024-06-22 17:00:42.489108', 3, 7),
(7, 1, '2024-06-22 17:49:32.319467', 3, 8),
(8, 1, '2024-06-23 01:22:52.820098', 3, 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `app_product`
--

CREATE TABLE `app_product` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `digital` tinyint(1) NOT NULL,
  `image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `app_product`
--

INSERT INTO `app_product` (`id`, `name`, `price`, `digital`, `image`) VALUES
(1, 'Tẩy siêu trắng', 4000.00, 0, 'Tay_sieu_trang.jpg'),
(2, 'Sách kẻ ngang', 2000.00, 1, 'sach_ke_ngang.jpg'),
(3, 'Que tính nhanh', 500.00, 0, 'que_tinh_nhanh.jpg'),
(4, 'Máy tính casio', 2500.00, 1, 'casio.jpg'),
(5, 'Bút màu sáp', 5000.00, 0, 'but_sap.jpg'),
(6, 'Cọ tô màu', 1000.00, 0, 'co_to_mau.jpg'),
(7, 'Dập ghim', 4000.00, 0, 'dap_ghim.jpg'),
(8, 'Gia de A4', 320000.00, 0, 'gia_de_a4.png'),
(9, 'Cuon day in tem doi', 200.00, 0, 'cuon_giay_in_tem_doi.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `app_shippingaddress`
--

CREATE TABLE `app_shippingaddress` (
  `id` bigint(20) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `state` varchar(200) DEFAULT NULL,
  `mobile` varchar(200) DEFAULT NULL,
  `date_added` datetime(6) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_permission`
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
(25, 'Can add oder item', 7, 'add_oderitem'),
(26, 'Can change oder item', 7, 'change_oderitem'),
(27, 'Can delete oder item', 7, 'delete_oderitem'),
(28, 'Can view oder item', 7, 'view_oderitem'),
(29, 'Can add shipping address', 8, 'add_shippingaddress'),
(30, 'Can change shipping address', 8, 'change_shippingaddress'),
(31, 'Can delete shipping address', 8, 'delete_shippingaddress'),
(32, 'Can view shipping address', 8, 'view_shippingaddress'),
(33, 'Can add product', 9, 'add_product'),
(34, 'Can change product', 9, 'change_product'),
(35, 'Can delete product', 9, 'delete_product'),
(36, 'Can view product', 9, 'view_product'),
(37, 'Can add oder', 10, 'add_oder'),
(38, 'Can change oder', 10, 'change_oder'),
(39, 'Can delete oder', 10, 'delete_oder'),
(40, 'Can view oder', 10, 'view_oder'),
(41, 'Can add customer', 11, 'add_customer'),
(42, 'Can change customer', 11, 'change_customer'),
(43, 'Can delete customer', 11, 'delete_customer'),
(44, 'Can view customer', 11, 'view_customer'),
(45, 'Can add order', 12, 'add_order'),
(46, 'Can change order', 12, 'change_order'),
(47, 'Can delete order', 12, 'delete_order'),
(48, 'Can view order', 12, 'view_order'),
(49, 'Can add order item', 13, 'add_orderitem'),
(50, 'Can change order item', 13, 'change_orderitem'),
(51, 'Can delete order item', 13, 'delete_orderitem'),
(52, 'Can view order item', 13, 'view_orderitem');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$yjsppO59DIWo4f8Ph5TZZc$FnQGcj4JhcmGXg1P04TfENJWa9sVdzJARXrcsqe5Id8=', '2024-06-19 03:14:52.967275', 1, 'nxpph', '', '', 'n.x.pphong13@gmial.com', 1, 1, '2024-06-07 13:38:36.983933'),
(2, 'pbkdf2_sha256$720000$ASb9pac6VyCecb1kFNCnh5$fNpVa+0rnsSdXF/fZTGARzAWeE1ABWPd4XKgzICyU/A=', '2024-06-07 15:41:24.825451', 1, 'nxp', '', '', 'n.x.pphong13@gmail.com', 1, 1, '2024-06-07 15:41:00.061736'),
(3, 'pbkdf2_sha256$720000$x53poljXsUOPMhalhhN1Ob$K4tMV4Os6ASg3jq5Uc5ungfHouuTCUzyYYsGsHlnG18=', NULL, 0, 'nxpph1', '', '', '', 0, 1, '2024-06-14 02:06:27.856425'),
(4, 'pbkdf2_sha256$720000$tYrVS6F5rqrXQN9JTw0edX$Lnue91KUjzKqV2FrkZDNNsuannxLBrX1T9VzyjsphiA=', NULL, 0, 'phong01', '', '', '', 0, 1, '2024-06-19 03:13:40.967696'),
(5, 'pbkdf2_sha256$720000$GGQnZhTZbzZz3UHEohir9y$AgMPQqnxLHZFGL/w5ONOPCe1lpkcSar8XbznA2drWEk=', NULL, 0, 'phongnxp01', '', '', '', 0, 1, '2024-06-19 03:15:48.000000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-06-14 02:04:51.665266', '1', 'None', 1, '[{\"added\": {}}]', 12, 1),
(2, '2024-06-14 02:06:28.705634', '3', 'nxpph1', 1, '[{\"added\": {}}]', 4, 1),
(3, '2024-06-14 02:07:41.899349', '1', 'Phong', 1, '[{\"added\": {}}]', 11, 1),
(4, '2024-06-14 02:08:21.461721', '2', 'Nguyen Xuan Phong', 1, '[{\"added\": {}}]', 11, 1),
(5, '2024-06-14 02:08:35.899521', '2', 'Quan ly 1', 1, '[{\"added\": {}}]', 12, 1),
(6, '2024-06-14 16:46:27.071593', '1', 'Tẩy siêu trắng', 1, '[{\"added\": {}}]', 9, 1),
(7, '2024-06-14 16:55:41.632867', '2', 'Sách kẻ ngang', 1, '[{\"added\": {}}]', 9, 1),
(8, '2024-06-14 17:26:37.962793', '3', 'Que tính nhanh', 1, '[{\"added\": {}}]', 9, 1),
(9, '2024-06-14 17:27:11.971748', '4', 'Máy tính casio', 1, '[{\"added\": {}}]', 9, 1),
(10, '2024-06-14 17:27:35.989039', '5', 'Bút màu sáp', 1, '[{\"added\": {}}]', 9, 1),
(11, '2024-06-14 17:27:51.539306', '6', 'Cọ tô màu', 1, '[{\"added\": {}}]', 9, 1),
(12, '2024-06-14 17:28:04.815288', '7', 'Dập ghim', 1, '[{\"added\": {}}]', 9, 1),
(13, '2024-06-14 17:28:19.412392', '8', 'Cặp sách', 1, '[{\"added\": {}}]', 9, 1),
(14, '2024-06-16 12:54:44.384255', '8', 'Gia de A4', 2, '[{\"changed\": {\"fields\": [\"Name\", \"Image\"]}}]', 9, 1),
(15, '2024-06-16 13:25:19.079096', '9', 'Cuon day in tem doi', 1, '[{\"added\": {}}]', 9, 1),
(16, '2024-06-16 13:29:17.385403', '7', 'Dập ghim', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 1),
(17, '2024-06-16 13:29:32.648079', '6', 'Cọ tô màu', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 1),
(18, '2024-06-16 13:29:51.078097', '5', 'Bút màu sáp', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 1),
(19, '2024-06-16 13:29:57.628870', '4', 'Máy tính casio', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 1),
(20, '2024-06-16 13:30:06.133687', '3', 'Que tính nhanh', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 1),
(21, '2024-06-16 13:30:12.756884', '2', 'Sách kẻ ngang', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 1),
(22, '2024-06-16 13:30:41.080974', '1', 'Tẩy siêu trắng', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 9, 1),
(23, '2024-06-17 15:47:05.684149', '3', 'nguyen xuan phong 123', 1, '[{\"added\": {}}]', 11, 1),
(24, '2024-06-17 15:47:45.287798', '3', '0001', 1, '[{\"added\": {}}]', 12, 1),
(25, '2024-06-17 15:48:40.926997', '1', '20 x Tẩy siêu trắng', 1, '[{\"added\": {}}]', 13, 1),
(26, '2024-06-17 15:48:52.355002', '2', '11 x Sách kẻ ngang', 1, '[{\"added\": {}}]', 13, 1),
(27, '2024-06-17 16:38:57.881912', '3', '11 x Que tính nhanh', 1, '[{\"added\": {}}]', 13, 1),
(28, '2024-06-18 18:36:00.677150', '4', '2 x Cọ tô màu', 1, '[{\"added\": {}}]', 13, 1),
(29, '2024-06-18 18:58:50.408827', '9', 'Cuon day in tem doi', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(30, '2024-06-18 18:58:58.464253', '9', 'Cuon day in tem doi', 2, '[]', 9, 1),
(31, '2024-06-18 18:59:06.457898', '7', 'Dập ghim', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(32, '2024-06-18 18:59:15.345968', '6', 'Cọ tô màu', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(33, '2024-06-18 18:59:21.698980', '5', 'Bút màu sáp', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(34, '2024-06-18 18:59:30.075278', '4', 'Máy tính casio', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(35, '2024-06-18 18:59:39.316090', '3', 'Que tính nhanh', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(36, '2024-06-18 18:59:45.290252', '2', 'Sách kẻ ngang', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(37, '2024-06-18 18:59:50.567142', '1', 'Tẩy siêu trắng', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(38, '2024-06-18 19:00:24.000418', '3', '0001', 2, '[]', 12, 1),
(39, '2024-06-18 19:00:32.222854', '2', '0002', 2, '[{\"changed\": {\"fields\": [\"Transaction id\"]}}]', 12, 1),
(40, '2024-06-18 19:00:54.057946', '4', '1 x Cọ tô màu', 2, '[{\"changed\": {\"fields\": [\"Quantity\"]}}]', 13, 1),
(41, '2024-06-18 19:00:57.611264', '3', '1 x Que tính nhanh', 2, '[{\"changed\": {\"fields\": [\"Quantity\"]}}]', 13, 1),
(42, '2024-06-18 19:01:00.937992', '2', '1 x Sách kẻ ngang', 2, '[{\"changed\": {\"fields\": [\"Quantity\"]}}]', 13, 1),
(43, '2024-06-18 19:01:04.717501', '1', '2 x Tẩy siêu trắng', 2, '[{\"changed\": {\"fields\": [\"Quantity\"]}}]', 13, 1),
(44, '2024-06-19 00:02:30.623222', '9', 'Cuon day in tem doi', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(45, '2024-06-19 00:03:52.021326', '8', 'Gia de A4', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 9, 1),
(46, '2024-06-19 03:13:41.826825', '4', 'phong01', 1, '[{\"added\": {}}]', 4, 1),
(47, '2024-06-19 03:15:49.685833', '5', 'phongnxp01', 1, '[{\"added\": {}}]', 4, 1),
(48, '2024-06-19 03:16:06.962303', '5', 'phongnxp01', 2, '[]', 4, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(11, 'app', 'customer'),
(10, 'app', 'oder'),
(7, 'app', 'oderitem'),
(12, 'app', 'order'),
(13, 'app', 'orderitem'),
(9, 'app', 'product'),
(8, 'app', 'shippingaddress'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-06-05 02:12:34.482817'),
(2, 'auth', '0001_initial', '2024-06-05 02:12:34.929197'),
(3, 'admin', '0001_initial', '2024-06-05 02:12:35.034643'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-06-05 02:12:35.041046'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-06-05 02:12:35.048685'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-06-05 02:12:35.105522'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-06-05 02:12:35.185943'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-06-05 02:12:35.204246'),
(9, 'auth', '0004_alter_user_username_opts', '2024-06-05 02:12:35.210882'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-06-05 02:12:35.245823'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-06-05 02:12:35.256552'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-06-05 02:12:35.262158'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-06-05 02:12:35.273861'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-06-05 02:12:35.278685'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-06-05 02:12:35.295672'),
(16, 'auth', '0011_update_proxy_permissions', '2024-06-05 02:12:35.307380'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-06-05 02:12:35.312036'),
(18, 'sessions', '0001_initial', '2024-06-05 02:12:35.345570'),
(19, 'app', '0001_initial', '2024-06-07 15:15:46.593382'),
(20, 'app', '0002_remove_oderitem_oder_remove_shippingaddress_oder_and_more', '2024-06-07 15:36:41.716954'),
(21, 'app', '0003_alter_customer_email_alter_customer_name_and_more', '2024-06-14 16:27:00.639052'),
(22, 'app', '0004_product_image', '2024-06-16 12:43:33.657605'),
(23, 'app', '0005_alter_orderitem_order_alter_orderitem_product', '2024-06-17 17:05:53.357772'),
(24, 'app', '0006_alter_orderitem_order_alter_orderitem_product', '2024-06-18 18:27:16.842397');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('f9y1lm39uh98eqgct3q7v536thr0omke', '.eJxVjMsOwiAQAP-FsyGUV8Gj934DWXa3UjU0Ke3J-O-GpAe9zkzmLRIce0lH4y0tJK5Ci8svy4BPrl3QA-p9lbjWfVuy7Ik8bZPTSvy6ne3foEArfcveEBCCsQrRkWJDHGbM0aGxw-g1cOZMkR1YrbyNYXSWg4rz4LQF8fkCDvg4Xg:1sFbiW:1UgKKjD3ejMPad4N2RXtpFkoOssTwkNdqNe8bdQDIWQ', '2024-06-21 15:41:24.825451'),
('i3dpjgctp11dun57eyihjozz5q0fpn91', '.eJxVjE0OwiAYBe_C2hBAQsGle89Avj-kamhS2lXj3bVJF7p9M_M2lWFdal67zHlkdVFWnX43BHpK2wE_oN0nTVNb5hH1ruiDdn2bWF7Xw_07qNDrt4ZoApbkbTLGO2RLZMGhJeQhWhJjhCAlMl4CxzTEMxAVH0osDlNh9f4A7_I4vA:1sJlme:eAHHP5FlxmHpFkTzR-QRzUo6d06bPrx2V9_ANTEuUCQ', '2024-07-03 03:14:52.967275'),
('ov8m69fv0dg48piya2xwnd1v0ftgvezm', '.eJxVjE0OwiAYBe_C2hBAQsGle89Avj-kamhS2lXj3bVJF7p9M_M2lWFdal67zHlkdVFWnX43BHpK2wE_oN0nTVNb5hH1ruiDdn2bWF7Xw_07qNDrt4ZoApbkbTLGO2RLZMGhJeQhWhJjhCAlMl4CxzTEMxAVH0osDlNh9f4A7_I4vA:1sFZnw:D1_mZQwPY69bf1s8RSBa4fxiofOEtwSQIdZ5Jd-8zL8', '2024-06-21 13:38:52.841361');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `app_customer`
--
ALTER TABLE `app_customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `app_order`
--
ALTER TABLE `app_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_order_customer_id_7c27c407_fk_app_customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `app_orderitem`
--
ALTER TABLE `app_orderitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_orderitem_order_id_41257a1b_fk_app_order_id` (`order_id`),
  ADD KEY `app_orderitem_product_id_5f40ddb0_fk_app_product_id` (`product_id`);

--
-- Chỉ mục cho bảng `app_product`
--
ALTER TABLE `app_product`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `app_shippingaddress`
--
ALTER TABLE `app_shippingaddress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Chỉ mục cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Chỉ mục cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Chỉ mục cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Chỉ mục cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Chỉ mục cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Chỉ mục cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Chỉ mục cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `app_customer`
--
ALTER TABLE `app_customer`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `app_order`
--
ALTER TABLE `app_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `app_orderitem`
--
ALTER TABLE `app_orderitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `app_product`
--
ALTER TABLE `app_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `app_shippingaddress`
--
ALTER TABLE `app_shippingaddress`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `app_customer`
--
ALTER TABLE `app_customer`
  ADD CONSTRAINT `app_customer_user_id_e6e52921_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `app_order`
--
ALTER TABLE `app_order`
  ADD CONSTRAINT `app_order_customer_id_7c27c407_fk_app_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`id`);

--
-- Các ràng buộc cho bảng `app_orderitem`
--
ALTER TABLE `app_orderitem`
  ADD CONSTRAINT `app_orderitem_order_id_41257a1b_fk_app_order_id` FOREIGN KEY (`order_id`) REFERENCES `app_order` (`id`),
  ADD CONSTRAINT `app_orderitem_product_id_5f40ddb0_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`);

--
-- Các ràng buộc cho bảng `app_shippingaddress`
--
ALTER TABLE `app_shippingaddress`
  ADD CONSTRAINT `app_shippingaddress_order_id_220f1517_fk_app_order_id` FOREIGN KEY (`order_id`) REFERENCES `app_order` (`id`);

--
-- Các ràng buộc cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Các ràng buộc cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Các ràng buộc cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Các ràng buộc cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
