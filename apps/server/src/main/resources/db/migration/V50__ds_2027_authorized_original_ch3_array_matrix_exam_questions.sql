-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.4.5/3.4.6 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-I

CREATE TABLE ds_2027_original_ch3_i_import (
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

INSERT INTO ds_2027_original_ch3_i_import (
    num, id, difficulty, source_year, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(11, '00000000-0000-0000-0000-000000050011', 'MEDIUM', 2016, 'pp.117-119', '【2016 统考真题】有一个 100 阶的三对角矩阵 M，其元素 mij（1≤i,j≤100）按行优先依次压缩存入下标从 0 开始的一维数组 N 中。元素 m30,30 在 N 中的下标是（ ）。', 'B', '三对角矩阵按行优先压缩存储时，可计算矩阵 A 中 3 条对角线上的元素 aij（1≤i,j≤n，|i-j|≤1）在一维数组中存放的下标为 k=2i+j-3。代入 i=30、j=30 得 k=87。也可观察：第 1 行有 2 个元素，m30,30 之前有 28 行各 3 个元素，且 m30,30 之前还有 m30,29 一个元素，所以其下标为 2+28*3+2-1=87。', '86', '87', '88', '89'),
(12, '00000000-0000-0000-0000-000000050012', 'BASIC', 2017, 'pp.117,119', '【2017 统考真题】适用于压缩存储稀疏矩阵的两种存储结构是（ ）。', 'A', '三元组表的结点存储行、列和值三种信息，是主要用于存储稀疏矩阵的一种数据结构。十字链表将行单链表和列单链表结合起来存储稀疏矩阵。邻接矩阵空间复杂度较高，不适合存储稀疏矩阵；二叉链表可用于表示树或森林。', '三元组表和十字链表', '三元组表和邻接矩阵', '十字链表和二叉链表', '邻接矩阵和十字链表'),
(13, '00000000-0000-0000-0000-000000050013', 'MEDIUM', 2018, 'pp.117,119', '【2018 统考真题】设有一个 12×12 阶对称矩阵 M，将其上三角部分的元素 mij（1≤i≤j≤12）按行优先存入 C 语言的一维数组 N 中，元素 m6,6 在 N 中的下标是（ ）。', 'A', '在 C 语言中，数组 N 的下标从 0 开始。第一个元素 m1,1 对应存入 N0。矩阵 M 的第 1 行有 12 个元素，第 2 行有 11 个，第 3 行有 10 个，第 4 行有 9 个，第 5 行有 8 个，所以 m6,6 是第 12+11+10+9+8+1=51 个元素，下标应为 50。', '50', '51', '55', '66'),
(14, '00000000-0000-0000-0000-000000050014', 'HARD', 2020, 'pp.117,119', '【2020 统考真题】将一个 10×10 阶对称矩阵 M 的上三角部分的元素 mij（1≤i≤j≤10）按列优先存入 C 语言的一维数组 N 中，元素 m7,2 在 N 中的下标是（ ）。', 'C', '上三角矩阵按列优先存储时，先存储只有 1 个元素的第 1 列，再存储有 2 个元素的第 2 列，以此类推。m7,2 位于左下角，对应右上角元素 m2,7。在 m2,7 之前，第 1 到第 6 列共存有 1+2+3+4+5+6=21 个元素，第 7 列中 m1,7 在其前面，所以前面共有 22 个元素。数组下标从 0 开始，因此 m7,2 在 N 中的下标为 22。', '15', '16', '22', '23'),
(15, '00000000-0000-0000-0000-000000050015', 'MEDIUM', 2021, 'pp.117,119', '【2021 统考真题】二维数组 A 按行优先方式存储，每个元素占用 1 个存储单元。若元素 A[0][0] 的存储地址是 100，A[3][3] 的存储地址是 220，则元素 A[5][5] 的存储地址是（ ）。', 'B', '二维数组 A 按行优先存储。由 A[0][0] 和 A[3][3] 的地址可知，A[3][3] 是二维数组 A 中的第 121 个元素。假设每行有 n 个元素，则 3n+4=121，得 n=39。因此 A[5][5] 的存储地址为 100+39*5+6-1=300。', '295', '300', '301', '306'),
(16, '00000000-0000-0000-0000-000000050016', 'MEDIUM', 2023, 'pp.117,119', '【2023 统考真题】若采用三元组表存储结构存储稀疏矩阵 M，则除三元组表外，下列数据中还需要保存的是（ ）。
I. M 的行数
II. M 中包含非零元素的行数
III. M 的列数
IV. M 中包含非零元素的列数', 'A', '用三元组表存储稀疏矩阵 M 时，每个非零元素都由三元组（行标、列标、关键字值）组成。但是，仅通过三元组表中的元素无法判断稀疏矩阵 M 的大小，因此还要保存 M 的行数和列数。此外，还可以保存 M 的非零元素个数。', '仅 I、III', '仅 I、IV', '仅 II、IV', 'I、II、III、IV');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 3 章 3.4.5/3.4.6 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch3_i_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_ARRAY_MATRIX';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000150', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_i_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000150', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_i_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000150', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_i_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000150', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_i_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_i_import q
JOIN knowledge_points kp ON kp.code = 'DS_ARRAY_MATRIX_COMPRESS';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000050701', 'DS-2027-ORIGINAL-CH3-I')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_i_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-I',
    '第3章栈队列和数组',
    '3.4数组和特殊矩阵',
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容'
)
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_original_ch3_i_import;
