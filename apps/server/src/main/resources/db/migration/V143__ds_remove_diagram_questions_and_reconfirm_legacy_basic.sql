-- Remove early data-structure image/diagram questions so they can be
-- re-imported manually with controlled assets later. Also keep legacy
-- non-authorized questions normalized to BASIC difficulty.

CREATE TEMPORARY TABLE target_ds_manual_reimport_questions (
    id UUID PRIMARY KEY
);

INSERT INTO target_ds_manual_reimport_questions (id) VALUES
('00000000-0000-0000-0000-000000041033'),
('00000000-0000-0000-0000-000000048016'),
('00000000-0000-0000-0000-000000059032'),
('00000000-0000-0000-0000-000000059033'),
('00000000-0000-0000-0000-000000059037'),
('00000000-0000-0000-0000-000000059039'),
('00000000-0000-0000-0000-000000059042'),
('00000000-0000-0000-0000-000000060013'),
('00000000-0000-0000-0000-000000061002'),
('00000000-0000-0000-0000-000000062024'),
('00000000-0000-0000-0000-000000063020'),
('00000000-0000-0000-0000-000000063028'),
('00000000-0000-0000-0000-000000063030'),
('00000000-0000-0000-0000-000000064006'),
('00000000-0000-0000-0000-000000064008'),
('00000000-0000-0000-0000-000000064024'),
('00000000-0000-0000-0000-000000064030'),
('00000000-0000-0000-0000-000000065005'),
('00000000-0000-0000-0000-000000065007'),
('00000000-0000-0000-0000-000000065009'),
('00000000-0000-0000-0000-000000065010'),
('00000000-0000-0000-0000-000000065011'),
('00000000-0000-0000-0000-000000065013'),
('00000000-0000-0000-0000-000000065015'),
('00000000-0000-0000-0000-000000065016'),
('00000000-0000-0000-0000-000000065018'),
('00000000-0000-0000-0000-000000065021'),
('00000000-0000-0000-0000-000000065022'),
('00000000-0000-0000-0000-000000065023');

DELETE FROM mistakes
WHERE question_id IN (SELECT id FROM target_ds_manual_reimport_questions);

DELETE FROM exam_attempt_answers
WHERE question_id IN (SELECT id FROM target_ds_manual_reimport_questions);

DELETE FROM exam_paper_questions
WHERE question_id IN (SELECT id FROM target_ds_manual_reimport_questions);

DELETE FROM practice_attempts
WHERE question_id IN (SELECT id FROM target_ds_manual_reimport_questions);

DELETE FROM questions
WHERE id IN (SELECT id FROM target_ds_manual_reimport_questions);

UPDATE questions q
SET difficulty = 'BASIC',
    updated_at = CURRENT_TIMESTAMP
WHERE q.status = 'PUBLISHED'
  AND q.review_status = 'APPROVED'
  AND q.difficulty <> 'BASIC'
  AND NOT EXISTS (
      SELECT 1
      FROM question_tag_relations qtr
      JOIN question_tags tag ON tag.id = qtr.tag_id
      WHERE qtr.question_id = q.id
        AND tag.name IN ('本节试题精选', '授权原题')
  );

DROP TABLE target_ds_manual_reimport_questions;
