-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.5.3/5.5.4 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-I

CREATE TABLE ds_2027_original_ch5_i_import (
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

INSERT INTO ds_2027_original_ch5_i_import (
    num, id, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, stem_format, stem_image_url,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000061001', 'BASIC', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,187', '在有 n 个叶结点的哈夫曼树中，非叶结点的总数是（ ）。', 'A', '由哈夫曼树的构造过程可知，哈夫曼树中只有度为 0 和 2 的结点。在非空二叉树中，有 n0=n2+1，因此 n2=n-1。也可理解为 n 个结点构造哈夫曼树需要 n-1 次合并过程，每次合并新建一个分支结点。', 'PLAIN_TEXT', NULL, 'n-1', 'n', '2n-1', '2n'),
(2, '00000000-0000-0000-0000-000000061002', 'MEDIUM', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,187-188', '给定整数集合 {3,5,6,9,12}，与之对应的哈夫曼树是（ ）。', 'C', '首先，3 和 5 构造为一棵子树，其根权值为 8；然后该子树与 6 构造为一棵新子树，根权值为 14；再后 9 与 12 构造为一棵子树，最后两棵子树共同构造为一棵哈夫曼树。', 'DIAGRAM', '/question-assets/ds-2027/ch5/q55-q02-huffman-options.png', '见题图 A', '见题图 B', '见题图 C', '见题图 D'),
(3, '00000000-0000-0000-0000-000000061003', 'BASIC', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,188', '下列编码中，（ ）不是前缀码。', 'B', '若没有一个编码是另一个编码的前缀，则称这样的编码为前缀编码。在选项 B 中，0 是 00 的前缀，1 是 11 的前缀，因此不是前缀码。', 'PLAIN_TEXT', NULL, '{00,01,10,11}', '{0,1,00,11}', '{0,10,110,111}', '{10,110,1110,1111}'),
(4, '00000000-0000-0000-0000-000000061004', 'HARD', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,188', '设哈夫曼编码的长度不超过 4，若已对两个字符编码为 1 和 01，则还最多可对（ ）个字符编码。', 'C', '在哈夫曼编码中，一个编码不能是任何其他编码的前缀。已知一个字符编码为 1，另一个字符编码为 01，则从剩余可用分支继续分配时，最多还能得到 4 个可用编码。等价地看，3 位编码可为 000、001，4 位编码可为 0010、0011；若全采用 4 位编码，则可为 0000、0001、0010、0011。', 'PLAIN_TEXT', NULL, '2', '3', '4', '5'),
(5, '00000000-0000-0000-0000-000000061005', 'BASIC', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,188', '一棵哈夫曼树共有 215 个结点，对其进行哈夫曼编码，共能得到（ ）个不同的码字。', 'B', '在哈夫曼树中只有度为 0 和 2 的结点，结点总数 n=n0+n2，且 n0=n2+1。题中 n=215，可得叶结点数 n0=(215+1)/2=108，因此共有 108 个不同的码字。', 'PLAIN_TEXT', NULL, '107', '108', '214', '215'),
(6, '00000000-0000-0000-0000-000000061006', 'MEDIUM', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,188', '设某哈夫曼树有 5 个叶结点，则该哈夫曼树的高度最高可以是（ ）。', 'C', '在哈夫曼树的构造中，每个初始结点最终都成为叶结点，5 个初始结点构造的哈夫曼树共新建 4 个双分支结点。4 个双分支结点所构成的高度最高的哈夫曼树高度为 5。', 'PLAIN_TEXT', NULL, '3', '4', '5', '6'),
(7, '00000000-0000-0000-0000-000000061007', 'BASIC', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,188', '以下对于哈夫曼树的说法中，错误的是（ ）。', 'D', '在哈夫曼树的构造过程中，每次选根的权值最小的两棵树，生成的新二叉树根权值为其左右两棵子树根结点权值之和。谁做左子树、谁做右子树没有限制，因此构造的哈夫曼树不唯一，但其带权路径长度是最小且唯一的。哈夫曼树只有度为 0 和 2 的结点，度为 0 的结点是外结点，带有权值，没有度为 1 的结点。', 'PLAIN_TEXT', NULL, '用一组权值构造出的哈夫曼树可能不唯一，但带权路径长度唯一', '哈夫曼树具有最小的带权路径长度', '哈夫曼树中没有度为 1 的结点', '哈夫曼树中除了度为 1 的结点，还有度为 2 的结点和叶结点'),
(8, '00000000-0000-0000-0000-000000061008', 'MEDIUM', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.185,188', '下列关于哈夫曼树的说法中，错误的是（ ）。\nI. 哈夫曼树的总结点数不能是偶数\nII. 哈夫曼树中度为 1 的结点数等于度为 2 和 0 的结点数之差\nIII. 哈夫曼树的带权路径长度等于其所有分支结点的权值之和', 'C', '由 n 个初始结点构造的哈夫曼树，会新建 n-1 个双分支结点，因此总结点数为 2n-1，必为奇数，I 正确。哈夫曼树中没有度为 1 的结点，II 错误。哈夫曼树的带权路径长度有两种计算方法：所有叶结点的带权路径长度之和，或所有分支结点的权值之和，III 正确。因此错误的是仅 II。', 'PLAIN_TEXT', NULL, '仅 III', 'I 和 II', '仅 II', 'I、II 和 III'),
(9, '00000000-0000-0000-0000-000000061009', 'MEDIUM', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.186,188', '若度为 m 的哈夫曼树中，叶结点数为 n，则非叶结点的个数为（ ）。', 'C', '一棵度为 m 的哈夫曼树应只有度为 0 和 m 的结点。设度为 m 的结点有 nm 个，度为 0 的结点有 n0 个，又该结点总数 N=n0+nm。因 N 个结点的哈夫曼树有 N-1 条分支，则 m*nm=N-1=nm+n0-1，整理得 (m-1)nm=n0-1，nm=(n0-1)/(m-1)。', 'PLAIN_TEXT', NULL, 'n-1', '⌊n/m⌋-1', '⌈(n-1)/(m-1)⌉', '⌈n/(m-1)⌉-1'),
(10, '00000000-0000-0000-0000-000000061010', 'BASIC', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.186,188', '并查集的结构是一种（ ）。', 'B', '并查集的存储结构是用双亲表示法存储的树，主要为了方便两个重要的操作。', 'PLAIN_TEXT', NULL, '二叉链表存储的二叉树', '双亲表示法存储的树', '顺序存储的二叉树', '孩子表示法存储的树'),
(11, '00000000-0000-0000-0000-000000061011', 'MEDIUM', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.186,188-189', '并查集中最核心的两个操作是：① 查找，查找两个元素是否属于同一个集合；② 合并，若两个元素不属于同一个集合，且所在的两个集合互不相交，则合并这两个集合。假设初始长度为 10（0~9）的有序集，按 1-2、3-4、5-6、7-8、8-9、1-8、0-5、1-9 的顺序进行查找和合并操作，最终并查集共有（ ）个集合。', 'C', '初始时，0~9 各自成一个集合。查找 1-2 时合并 {1} 和 {2}；查找 3-4 时合并 {3} 和 {4}；查找 5-6 时合并 {5} 和 {6}；查找 7-8 时合并 {7} 和 {8}；查找 8-9 时合并 {7,8} 和 {9}；查找 1-8 时合并 {1,2} 和 {7,8,9}；查找 0-5 时合并 {0} 和 {5,6}；查找 1-9 时它们属于同一个集合。最终集合为 {0,5,6}、{1,2,7,8,9} 和 {3,4}，因此共有 3 个集合。', 'PLAIN_TEXT', NULL, '1', '2', '3', '4');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 5 章 5.5.3/5.5.4 本节试题精选及答案解析，参考页：' || q.source_pages || '。',
    q.stem_format,
    q.stem_image_url,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch5_i_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_TREE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000161', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5_i_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000161', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5_i_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000161', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5_i_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000161', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5_i_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5_i_import q
JOIN knowledge_points kp ON kp.code = 'DS_TREE_HUFFMAN_UNION_FIND';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000061701', 'DS-2027-ORIGINAL-CH5-I'),
    ('00000000-0000-0000-0000-000000061702', '5.5树与二叉树的应用')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5_i_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-I',
    '第5章树与二叉树',
    q.section_tag,
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

DROP TABLE ds_2027_original_ch5_i_import;
