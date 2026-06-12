-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.2.5/3.2.6 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-E

CREATE TABLE ds_2027_original_ch3_e_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_type VARCHAR(16) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch3_e_import (
    num, id, difficulty, source_type, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(13, '00000000-0000-0000-0000-000000046013', 'MEDIUM', 'MOCK', 'pp.95,98', '下列描述的几种链表中，最不适合用作链式队列的是（ ）。', 'A', '非循环双链表只带队首指针时，入队需要修改队尾结点的指针域，而查找队尾结点需要 O(n) 时间。选项 B、C、D 均可在 O(1) 时间内找到队首和队尾。', '只带队首指针的非循环双链表', '只带队首指针的循环双链表', '只带队尾指针的循环双链表', '只带队尾指针的循环单链表'),
(14, '00000000-0000-0000-0000-000000046014', 'BASIC', 'MOCK', 'pp.95,98', '在用单链表实现队列时，队头设在链表的（ ）位置。', 'A', '队列在队头做出队操作。为了便于删除队首元素，通常总是选择链头作为队头。', '链头', '链尾', '链中', '以上都可以'),
(15, '00000000-0000-0000-0000-000000046015', 'MEDIUM', 'MOCK', 'pp.95,98', '用链式存储方式的队列进行删除操作时需要（ ）。', 'D', '链式队列删除元素时从表头删除，通常只需修改头指针。但若队列中只有一个元素，删除后队列为空，还需要修改队尾指针为 rear=front。', '仅修改头指针', '仅修改尾指针', '头尾指针都要修改', '头尾指针可能都需要修改'),
(16, '00000000-0000-0000-0000-000000046016', 'BASIC', 'MOCK', 'pp.95,98', '在一个链式队列中，假设队首指针为 front，队尾指针为 rear，x 所指向的元素需要入队，则需要执行的操作为（ ）。', 'D', '插入操作时，先将结点 x 插入到链表尾部，再让 rear 指向结点 x。选项 C 不够严密，因为 x 成为队尾后，x->next 必须置为空。', 'front=x，front=front->next', 'x->next=front->next，front=x', 'rear->next=x，rear=x', 'rear->next=x，x->next=NULL，rear=x'),
(17, '00000000-0000-0000-0000-000000046017', 'MEDIUM', 'MOCK', 'pp.95,98', '假设循环单链表表示的队列长度为 n，队头固定在链表尾，若只设头指针，则入队操作的时间复杂度为（ ）。', 'A', '入队在队尾进行，即链表表头。题中已明确链表只设头指针，即没有头结点和尾指针。入队后循环单链表必须保持循环性质，在只带头指针的循环单链表中寻找表尾结点需要 O(n) 时间，所以入队时间复杂度为 O(n)。', 'O(n)', 'O(1)', 'O(n^2)', 'O(nlog2n)'),
(18, '00000000-0000-0000-0000-000000046018', 'MEDIUM', 'MOCK', 'pp.95,98', '假设输入序列为 1,2,3,4,5，利用两个队列进行出入队操作，不可能输出的序列是（ ）。', 'B', '可对各选项逐项模拟。若 5 最先出队，则 1、2、3、4 只能先进入另一个队列，随后 5 出队，只能得到 5,1,2,3,4，因此 5,2,3,4,1 不可能得到。', '1,2,3,4,5', '5,2,3,4,1', '1,3,2,4,5', '4,1,5,2,3'),
(19, '00000000-0000-0000-0000-000000046019', 'HARD', 'MOCK', 'pp.95,98', '若以 1,2,3,4 作为双端队列的输入序列，则既不能由输入受限的双端队列得到，又不能由输出受限的双端队列得到的输出序列是（ ）。', 'C', '使用排除法。4,3,2,1 可由输入受限双端队列依次左入、再依次左出得到，4,1,3,2 也可由输入受限双端队列得到；4,2,1,3 可由输出受限双端队列得到。因此不能得到的是 4,2,3,1。', '1,2,3,4', '4,1,3,2', '4,2,3,1', '4,2,1,3'),
(20, '00000000-0000-0000-0000-000000046020', 'HARD', 'PAST_EXAM', 'pp.95,98', '【2010 统考真题】某队列允许在其两端进行入队操作，但仅允许在一端进行出队操作。若元素 a,b,c,d,e 依次入此队列后再进行出队操作，则不可能得到的出队序列是（ ）。', 'C', '该队列实际是输出受限的双端队列。初始队列为空，第一个元素 a 入队后，第二个元素 b 无论从左端还是右端入队都必与 a 相邻，而选项 C 中 a 与 b 不相邻，不合题意。', 'b,a,c,d,e', 'd,b,a,c,e', 'd,b,c,a,e', 'e,c,b,a,d'),
(21, '00000000-0000-0000-0000-000000046021', 'MEDIUM', 'PAST_EXAM', 'pp.95-96,98', '【2011 统考真题】已知循环队列存储在一维数组 A[0..n-1] 中，且队列非空时 front 和 rear 分别指向队首元素和队尾元素。若初始时队列为空，且要求第一个进入队列的元素存储在 A[0] 处，则初始时 front 和 rear 的值分别是（ ）。', 'B', '第一个元素进入队列后存储在 A[0] 处，此时 front 和 rear 均为 0。入队时要执行 rear=(rear+1) mod n 操作，所以若入队后 rear 指向 0，则 rear 初值为 n-1；而第一个元素在 A[0] 中，插入操作只改变 rear 指针，所以 front 为 0 不变。', '0,0', '0,n-1', 'n-1,0', 'n-1,n-1'),
(22, '00000000-0000-0000-0000-000000046022', 'HARD', 'PAST_EXAM', 'pp.96,99', '【2014 统考真题】循环队列放在一维数组 A[0..M-1] 中，end1 指向队首元素，end2 指向队尾元素的后一个位置。假设队列两端均可进行入队和出队操作，队列中最多能容纳 M-1 个元素。初始时为空。下列判断队空和队满的条件中，正确的是（ ）。', 'A', '初始时队列为空，end1 和 end2 的初值均为 0，因此队空条件为 end1==end2。队满时队列实际存储在 0 到 M-2 的 M-1 个区域，队头为 A[0]，队尾为 A[M-2]，此时 end1=0，end2=M-1，所以队满条件为 end1==(end2+1) mod M。', '队空：end1==end2；队满：end1==(end2+1) mod M', '队空：end1==end2；队满：end2==(end1+1) mod (M-1)', '队空：end2==(end1+1) mod M；队满：end1==(end2+1) mod M', '队空：end1==(end2+1) mod M；队满：end2==(end1+1) mod (M-1)'),
(23, '00000000-0000-0000-0000-000000046023', 'HARD', 'PAST_EXAM', 'pp.96,99', '【2018 统考真题】现有队列 Q 与栈 S，初始时 Q 中的元素依次是 1,2,3,4,5,6（1 在队头），S 为空。若仅允许下列 3 种操作：① 出队并输出出队元素；② 出队并将出队元素入栈；③ 出栈并输出出栈元素，则不能得到的输出序列是（ ）。', 'C', '逐项模拟可知，选项 A 的操作顺序为 ①①②②①①③③；选项 B 的操作顺序为 ②①①①①①③；选项 D 的操作顺序为 ②②②②②①③③③③③。对于选项 C，若首先输出 3，则 1 和 2 必须先依次入栈，而此后 2 肯定比 1 先输出，因此无法得到 1,2 的输出顺序。', '1,2,5,6,4,3', '2,3,4,5,6,1', '3,4,5,6,1,2', '6,5,4,3,2,1'),
(24, '00000000-0000-0000-0000-000000046024', 'HARD', 'PAST_EXAM', 'pp.96,99', '【2021 统考真题】初始为空的队列 Q 的一端仅能进行入队操作，另外一端既能进行入队操作又能进行出队操作。若 Q 的入队序列是 1,2,3,4,5，则不能得到的出队序列是（ ）。', 'D', '设队列左端允许入队和出队，右端只能入队。选项 A、B、C 均可通过相应的两端入队安排得到。对选项 D，无论 1 从哪端入队，都无法在 4 和 3 之间输出 1，因此不能得到 4,1,3,2,5。', '5,4,3,1,2', '5,3,1,2,4', '4,2,1,3,5', '4,1,3,2,5');

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
FROM ds_2027_original_ch3_e_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STACK_QUEUE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000146', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_e_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000146', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_e_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000146', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_e_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000146', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_e_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_e_import q
JOIN knowledge_points kp ON kp.code = 'DS_STACK_QUEUE_APPLICATION';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000046701', 'DS-2027-ORIGINAL-CH3-E')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_e_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-E',
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

DROP TABLE ds_2027_original_ch3_e_import;
