<?php
require_once __DIR__ . '/../includes/bootstrap.php';
require_role(['admin']);
$counts = [];
foreach (['teachers'=>'teachers','students'=>'students','classes'=>'classes','admissions'=>'admission_applications'] as $key=>$table) {
    $counts[$key] = (int)db()->query("SELECT COUNT(*) FROM `$table`")->fetchColumn();
}
$pageTitle = t('dashboard');
require __DIR__ . '/../includes/header.php';
?>
<h1><?= e(t('welcome')) ?>, <?= e($_SESSION['user']['name']) ?></h1>
<p class="muted"><?= e(t('school')) ?> · <?= e(t('session')) ?>: <?= e(ACADEMIC_SESSION) ?></p>
<div class="grid">
<?php foreach ($counts as $key=>$count): ?>
<div class="card"><div><?= e(t($key) === $key ? ucfirst($key) : t($key)) ?></div><div class="stat"><?= $count ?></div></div>
<?php endforeach; ?>
</div>
<div class="card"><h2>System foundation / সিস্টেম প্রস্তুতি</h2><p class="muted">Database and role-based login are ready. Feature pages will be implemented module by module.</p></div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
