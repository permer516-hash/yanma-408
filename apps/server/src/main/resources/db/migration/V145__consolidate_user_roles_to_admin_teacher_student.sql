ALTER TABLE app_user_roles DROP CONSTRAINT chk_app_user_roles_role;

DELETE FROM app_user_roles
WHERE role IN ('ROOT', 'AUTHOR', 'REVIEWER');

ALTER TABLE app_user_roles
    ADD CONSTRAINT chk_app_user_roles_role
        CHECK (role IN ('ADMIN', 'TEACHER', 'STUDENT'));

ALTER TABLE question_draft_review_tasks DROP CONSTRAINT chk_question_draft_review_role;

UPDATE question_draft_review_tasks
SET reviewer_role = 'ADMIN'
WHERE reviewer_role IN ('AUTHOR', 'REVIEWER');

ALTER TABLE question_draft_review_tasks
    ADD CONSTRAINT chk_question_draft_review_role
        CHECK (reviewer_role = 'ADMIN');
