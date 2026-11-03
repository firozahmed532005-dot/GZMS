# Genius Zone Model School — Management System Foundation

Bilingual (Bangla/English), lightweight PHP + MySQL starter foundation for academic session 2026.

## Important hosting note
000webhost has been discontinued. This project targets standard PHP 8.1+ and MySQL/MariaDB shared hosting. Before uploading, choose an active host that supports PHP, MySQL, HTTPS, and phpMyAdmin. Update `config/config.php` with the host's database credentials.

## Setup
1. Create a MySQL database and database user in your hosting control panel.
2. Import `database/school.sql` using phpMyAdmin.
3. Upload the project contents to your domain's document root (`public_html`).
4. Edit `config/config.php` and set database credentials, `APP_URL`, and a long random `APP_KEY`.
5. Ensure `uploads/` is writable by PHP (usually 755; follow host guidance).
6. Visit `/install.php` once to create the first administrator, then delete `install.php`.
7. Sign in at `/login.php`.

## Default modules in this foundation
- Secure session-based login with role checks
- Admin dashboard
- Teacher, student, class/section, subject, guardian, and admission database tables
- Teacher and student attendance tables
- Exams, rooms, seat allocations, and admit-card data tables
- Notification queue for future email / WhatsApp integration
- Bilingual interface strings and responsive lightweight layout

## Security notes
- Change `APP_KEY` before deployment.
- Use HTTPS.
- Delete `install.php` immediately after creating the administrator.
- Do not store plain-text passwords; this foundation uses `password_hash()`.
- Uploaded files must be validated by MIME type and size in the application before enabling public uploads.
- WhatsApp Cloud API and SMTP credentials should be configured server-side only. Never put secrets in JavaScript or public files.
- The notification queue is a database foundation; sending WhatsApp/email requires credentials and a compliant WhatsApp Business setup.
