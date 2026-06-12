-- Fix: add 第3章存储系统 chapter tag and assign to all Ch3 questions (V77 3.2 + V78 3.1/3.2)

INSERT INTO question_tags (id, name, created_at)
SELECT '00000000-0000-0000-0000-000000079001', '第3章存储系统', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM question_tags WHERE name = '第3章存储系统');

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT q.id, tag.id
FROM questions q
JOIN chapters c ON c.id = q.chapter_id
JOIN question_tags tag ON tag.name = '第3章存储系统'
WHERE c.code = 'CO_CACHE'
  AND NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = q.id AND r.tag_id = tag.id
  );
