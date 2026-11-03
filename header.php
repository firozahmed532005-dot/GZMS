<?php
$pageTitle = $pageTitle ?? t('dashboard');
?>
<!doctype html>
<html lang="<?= e($_SESSION['lang'] ?? 'bn') ?>">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle) ?> | <?= e(APP_NAME) ?></title>
<link rel="stylesheet" href="<?= e(APP_URL) ?>/assets/css/app.css">
</head>
<body>
<header class="topbar">
  <a class="brand" href="<?= e(APP_URL) ?>/admin/dashboard.php"><?= e(APP_NAME) ?></a>
  <nav>
    <a href="<?= e(APP_URL) ?>/language.php?lang=bn">বাংলা</a>
    <a href="<?= e(APP_URL) ?>/language.php?lang=en">English</a>
    <?php if (!empty($_SESSION['user'])): ?>
      <span class="user"><?= e($_SESSION['user']['name']) ?></span>
      <a href="<?= e(APP_URL) ?>/logout.php"><?= e(t('logout')) ?></a>
    <?php endif; ?>
  </nav>
</header>
<div class="layout">
<aside class="sidebar">
  <a href="<?= e(APP_URL) ?>/admin/dashboard.php"><?= e(t('dashboard')) ?></a>
  <a href="<?= e(APP_URL) ?>/admin/teachers.php"><?= e(t('teachers')) ?></a>
  <a href="<?= e(APP_URL) ?>/admin/students.php"><?= e(t('students')) ?></a>
  <a href="<?= e(APP_URL) ?>/admin/classes.php"><?= e(t('classes')) ?></a>
  <a href="<?= e(APP_URL) ?>/admin/admissions.php"><?= e(t('admissions')) ?></a>
  <a href="<?= e(APP_URL) ?>/admin/attendance.php"><?= e(t('attendance')) ?></a>
  <a href="<?= e(APP_URL) ?>/admin/exams.php"><?= e(t('exams')) ?></a>
</aside>
<main class="content">
