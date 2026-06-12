-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 2: 2.1.3/2.1.4 and 2.3.7/2.3.8 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH2-A

CREATE TABLE ds_2027_original_ch2_a_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    section_code VARCHAR(32) NOT NULL,
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

INSERT INTO ds_2027_original_ch2_a_import (
    num, id, section_code, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000039001', '2.1', 'BASIC', 'pp.26-27', '线性表是具有 n 个（ ）的有限序列。', 'C', '线性表是由具有相同数据类型的有限数据元素组成的，数据元素是由数据项组成的。', '数据表', '字符', '数据元素', '数据项'),
(2, '00000000-0000-0000-0000-000000039002', '2.1', 'BASIC', 'pp.26-27', '下列几种描述中，（ ）是一个线性表。', 'B', '线性表定义的要求为：相同数据类型、有限序列。选项 C 的元素个数是无穷个，错误；选项 A 集合中的元素没有前后驱关系，错误；选项 D 属于一种存储结构，本题要求选出的是一个具体的线性表，不要将二者混为一谈。只有选项 B 符合线性表定义的要求。', '由 n 个实数组成的集合', '由 100 个字符组成的序列', '所有整数组成的序列', '邻接表'),
(3, '00000000-0000-0000-0000-000000039003', '2.1', 'BASIC', 'pp.26-27', '在线性表中，除开始元素外，每个元素（ ）。', 'A', '线性表中，除最后一个（或第一个）元素外，每个元素都只有一个后继（或前驱）元素。', '只有唯一的前驱元素', '只有唯一的后继元素', '有多个前驱元素', '有多个后继元素'),
(4, '00000000-0000-0000-0000-000000039004', '2.1', 'BASIC', 'pp.26-27', '若非空线性表中的元素既没有直接前驱，又没有直接后继，则该表中有（ ）个元素。', 'A', '线性表中的第一个元素没有直接前驱，最后一个元素没有直接后继；当线性表中仅有一个元素时，该元素既没有直接前驱，又没有直接后继。', '1', '2', '3', 'n'),
(5, '00000000-0000-0000-0000-000000039005', '2.3', 'MEDIUM', 'pp.51,57-58', '下列关于线性表的存储结构的描述中，正确的是（ ）。
I. 线性表的顺序存储结构优于其链式存储结构
II. 链式存储结构比顺序存储结构能更方便地表示各种逻辑结构
III. 若频繁使用插入和删除结点操作，则顺序存储结构更优于链式存储结构
IV. 顺序存储结构和链式存储结构都可以进行顺序存取', 'B', '两种存储结构适用于不同的场合，不能简单地说谁好谁坏，说法 I 错误。链式存储用指针表示逻辑结构，而指针的设置是任意的，因此比顺序存储结构能更方便地表示各种逻辑结构，说法 II 正确。在顺序存储中，插入和删除结点需要移动大量元素，效率较低，说法 III 的描述刚好相反。顺序存储结构既能随机存取又能顺序存取，而链式结构只能顺序存取，说法 IV 正确。', 'I、II、III', 'II、IV', 'II、III', 'III、IV'),
(6, '00000000-0000-0000-0000-000000039006', '2.3', 'MEDIUM', 'pp.51,58', '对于一个线性表，既要求能进行较快速地插入和删除，又要求存储结构能反映数据之间的逻辑关系，则应该用（ ）。', 'B', '首先直接排除选项 A 和 D。散列存储通过散列函数映射到物理空间，不能反映数据之间的逻辑关系，排除选项 C。链式存储能方便地表示各种逻辑关系，且插入和删除操作的时间复杂度为 O(1)。', '顺序存储方式', '链式存储方式', '散列存储方式', '以上均可以'),
(7, '00000000-0000-0000-0000-000000039007', '2.3', 'BASIC', 'pp.51-52,58', '链式存储设计时，结点内的存储单元地址（ ）。', 'A', '链式存储设计时，各个不同结点的存储空间可以不连续，但结点内的存储单元地址必须连续。', '一定连续', '一定不连续', '不一定连续', '部分连续，部分不连续'),
(8, '00000000-0000-0000-0000-000000039008', '2.3', 'MEDIUM', 'pp.52,58', '下列关于线性表的说法中，正确的是（ ）。
I. 顺序存储方式只能用于存储线性结构
II. 在一个设有头指针和尾指针的单链表中，删除表尾元素的时间复杂度与表长无关
III. 带头结点的循环单链表中不存在空指针
IV. 在一个长度为 n 的有序单链表中插入一个新结点并仍保持有序的时间复杂度为 O(n)
V. 若用单链表来表示队列，则应该选用带尾指针的循环链表', 'D', '顺序存储方式同样适用于存储图和树，说法 I 错误。删除表尾结点时，必须从头开始找到表尾结点的前驱，其时间与表长有关，说法 II 错误。循环单链表中最后一个结点的指针不是 NULL，而是指向头结点，整个链表形成一个环，因此不存在空指针，说法 III 正确。有序单链表只能依次查找插入位置，时间复杂度为 O(n)，说法 IV 正确。队列需要在表头删除元素、表尾插入元素，采用带尾指针的循环链表较为方便，插入和删除的时间复杂度都为 O(1)，说法 V 正确。', 'I、II', 'I、III、IV、V', 'IV、V', 'III、IV、V'),
(9, '00000000-0000-0000-0000-000000039009', '2.3', 'MEDIUM', 'pp.52,58', '设线性表中有 2n 个元素，（ ）在单链表上实现要比在顺序表上实现效率更高。', 'A', '对于选项 A，在单链表和顺序表上实现的时间复杂度都为 O(n)，但后者要移动很多元素，因此在单链表上实现效率更高。对于选项 B 和 D，顺序表的效率更高。选项 C 无区别。', '删除所有值为 x 的元素', '在最后一个元素的后面插入一个新元素', '顺序输出前 k 个元素', '交换第 i 个元素和第 2n-i-1 个元素的值（i=0，…，n-1）'),
(10, '00000000-0000-0000-0000-000000039010', '2.3', 'BASIC', 'pp.52,58', '在一个单链表中，已知 q 所指结点是 p 所指结点的前驱结点，若在 q 和 p 之间插入结点 s，则执行（ ）。', 'C', 's 插入后，q 成为 s 的前驱，而 p 成为 s 的后继，选择选项 C。可能有读者认为选项 C 中的两条语句交换后才正确。实际上，因为本题插入位置的前后结点都有指针指示，所以选项 C 中的语句顺序并不会造成断链。', 's->next=p->next; p->next=s;', 'p->next=s->next; s->next=p;', 'q->next=s; s->next=p;', 'p->next=s; s->next=q;'),
(11, '00000000-0000-0000-0000-000000039011', '2.3', 'HARD', 'pp.52,58', '给定有 n 个元素的一维数组，建立一个有序单链表的最低时间复杂度是（ ）。', 'D', '若先建立链表，然后依次插入建立有序表，则每插入一个元素就需遍历链表寻找插入位置，即直接插入排序，时间复杂度为 O(n^2)。若先将数组排好序，然后建立链表，建立链表的时间复杂度为 O(n)，数组排序的最好时间复杂度为 O(nlog2n)，总时间复杂度为 O(nlog2n)。故选择选项 D。', 'O(1)', 'O(n)', 'O(n^2)', 'O(nlog2n)'),
(12, '00000000-0000-0000-0000-000000039012', '2.3', 'MEDIUM', 'pp.52,58', '将长度为 n 的单链表链接在长度为 m 的单链表后面，其算法的时间复杂度采用大 O 形式表示应该是（ ）。', 'C', '先遍历长度为 m 的单链表，找到该单链表的尾结点，然后将其 next 域指向另一个单链表的首结点，其时间复杂度为 O(m)。', 'O(1)', 'O(n)', 'O(m)', 'O(n+m)'),
(13, '00000000-0000-0000-0000-000000039013', '2.3', 'BASIC', 'pp.52,58', '单链表中，增加一个头结点的目的是（ ）。', 'C', '单链表设置头结点的目的是方便运算的实现，主要好处体现在：第一，有头结点后，插入和删除数据元素的算法就统一了，不再需要判断是否在第一个元素之前插入或删除第一个元素；第二，不论链表是否为空，其头指针是指向头结点的非空指针，链表的头指针不变，因此空表和非空表的处理也就统一了。', '使单链表至少有一个结点', '标识表结点中首结点的位置', '方便运算的实现', '说明单链表是线性表的链式存储'),
(14, '00000000-0000-0000-0000-000000039014', '2.3', 'MEDIUM', 'pp.52,58', '在一个长度为 n 的带头结点的单链表 h 上，设有尾指针 r，则执行（ ）操作与链表的表长有关。', 'B', '删除单链表的最后一个结点需置其前驱结点的指针域为 NULL，需要从头开始依次遍历找到该前驱结点，需要 O(n) 的时间，与表长有关。其他操作均与表长无关。', '删除单链表中的第一个元素', '删除单链表中的最后一个元素', '在单链表第一个元素前插入一个新元素', '在单链表最后一个元素后插入一个新元素');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 2 章 ' || q.section_code || ' 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch2_a_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_LINEAR_LIST';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000139', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch2_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000139', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch2_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000139', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch2_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000139', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch2_a_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch2_a_import q
JOIN knowledge_points kp ON kp.code = 'DS_LINEAR_LIST_BASIC';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000039701', 'DS-2027-ORIGINAL-CH2-A'),
    ('00000000-0000-0000-0000-000000039702', '第2章线性表'),
    ('00000000-0000-0000-0000-000000039703', '2.1线性表定义和基本操作'),
    ('00000000-0000-0000-0000-000000039704', '2.3线性表链式表示')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch2_a_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH2-A',
    '第2章线性表',
    CASE WHEN q.section_code = '2.1' THEN '2.1线性表定义和基本操作' ELSE '2.3线性表链式表示' END,
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

DROP TABLE ds_2027_original_ch2_a_import;
