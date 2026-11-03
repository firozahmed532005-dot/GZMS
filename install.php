<?php
require_once __DIR__ . '/includes/bootstrap.php';
$exists = (int)db()->query("SELECT COUNT(*) FROM users WHERE role='admin'")->fetchColumn();
$message = '';
if ($exists > 0) { exit('An administrator already exists. Delete install.php now.'); }
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();
    $name = trim((string)($_POST['name'] ?? ''));
    $email = filter_var(trim((string)($_POST['email'] ?? '')), FILTER_VALIDATE_EMAIL);
    $password = (string)($_POST['password'] ?? '');
    if ($name === '' || !$email || strlen($password) < 12) {
        $message = 'Name, valid email and password of at least 12 characters are required.';
    } else {
        $stmt = db()->prepare("INSERT INTO users (full_name,email,password_hash,role,status) VALUES (?,?,?,'admin','active')");
        $stmt->execute([$name,$email,password_hash($password,PASSWORD_DEFAULT)]);
        exit('Admin created. Delete install.php immediately, then sign in at login.php.');
    }
}
?><!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><link rel="stylesheet" href="assets/css/app.css"><title>Initial Admin Setup</title></head><body><div class="card login-wrap"><h1>Initial administrator</h1><p>Run once only. Delete this file after setup.</p><?php if($message):?><div class="notice"><?=e($message)?></div><?php endif;?><form method="post"><input type="hidden" name="csrf" value="<?=e(csrf_token())?>"><label>Full name</label><input name="name" required><label>Email</label><input type="email" name="email" required><label>Password (minimum 12 characters)</label><input type="password" name="password" minlength="12" required><button class="btn">Create administrator</button></form></div></body></html>
