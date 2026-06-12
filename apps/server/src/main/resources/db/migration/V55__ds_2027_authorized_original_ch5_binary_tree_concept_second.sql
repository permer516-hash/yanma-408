-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.2.3/5.2.4 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-C

CREATE TABLE ds_2027_original_ch5_c_import (
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

INSERT INTO ds_2027_original_ch5_c_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(11, '00000000-0000-0000-0000-000000055011', 'BASIC', 'pp.145,148', '高度为 h 的完全二叉树最少有（ ）个结点。', 'C', '高度为 h 的完全二叉树中，第 1 层到第 h-1 层构成一个高度为 h-1 的满二叉树，结点数为 2^(h-1)-1。第 h 层至少有一个结点，所以最少的结点数为 2^(h-1)。', '2^h', '2^h+1', '2^(h-1)', '2^h-1'),
(12, '00000000-0000-0000-0000-000000055012', 'MEDIUM', 'pp.145,149', '已知一棵完全二叉树的第 6 层（设根为第 1 层）有 8 个叶结点，则完全二叉树的结点数最少是（ ）。', 'A', '第 6 层有叶结点，说明完全二叉树的高度可能为 6 或 7。显然树高为 6 时结点最少。若第 6 层上有 8 个叶结点，则前 5 层为满二叉树，所以完全二叉树的结点数最少为 2^5-1+8=39。', '39', '52', '111', '119'),
(13, '00000000-0000-0000-0000-000000055013', 'MEDIUM', 'pp.145,149', '若一棵深度为 6 的完全二叉树的第 6 层有 3 个叶结点，则该二叉树共有（ ）个叶结点。', 'A', '深度为 6 的完全二叉树，第 5 层共有 2^4=16 个结点。第 6 层最左边有 3 个叶结点，其对应的双亲结点为第 5 层最左边的两个结点，所以第 5 层剩余的结点均为叶结点，共有 16-2=14 个，加上第 6 层的 3 个叶结点，共有 17 个叶结点。', '17', '18', '19', '20'),
(14, '00000000-0000-0000-0000-000000055014', 'MEDIUM', 'pp.146,149', '一棵完全二叉树上有 1001 个结点，其中叶结点的个数是（ ）。', 'D', '由完全二叉树的性质，最后一个分支结点的序号为 floor(1001/2)=500，所以叶结点数为 501。也可由 n=n0+n1+n2=2n0+n1-1 且 n=1001 推得 n1=0、n0=501。', '250', '500', '254', '501'),
(15, '00000000-0000-0000-0000-000000055015', 'MEDIUM', 'pp.146,149', '若一棵二叉树有 126 个结点，在第 7 层（根结点在第 1 层）至多有（ ）个结点。', 'C', '要使二叉树第 7 层的结点数最多，只考虑树高为 7 层的情况。7 层满二叉树有 127 个结点，126 仅比 127 少 1 个结点，只能少在第 7 层，所以第 7 层最多有 2^6-1=63 个结点。', '32', '64', '63', '不存在第 7 层'),
(16, '00000000-0000-0000-0000-000000055016', 'HARD', 'pp.146,149', '一棵有 124 个叶结点的完全二叉树，最多有（ ）个结点。', 'B', '在非空二叉树中，由度为 0 和 2 的结点数关系 n0=n2+1 可知 n2=123；总结点数 n=n0+n1+n2=247+n1。完全二叉树中 n1 的取值为 0 或 1，当 n1=1 时结点最多，因此最多有 248 个结点。', '247', '248', '249', '250'),
(17, '00000000-0000-0000-0000-000000055017', 'MEDIUM', 'pp.146,149', '某完全二叉树 T 中，结点数最大的层有 8 个结点，则 T 中至多有（ ）个结点。', 'C', '在完全二叉树中，第 4 层刚好最多有 8 个结点，前 4 层对应高度为 4 的满二叉树。若第 5 层也有 8 个结点，则对应结点数最多的情况，此时树高为 5，总结点数为 15+8=23。', '8', '15', '23', '31'),
(18, '00000000-0000-0000-0000-000000055018', 'BASIC', 'pp.146,149', '一棵有 n 个结点的二叉树采用二叉链存储结点，其中空指针数为（ ）。', 'B', '非空指针数等于总分支数 n-1，空指针数等于 2×结点总数减去非空指针数，即 2n-(n-1)=n+1。', 'n', 'n+1', 'n-1', '2n'),
(19, '00000000-0000-0000-0000-000000055019', 'HARD', 'pp.146,149', '设有 n（n≥1）个结点的二叉树采用三叉链表表示，其中每个结点包含三个指针，分别指向其左孩子、右孩子及双亲（若不存在，则置为空），则下列说法中正确的是（ ）。\nI. 树中空指针的数量为 n+2\nII. 所有度为 2 的结点均被三个指针指向\nIII. 每个叶结点均被一个指针所指', 'A', '二叉链表表示的二叉树中空指针的数量为 n+1，三叉链表表示的二叉树多了一个根结点指向双亲的空指针，所以树中空指针的数量为 n+2，说法 I 正确。若根结点的度为 2，则只有左右两个孩子指向它，说法 II 错误。若整棵树只有一个根结点，则没有指针指向它，说法 III 错误。', 'I', 'I、II', 'I、III', 'II、III'),
(20, '00000000-0000-0000-0000-000000055020', 'MEDIUM', 'pp.146,149', '在一棵完全二叉树中，其根的序号为 1，（ ）可判定序号为 p 和 q 的两个结点是否在同一层。', 'A', '由完全二叉树的性质，编号为 i（i≥1）的结点所在的层次为 floor(log2 i)+1。若两个结点位于同一层，则一定有 floor(log2 p)+1=floor(log2 q)+1，因此 floor(log2 p)=floor(log2 q) 成立。', 'floor(log2 p)=floor(log2 q)', 'log2 p=log2 q', 'floor(log2 p)+1=floor(log2 q)', 'floor(log2 p)=floor(log2 q)+1'),
(21, '00000000-0000-0000-0000-000000055021', 'MEDIUM', 'pp.146,149', '在一个用数组表示的完全二叉树中，根结点的下标为 1，那么下标为 17 和 19 的结点的最近公共祖先的下标是（ ）。', 'C', '当根结点下标为 1 时，下标为 i 的结点的父结点下标为 floor(i/2)。下标为 17 的祖先下标有 8、4、2、1，下标为 19 的祖先下标有 9、4、2、1，因此两者最近的公共祖先下标是 4。', '1', '2', '4', '8'),
(22, '00000000-0000-0000-0000-000000055022', 'MEDIUM', 'pp.146,149', '假定一棵三叉树的结点数为 50，则它的最小高度为（ ）。', 'C', '满足条件的三叉树可以是完全三叉树，第 i 层最多有 3^(i-1) 个结点。设高度为 h，则 3^0+3^1+...+3^(h-1)=(3^h-1)/2 是结点数的上限。求 50≤(3^h-1)/2 的最小 h，可得 h=5。', '3', '4', '5', '6'),
(23, '00000000-0000-0000-0000-000000055023', 'MEDIUM', 'pp.146,150', '具有 n 个结点的三叉树用三叉链表表示，则树中空指针域的个数为（ ）。', 'B', '三叉树采用三叉链表表示，每个结点均有 3 个指针域，共有 3n 个指针域；但 n 个结点构成的一棵树中只需要 n-1 个指针对应 n-1 条边，因此空指针域有 3n-(n-1)=2n+1 个。', '3n+1', '2n+1', '3n-1', '3n'),
(24, '00000000-0000-0000-0000-000000055024', 'MEDIUM', 'pp.146,150', '对于一棵满二叉树，共有 n 个结点和 m 个叶结点，高度为 h，则（ ）。', 'D', '对于高度为 h 的满二叉树，结点总数 n=2^0+2^1+...+2^(h-1)=2^h-1，叶结点数 m=2^(h-1)。', 'n=h+m', 'n+m=2h', 'm=h-1', 'n=2^h-1');

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
FROM ds_2027_original_ch5_c_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000155', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000155', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000155', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000155', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_c_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_c_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000055701', 'DS-2027-ORIGINAL-CH5-C')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_c_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-C',
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

DROP TABLE ds_2027_original_ch5_c_import;
