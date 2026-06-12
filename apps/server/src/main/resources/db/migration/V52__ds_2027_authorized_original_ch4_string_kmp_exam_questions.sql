-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 4: 4.2.4/4.2.5 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH4-B

CREATE TABLE ds_2027_original_ch4_b_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_year INTEGER NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch4_b_import (
    num, id, difficulty, source_year, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(10, '00000000-0000-0000-0000-000000052010', 'MEDIUM', 2015, 'pp.130,132-133', '【2015 统考真题】已知字符串 s 为 ''abaabaabacacaabaabcc''，模式串 t 为 ''abaabc''。采用 KMP 算法进行匹配，第一次出现“失配”（s[i]≠t[j]）时，i=j=5，则下次开始匹配时，i 和 j 的值分别是（ ）。', 'C', '由题中“失配 s[i]≠t[j] 时，i=j=5”可知，题中的主串和模式串的位置都是从 0 开始的。按照 next 数组生成算法，对于 t 有 next[5]=2。发生失配时，主串指针 i 不变，模式串指针 j 回退到 next[j] 位置重新比较，因此 i=5，j=2。', 'i=1，j=0', 'i=5，j=0', 'i=5，j=2', 'i=6，j=2'),
(11, '00000000-0000-0000-0000-000000052011', 'MEDIUM', 2019, 'pp.130,133', '【2019 统考真题】设主串 T=''abaabaabcabaabc''，模式串 S=''abaabc''，采用 KMP 算法进行模式匹配，到匹配成功时为止，在匹配过程中进行的单个字符间的比较次数是（ ）。', 'B', '假设位序从 0 开始，按照 next 数组生成算法，模式串 S 的 next 数组为 -1,0,0,1,1,2。第一趟连续比较 6 次，在模式串的 5 号位和主串的 5 号位匹配失败，下一次比较从模式串的 2 号位和主串的 5 号位开始；第二趟比较 4 次后匹配成功。因此单个字符的比较次数为 10 次。', '9', '10', '12', '15'),
(12, '00000000-0000-0000-0000-000000052012', 'HARD', 2024, 'pp.130,133', '【2024 统考真题】KMP 算法使用修正后的 next 数组进行模式匹配，模式串为 S=''aabaab''，当主串的某个字符与 S 的某个字符失配时，S 向右滑动的最长距离是（ ）。', 'A', '假设位序从 0 开始，计算出 nextval 数组。当比较到 S[j] 失配时，模式串向右滑动的距离为 j-nextval[j]（0≤j≤5）。由表可知，当 j=4 时向右滑动的距离最长，此时距离为 5。', '5', '4', '3', '2');

INSERT INTO questions (
    id, subject_id, chapter_id, type, difficulty, stem, answer, explanation,
    source, source_year, score, status, review_status, review_note,
    stem_format, stem_image_url, reviewed_at, created_at, updated_at
)
SELECT
    CAST(q.id AS UUID),
    s.id,
    c.id,
    'SINGLE_CHOICE',
    q.difficulty,
    q.stem,
    q.answer,
    q.explanation,
    'PAST_EXAM',
    q.source_year,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 4 章 4.2.4/4.2.5 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch4_b_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STRING';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000152', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch4_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000152', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch4_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000152', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch4_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000152', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch4_b_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch4_b_import q
JOIN knowledge_points kp ON kp.code = 'DS_STRING_KMP';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000052701', 'DS-2027-ORIGINAL-CH4-B')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch4_b_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH4-B',
    '第4章串',
    '4.2串的模式匹配',
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容',
    '真题'
)
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_original_ch4_b_import;
