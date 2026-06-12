-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.3.3/5.3.4 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-F

CREATE TABLE ds_2027_original_ch5_f_import (
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

INSERT INTO ds_2027_original_ch5_f_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(11, '00000000-0000-0000-0000-000000058011', 'MEDIUM', 'pp.147,153', '设结点 X 和 Y 是二叉树中任意的两个结点。在该二叉树的先序遍历序列中 X 在 Y 之前，而在其后序遍历序列中 X 在 Y 之后，则 X 和 Y 的关系是（ ）。', 'C', '二叉树的先序遍历为 NLR，后序遍历为 LRN。根据题意，在先序序列中 X 在 Y 之前，在后序序列中 X 在 Y 之后。若设 X 在根的位置，Y 在其左子树或右子树中，即满足要求，因此 X 是 Y 的祖先。', 'X 是 Y 的左兄弟', 'X 是 Y 的右兄弟', 'X 是 Y 的祖先', 'X 是 Y 的后裔'),
(12, '00000000-0000-0000-0000-000000058012', 'MEDIUM', 'pp.148,153', '若二叉树中结点的先序序列是 ...a...b...，中序序列是 ...b...a...，则（ ）。', 'C', '先序序列是 ...a...b...，因此 a 和 b 结点的三种情况分别可能为 a 是 b 的祖先、a 和 b 分别位于某结点的左右分支上、b 位于 a 的左子树中。中序序列是 ...b...a...，相同部分均说明 b 在 a 的左子树中。', '结点 a 和结点 b 分别在某结点的左子树和右子树中', '结点 b 在结点 a 的右子树中', '结点 b 在结点 a 的左子树中', '结点 a 和结点 b 分别在某结点的两棵非空子树中'),
(13, '00000000-0000-0000-0000-000000058013', 'HARD', 'pp.148,154', '一棵二叉树的先序遍历序列为 1234567，它的中序遍历序列可能是（ ）。', 'B', '可用栈模拟由先序序列和中序序列构造二叉树的过程。先序序列为入栈次序，中序序列为出栈次序。题中以 1234567 入栈，选项 A、C、D 都会出现不符合栈出栈顺序的情况，只有选项 B 可行。也可由先序和中序构造相应二叉树进行验证。', '3124567', '1234567', '4135627', '1463572'),
(14, '00000000-0000-0000-0000-000000058014', 'BASIC', 'pp.148,154', '下列序列中，不能唯一地确定一棵二叉树的是（ ）。', 'D', '先序序列为 NLR，后序序列为 LRN，虽然可以唯一确定树的根结点，但无法划分左右子树。例如先序为 AB、后序为 BA 时，既可能是只有左孩子，也可能是只有右孩子。层次序列和中序序列、先序序列和中序序列、后序序列和中序序列均可唯一确定一棵二叉树。', '层次序列和中序序列', '先序序列和中序序列', '后序序列和中序序列', '先序序列和后序序列'),
(15, '00000000-0000-0000-0000-000000058015', 'MEDIUM', 'pp.148,154', '若一棵二叉树的中序序列和后序序列相同，则（ ）。', 'B', '中序遍历是“左根右”，后序遍历是“左右根”。当任一结点没有右子树时，两种遍历都是“左根”。显然，当二叉树为空树或只有根结点时，其中序序列和后序序列也相同。', '二叉树为空树或二叉树任一结点没有左子树', '二叉树为空树或二叉树任一结点没有右子树', '二叉树为空树或二叉树中每个结点的度为 1', '二叉树为空树或二叉树为满二叉树'),
(16, '00000000-0000-0000-0000-000000058016', 'MEDIUM', 'pp.148,154', '已知一棵二叉树的后序序列为 DABEC，中序序列为 DEBAC，则先序序列为（ ）。', 'D', '根据后序序列与中序序列可构造出二叉树。后序序列最后一个结点 C 为根结点，中序序列中 C 左侧为左子树，继续递归确定左子树根结点 E 及其左右子树，最终得到先序序列 CEDBA。', 'ACBED', 'DECAB', 'DEABC', 'CEDBA'),
(17, '00000000-0000-0000-0000-000000058017', 'HARD', 'pp.148,154', '已知一棵二叉树的先序遍历结果为 ABCDEF，中序遍历结果为 CBAEDF，则后序遍历的结果为（ ）。', 'A', '对于遍历序列问题，先根据遍历性质排除若干项，若还无法确定答案，则由先序和中序遍历结果构造二叉树，再得到对应后序序列。本题中，已知先序和中序遍历结果，可以确定根结点和左右子树，最终后序序列为 CBEFDA。', 'CBEFDA', 'FEDCBA', 'CBEDFA', '不确定'),
(18, '00000000-0000-0000-0000-000000058018', 'MEDIUM', 'pp.148,155', '已知一棵二叉树的层次序列为 ABCDEF，中序序列为 BADCFE，则先序序列为（ ）。', 'B', '由层次序列可先确定根结点，再结合中序序列划分左右子树，递归构造二叉树。按该二叉树进行先序遍历，得到 ABCDEF。', 'ACBEDF', 'ABCDEF', 'BDFECA', 'FCEDBA'),
(19, '00000000-0000-0000-0000-000000058019', 'HARD', 'pp.148,155', '某二叉树中结点 x 在先序、中序、后序遍历序列中的编号分别为 pre(x)、in(x)、post(x)（假设都从 1 开始依次顺序编号），a 和 b 是该二叉树中的两个结点，其中 a 是 b 的祖先，则下列选项中不可能出现的是（ ）。', 'B', '先序遍历是根左右，祖先 a 先于子孙 b 访问，所以 pre(a)<pre(b) 一定成立。后序遍历是左右根，子孙 b 先于祖先 a 访问，所以 post(b)<post(a)，因此 post(a)<post(b) 一定不成立。中序遍历是左根右，子孙编号既可能小于祖先编号，也可能大于祖先编号。', 'pre(a)<pre(b)', 'post(a)<post(b)', 'in(a)<in(b)', 'in(a)>in(b)'),
(20, '00000000-0000-0000-0000-000000058020', 'BASIC', 'pp.148,155', '某二叉树采用二叉链表存储结构，若要删除该二叉链表中的所有结点，并释放它们占用的存储空间，则采用（ ）遍历方法最合适。', 'C', '删除一个结点时，需要先递归地删除它的左右孩子，并释放它们所占的存储空间，然后再删除该结点并释放其存储空间，这正好和后序遍历的访问顺序相吻合。', '中序', '层次', '后序', '先序'),
(21, '00000000-0000-0000-0000-000000058021', 'HARD', 'pp.148,155', '某二叉树 T 采用二叉链表存储结构，T 的中序遍历序列为一个升序序列，要求采用某种方法对 T 进行某种操作之后得到一棵新的二叉树 T''，要求 T'' 的中序遍历序列为一个降序序列，则下列关于该算法的叙述中，正确的是（ ）。', 'B', '只要交换 T 中所有分支结点的左右子树，就能得到一棵中序遍历序列为降序序列的树，而这并不会改变根结点，叶结点也仅仅交换位置，仍是原 T 中的叶结点。交换所有分支结点的左右子树，可以先处理根结点再处理左右子树，即先序遍历；也可以先处理左右子树再处理根结点，即后序遍历；中序遍历不适合。选项 B 正确。', '采用中序遍历的方法最合适', '采用后序遍历的方法最合适', 'T'' 中的根结点一定不是原 T 中的根结点', 'T'' 中的叶结点不一定是原 T 中的叶结点'),
(22, '00000000-0000-0000-0000-000000058022', 'BASIC', 'pp.148,155', '引入线索二叉树的目的是（ ）。', 'A', '线索是前驱结点和后继结点的指针，引入线索的目的是加快对二叉树的遍历。', '加快查找结点的前驱或后继的速度', '为了能在二叉树中方便插入和删除', '为了能方便找到双亲', '使二叉树的遍历结果唯一'),
(23, '00000000-0000-0000-0000-000000058023', 'MEDIUM', 'pp.148,155', 'n 个结点的线索二叉树上含有的线索数为（ ）。', 'C', 'n 个结点共有链域指针 2n 个。其中，除根结点外，每个结点都被一个指针指向，因此普通孩子指针有 n-1 个，剩余的链域用于建立线索，共 2n-(n-1)=n+1 个线索。', '2n', 'n-1', 'n+1', 'n'),
(24, '00000000-0000-0000-0000-000000058024', 'MEDIUM', 'pp.148-149,155', '判断线索二叉树中 *p 结点有右孩子结点的条件是（ ）。', 'C', '线索二叉树中用 ltag/rtag 标识结点的左/右指针域是否为线索。当其值为 1 时，对应指针域为线索；当其值为 0 时，对应指针域为左/右孩子。因此 *p 结点有右孩子结点的条件是 p->rtag==0。', 'p!=NULL', 'p->rchild!=NULL', 'p->rtag==0', 'p->rtag==1');

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
FROM ds_2027_original_ch5_f_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000158', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_f_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000158', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_f_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000158', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_f_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000158', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_f_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_f_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000058701', 'DS-2027-ORIGINAL-CH5-F')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_f_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-F',
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

DROP TABLE ds_2027_original_ch5_f_import;
