-- Convert literal escape sequences that came from OCR/manual SQL import into
-- display-friendly text. Future UI rendering also normalizes defensively.

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
