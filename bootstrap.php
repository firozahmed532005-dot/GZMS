<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../config/database.php';

if (session_status() !== PHP_SESSION_ACTIVE) {
    $secure = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off');
    session_set_cookie_params([
        'lifetime' => 0, 'path' => '/', 'secure' => $secure,
        'httponly' => true, 'samesite' => 'Lax'
    ]);
    session_start();
}

function e(?string $value): string {
    return htmlspecialchars($value ?? '', ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
function csrf_token(): string {
    if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32));
    return $_SESSION['csrf'];
}
function verify_csrf(): void {
    $sent = $_POST['csrf'] ?? '';
    if (!is_string($sent) || !hash_equals($_SESSION['csrf'] ?? '', $sent)) {
        http_response_code(419); exit('Invalid request token. Please go back and try again.');
    }
}
function require_login(): void {
    if (empty($_SESSION['user'])) {
        header('Location: ' . APP_URL . '/login.php'); exit;
    }
}
function require_role(array $roles): void {
    require_login();
    if (!in_array($_SESSION['user']['role'], $roles, true)) {
        http_response_code(403); exit('Access denied.');
    }
}
function t(string $key): string {
    $lang = $_SESSION['lang'] ?? DEFAULT_LANGUAGE;
    $dict = [
        'bn' => [
            'dashboard'=>'ড্যাশবোর্ড','teachers'=>'শিক্ষক','students'=>'শিক্ষার্থী',
            'classes'=>'শ্রেণি ও শাখা','admissions'=>'ভর্তি আবেদন','attendance'=>'উপস্থিতি',
            'exams'=>'পরীক্ষা','logout'=>'লগআউট','welcome'=>'স্বাগতম',
            'school'=>'জিনিয়াস জোন মডেল স্কুল','session'=>'শিক্ষাবর্ষ'
        ],
        'en' => [
            'dashboard'=>'Dashboard','teachers'=>'Teachers','students'=>'Students',
            'classes'=>'Classes & Sections','admissions'=>'Admissions','attendance'=>'Attendance',
            'exams'=>'Examinations','logout'=>'Logout','welcome'=>'Welcome',
            'school'=>'Genius Zone Model School','session'=>'Academic session'
        ]
    ];
    return $dict[$lang][$key] ?? $key;
}
