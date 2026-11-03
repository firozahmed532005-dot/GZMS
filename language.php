<?php
require_once __DIR__ . '/includes/bootstrap.php';
$lang = $_GET['lang'] ?? 'bn';
if (in_array($lang, ['bn','en'], true)) $_SESSION['lang'] = $lang;
$back = $_SERVER['HTTP_REFERER'] ?? (APP_URL . '/admin/dashboard.php');
header('Location: ' . $back); exit;
