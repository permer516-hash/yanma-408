-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 2 close-out: 2.3.7/2.3.8 question 11
-- Chapter 3 start: 3.1.4/3.1.5 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH2-D and DS-2027-ORIGINAL-CH3-A

CREATE TABLE ds_2027_original_ch2_d_ch3_a_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    knowledge_point_code VARCHAR(64) NOT NULL,
    section_tag VARCHAR(64) NOT NULL,
    batch_tag VARCHAR(64) NOT NULL,
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

INSERT INTO ds_2027_original_ch2_d_ch3_a_import (
    num, id, chapter_code, knowledge_point_code, section_tag, batch_tag, difficulty, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000042001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', '2.3线性表链式表示', 'DS-2027-ORIGINAL-CH2-D', 'BASIC', 'pp.52,58', '对于一个头指针为 head 的带头结点的单链表，判定该表为空表的条件是（ ）；对于不带头结点的单链表，判定空表的条件为（ ）。
A. head==NULL
B. head->next==NULL
C. head->next==head
D. head!=NULL', 'B', '在带头结点的单链表中，头指针 head 指向头结点，头结点的 next 域指向第一个元素结点，head->next==NULL 表示该单链表为空。在不带头结点的单链表中，head 直接指向第一个元素结点，head==NULL 表示该单链表为空。原答案为 B、A；为适配当前单选作答 UI，本题使用组合选项。', '带头结点：A；不带头结点：B', '带头结点：B；不带头结点：A', '带头结点：C；不带头结点：A', '带头结点：D；不带头结点：B'),
(2, '00000000-0000-0000-0000-000000042101', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'BASIC', 'pp.79,81', '栈和队列具有相同的（ ）。', 'B', '栈和队列的逻辑结构都是相同的，都属于线性结构，只是它们对数据的运算不同。', '抽象数据类型', '逻辑结构', '存储结构', '运算'),
(3, '00000000-0000-0000-0000-000000042102', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'BASIC', 'pp.79,81', '栈是一种（ ）。', 'C', '栈是一种线性表；按存储结构可分为顺序栈和链栈，不能把栈局限在某一种存储结构上。栈和队列都是限制存取点的线性结构。', '顺序存储的线性结构', '链式存储的非线性结构', '限制存取点的线性结构', '限制存取点的非线性结构'),
(4, '00000000-0000-0000-0000-000000042103', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'BASIC', 'pp.79,81', '下列选项中，（ ）不是栈的基本操作。', 'B', '基本操作是指数据结构最核心、最基本的运算，其他较复杂的操作可通过基本操作实现。删除栈底元素不属于栈的基本运算，但它可以通过调用栈的基本运算得到。', '删除栈顶元素', '删除栈底元素', '判断栈是否为空', '将栈置为空栈'),
(5, '00000000-0000-0000-0000-000000042104', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79,82', '设用数组 a[n] 存储一个栈，初始栈顶指针 top=-1，则元素 x 入栈的操作是（ ）。', 'C', '数组下标范围为 0 到 n-1，初始时 top=-1。第一个元素入栈后 top 为 0，即 top 指向栈顶元素。栈向高地址方向增长，所以入栈时应先将 top 加 1，然后存入元素 x。', 'a[--top]=x', 'a[top--]=x', 'a[++top]=x', 'a[top++]=x'),
(6, '00000000-0000-0000-0000-000000042105', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79,82', '设用数组 data[1..n] 存储一个栈，初始栈顶指针 top=1，则元素 x 入栈的操作是（ ）。', 'B', '数组下标范围为 1 到 n，初始时 top 为 1，表示 top 指向栈顶元素的下一个元素。栈向高地址方向增长，所以入栈时应先存入元素，然后将指针 top 加 1。', 'data[top--]=x', 'data[top++]=x', 'data[--top]=x', 'data[++top]=x'),
(7, '00000000-0000-0000-0000-000000042106', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79,82', '设用数组 data[1..n] 存储一个栈，初始栈顶指针 top=n+1，则元素 x 入栈的操作是（ ）。', 'A', '数组下标范围为 1 到 n，初始时 top=n+1，表示 top 指向栈顶元素。栈向低地址方向增长，所以入栈时应先将指针 top 减 1，然后存入元素 x。', 'data[--top]=x', 'data[top++]=x', 'data[top--]=x', 'data[++top]=x'),
(8, '00000000-0000-0000-0000-000000042107', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79,82', '设有一个空栈，栈顶指针为 1000H，栈向高地址方向增长，每个元素占一个存储单元。执行 Push、Push、Pop、Push、Pop、Push、Pop、Push 操作后，栈顶指针为（ ）。', 'A', '每个元素占一个存储单元，因此每入栈一次 top 加 1，出栈一次 top 减 1。指针 top 的值依次为 1001H、1002H、1001H、1002H、1001H、1002H、1001H、1002H。', '1002H', '1003H', '1004H', '1005H'),
(9, '00000000-0000-0000-0000-000000042108', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'BASIC', 'pp.79,82', '和顺序栈相比，链栈有一个比较明显的优势，即（ ）。', 'A', '顺序栈采用数组存储，数组大小是固定的，不能动态分配大小。和顺序栈相比，链栈的最大优势在于它可以动态分配存储空间。', '通常不会出现栈满的情况', '通常不会出现栈空的情况', '插入操作更容易实现', '删除操作更容易实现'),
(10, '00000000-0000-0000-0000-000000042109', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79,82', '设链栈不带头结点且所有操作均在表头进行，则下列最不适合作为链栈的是（ ）。', 'C', '对于双向循环链表，不管是表头指针还是表尾指针，都可以很方便地找到表头结点，方便在表头做插入或删除操作。而循环单链表通过尾指针可以很方便地找到表头结点，但通过头指针找尾结点需要遍历一遍链表。', '只有表头结点指针，没有表尾指针的双向循环链表', '只有表尾结点指针，没有表头指针的双向循环链表', '只有表头结点指针，没有表尾指针的单向循环链表', '只有表尾结点指针，没有表头指针的单向循环链表'),
(11, '00000000-0000-0000-0000-000000042110', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79,82', '向一个栈顶指针为 top 的链栈（不带头结点）中插入一个 x 结点，则执行（ ）。', 'C', '链栈采用不带头结点的单链表表示时，入栈操作是在首部插入一个结点 x，即 x->next=top；插入完成后需要将 top 指向新插入的结点 x。', 'top->next=x', 'x->next=top->next; top->next=x', 'x->next=top; top=x', 'x->next=top; top=top->next'),
(12, '00000000-0000-0000-0000-000000042111', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79,82', '链栈（不带头结点）执行 Pop 操作，并将出栈的元素存在 x 中，应该执行（ ）。', 'D', '这里假设栈顶指针指向的是栈顶元素，所以先取出 top->data 保存到 x 中，再将 top 指向下一个结点。', 'x=top; top=top->next', 'x=top->data', 'top=top->next; x=top->data', 'x=top->data; top=top->next'),
(13, '00000000-0000-0000-0000-000000042112', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'BASIC', 'pp.79,82', '经过以下栈的操作后，变量 x 的值为（ ）。
InitStack(st); Push(st, a); Push(st, b); Pop(st, x); GetTop(st, x);', 'A', '执行前 3 句后，栈 st 内的值为 a、b，其中 b 为栈顶元素；执行第 4 句后，栈顶元素 b 出栈，x 的值为 b；执行最后一句，读取栈顶元素的值，x 的值为 a。', 'a', 'b', 'NULL', 'false'),
(14, '00000000-0000-0000-0000-000000042113', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', '3.1栈', 'DS-2027-ORIGINAL-CH3-A', 'MEDIUM', 'pp.79-80,82', '3 个不同元素依次入栈，能得到（ ）种不同的出栈序列。', 'B', '当 n 个不同元素入栈时，出栈序列的个数为卡特兰数。对于 3 个元素，也可以采用列举方法，可能的出栈序列共有 5 种。', '4', '5', '6', '7');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 ' ||
        CASE WHEN q.chapter_code = 'DS_LINEAR_LIST' THEN '2 章 2.3.7/2.3.8' ELSE '3 章 3.1.4/3.1.5' END ||
        ' 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch2_d_ch3_a_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000142', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch2_d_ch3_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000142', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch2_d_ch3_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000142', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch2_d_ch3_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000142', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch2_d_ch3_a_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch2_d_ch3_a_import q
JOIN knowledge_points kp ON kp.code = q.knowledge_point_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000042701', 'DS-2027-ORIGINAL-CH2-D'),
    ('00000000-0000-0000-0000-000000042702', 'DS-2027-ORIGINAL-CH3-A'),
    ('00000000-0000-0000-0000-000000042703', '第3章栈队列和数组'),
    ('00000000-0000-0000-0000-000000042704', '3.1栈')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch2_d_ch3_a_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    q.batch_tag,
    CASE WHEN q.chapter_code = 'DS_LINEAR_LIST' THEN '第2章线性表' ELSE '第3章栈队列和数组' END,
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

DROP TABLE ds_2027_original_ch2_d_ch3_a_import;
