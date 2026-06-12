-- Normalize literal escape sequences introduced by later authorized imports
-- after V38, so code snippets and enumerated stems render as real lines.

UPDATE questions
SET stem = REPLACE(REPLACE(stem, '\"', '"'), '\n', '
'),
    explanation = REPLACE(REPLACE(explanation, '\"', '"'), '\n', '
'),
    updated_at = CURRENT_TIMESTAMP
WHERE stem LIKE '%\n%'
   OR stem LIKE '%\"%'
   OR explanation LIKE '%\n%'
   OR explanation LIKE '%\"%';

UPDATE question_options
SET content = REPLACE(REPLACE(content, '\"', '"'), '\n', '
')
WHERE content LIKE '%\n%'
   OR content LIKE '%\"%';
