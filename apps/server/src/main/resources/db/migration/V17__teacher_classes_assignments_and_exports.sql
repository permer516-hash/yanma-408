CREATE TABLE teacher_classes (
    id UUID PRIMARY KEY,
    teacher_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    name VARCHAR(80) NOT NULL,
    course_name VARCHAR(80) NOT NULL,
    description TEXT,
    status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_teacher_classes_status
        CHECK (status IN ('ACTIVE', 'ARCHIVED'))
);

CREATE TABLE teacher_class_students (
    class_id UUID NOT NULL REFERENCES teacher_classes(id) ON DELETE CASCADE,
    student_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (class_id, student_id)
);

CREATE TABLE teacher_task_assignments (
    id UUID PRIMARY KEY,
    class_id UUID NOT NULL REFERENCES teacher_classes(id) ON DELETE CASCADE,
    teacher_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    title VARCHAR(128) NOT NULL,
    subject_code VARCHAR(64) NOT NULL,
    task_type VARCHAR(32) NOT NULL,
    target_count INTEGER NOT NULL,
    estimated_minutes INTEGER NOT NULL,
    priority VARCHAR(32) NOT NULL,
    task_date DATE NOT NULL,
    recurrence_rule VARCHAR(32) NOT NULL DEFAULT 'NONE',
    reminder_time TIME,
    assigned_count INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_teacher_task_assignments_count
        CHECK (assigned_count >= 0)
);

ALTER TABLE study_plan_tasks
    ADD COLUMN teacher_assignment_id UUID REFERENCES teacher_task_assignments(id) ON DELETE SET NULL;

CREATE INDEX idx_teacher_classes_teacher ON teacher_classes(teacher_id, status);
CREATE INDEX idx_teacher_class_students_student ON teacher_class_students(student_id);
CREATE INDEX idx_teacher_task_assignments_class ON teacher_task_assignments(class_id, created_at);
CREATE INDEX idx_study_plan_tasks_teacher_assignment ON study_plan_tasks(teacher_assignment_id);

INSERT INTO teacher_classes (
    id, teacher_id, name, course_name, description, status, created_at, updated_at
) VALUES (
    '00000000-0000-0000-0000-000000001701',
    '00000000-0000-0000-0000-000000000001',
    '默认 408 班级',
    '408 综合',
    'MVP 默认班级，用于教师端学生范围和任务下发演示。',
    'ACTIVE',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

INSERT INTO teacher_class_students (class_id, student_id, created_at)
SELECT '00000000-0000-0000-0000-000000001701', id, CURRENT_TIMESTAMP
FROM app_users
WHERE EXISTS (
    SELECT 1
    FROM app_user_roles
    WHERE app_user_roles.user_id = app_users.id
      AND app_user_roles.role = 'STUDENT'
);
