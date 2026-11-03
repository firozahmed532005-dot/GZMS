<?php
require_once __DIR__ . '/includes/bootstrap.php';
if (!empty($_SESSION['user'])) { header('Location: ' . APP_URL . '/admin/dashboard.php'); exit; }
header('Location: ' . APP_URL . '/login.php'); exit;
