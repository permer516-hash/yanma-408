-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.2.3/5.2.4 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-D

CREATE TABLE ds_2027_original_ch5_d_import (
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

INSERT INTO ds_2027_original_ch5_d_import (
    num, id, difficulty, source_year, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(25, '00000000-0000-0000-0000-000000056025', 'MEDIUM', 2009, 'pp.146-150', '【2009 统考真题】已知一棵完全二叉树的第 6 层（设根为第 1 层）有 8 个叶结点，则该完全二叉树的结点数最多是（ ）。', 'C', '第 6 层有叶结点，完全二叉树的高度可能为 6 或 7，显然树高为 7 时结点最多。完全二叉树与满二叉树相比，只是在最下一层的右边缺少部分叶结点，而最后一层之上是个满二叉树，且只有最后两层上有叶结点。若第 6 层上有 8 个叶结点，则前 6 层为满二叉树，而第 7 层缺失 8*2=16 个叶结点，所以完全二叉树的结点数最多为 2^7-1-16=111。', '39', '52', '111', '119'),
(26, '00000000-0000-0000-0000-000000056026', 'BASIC', 2011, 'pp.146-150', '【2011 统考真题】若一棵完全二叉树有 768 个结点，则该二叉树中叶结点的个数是（ ）。', 'C', '完全二叉树中最后一个分支结点的编号为 floor(768/2)=384，所以叶结点的个数为 768-384=384。也可由 n=n0+n1+n2=n0+n1+(n0-1)=2n0+n1-1 推得；当 n=768 时，完全二叉树中 n1 只能取 1，因此 n0=384。', '257', '258', '384', '385'),
(27, '00000000-0000-0000-0000-000000056027', 'MEDIUM', 2018, 'pp.146-150', '【2018 统考真题】设一棵非空完全二叉树 T 的所有叶结点均位于同一层，且每个非叶结点都有 2 个子结点。若 T 有 k 个叶结点，则 T 的结点总数是（ ）。', 'A', '非叶结点的度均为 2，且所有叶结点都位于同一层的完全二叉树就是满二叉树。对于一棵高度为 h 的满二叉树，其最后一层全部是叶结点，数目为 2^(h-1)，总结点数为 2^h-1。因此当 2^(h-1)=k 时，总结点数为 2k-1。', '2k-1', '2k', 'k^2', '2^k-1'),
(28, '00000000-0000-0000-0000-000000056028', 'MEDIUM', 2020, 'pp.146-150', '【2020 统考真题】对于任意一棵高度为 5 且有 10 个结点的二叉树，若采用顺序存储结构保存，每个结点占 1 个存储单元（仅存放结点的数据信息），则存放该二叉树需要的存储单元数量至少是（ ）。', 'A', '二叉树采用顺序存储时，用数组下标表示结点之间的父子关系。对于一棵高度为 5 的二叉树，为了满足任意性，其 1~5 层的所有结点都要能被存储起来，即考虑为一棵高度为 5 的满二叉树，共需要 1+2+4+8+16=31 个存储单元。', '31', '16', '15', '10'),
(29, '00000000-0000-0000-0000-000000056029', 'MEDIUM', 2022, 'pp.146-150', '【2022 统考真题】若三叉树 T 中有 244 个结点（叶结点的高度为 1），则 T 的高度至少是（ ）。', 'C', '高度一定的三叉树中结点数最多的情况是满三叉树。高度为 5 的满三叉树的结点数为 3^0+3^1+3^2+3^3+3^4=121，高度为 6 的满三叉树的结点数为 3^0+3^1+3^2+3^3+3^4+3^5=364。三叉树 T 的结点数为 244，121<244<364，因此 T 的高度至少为 6。', '8', '7', '6', '5'),
(30, '00000000-0000-0000-0000-000000056030', 'HARD', 2025, 'pp.147,150', '【2025 统考真题】若二叉树的结点值均为正整数，采用顺序存储方式保存在数组 R 中，用 -1 表示结点不存在，则下列数组中，不能表示一棵二叉树的是（ ）。', 'D', '在二叉树的顺序存储结构中，结点按完全二叉树的层次顺序存放，根在下标 0。对于任意非根结点 R[i]，其父结点为 R[(i-1)/2]。若某结点为空，则其所有后代位置必须也为空，否则将出现“空结点拥有非空子结点”的情况，违背二叉树定义。选项 A、B、C 中所有非 -1 元素从根到该结点的祖先路径上均不含 -1；选项 D 中 R[8]=19 是有效结点，其父结点应为 R[(8-1)/2]=R[3]，但 R[3]=-1，因此无法构成合法二叉树。', 'R[]={20, 15, 40, -1, -1, 35}', 'R[]={15, 40, 10, 18, 35, -1, -1}', 'R[]={15, 40, 10, -1, -1, -1, 12}', 'R[]={17, 20, 35, -1, 18, 45, -1, -1, 19, 27}');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 5 章 5.2.3/5.2.4 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch5_d_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000156', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_d_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000156', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_d_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000156', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_d_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000156', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_d_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_d_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000056701', 'DS-2027-ORIGINAL-CH5-D')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_d_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-D',
    '第5章树与二叉树',
    '5.2二叉树的概念',
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

DROP TABLE ds_2027_original_ch5_d_import;
