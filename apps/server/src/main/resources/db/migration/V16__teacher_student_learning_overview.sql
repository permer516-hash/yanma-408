ALTER TABLE app_user_roles DROP CONSTRAINT chk_app_user_roles_role;

ALTER TABLE app_user_roles
    ADD CONSTRAINT chk_app_user_roles_role
        CHECK (role IN ('STUDENT', 'TEACHER', 'AUTHOR', 'REVIEWER', 'ADMIN'));

INSERT INTO app_user_roles (user_id, role, created_at)
SELECT '00000000-0000-0000-0000-000000000001', 'TEACHER', CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1 FROM app_user_roles
    WHERE user_id = '00000000-0000-0000-0000-000000000001' AND role = 'TEACHER'
);
