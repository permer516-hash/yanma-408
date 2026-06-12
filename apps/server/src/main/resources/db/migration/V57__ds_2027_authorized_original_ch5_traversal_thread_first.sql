-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.3.3/5.3.4 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-E

CREATE TABLE ds_2027_original_ch5_e_import (
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

INSERT INTO ds_2027_original_ch5_e_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000057001', 'MEDIUM', 'pp.146-152', '在下列关于二叉树遍历的说法中，正确的是（ ）。', 'C', '二叉树中序遍历的最后一个结点一定是从根开始沿右孩子指针链走到底的结点。若该结点 p 不是叶结点，则先序遍历的最后一个结点在它的左子树中，选项 A、B 错误；若 p 是叶结点，则先序与中序遍历的最后一个结点就是它，选项 C 正确。若中序遍历的最后一个结点 p 不是叶结点，它还有一个左孩子 q，结点 q 是叶结点，那么 q 是先序遍历的最后一个结点，但不是中序遍历的最后一个结点，选项 D 错误。', '若有一个结点是二叉树中某个子树的中序遍历结果序列的最后一个结点，则它一定是该子树的先序遍历结果序列的最后一个结点', '若有一个结点是二叉树中某个子树的先序遍历结果序列的最后一个结点，则它一定是该子树的中序遍历结果序列的最后一个结点', '若有一个叶结点是二叉树中某个子树的中序遍历结果序列的最后一个结点，则它一定是该子树的先序遍历结果序列的最后一个结点', '若有一个叶结点是二叉树中某个子树的先序遍历结果序列的最后一个结点，则它一定是该子树的中序遍历结果序列的最后一个结点'),
(2, '00000000-0000-0000-0000-000000057002', 'BASIC', 'pp.147,152', '在任何一棵二叉树中，若结点 a 有左孩子 b、右孩子 c，则在结点的先序序列、中序序列、后序序列中，（ ）。', 'C', '三种遍历方式中，都先遍历左子树，再遍历右子树，因此 b 一定在 c 的前面访问。', '结点 b 一定在结点 a 的前面', '结点 a 一定在结点 c 的前面', '结点 b 一定在结点 c 的前面', '结点 a 一定在结点 b 的前面'),
(3, '00000000-0000-0000-0000-000000057003', 'MEDIUM', 'pp.147,152', '设 n、m 为一棵二叉树上的两个结点，在中序遍历时，n 在 m 前的条件是（ ）。', 'C', '中序遍历时，先访问左子树，再访问根结点，后访问右子树。n 在 m 前的三种可能性中，均可概括为 n 总是在 m 的左方。若设 n 和 m 的最近公共祖先为 p，则可能是 m 和 n 分列在 p 的左右分支上，或 m、n 中有一个为 p，另一个位于其左侧分支。', 'n 在 m 右方', 'n 是 m 祖先', 'n 在 m 左方', 'n 是 m 子孙'),
(4, '00000000-0000-0000-0000-000000057004', 'MEDIUM', 'pp.147,153', '设 n、m 为一棵二叉树上的两个结点，在后序遍历时，n 在 m 前的充分条件是（ ）。', 'D', '后序遍历的顺序是 LRN。若 n 在 m 的左子树上，m 在 n 的右方，则 n 在 m 之前访问；若 n 是 m 的子孙，则设 m 在 N 的位置，无论是在 m 的左子树还是右子树，在后序遍历过程中 n 都在 m 之前访问。其他选项都不可以，选项 C 要成立还需加上两个结点位于同一层这个条件。', 'n 在 m 右方', 'n 是 m 祖先', 'n 在 m 左方', 'n 是 m 子孙'),
(5, '00000000-0000-0000-0000-000000057005', 'MEDIUM', 'pp.147,153', '某非空二叉树采用顺序存储结构，树中的结点信息按完全二叉树的层次序列依次存放在一维数组中。数组下标和值为：0:a，1:b，2:c，3:空，4:d，5:e，6:f，7:空，8:空，9:g，10:空，11:空，12:h。则该二叉树的后序遍历序列为（ ）。', 'C', '在二叉树的数组存储结构中，下标为 i 的结点的左右孩子下标分别为 2i+1 和 2i+2（若存在）。由数组可画出二叉树形态，按后序遍历得到 gdbhefca。', 'ghbefhca', 'gbdehcfa', 'gdbhefca', 'bgdehcfa'),
(6, '00000000-0000-0000-0000-000000057006', 'BASIC', 'pp.147,153', '在二叉树的先序序列、中序序列和后序序列中，所有叶结点的先后顺序（ ）。', 'B', '三种遍历方式中，访问左右子树的先后顺序是不变的，只是访问根结点的顺序不同，因此叶结点的先后顺序完全相同。也可采用特殊值法，画一个结点数为 3 的满二叉树，用三种遍历方式验证答案。', '都不相同', '完全相同', '先序和中序相同，而与后序不同', '中序和后序相同，而与先序不同'),
(7, '00000000-0000-0000-0000-000000057007', 'MEDIUM', 'pp.147,153', '对二叉树的结点从 1 开始进行连续编号，要求每个结点的编号大于其左右孩子的编号，同一结点的左右孩子中，其左孩子的编号小于其右孩子的编号，可采用（ ）次序的遍历实现编号。', 'C', '对每个顶点从 1 开始按序编号，要求结点编号大于其左右孩子编号，并且左孩子编号小于右孩子编号。编号越大说明遍历顺序越靠后，因此遍历顺序为先左子树，再右子树，后根结点。4 个选项中仅后序遍历满足要求。', '先序遍历', '中序遍历', '后序遍历', '层次遍历'),
(8, '00000000-0000-0000-0000-000000057008', 'MEDIUM', 'pp.147,153', '按某种顺序对二叉树的结点进行编号，编号为 1,2,...,n，规定：树中任一结点 v，其编号等于 v 的左子树上的最小编号减 1，而 v 的右子树中的最小编号等于 v 的左子树上的最大编号加 1，则说明该二叉树是按（ ）次序编号的。', 'B', '结点 v 的编号比其左子树上的最小编号还小，而 v 的右子树中的最小编号大于 v 的左子树中的最大编号，因此 v 的编号比其左右子树上所有编号都小，显然是按先序遍历次序编号。', '中序遍历', '先序遍历', '后序遍历', '层次遍历'),
(9, '00000000-0000-0000-0000-000000057009', 'HARD', 'pp.147,153', '先序序列为 A,B,C，后序序列为 C,B,A 的二叉树共有（ ）。', 'D', '先序为 A、B、C 的不同二叉树共有 5 种，其中后序为 C、B、A 的有 4 种（前 4 种），它们都是单支树。', '1 棵', '2 棵', '3 棵', '4 棵'),
(10, '00000000-0000-0000-0000-000000057010', 'MEDIUM', 'pp.147,153', '一棵完全二叉树的后序遍历序列为 CDBFGEA，则其先序遍历序列是（ ）。', 'C', '7 个结点的完全二叉树是一棵 3 层的满二叉树。画出相应二叉树的树形，根据后序遍历序列填入相应的结点，可得其先序遍历序列为 ABCDEFG。', 'CBDAFEG', 'ABECDFG', 'ABCDEFG', '无法确定');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 5 章 5.3.3/5.3.4 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch5_e_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000157', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_e_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000157', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_e_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000157', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_e_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000157', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_e_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_e_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000057701', 'DS-2027-ORIGINAL-CH5-E'),
    ('00000000-0000-0000-0000-000000057702', '5.3二叉树的遍历和线索二叉树')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_e_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-E',
    '第5章树与二叉树',
    '5.3二叉树的遍历和线索二叉树',
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

DROP TABLE ds_2027_original_ch5_e_import;
