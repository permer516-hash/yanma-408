-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.2.5/3.2.6 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-D

CREATE TABLE ds_2027_original_ch3_d_import (
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

INSERT INTO ds_2027_original_ch3_d_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000045001', 'BASIC', 'pp.94,96', '栈和队列的主要区别在于（ ）。', 'D', '栈和队列同属于操作受限的线性表，其逻辑结构可以相同，主要区别在于插入、删除操作的限定不同。', '它们的逻辑结构不一样', '它们的存储结构不一样', '所包含的元素不一样', '插入、删除操作的限定不一样'),
(2, '00000000-0000-0000-0000-000000045002', 'BASIC', 'pp.94,97', '队列的“先进先出”特性是指（ ）。
I. 最后插入队列中的元素总是最后被删除
II. 当同时进行插入、删除操作时，总是插入操作优先
III. 每当有删除操作时，总是先做一次插入操作
IV. 每次从队列中删除的总是最早插入的元素', 'B', '队列的先进先出是指最早插入的元素最早被删除，因此最后插入的元素总是最后被删除。入队对应插入操作，出队对应删除操作，说法 I 和 IV 正确。', 'I', 'I 和 IV', 'II 和 III', 'IV'),
(3, '00000000-0000-0000-0000-000000045003', 'BASIC', 'pp.94,97', '允许对队列进行的操作有（ ）。', 'D', '删除队首元素即出队，是队列的基本操作之一。队列不允许对中间元素排序、取最近入队元素或在元素之间插入元素。', '对队列中的元素排序', '取出最近入队的元素', '在队列元素之间插入元素', '删除队首元素'),
(4, '00000000-0000-0000-0000-000000045004', 'BASIC', 'pp.94,97', '一个队列的入队序列是 1,2,3,4，则出队的输出顺序是（ ）。', 'B', '队列的入队顺序和出队顺序一致，这是队列和栈不同的地方。', '4,3,2,1', '1,2,3,4', '1,4,3,2', '3,2,4,1'),
(5, '00000000-0000-0000-0000-000000045005', 'MEDIUM', 'pp.94,97', '循环队列存储在数组 A[0..n] 中，入队时的操作为（ ）。', 'D', '数组下标范围为 0 到 n，因此数组容量为 n+1。循环队列中元素入队操作为 rear=(rear+1) mod maxsize，其中 maxsize=n+1。', 'rear=rear+1', 'rear=(rear+1) mod (n-1)', 'rear=(rear+1) mod n', 'rear=(rear+1) mod (n+1)'),
(6, '00000000-0000-0000-0000-000000045006', 'MEDIUM', 'pp.94,97', '已知循环队列的存储空间为数组 A[21]，front 指向队首元素的前一个位置，rear 指向队尾元素，假设当前 front 和 rear 的值分别为 8 和 3，则该队列的长度为（ ）。', 'C', '队列长度为 (rear-front+maxsize) mod maxsize，即 (3-8+21) mod 21=16。这和 front 指向队首元素、rear 指向队尾元素的下一个位置时的计算相同。', '3', '6', '16', '17'),
(7, '00000000-0000-0000-0000-000000045007', 'MEDIUM', 'pp.94,97', '若用数组 A[0..5] 实现循环队列，且当前 rear 和 front 的值分别为 1 和 5，当从队列中删除一个元素，再加入两个元素后，rear 和 front 的值分别为（ ）。', 'B', '循环队列中，每删除一个元素，队首指针 front=(front+1) mod 6；每加入一个元素，队尾指针 rear=(rear+1) mod 6。上述操作后 front=0，rear=3。', '3 和 4', '3 和 0', '5 和 0', '5 和 1'),
(8, '00000000-0000-0000-0000-000000045008', 'BASIC', 'pp.94,97', '假设用数组 Q[MaxSize] 实现循环队列，队首指针 front 指向队首元素的前一个位置，队尾指针 rear 指向队尾元素，则判断该队列为空的条件是（ ）。', 'D', '当队列中只有一个元素时，front 指向该元素的前一个位置，rear 指向该元素。队列为空时，队首指针等于队尾指针。', 'Q.rear==(Q.front+1)%MaxSize', '(Q.rear+1)%MaxSize==Q.front+1', '(Q.rear+1)%MaxSize==Q.front', 'Q.rear==Q.front'),
(9, '00000000-0000-0000-0000-000000045009', 'MEDIUM', 'pp.94,97', '假设循环队列 Q[MaxSize] 的队首指针为 front，队尾指针为 rear，队列的最大容量为 MaxSize，此外，该队列再没有其他数据成员，则判断该队列已满的条件是（ ）。', 'C', '为了区分队空和队满，循环队列通常牺牲一个存储单元。队尾指针的下一个位置为队首时，表示队满，即 front==(rear+1)%MaxSize。', 'Q.front==Q.rear', 'Q.front+Q.rear>=MaxSize', 'Q.front==(Q.rear+1)%MaxSize', 'Q.rear==(Q.front+1)%MaxSize'),
(10, '00000000-0000-0000-0000-000000045010', 'MEDIUM', 'pp.94-95,97', '假设用 A[0..n] 实现循环队列，front、rear 分别指向队首元素的前一个位置和队尾元素。若用 (rear+1)%(n+1)==front 作为队满标志，则（ ）。', 'A', '若用 (rear+1)%(n+1)==front 作为队满标志，则该方法本身已经区分队空和队满，因此可用 front==rear 作为队空标志。', '可用 front==rear 作为队空标志', '队列中最多可有 n+1 个元素', '可用 front>rear 作为队空标志', '可用 (front+1)%(n+1)==rear 作为队空标志'),
(11, '00000000-0000-0000-0000-000000045011', 'BASIC', 'pp.95,97', '与顺序队列相比，链式队列的（ ）。', 'D', '链式队列采用动态分配方式，但长度仍受内存空间限制；顺序队列和链式队列的入队、出队时间复杂度均为 O(1)；两者都可以顺序访问。对于顺序队列，可通过队首指针和队尾指针计算队列长度，而链式队列通常不能仅根据这两个指针计算长度。', '优点是队列的长度不受限制', '优点是入队和出队时间效率更高', '缺点是不能进行顺序访问', '缺点是不能根据队首指针和队尾指针计算队列的长度'),
(12, '00000000-0000-0000-0000-000000045012', 'MEDIUM', 'pp.95,97', '下列描述的几种链表中，最适合用作队列的是（ ）。', 'B', '队列需要在两端进行操作。带队首指针和队尾指针的非循环单链表既能方便地在队头删除，也能方便地在队尾插入；循环结构对队列不是必要条件。', '带队首指针和队尾指针的循环单链表', '带队首指针和队尾指针的非循环单链表', '只带队首指针的非循环单链表', '只带队首指针的循环单链表');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 3 章 3.2.5/3.2.6 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch3_d_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STACK_QUEUE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000145', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_d_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000145', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_d_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000145', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_d_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000145', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_d_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_d_import q
JOIN knowledge_points kp ON kp.code = 'DS_STACK_QUEUE_APPLICATION';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000045701', 'DS-2027-ORIGINAL-CH3-D'),
    ('00000000-0000-0000-0000-000000045702', '3.2队列')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_d_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-D',
    '第3章栈队列和数组',
    '3.2队列',
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

DROP TABLE ds_2027_original_ch3_d_import;
