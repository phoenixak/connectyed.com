-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: connectyed
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES
('2uKGNWRUuVKJ6DS7','a:1:{s:11:\"valid_until\";i:1716023998;}',1716044159),
('5uAo9FjE0TXJFqsL','a:1:{s:11:\"valid_until\";i:1716023977;}',1716044138),
('O3LddcRWVeMIhaog','a:1:{s:11:\"valid_until\";i:1716024750;}',1716044911),
('PlRo5HnUUFHvF6yt','a:1:{s:11:\"valid_until\";i:1716024747;}',1716044908),
('qNLaLcdLs7U87YXa','a:1:{s:11:\"valid_until\";i:1716022460;}',1716042621),
('yzoEzX7JXj8sF2mc','a:1:{s:11:\"valid_until\";i:1716023970;}',1716044106);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES
(1,1,21,NULL,'ada','2024-05-17 19:49:01','2024-05-17 19:49:01'),
(2,1,21,NULL,'sd','2024-05-17 19:49:17','2024-05-17 19:49:17'),
(3,1,21,NULL,'aaaaaaaaaaaaaaaaaa','2024-05-17 19:49:22','2024-05-17 19:49:22'),
(4,1,21,NULL,'sds','2024-05-17 19:50:05','2024-05-17 19:50:05'),
(5,1,21,NULL,'ggg','2024-05-17 19:51:07','2024-05-17 19:51:07'),
(6,1,21,NULL,'sss','2024-05-17 19:51:28','2024-05-17 19:51:28'),
(7,1,20,NULL,'sd','2024-05-17 19:52:28','2024-05-17 19:52:28'),
(8,1,20,NULL,'sd','2024-05-17 19:52:52','2024-05-17 19:52:52'),
(9,1,20,NULL,'asd','2024-05-17 19:53:05','2024-05-17 19:53:05'),
(10,1,20,NULL,'dsa','2024-05-17 19:53:10','2024-05-17 19:53:10'),
(11,1,20,NULL,'888','2024-05-17 19:53:15','2024-05-17 19:53:15'),
(12,1,20,NULL,'ttt','2024-05-17 19:53:21','2024-05-17 19:53:21'),
(13,1,20,NULL,'sss','2024-05-17 19:53:40','2024-05-17 19:53:40'),
(14,1,20,NULL,'dds','2024-05-17 19:53:49','2024-05-17 19:53:49'),
(15,1,20,NULL,'sss','2024-05-17 19:54:04','2024-05-17 19:54:04'),
(16,1,19,NULL,'ss','2024-05-17 19:54:55','2024-05-17 19:54:55'),
(17,1,19,NULL,'ds','2024-05-17 19:54:58','2024-05-17 19:54:58'),
(18,1,19,NULL,'a','2024-05-17 19:57:21','2024-05-17 19:57:21'),
(19,1,19,NULL,'sd','2024-05-17 20:02:30','2024-05-17 20:02:30'),
(20,1,19,NULL,'ada deh','2024-05-17 20:17:13','2024-05-17 20:17:13'),
(21,1,3,NULL,'ada','2024-05-17 20:19:11','2024-05-17 20:19:11'),
(22,1,3,NULL,'dddaaa','2024-05-17 20:19:13','2024-05-17 20:19:13'),
(23,1,3,NULL,'diaa','2024-05-17 20:19:18','2024-05-17 20:19:18'),
(24,2,21,NULL,'tau ah','2024-05-17 20:21:27','2024-05-17 20:21:27'),
(25,2,20,NULL,'ooooooooooooooo','2024-05-17 20:55:30','2024-05-17 20:55:30'),
(26,1,27,NULL,'please restore this article','2024-05-18 02:19:22','2024-05-18 02:19:22');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `userable_type` varchar(255) NOT NULL,
  `userable_id` bigint(20) unsigned NOT NULL,
  `likeable_type` varchar(255) NOT NULL,
  `likeable_id` bigint(20) unsigned NOT NULL,
  `is_liked` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`userable_type`,`userable_id`,`likeable_type`,`likeable_id`),
  KEY `likes_userable_type_userable_id_index` (`userable_type`,`userable_id`),
  KEY `likes_likeable_type_likeable_id_index` (`likeable_type`,`likeable_id`),
  KEY `likes_is_liked_index` (`is_liked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES
('user',1,'comment',22,1,'2024-05-17 20:20:26','2024-05-17 20:20:26'),
('user',1,'post',1,1,'2024-05-17 10:51:17','2024-05-17 10:51:17'),
('user',1,'post',21,1,'2024-05-17 10:50:40','2024-05-17 10:50:40'),
('user',1,'post',27,1,'2024-05-18 02:19:03','2024-05-18 02:19:03'),
('user',2,'comment',4,1,'2024-05-17 20:21:32','2024-05-17 20:21:32'),
('user',2,'comment',6,1,'2024-05-17 20:21:31','2024-05-17 20:21:31'),
('user',2,'comment',24,1,'2024-05-17 20:21:34','2024-05-17 20:21:34'),
('user',2,'comment',25,1,'2024-05-17 20:55:33','2024-05-17 20:55:33'),
('user',2,'comment',26,1,'2024-05-18 02:19:47','2024-05-18 02:19:47'),
('user',2,'post',2,1,'2024-05-17 02:56:57','2024-05-17 02:56:57'),
('user',2,'post',3,1,'2024-05-17 07:06:56','2024-05-17 07:06:56'),
('user',2,'post',6,1,'2024-05-17 07:06:59','2024-05-17 07:06:59');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2024_05_14_085007_create_personal_access_tokens_table',1),
(5,'2024_05_15_154546_create_posts_table',1),
(6,'2024_05_17_062309_create_comments_table',2),
(7,'2024_05_17_062322_create_likes_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `post_date` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES
(1,'Adapt Content Based On User Behavior:','sample-post-1','AI can analyze readers\' behavior including how much time they spend on certain topics or posts, the links they click on within the articles and their comments or likes. This information helps in generating more engaging and relatable content. For instance, if a majority of readers spend more time on posts about eco-friendly lifestyle tips, you could create more detailed articles or infographics on that topic.',1,'2024-05-15 16:54:07',NULL,NULL,'2024-05-18 02:18:24'),
(2,'Keyword Research','new-sample-post-2','One of the crucial aspects of SEO is keyword research, which is the practice of identifying common words or phrases that people enter into search engines. AI technology can quickly analyze vast amounts of data related to search volume and competition for various keywords. This helps in selecting the most relevant and impactful keywords for your content, ensuring that it reaches the right audience at the right time.',2,'2024-05-15 17:54:07',NULL,NULL,'2024-05-18 02:18:41'),
(3,'Another New Sample Post','another-new-sample-post','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',1,'2024-05-15 18:54:07',NULL,NULL,NULL),
(4,'Another New Sample Post 2','another-new-sample-post-2','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',2,'2024-05-15 19:54:07',NULL,NULL,NULL),
(5,'Simple Post 101','simple-post-101','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',1,'2024-05-15 19:54:07',NULL,NULL,NULL),
(6,'Simple Post 102','simple-post-102','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',2,'2024-05-15 19:54:07',NULL,NULL,NULL),
(7,'Simple Post 103','simple-post-103','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',1,'2024-05-15 19:54:07',NULL,NULL,NULL),
(8,'Simple Post 104','simple-post-104','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',2,'2024-05-15 19:54:07',NULL,NULL,'2024-05-17 09:49:29'),
(9,'Simple Post 105','simple-post-105','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',1,'2024-05-15 19:54:07',NULL,NULL,NULL),
(10,'Simple Post 106','simple-post-106','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',2,'2024-05-15 19:54:07',NULL,NULL,NULL),
(11,'Simple Post 107','simple-post-107','<p>Test Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',1,'2024-05-15 19:54:07',NULL,NULL,NULL),
(12,'Simple Post 108','simple-post-108','<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>',2,'2024-05-15 19:54:07',NULL,NULL,NULL),
(13,'Curate Personalized Content:','testing','AI can suggest relevant articles, videos, and other content from your blog based on a reader\'s preferences. Let\'s say a reader has shown interest in vegan recipes on your blog; AI tools can identify this pattern. They might then recommend other vegan-related articles or suggest videos demonstrating vegan cooking techniques from your blog. This not only keeps the reader engaged but also enhances their overall experience by providing them with more of what they love.',2,'2024-05-17 15:06:47',NULL,'2024-05-17 08:06:47','2024-05-18 02:18:03'),
(14,'Create Variations of Your Blog Post:','abc','Generate alternative headlines, introductions, and even entire paragraphs to cater to specific audience segments. For example, if your blog post is about \"How to Stay Fit,\" you can create different versions targeting various demographics: one version for busy professionals highlighting quick workout routines, another for parents emphasizing family-friendly fitness activities, and yet another for seniors focusing on low-impact exercises. This way, the same core content can be tailored in a way that resonates with each reader group.',2,'2024-05-17 15:31:33',NULL,'2024-05-17 08:31:33','2024-05-18 02:17:26'),
(15,'Generating Tailored Content','aaa','With AI, you can create multiple versions of a blog post for different target audiences based on their interests and preferences, making sure that everyone finds it interesting and relevant. By using AI-powered writing tools like blog posts generators, you can enter a new era of personalized content creation.',2,'2024-05-17 15:32:18',NULL,'2024-05-17 08:32:18','2024-05-18 02:17:08'),
(16,'Demographics and Interests','aaa','Combining demographic information (like age, location, gender) with expressed interests helps generate more accurate reader profiles. If an 18-year-old female from New York shows interest in Korean skincare routines through her search history and social media activity, AI can tailor skincare-related content towards her preference. This may include Korean skincare product reviews or step-by-step guides for implementing these routines.',2,'2024-05-17 15:33:05',NULL,'2024-05-17 08:33:05','2024-05-18 02:16:53'),
(17,'Social Media Activity:','qqq','Analyzing users\' likes, shares, and follows on various social media platforms provides valuable insight into topics and content styles that resonate with them. For instance, if a user frequently likes and shares articles about sustainable fashion on Facebook or Instagram, AI can infer that they\'re interested in this subject. Consequently, blog posts related to sustainable fashion practices, brands, or trends could be recommended or created for this user.',2,'2024-05-17 15:33:41',NULL,'2024-05-17 08:33:41','2024-05-18 02:16:32'),
(18,'AI and Hyper-Personalized Blogs','test-aaaaa','Artificial Intelligence (AI) can analyze a vast volume of data from user behavior, preferences, and demographics to create comprehensive profiles. This knowledge empowers content creators to craft blog posts that deeply resonate with their target audience.',2,'2024-05-17 15:36:43',NULL,'2024-05-17 08:36:43','2024-05-18 02:16:17'),
(19,'Sentence Rewriter','test-aqqqqqqaaaa','Maintaining originality while ensuring readability and engagement can be a challenging task when creating blog posts. But what if you could refresh your content without losing its original essence? That\'s where a sentence rewriter tool comes in. By intelligently rephrasing sentences, it helps to enhance the overall quality of your content without distorting their original meaning.',2,'2024-05-19 15:40:14',NULL,'2024-05-17 08:40:14','2024-05-18 02:15:58'),
(20,'What are Blog Post Generators?','test','Blog post generators are a type of AI writing tool that use artificial intelligence to make it easier for you to create great content. These tools analyze lots of information to understand how language works and then generate written material that fits the tone, style, and topic you want. They\'re perfect for overcoming writer\'s block!But what\'s the secret behind their magic? Here\'s a simple explanation:',2,'2024-05-17 16:42:17',NULL,'2024-05-17 09:42:17','2024-05-18 00:14:27'),
(21,'The Good Old Tough Days of Blog Writing','dsa','Before AI, writing a blog post was a lot of work. You had to come up with interesting topics that would appeal to your audience, do thorough research to gather relevant information, and then actually write the post while making sure it was free of any mistakes.\n\nThere was also the challenge of catering to an international audience. If you wanted your content to be successful globally, you had to be able to write in multiple languages.',1,'2024-05-17 16:42:54',NULL,'2024-05-17 09:42:54','2024-05-18 00:35:39'),
(22,'Product Description Generator: An Indispensable Tool for E-commerce','ddd','In the competitive world of e-commerce, engaging and compelling product descriptions can be the difference between making a sale or losing a potential customer. These descriptions serve as your digital salesperson, providing crucial information that influences consumer purchasing decisions. To help with this crucial task, a product description generator can be an invaluable resource.',1,'2024-05-17 16:43:07',NULL,'2024-05-17 09:43:07','2024-05-18 02:15:39'),
(23,'Paragraph Generator','tttt','A Paragraph Generator is an AI-driven writing tool designed to make a writer\'s life easier by generating coherent, well-structured paragraphs on any given topic. These innovative tools create custom content that aligns with the target audience’s preferences and interests, enhancing reader engagement. Here\'s a closer look at how these impressive generators operate:',1,'2024-05-19 16:59:51',NULL,'2024-05-17 09:59:51','2024-05-18 02:15:21'),
(24,'Providing suggestions for headlines, subheadings, and article structure','test555','Crafting an attention-grabbing headline, Choosing the right subheadings and arranging your content into an interesting story can be tough without help. AI blog post generators come to the rescue by suggesting captivating headlines, relevant subheadings, and even providing an overall structure for your article to ensure maximum readability and engagement. For example, for a post about \'Healthy Eating\', an AI could suggest a headline like \'The Ultimate Guide to Healthy Eating\', with subheadings like \'Benefits of a Balanced Diet\', \'Easy Healthy Recipes\', etc',2,'2024-05-18 03:21:49',NULL,'2024-05-17 20:21:49','2024-05-18 02:14:41'),
(25,'Deep Learning','aaa','These AI blog writing tools leverage deep learning algorithms to create content that is coherent, logical, and informative. This technology helps them understand complex sentence structures and produce content that is relevant to the topic at hand. Some popular deep learning techniques used in AI writing generators include:',1,'2024-05-18 07:10:20',NULL,'2024-05-18 00:10:20','2024-05-18 02:11:23'),
(26,'How Can AI Blog Post Generators Help with Content Creation?s','how-can-ai-blog-post-generators-help-with-content-creation-s','AI blog post generators are a game changer for content creation. These innovative tools leverage artificial intelligence to automate the writing process, generating high-quality, engaging content in a matter of seconds. Let\'s take a closer look at how AI blog post generators can help with content creation and explore some popular tools like paragraph generator, product description generator, and sentence rewriter.',1,'2024-05-18 07:23:50','2024-05-18 02:12:32','2024-05-18 00:23:50','2024-05-18 02:12:32'),
(27,'deleted 555','asdwwwwww','deleted 555',1,'2024-05-18 07:36:06',NULL,'2024-05-18 00:36:06','2024-05-18 02:12:40'),
(28,'Generating ideas based on keywords or topic input','new-post-11','No more writer\'s block! With an AI blog post generator, all you need to do is input a few keywords or a specific topic. The AI gets to work and generates a list of unique ideas for you to choose from or even construct your entire article around. For example, if you enter \'digital marketing\' as your keyword, the tool might suggest topics like \'The Future of Digital Marketing\' or \'How Digital Marketing affects consumer behavior\'',2,'2024-05-18 08:58:51',NULL,'2024-05-18 01:58:51','2024-05-18 02:05:19');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES
('kJ0MehXu0exfbaoFOmPFwdJwojvYlixiyc61OgTx',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXJ0c1dQUk1MZTJCNjFkOExKSmpwVFIya3FxeVVpM3BVUVJ5am55USI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1716024709),
('mBWeCkCIYHqCOZX5ZbAApLUkNs7Yu1W39UUzRdS1',2,'127.0.0.1','PostmanRuntime/7.36.3','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUlZiMGV5SEprZGUwSlNUT2tOV1F4ZFgySW90Y1RwamdSdFp1VmdSZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1716023064);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'Admin','admin','admin@mail.com',NULL,'$2y$12$ivRRA8z6zYwEK.Vgj1NuEu2ucfjVWVwQQJXBS3z9QAYrzV3rZN5ea','admin',NULL,NULL,NULL),
(2,'Efriel Elyasa','user','user@mail.com',NULL,'$2y$12$ivRRA8z6zYwEK.Vgj1NuEu2ucfjVWVwQQJXBS3z9QAYrzV3rZN5ea',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-18 16:38:18
