-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.4.4/5.4.5 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-H

CREATE TABLE ds_2027_original_ch5_h_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    section_tag VARCHAR(64) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    stem_format VARCHAR(32) NOT NULL DEFAULT 'PLAIN_TEXT',
    stem_image_url VARCHAR(512),
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch5_h_import (
    num, id, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, stem_format, stem_image_url,
    option_a, option_b, option_c, option_d
) VALUES
(12, '00000000-0000-0000-0000-000000060012', 'MEDIUM', 'MOCK', 2027, '5.4树、森林', 'pp.174,176', '设 X 是树 T 中的一个非根结点，B 是 T 所对应的二叉树。在 B 中，X 是其双亲结点的右孩子，下列结论中正确的是（ ）。', 'D', '在树 T 对应的二叉树 B 中，右孩子表示右兄弟关系。X 是其双亲结点的右孩子，说明在树 T 中 X 是该结点的右兄弟，因此 X 一定有左边兄弟。', 'PLAIN_TEXT', NULL, '在树 T 中，X 是其双亲结点的第一个孩子', '在树 T 中，X 一定无右边兄弟', '在树 T 中，X 一定是叶结点', '在树 T 中，X 一定有左边兄弟'),
(13, '00000000-0000-0000-0000-000000060013', 'MEDIUM', 'MOCK', 2027, '5.4树、森林', 'pp.174,176', '右图是一棵逻辑上的树 T，则在关于该树的存储结构的叙述中，错误的是（ ）。', 'C', '题图中树共有 10 个结点，采用双亲表示法时除根结点外有 9 个指向双亲的指针。孩子表示法查找孩子更方便。孩子兄弟表示法通常无法在 O(1) 时间内查找某结点的双亲，仍需从根开始查找，所以 C 错误。双亲表示法是顺序存储结构，孩子表示法和孩子兄弟表示法通常是链式存储结构。', 'DIAGRAM', '/question-assets/ds-2027/ch5/q54-q13-logical-tree.png', '若 T 采用双亲表示法，则有 9 个指向双亲的指针', '若 T 采用孩子表示法，则在 T 中查找某个结点的孩子比双亲表示法更方便', '若 T 采用孩子兄弟表示法，则在 T 中查找某个结点的双亲的时间复杂度为 O(1)', '双亲表示法是顺序存储结构，孩子表示法和孩子兄弟表示法通常是链式存储结构'),
(14, '00000000-0000-0000-0000-000000060014', 'MEDIUM', 'MOCK', 2027, '5.4树、森林', 'pp.174-175,176', '在森林的二叉树表示中，结点 M 和结点 N 是同一父结点的左孩子和右孩子，则在该森林中（ ）。', 'B', '在森林转换成二叉树时，左孩子表示孩子关系，右孩子表示兄弟关系。若 M 和 N 是同一父结点的左孩子和右孩子，当该父结点是二叉树根结点时，M 和 N 可能分属森林中不同的树，因此在森林中可能无公共祖先。', 'PLAIN_TEXT', NULL, 'M 和 N 有同一双亲', 'M 和 N 可能无公共祖先', 'M 是 N 的孩子', 'M 是 N 的左兄弟'),
(15, '00000000-0000-0000-0000-000000060015', 'HARD', 'PAST_EXAM', 2009, '5.4树、森林', 'pp.175,176', '【2009 统考真题】将森林转换为对应的二叉树，若在二叉树中，结点 u 是结点 v 的父结点的父结点，则在原来的森林中，u 和 v 可能具有的关系是（ ）。\nI. 父子关系\nII. 兄弟关系\nIII. u 的父结点与 v 的父结点是兄弟关系', 'B', '森林转换为二叉树采用孩子兄弟表示法。二叉树中结点 u 是结点 v 的父结点的父结点时，在原森林中 u 与 v 可能是父子关系，也可能是兄弟关系；但不可能推出 u 的父结点与 v 的父结点是兄弟关系。故 I、II 正确。', 'PLAIN_TEXT', NULL, '只有 II', 'I 和 II', 'I 和 III', 'I、II 和 III'),
(16, '00000000-0000-0000-0000-000000060016', 'MEDIUM', 'PAST_EXAM', 2011, '5.4树、森林', 'pp.175,176', '【2011 统考真题】已知一棵有 2011 个结点的树，其中叶结点数为 116，该树对应的二叉树中无右孩子的结点数是（ ）。', 'D', '树转换为二叉树后，每个分支结点的最右孩子在二叉树中无右孩子，根结点转换后也无右孩子。该树的分支结点数为 2011-116=1895，所以对应二叉树中无右孩子的结点数为 1895+1=1896。', 'PLAIN_TEXT', NULL, '115', '116', '1895', '1896'),
(17, '00000000-0000-0000-0000-000000060017', 'MEDIUM', 'PAST_EXAM', 2014, '5.4树、森林', 'pp.175,177', '【2014 统考真题】将森林 F 转换为对应的二叉树 T，F 中叶结点的个数等于（ ）。', 'C', '森林转换为二叉树时采用左孩子右兄弟表示法。森林中的叶结点没有孩子，转换到二叉树中表现为左孩子指针为空，因此 F 中叶结点的个数等于 T 中左孩子指针为空的结点数。', 'PLAIN_TEXT', NULL, 'T 中叶结点的个数', 'T 中度为 1 的结点数', 'T 中左孩子指针为空的结点数', 'T 中右孩子指针为空的结点数'),
(18, '00000000-0000-0000-0000-000000060018', 'MEDIUM', 'PAST_EXAM', 2019, '5.4树、森林', 'pp.175,177', '【2019 统考真题】若将一棵树 T 转化为对应的二叉树 BT，则下列对 BT 的遍历中，其遍历序列与 T 的后根遍历序列相同的是（ ）。', 'B', '树的后根遍历是先从左到右访问根结点的各棵子树，最后访问根结点。树转换为二叉树后，孩子关系变为左孩子，兄弟关系变为右孩子，二叉树的中序遍历序列与原树的后根遍历序列相同。', 'PLAIN_TEXT', NULL, '先序遍历', '中序遍历', '后序遍历', '按层遍历'),
(19, '00000000-0000-0000-0000-000000060019', 'HARD', 'PAST_EXAM', 2020, '5.4树、森林', 'pp.175,177', '【2020 统考真题】已知森林 F 及与之对应的二叉树 T，若 F 的先根遍历序列是 a,b,c,d,e,f，后根遍历序列是 b,a,d,f,e,c，则 T 的后序遍历序列是（ ）。', 'C', '森林的先根遍历序列对应二叉树 T 的先序遍历序列，森林的后根遍历序列对应二叉树 T 的中序遍历序列。由先序 a,b,c,d,e,f 和中序 b,a,d,f,e,c 可构造出二叉树 T，其后序遍历序列为 b,f,e,d,c,a。', 'PLAIN_TEXT', NULL, 'b,a,d,f,e,c', 'b,d,f,e,c,a', 'b,f,e,d,c,a', 'f,e,d,c,b,a'),
(20, '00000000-0000-0000-0000-000000060020', 'HARD', 'PAST_EXAM', 2021, '5.4树、森林', 'pp.175,177', '【2021 统考真题】某森林 F 对应的二叉树为 T，若 T 的先序遍历序列是 a,b,d,c,e,g,f，中序遍历序列是 b,d,a,e,g,c,f，则 F 中树的棵数是（ ）。', 'C', '由二叉树 T 的先序序列和中序序列可构造出 T。森林转换为二叉树后，森林中各棵树的根结点通过二叉树的右孩子链相连。构造可知该右孩子链上的根结点为 a、c、f，因此森林 F 中有 3 棵树。', 'PLAIN_TEXT', NULL, '1', '2', '3', '4'),
(21, '00000000-0000-0000-0000-000000060021', 'MEDIUM', 'PAST_EXAM', 2025, '5.4树、森林', 'pp.175,177', '【2025 统考真题】下列关于二叉树及森林的叙述中，正确的是（ ）。', 'B', '完全二叉树在结点个数为偶数时可以存在一个度为 1 的结点，A 错误。任意一个森林都可通过孩子兄弟表示法转换为一棵二叉树，B 正确。二叉树中叶结点数等于度为 2 的结点数加 1，但分支结点还包括度为 1 的结点，C 错误。表达式树根结点保存的是最后计算的运算符，D 错误。', 'PLAIN_TEXT', NULL, '完全二叉树中不存在度为 1 的结点', '任意一个森林都可以转换为一棵二叉树', '二叉树的分支结点数比叶结点数少', '表达式树的根中保存的是最先计算的运算符');

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
    q.source_type,
    q.source_year,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 5 章 5.4.4/5.4.5 本节试题精选及答案解析，参考页：' || q.source_pages || '。',
    q.stem_format,
    q.stem_image_url,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch5_h_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000160', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_h_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000160', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_h_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000160', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_h_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000160', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_h_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_h_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000060701', 'DS-2027-ORIGINAL-CH5-H'),
    ('00000000-0000-0000-0000-000000060702', '5.4树、森林')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_h_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-H',
    '第5章树与二叉树',
    q.section_tag,
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容'
) OR (q.source_type = 'PAST_EXAM' AND tag.name = '真题')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_original_ch5_h_import;
