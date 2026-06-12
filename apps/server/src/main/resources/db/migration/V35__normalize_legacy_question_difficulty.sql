-- Normalize legacy generated/rewritten questions after switching to the
-- authorized original-question import strategy.

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000035701', '历史非精选题已降级简单')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- DS-2027-009 was created from section-selected exercise areas before the
-- authorization confirmation. Keep it outside the legacy downgrade set.
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT qtr.question_id, tag.id
FROM question_tag_relations qtr
JOIN question_tags batch_tag ON batch_tag.id = qtr.tag_id
JOIN question_tags tag ON tag.name = '本节试题精选'
WHERE batch_tag.name = 'DS-2027-009'
  AND NOT EXISTS (
      SELECT 1 FROM question_tag_relations existing
      WHERE existing.question_id = qtr.question_id
        AND existing.tag_id = tag.id
  );

UPDATE questions q
SET difficulty = 'BASIC',
    updated_at = CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM question_tag_relations qtr
    JOIN question_tags tag ON tag.id = qtr.tag_id
    WHERE qtr.question_id = q.id
      AND tag.name IN ('本节试题精选', '授权原题')
);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT q.id, tag.id
FROM questions q
JOIN question_tags tag ON tag.name = '历史非精选题已降级简单'
WHERE NOT EXISTS (
    SELECT 1
    FROM question_tag_relations qtr
    JOIN question_tags keep_tag ON keep_tag.id = qtr.tag_id
    WHERE qtr.question_id = q.id
      AND keep_tag.name IN ('本节试题精选', '授权原题')
)
AND NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = q.id
      AND existing.tag_id = tag.id
);
