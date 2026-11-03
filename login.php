<?php
require_once __DIR__ . '/includes/bootstrap.php';
$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();
    $email = trim((string)($_POST['email'] ?? ''));
    $password = (string)($_POST['password'] ?? '');
    $stmt = db()->prepare('SELECT id, full_name, email, password_hash, role, status FROM users WHERE email = ? LIMIT 1');
    $stmt->execute([$email]); $user = $stmt->fetch();
    if ($user && $user['status'] === 'active' && password_verify($password, $user['password_hash'])) {
        session_regenerate_id(true);
        $_SESSION['user'] = ['id'=>(int)$user['id'],'name'=>$user['full_name'],'email'=>$user['email'],'role'=>$user['role']];
        header('Location: ' . APP_URL . '/admin/dashboard.php'); exit;
    }
    $error = 'ইমেইল অথবা পাসওয়ার্ড সঠিক নয়। / Invalid email or password.';
}
$pageTitle = 'Login';
?>
<!doctype html><html lang="bn"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Login | <?= e(APP_NAME) ?></title><link rel="stylesheet" href="<?= e(APP_URL) ?>/assets/css/app.css"></head>
<body><div class="card login-wrap"><h1><?= e(APP_NAME) ?></h1><p class="muted">Admin / Teacher Login</p>
<?php if ($error): ?><div class="notice"><?= e($error) ?></div><?php endif; ?>
<form method="post"><input type="hidden" name="csrf" value="<?= e(csrf_token()) ?>">
<label>Email / ইমেইল</label><input type="email" name="email" required autocomplete="username">
<label>Password / পাসওয়ার্ড</label><input type="password" name="password" required autocomplete="current-password">
<button class="btn" type="submit">Login / প্রবেশ করুন</button></form></div></body></html>
