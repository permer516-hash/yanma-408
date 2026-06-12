-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.2.3/5.2.4 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-B

CREATE TABLE ds_2027_original_ch5_b_import (
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

INSERT INTO ds_2027_original_ch5_b_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000054001', 'MEDIUM', 'pp.145,147', '下列关于二叉树的说法中，正确的是（ ）。', 'C', '在二叉树中，若某个结点只有一个孩子，则这个孩子的左右次序是确定的；而在度为 2 的有序树中，若某个结点只有一个孩子，则这个孩子无须区分其左右次序。二叉树可以为空。完全二叉树的高度为 floor(log2 n)+1 或 ceil(log2(n+1))。', '度为 2 的有序树就是二叉树', '含有 n 个结点的二叉树的高度为 floor(log2 n)+1', '在完全二叉树中，若一个结点没有左孩子，则它必是叶结点', '含有 n 个结点的完全二叉树的高度为 floor(log2 n)'),
(2, '00000000-0000-0000-0000-000000054002', 'BASIC', 'pp.145,147', '“二叉树为空”意味着二叉树（ ）。', 'C', '“二叉树为空”意味着二叉树中没有结点，但并不意味着二叉树不存在。线性表可以是空表，树可以是空树，但不能是空图。', '根结点没有子树', '不存在', '没有结点', '由一些没有赋值的空结点构成'),
(3, '00000000-0000-0000-0000-000000054003', 'MEDIUM', 'pp.145,147', '下列关于完全二叉树的说法中，正确的是（ ）。', 'A', '在完全二叉树中，叶结点的双亲的左兄弟的孩子一定在其前面且一定存在，所以双亲的左兄弟若存在，一定不是叶结点。二叉树中 n0=n2+1。完全二叉树和满二叉树均可采用顺序存储结构。第 i 个结点的左孩子不一定存在。', '在完全二叉树中，叶结点的双亲的左兄弟（若存在）一定不是叶结点', '任何一棵二叉树中，叶结点数为度为 2 的结点数减 1，即 n0=n2-1', '完全二叉树不适合顺序存储结构，只有满二叉树适合顺序存储结构', '结点按完全二叉树层序编号的二叉树中，第 i 个结点的左孩子的编号为 2i'),
(4, '00000000-0000-0000-0000-000000054004', 'MEDIUM', 'pp.145,148', '具有 10 个叶结点的二叉树中有（ ）个度为 2 的结点。', 'B', '由二叉树的性质 n0=n2+1，可得 n2=n0-1=10-1=9。也可画出草图：每 2 个叶结点向上合并构造新的度为 2 的分支结点，直到构成相应二叉树。', '8', '9', '10', '11'),
(5, '00000000-0000-0000-0000-000000054005', 'MEDIUM', 'pp.145,148', '设高度为 h 的二叉树上只有度为 0 和度为 2 的结点，则此类二叉树中所包含的结点数至少为（ ）。', 'B', '结点最少的情况为：除根结点层只有 1 个结点外，其他 h-1 层均有两个结点，因此结点总数为 2(h-1)+1=2h-1。', 'h', '2h-1', '2h+1', 'h+1'),
(6, '00000000-0000-0000-0000-000000054006', 'HARD', 'pp.145,148', '具有 n 个结点且高度为 n 的二叉树的数目为（ ）。', 'D', '除根结点外，在其余 n-1 个结点中，每个结点要么是其父结点的左孩子，要么是其父结点的右孩子，每个结点都有两种可能，因此 n-1 个结点共有 2^(n-1) 种不同的组合形态。', 'log2 n', 'n/2', 'n', '2^(n-1)'),
(7, '00000000-0000-0000-0000-000000054007', 'MEDIUM', 'pp.145,148', '假设一棵二叉树的结点数为 50，则它的最小高度是（ ）。', 'C', '满足条件且高度最小的二叉树应尽量成为完全二叉树，最小高度 h=floor(log2 n)+1=floor(log2 50)+1=6。也可按每层最大结点数累加判断。', '4', '5', '6', '7'),
(8, '00000000-0000-0000-0000-000000054008', 'MEDIUM', 'pp.145,148', '设二叉树有 2n 个结点，且 m<n，则不可能存在（ ）的结点。', 'C', '由二叉树性质 n0=n2+1，且结点总数 2n=n0+n1+n2，可得 n1=2(n-n2)-1，因此 n1 必为奇数，说明该二叉树中不可能有 2m 个度为 1 的结点。', 'n 个度为 0', '2m 个度为 0', '2m 个度为 1', '2m 个度为 2'),
(9, '00000000-0000-0000-0000-000000054009', 'BASIC', 'pp.145,148', '一个具有 1025 个结点的二叉树的高 h 为（ ）。', 'C', '当二叉树为单支树时具有最大高度，即每层上只有一个结点，最大高度为 1025；当树为完全二叉树时，其高度最小，最小高度为 floor(log2 n)+1=11。因此 h 的范围为 11~1025。', '11', '10', '11~1025', '10~1024'),
(10, '00000000-0000-0000-0000-000000054010', 'HARD', 'pp.145,148', '设二叉树只有度为 0 和 2 的结点，其结点数为 15，则该二叉树的最大深度为（ ）。', 'C', '构造使深度尽可能大的二叉树：第一层有 1 个结点，其余 h-1 层各有 2 个结点，总结点数为 1+2(h-1)=15，解得 h=8。', '4', '5', '8', '9');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 5 章 5.2.3/5.2.4 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch5_b_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000154', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000154', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000154', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000154', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_b_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_b_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000054701', 'DS-2027-ORIGINAL-CH5-B'),
    ('00000000-0000-0000-0000-000000054702', '5.2二叉树的概念')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_b_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-B',
    '第5章树与二叉树',
    '5.2二叉树的概念',
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

DROP TABLE ds_2027_original_ch5_b_import;
