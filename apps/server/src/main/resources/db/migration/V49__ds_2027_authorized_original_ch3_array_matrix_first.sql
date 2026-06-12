-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.4.5/3.4.6 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-H

CREATE TABLE ds_2027_original_ch3_h_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch3_h_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000049001', 'BASIC', 'pp.116-117', '对特殊矩阵采用压缩存储的主要目的是（ ）。', 'D', '特殊矩阵中含有很多相同元素或零元素，所以可采用压缩存储，以节省存储空间。', '表达变得简单', '对矩阵元素的存取变得简单', '去掉矩阵中的多余元素', '减少不必要的存储空间'),
(2, '00000000-0000-0000-0000-000000049002', 'BASIC', 'pp.116-117', '对 n 阶对称矩阵压缩存储时，需要表长为（ ）的顺序表。', 'C', '只需存储其上三角或下三角部分（含对角线），元素个数为 n+(n-1)+...+1=n(n+1)/2。', 'n/2', 'n*n/2', 'n(n+1)/2', 'n(n-1)/2'),
(3, '00000000-0000-0000-0000-000000049003', 'HARD', 'pp.116-118', '有一个 n×n 的对称矩阵 A，将其下三角部分按行存放在一维数组 B 中，而 A[0][0] 存放于 B[0] 中，则元素 A[i][i] 存放于 B 中的（ ）处。', 'A', '注意矩阵最小下标为 0，数组下标也从 0 开始，矩阵按行优先存储到数组中。将 i=1 代入各选项，只有选项 A 满足 A[1][1] 对应下标 2。', '(i+3)i/2', '(i+1)i/2', '(2n-i+1)i/2', '(2n-i-1)i/2'),
(4, '00000000-0000-0000-0000-000000049004', 'MEDIUM', 'pp.116,118', '在三维数组 A 中，假设每个数组元素的长度为 3 个存储单元，行下标 i 为 0~8，列下标 j 为 0~9，从首地址 SA 开始连续存放。在这种情况下，元素 A[8][5] 的起始地址为（ ）。', 'D', '二维数组按行优先顺序计算地址的公式为 LOC(i,j)=LOC(0,0)+(i*m+j)L，其中 m 是数组列数，L 是每个数组元素长度。这里 m=10，L=3，因此 LOC(8,5)=SA+(8*10+5)*3=SA+255。', 'SA+144', 'SA+255', 'SA+144', 'SA+222'),
(5, '00000000-0000-0000-0000-000000049005', 'HARD', 'pp.116,118', '二维数组 A 按行优先存储，其中每个元素占 1 个存储单元。若 A[1][1] 的存储地址为 420，A[3][3] 的存储地址为 446，则 A[5][5] 的存储地址为（ ）。', 'A', '二维数组按行优先存储。由 A[3][3] 地址为 446 可知 A[3][1] 地址为 444，又 A[1][1] 地址为 420，二者正好相差 2 行，故矩阵列数为 12。A[5][3] 与 A[3][3] 相差 2 行，A[5][5] 与 A[5][3] 相差 2 个元素，所以 A[5][5] 地址为 446+24+2=472。', '472', '471', '458', '457'),
(6, '00000000-0000-0000-0000-000000049006', 'MEDIUM', 'pp.116,118', '将三对角矩阵即数组 A[1...100][1...100] 按行优先存入一维数组 B[1...298] 中，数组 A 中元素 A[66][65] 在数组 B 中的位置 k 为（ ）。', 'B', '对于三对角矩阵，将 A[1...n][1...n] 压缩至 B[1...3n-2] 时，aij 与 bk 的对应关系为 k=2i+j-2。因此 A[66][65] 在 B 中的位置为 2*66+65-2=195。', '198', '195', '197', '196'),
(7, '00000000-0000-0000-0000-000000049007', 'HARD', 'pp.116,118', '若将 n 阶上三角矩阵 A 按列优先级压缩存放在一维数组 B[1...n(n+1)/2+1] 中，则存放到 B[k] 中的非零元素 aij（1≤i,j≤n）的下标 i、j 与 k 的对应关系是（ ）。', 'C', '按列优先存储时，元素 aij 前面有 j-1 列，共有 (1+2+...+j-1)=j(j-1)/2 个元素；元素 aij 在第 j 列上是第 i 个元素，数组 B 下标从 1 开始，因此 k=j(j-1)/2+i。', 'i(i+1)/2+j', 'i(i-1)/2+j-1', 'j(j-1)/2+i', 'j(j-1)/2+i-1'),
(8, '00000000-0000-0000-0000-000000049008', 'HARD', 'pp.117-118', '若将 n 阶下三角矩阵 A 按列优先顺序压缩存放在一维数组 B[1...n(n+1)/2+1] 中，则存放到 B[k] 中的非零元素 aij（1≤i,j≤n）的下标 i、j 与 k 的对应关系是（ ）。', 'B', '按列优先存储时，元素 aij 前面有 j-1 列，共有 n+(n-1)+...+(n-j+2)=(j-1)(2n-j+2)/2 个元素；aij 是第 j 列第 i-j+1 个元素，数组 B 下标从 1 开始，因此 k=(j-1)(2n-j+2)/2+i-j+1。', '(j-1)(2n-j+1)/2+i-j', '(j-1)(2n-j+2)/2+i-j+1', '(j-1)(2n-j+2)/2+i-j', '(j-1)(2n-j+1)/2+i-j-1'),
(9, '00000000-0000-0000-0000-000000049009', 'BASIC', 'pp.117-118', '稀疏矩阵采用压缩存储后的缺点主要是（ ）。', 'B', '稀疏矩阵通常采用三元组来压缩存储，存储矩阵元素的行列下标和相应值，因此不能根据矩阵元素的行列下标快速定位矩阵元素，失去了随机存取特性。', '无法判断矩阵的行列数', '丧失随机存取的特性', '无法由行、列值查找某个矩阵元素', '使矩阵元素之间的逻辑关系更复杂'),
(10, '00000000-0000-0000-0000-000000049010', 'MEDIUM', 'pp.117-118', '下列关于矩阵的说法中，正确的是（ ）。
I. 在 n（n>3）阶三对角矩阵中，每行都有 3 个非零元素
II. 稀疏矩阵的特点是矩阵中的元素较少', 'D', '在三对角矩阵中，第 1 行和最后 1 行只有 2 个非零元素，其余各行均有 3 个非零元素。稀疏矩阵的特点是矩阵中非零元素的个数较少。因此 I 和 II 均错误。', '仅 I', '仅 II', 'I 和 II', '无正确项');

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
    'MOCK',
    2027,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 3 章 3.4.5/3.4.6 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch3_h_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_ARRAY_MATRIX';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000149', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_h_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000149', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_h_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000149', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_h_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000149', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_h_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_h_import q
JOIN knowledge_points kp ON kp.code = 'DS_ARRAY_MATRIX_COMPRESS';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000049701', 'DS-2027-ORIGINAL-CH3-H'),
    ('00000000-0000-0000-0000-000000049702', '3.4数组和特殊矩阵')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_h_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-H',
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

DROP TABLE ds_2027_original_ch3_h_import;
