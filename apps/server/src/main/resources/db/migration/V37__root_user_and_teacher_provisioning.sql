ALTER TABLE app_user_roles DROP CONSTRAINT chk_app_user_roles_role;

ALTER TABLE app_user_roles
    ADD CONSTRAINT chk_app_user_roles_role
        CHECK (role IN ('STUDENT', 'TEACHER', 'AUTHOR', 'REVIEWER', 'ADMIN', 'ROOT'));

UPDATE app_users
SET display_name = '超级用户',
    password_hash = '{noop}0516cyb123',
    updated_at = CURRENT_TIMESTAMP
WHERE username = 'root';

INSERT INTO app_users (id, username, display_name, password_hash, created_at, updated_at)
SELECT
    '00000000-0000-0000-0000-000000000999',
    'root',
    '超级用户',
    '{noop}0516cyb123',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1 FROM app_users WHERE username = 'root'
);

INSERT INTO app_user_roles (user_id, role, created_at)
SELECT id, role, CURRENT_TIMESTAMP
FROM app_users
CROSS JOIN (VALUES ('ROOT'), ('ADMIN'), ('TEACHER')) AS root_roles(role)
WHERE username = 'root'
  AND NOT EXISTS (
      SELECT 1 FROM app_user_roles existing
      WHERE existing.user_id = app_users.id AND existing.role = root_roles.role
  );
