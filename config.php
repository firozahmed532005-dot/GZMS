<?php
declare(strict_types=1);

// Copy this file to config/local.php for production overrides, if preferred.
// Never commit or publicly expose real credentials.
define('APP_NAME', 'Genius Zone Model School');
define('APP_URL', 'https://your-domain.example'); // No trailing slash
define('APP_KEY', 'CHANGE-THIS-TO-A-LONG-RANDOM-SECRET-BEFORE-DEPLOYMENT');
define('APP_ENV', 'production'); // production or development
define('DEFAULT_LANGUAGE', 'bn');
define('ACADEMIC_SESSION', '2026');

define('DB_HOST', 'localhost');
define('DB_NAME', 'your_database_name');
define('DB_USER', 'your_database_user');
define('DB_PASS', 'your_database_password');

date_default_timezone_set('Asia/Dhaka');

if (APP_ENV === 'production') {
    ini_set('display_errors', '0');
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', '1');
    error_reporting(E_ALL);
}
