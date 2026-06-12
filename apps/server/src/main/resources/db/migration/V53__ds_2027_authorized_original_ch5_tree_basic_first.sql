-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.1.4/5.1.5 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-A

CREATE TABLE ds_2027_original_ch5_a_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source VARCHAR(16) NOT NULL,
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

INSERT INTO ds_2027_original_ch5_a_import (
    num, id, difficulty, source, source_year, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000053001', 'BASIC', 'MOCK', 2027, 'pp.138-139', '树最适合用来表示（ ）的数据。', 'D', '树是一种分层结构，它特别适合组织那些具有分支层次关系的数据。', '有序', '无序', '任意元素之间具有多种联系', '元素之间具有分支层次关系'),
(2, '00000000-0000-0000-0000-000000053002', 'BASIC', 'MOCK', 2027, 'pp.138-139', '一棵有 n 个结点的树的所有结点的度数之和为（ ）。', 'A', '除根结点外，其他每个结点都是某个结点的孩子，因此树中所有结点的度数加 1 等于结点数，即所有结点的度数之和等于总结点数减 1。这是一个重要的结论，做题时经常用到。', 'n-1', 'n', 'n+1', '2n'),
(3, '00000000-0000-0000-0000-000000053003', 'BASIC', 'MOCK', 2027, 'pp.138-139', '树的路径长度是从树根到每个结点的路径长度的（ ）。', 'A', '树的路径长度是指树根到每个结点的路径长度的总和，根到每个结点的路径长度的最大值应是树的高度减 1。注意与哈夫曼树的带权路径长度相区别。', '总和', '最小值', '最大值', '平均值'),
(4, '00000000-0000-0000-0000-000000053004', 'HARD', 'MOCK', 2027, 'pp.139-140', '对于一棵具有 n 个结点、度为 4 的树来说，（ ）。', 'A', '要使得具有 n 个结点、度为 4 的树的高度最大，就要使得每层的结点数尽可能少。除最后一层外，每层的结点数是 1，最终该树的高度为 n-3。树的度为 4 只能说明存在某结点正好且最多有 4 个孩子结点。', '树的高度至多是 n-3', '树的高度至多是 n-4', '第 i 层上至多有 4(i-1) 个结点', '至少在某一层上正好有 4 个结点'),
(5, '00000000-0000-0000-0000-000000053005', 'MEDIUM', 'MOCK', 2027, 'pp.139-140', '度为 4、高度为 h 的树，（ ）。', 'A', '要使得度为 4、高度为 h 的树的总结点数最少，需要满足：至少有一个结点有 4 个分支，并且每层的结点数尽可能少。这种情况下结点数为 h+3。要使总结点数最多，应使每个非叶结点的度均为 4，即为满树。', '至少有 h+3 个结点', '至多有 4h-1 个结点', '至多有 4h 个结点', '至少有 h+4 个结点'),
(6, '00000000-0000-0000-0000-000000053006', 'MEDIUM', 'MOCK', 2027, 'pp.139-140', '假定一棵度为 3 的树中，结点数为 50，则其最小高度为（ ）。', 'C', '要求满足条件的树，那么该树是一棵完全三叉树。在度为 3 的完全三叉树中，第 1 层有 1 个结点，第 2 层有 3 个结点，第 3 层有 9 个结点，第 4 层有 27 个结点，因此前 4 层结点数之和为 40，第 5 层需要放入剩余 10 个结点，因此最小高度为 5。', '3', '4', '5', '6'),
(7, '00000000-0000-0000-0000-000000053007', 'HARD', 'MOCK', 2027, 'pp.139-140', '设有一棵度为 3 的树，其中度为 3 的结点数 n3=2，度为 2 的结点数 n2=1，叶结点数 n0=6，则该树的总结点数为（ ）。', 'D', '总结点数 n=n0+n1+n2+n3=6+n1+1+2=n1+9，总度数为 n-1=n1+8。根据题目条件无法得出 n 的具体值，只能证明 n 是一个大于或等于 9 的任意整数。', '12', '9', '10', '≥9 的任意整数'),
(8, '00000000-0000-0000-0000-000000053008', 'MEDIUM', 'MOCK', 2027, 'pp.139-140', '设一棵 m 叉树中有 N1 个度数为 1 的结点，N2 个度数为 2 的结点，……，Nm 个度数为 m 的结点，则该树中共有（ ）个叶结点。', 'D', '设叶结点数为 N0，总结点数为 N，则 N=N1+2N2+3N3+...+mNm+1；又因为 N=N0+N1+N2+N3+...+Nm，所以 N0=N2+2N3+...+(m-1)Nm+1，即 N0=sum_{i=2}^m (i-1)Ni + 1。', 'sum_{i=1}^m (i-1)Ni', 'sum_{i=1}^m Ni', 'sum_{i=2}^m (i-1)Ni', 'sum_{i=2}^m (i-1)Ni + 1'),
(9, '00000000-0000-0000-0000-000000053009', 'MEDIUM', 'PAST_EXAM', 2010, 'pp.139-140', '【2010 统考真题】在一棵度为 4 的树 T 中，若有 20 个度为 4 的结点，10 个度为 3 的结点，1 个度为 2 的结点，10 个度为 1 的结点，则树 T 的叶结点数是（ ）。', 'B', '设树中度为 i（i=0,1,2,3,4）的结点数分别为 ni，树中结点总数为 n，则 n=分支数+1，而分支数又等于树中各结点的度数之和。由题意，n1+2n2+3n3+4n4=10+2+30+80=122，n1+n2+n3+n4=10+1+10+20=41，可得 n0=82，即树 T 的叶结点数是 82。', '41', '82', '113', '122'),
(10, '00000000-0000-0000-0000-000000053010', 'BASIC', 'PAST_EXAM', 2016, 'pp.139-140', '【2016 统考真题】若森林 F 有 15 条边、25 个结点，则 F 包含树的个数是（ ）。', 'C', '树有一个重要性质，即在 n 个结点的树中有 n-1 条边，也就是对于每棵树，其结点数比边数多 1。本题森林中的结点数比边数多 10（25-15=10），因此共有 10 棵树。', '8', '9', '10', '11');

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
    q.source,
    q.source_year,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 5 章 5.1.4/5.1.5 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch5_a_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000153', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000153', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000153', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000153', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_a_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_a_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000053701', 'DS-2027-ORIGINAL-CH5-A'),
    ('00000000-0000-0000-0000-000000053702', '第5章树与二叉树'),
    ('00000000-0000-0000-0000-000000053703', '5.1树的基本概念')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_a_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-A',
    '第5章树与二叉树',
    '5.1树的基本概念',
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

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_a_import q
JOIN question_tags tag ON tag.name = '真题'
WHERE q.source = 'PAST_EXAM'
  AND NOT EXISTS (
      SELECT 1 FROM question_tag_relations existing
      WHERE existing.question_id = CAST(q.id AS UUID)
        AND existing.tag_id = tag.id
  );

DROP TABLE ds_2027_original_ch5_a_import;
