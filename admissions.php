<?php
require_once __DIR__ . '/../includes/bootstrap.php';
require_role(['admin']);
$pageTitle = ($_SESSION['lang'] ?? 'bn') === 'bn' ? 'ভর্তি আবেদন' : 'Admission Applications';
require __DIR__ . '/../includes/header.php';
?>
<h1><?= e($pageTitle) ?></h1>
<div class="card"><p class="muted">এই মডিউলের ডেটাবেস টেবিল তৈরি আছে। পরবর্তী ধাপে CRUD, ফর্ম, সার্চ, রিপোর্ট ও অনুমোদন প্রক্রিয়া যুক্ত হবে।</p></div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
