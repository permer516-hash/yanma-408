-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Section: 2.2.3 本节试题精选 / 2.2.4 答案与解析
-- Batch: DS-2027-ORIGINAL-2-2

CREATE TABLE ds_2027_original_2_2_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer VARCHAR(1) NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_2_2_import (
    num, id, chapter_code, kp_code, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000034001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', 'pp.30,33', '下列叙述中，（ ）是顺序存储结构的优点。', 'A', '顺序表不像链表那样要在结点中存放指针域，因此存储密度大，选项 A 正确。选项 B 和 C 是链表的优点。选项 D 是错误的，比如对于树形结构，顺序表显然不如链表表示起来方便。', '存储密度大', '插入运算方便', '删除运算方便', '方便地运用于各种逻辑结构的存储表示'),
(2, '00000000-0000-0000-0000-000000034002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', 'pp.30,33', '下列关于顺序表的叙述中，正确的是（ ）。', 'C', '顺序表是顺序存储的线性表，表中所有元素的类型必须相同，且必须连续存放。一维数组中的元素可以不连续存放；此外，栈、队列和树等逻辑结构也可利用一维数组表示，但它与顺序表不属于相同的逻辑结构。在顺序表中，逻辑上相邻的元素物理位置上也相邻。', '顺序表可以利用一维数组表示，因此顺序表与一维数组在逻辑结构上是相同的', '在顺序表中，逻辑上相邻的元素物理位置上不一定相邻', '顺序表和一维数组一样，都可以进行随机存取', '在顺序表中，每个元素的类型不必相同'),
(3, '00000000-0000-0000-0000-000000034003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', 'pp.30-31,33', '通常说顺序表具有随机存取的特性，指的是（ ）。', 'C', '随机存取是指在 O(1) 的时间访问下标为 i 的元素，所需时间与顺序表中的元素个数 n 无关。', '查找值为 x 的元素的时间与顺序表中元素个数 n 无关', '查找值为 x 的元素的时间与顺序表中元素个数 n 有关', '查找序号为 i 的元素的时间与顺序表中元素个数 n 无关', '查找序号为 i 的元素的时间与顺序表中元素个数 n 有关'),
(4, '00000000-0000-0000-0000-000000034004', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', 'pp.31,33', '一个顺序表所占用的存储空间大小与（ ）无关。', 'B', '顺序表所占的存储空间 = 表长 x sizeof(元素的类型)，表长和元素的类型显然会影响存储空间的大小。若元素为结构体类型，则元素中各字段的类型也会影响存储空间的大小。', '表的长度', '元素的存放顺序', '元素的类型', '元素中各字段的类型'),
(5, '00000000-0000-0000-0000-000000034005', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.31,34', '若线性表最常用的操作是存取第 i 个元素及其前驱和后继元素的值，为了提高效率，应采用（ ）的存储方式。', 'D', '题干实际要求能最快存取第 i-1、i 和 i+1 个元素值。选项 A、B、C 都只能从头结点依次顺序查找，时间复杂度为 O(n)；只有顺序表可以按序号随机存取，时间复杂度为 O(1)。', '单链表', '双链表', '循环单链表', '顺序表'),
(6, '00000000-0000-0000-0000-000000034006', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.31,34', '一个线性表最常用的操作是存取任意一个指定序号的元素并在最后进行插入、删除操作，则利用（ ）存储方式可以节省时间。', 'A', '只有顺序表可以按序号随机存取，且在最后进行插入和删除操作时不需要移动任何元素。', '顺序表', '双链表', '带头结点的循环双链表', '循环单链表'),
(7, '00000000-0000-0000-0000-000000034007', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.31,34', '在 n 个元素的线性表的数组表示中，时间复杂度为 O(1) 的操作是（ ）。\nI. 访问第 i（1<=i<=n）个结点和求第 i（2<=i<=n）个结点的直接前驱\nII. 在最后一个结点后插入一个新的结点\nIII. 删除第 1 个结点\nIV. 在第 i（1<=i<=n）个结点后插入一个结点', 'C', '对说法 I，解析略；对说法 II，在最后位置插入新结点不需要移动元素，时间复杂度为 O(1)；对说法 III，被删结点后的结点需要依次前移，时间复杂度为 O(n)；对说法 IV，需要后移 n-i 个结点，时间复杂度为 O(n)。', 'I', 'II、III', 'I、II', 'I、II、III'),
(8, '00000000-0000-0000-0000-000000034008', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.31,34', '设线性表有 n 个元素，严格说来，以下操作中，（ ）在顺序表上实现要比在链表上实现的效率高。\nI. 输出第 i（1<=i<=n）个元素值\nII. 交换第 3 个元素与第 4 个元素的值\nIII. 顺序输出这 n 个元素的值', 'C', '对说法 II，顺序表只需 3 次交换操作；链表需要分别找到两个结点前驱，第 4 个结点断链后再插入到第 2 个结点后，效率较低。对说法 III，需要依次顺序访问每个元素，时间复杂度相同。', 'I', 'I、III', 'I、II', 'II、III'),
(9, '00000000-0000-0000-0000-000000034009', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.31,34', '在一个长度为 n 的顺序表中删除第 i（1<=i<=n）个元素时，需向前移动（ ）个元素。', 'C', '需要将元素 a_{i+1} 到 a_n 依次前移一位，共移动 n-(i+1)+1 = n-i 个元素。', 'n', 'i-1', 'n-i', 'n-i+1'),
(10, '00000000-0000-0000-0000-000000034010', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.31,34', '对于顺序表，访问第 i 个位置的元素和在第 i 个位置插入一个元素的时间复杂度为（ ）。', 'C', '在第 i 个位置插入一个元素，需要移动 n-i+1 个元素，时间复杂度为 O(n)。顺序表访问第 i 个位置的元素可随机存取，时间复杂度为 O(1)。', 'O(n)，O(n)', 'O(n)，O(1)', 'O(1)，O(n)', 'O(1)，O(1)'),
(11, '00000000-0000-0000-0000-000000034011', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.31,34', '对于顺序存储的线性表，其算法时间复杂度为 O(1) 的运算应该是（ ）。', 'C', '对 n 个元素进行排序的时间复杂度最小也要 O(n)（初始有序时），通常为 O(nlog2n) 或 O(n^2)，通过第 8 章学习后会更容易理解。选项 B 和 D 显然错误。顺序表支持按序号的随机存取方式。', '将 n 个元素从小到大排序', '删除第 i（1<=i<=n）个元素', '改变第 i（1<=i<=n）个元素的值', '在第 i（1<=i<=n）个元素后插入一个新元素'),
(12, '00000000-0000-0000-0000-000000034012', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', 'pp.31,34', '顺序表的插入算法中，当 n 个空间已满时，可再申请增加分配 m 个空间，若申请失败，则说明系统没有（ ）可分配的存储空间。', 'D', '顺序存储需要连续的存储空间，在申请时需申请 n+m 个连续的存储空间，然后将线性表原来的 n 个元素复制到新申请的 n+m 个连续的存储空间的前 n 个单元。', 'm 个', 'm 个连续', 'n+m 个', 'n+m 个连续');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，2.2.3 本节试题精选与 2.2.4 答案与解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_2_2_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000134', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_2_2_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000134', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_2_2_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000134', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_2_2_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000134', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_2_2_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_2_2_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000034701', 'DS-2027-ORIGINAL-2-2'),
    ('00000000-0000-0000-0000-000000034702', '授权原题'),
    ('00000000-0000-0000-0000-000000034703', '本节试题精选'),
    ('00000000-0000-0000-0000-000000034704', '原答案解析')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_2_2_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-2-2',
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

DROP TABLE ds_2027_original_2_2_import;
