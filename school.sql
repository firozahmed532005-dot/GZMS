-- Import this file after selecting the database created in your hosting panel.

CREATE TABLE users (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(150) NOT NULL,
 email VARCHAR(190) NOT NULL UNIQUE,
 phone VARCHAR(30) NULL,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('admin','teacher','student','parent') NOT NULL,
 status ENUM('active','inactive','pending') NOT NULL DEFAULT 'active',
 last_login_at DATETIME NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE teachers (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id BIGINT UNSIGNED NULL UNIQUE,
 teacher_code VARCHAR(40) NOT NULL UNIQUE,
 full_name VARCHAR(150) NOT NULL,
 email VARCHAR(190) NULL,
 phone VARCHAR(30) NULL,
 gender ENUM('male','female','other') NULL,
 date_of_birth DATE NULL,
 qualification VARCHAR(190) NULL,
 designation VARCHAR(100) NULL,
 joining_date DATE NULL,
 address TEXT NULL,
 status ENUM('active','inactive') NOT NULL DEFAULT 'active',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE guardians (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(150) NOT NULL,
 relation VARCHAR(50) NULL,
 phone VARCHAR(30) NULL,
 whatsapp_phone VARCHAR(30) NULL,
 email VARCHAR(190) NULL,
 address TEXT NULL,
 whatsapp_consent TINYINT(1) NOT NULL DEFAULT 0,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE classes (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name_bn VARCHAR(100) NOT NULL,
 name_en VARCHAR(100) NOT NULL,
 class_order SMALLINT UNSIGNED NOT NULL,
 academic_session VARCHAR(9) NOT NULL DEFAULT '2026',
 status ENUM('active','inactive') NOT NULL DEFAULT 'active',
 UNIQUE KEY uq_class_session (name_en, academic_session)
) ENGINE=InnoDB;

CREATE TABLE sections (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 class_id BIGINT UNSIGNED NOT NULL,
 name VARCHAR(50) NOT NULL,
 capacity SMALLINT UNSIGNED NULL,
 UNIQUE KEY uq_section (class_id,name),
 FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE subjects (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 subject_code VARCHAR(30) NULL,
 name_bn VARCHAR(120) NOT NULL,
 name_en VARCHAR(120) NOT NULL,
 class_id BIGINT UNSIGNED NULL,
 FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE students (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id BIGINT UNSIGNED NULL UNIQUE,
 guardian_id BIGINT UNSIGNED NULL,
 student_code VARCHAR(40) NOT NULL UNIQUE,
 roll_no VARCHAR(30) NULL,
 full_name_bn VARCHAR(150) NULL,
 full_name_en VARCHAR(150) NOT NULL,
 gender ENUM('male','female','other') NULL,
 date_of_birth DATE NULL,
 blood_group VARCHAR(5) NULL,
 class_id BIGINT UNSIGNED NULL,
 section_id BIGINT UNSIGNED NULL,
 academic_session VARCHAR(9) NOT NULL DEFAULT '2026',
 admission_date DATE NULL,
 photo_path VARCHAR(255) NULL,
 address TEXT NULL,
 status ENUM('active','inactive','transferred','graduated') NOT NULL DEFAULT 'active',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
 FOREIGN KEY (guardian_id) REFERENCES guardians(id) ON DELETE SET NULL,
 FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE SET NULL,
 FOREIGN KEY (section_id) REFERENCES sections(id) ON DELETE SET NULL,
 INDEX idx_students_class (class_id,section_id,academic_session)
) ENGINE=InnoDB;

CREATE TABLE admission_applications (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 application_no VARCHAR(40) NOT NULL UNIQUE,
 applicant_name_bn VARCHAR(150) NULL,
 applicant_name_en VARCHAR(150) NOT NULL,
 date_of_birth DATE NULL,
 gender ENUM('male','female','other') NULL,
 applying_class_id BIGINT UNSIGNED NULL,
 previous_school VARCHAR(190) NULL,
 guardian_name VARCHAR(150) NOT NULL,
 guardian_phone VARCHAR(30) NOT NULL,
 guardian_whatsapp VARCHAR(30) NULL,
 guardian_email VARCHAR(190) NULL,
 address TEXT NULL,
 photo_path VARCHAR(255) NULL,
 documents_json JSON NULL,
 whatsapp_consent TINYINT(1) NOT NULL DEFAULT 0,
 status ENUM('pending','approved','rejected','waitlisted') NOT NULL DEFAULT 'pending',
 reviewed_by BIGINT UNSIGNED NULL,
 reviewed_at DATETIME NULL,
 rejection_reason TEXT NULL,
 converted_student_id BIGINT UNSIGNED NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (applying_class_id) REFERENCES classes(id) ON DELETE SET NULL,
 FOREIGN KEY (reviewed_by) REFERENCES users(id) ON DELETE SET NULL,
 FOREIGN KEY (converted_student_id) REFERENCES students(id) ON DELETE SET NULL,
 INDEX idx_admission_status (status,created_at)
) ENGINE=InnoDB;

CREATE TABLE teacher_attendance (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 teacher_id BIGINT UNSIGNED NOT NULL,
 attendance_date DATE NOT NULL,
 check_in TIME NULL,
 check_out TIME NULL,
 status ENUM('present','late','absent','leave','half_day') NOT NULL,
 note VARCHAR(255) NULL,
 marked_by BIGINT UNSIGNED NULL,
 UNIQUE KEY uq_teacher_day (teacher_id,attendance_date),
 FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE,
 FOREIGN KEY (marked_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE student_attendance (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 student_id BIGINT UNSIGNED NOT NULL,
 attendance_date DATE NOT NULL,
 status ENUM('present','late','absent','leave') NOT NULL,
 note VARCHAR(255) NULL,
 marked_by BIGINT UNSIGNED NULL,
 UNIQUE KEY uq_student_day (student_id,attendance_date),
 FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
 FOREIGN KEY (marked_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE exams (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 title_bn VARCHAR(150) NULL,
 title_en VARCHAR(150) NOT NULL,
 class_id BIGINT UNSIGNED NOT NULL,
 academic_session VARCHAR(9) NOT NULL DEFAULT '2026',
 start_date DATE NULL,
 end_date DATE NULL,
 admit_card_publish_date DATE NULL,
 status ENUM('draft','published','completed') NOT NULL DEFAULT 'draft',
 FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE exam_subjects (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 exam_id BIGINT UNSIGNED NOT NULL,
 subject_id BIGINT UNSIGNED NOT NULL,
 exam_date DATE NOT NULL,
 start_time TIME NULL,
 duration_minutes SMALLINT UNSIGNED NULL,
 room_label VARCHAR(80) NULL,
 FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE,
 FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE exam_rooms (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 room_name VARCHAR(80) NOT NULL,
 capacity SMALLINT UNSIGNED NOT NULL,
 building VARCHAR(100) NULL,
 UNIQUE KEY uq_room (room_name)
) ENGINE=InnoDB;

CREATE TABLE seat_allocations (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 exam_id BIGINT UNSIGNED NOT NULL,
 student_id BIGINT UNSIGNED NOT NULL,
 exam_room_id BIGINT UNSIGNED NOT NULL,
 seat_number VARCHAR(30) NOT NULL,
 UNIQUE KEY uq_exam_student (exam_id,student_id),
 UNIQUE KEY uq_exam_room_seat (exam_id,exam_room_id,seat_number),
 FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE,
 FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
 FOREIGN KEY (exam_room_id) REFERENCES exam_rooms(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE notification_queue (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 channel ENUM('email','whatsapp','sms') NOT NULL,
 recipient VARCHAR(190) NOT NULL,
 template_key VARCHAR(100) NOT NULL,
 payload_json JSON NULL,
 related_type VARCHAR(60) NULL,
 related_id BIGINT UNSIGNED NULL,
 status ENUM('queued','sent','failed','cancelled') NOT NULL DEFAULT 'queued',
 attempts SMALLINT UNSIGNED NOT NULL DEFAULT 0,
 last_error TEXT NULL,
 scheduled_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 sent_at DATETIME NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_queue_status (status,scheduled_at)
) ENGINE=InnoDB;

CREATE TABLE audit_logs (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id BIGINT UNSIGNED NULL,
 action VARCHAR(100) NOT NULL,
 entity_type VARCHAR(80) NULL,
 entity_id BIGINT UNSIGNED NULL,
 details_json JSON NULL,
 ip_address VARCHAR(45) NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO classes (name_bn,name_en,class_order,academic_session) VALUES
('প্লে','Play',1,'2026'),
('নার্সারি','Nursery',2,'2026'),
('প্রথম শ্রেণি','Class 1',3,'2026'),
('দ্বিতীয় শ্রেণি','Class 2',4,'2026'),
('তৃতীয় শ্রেণি','Class 3',5,'2026'),
('চতুর্থ শ্রেণি','Class 4',6,'2026'),
('পঞ্চম শ্রেণি','Class 5',7,'2026');
