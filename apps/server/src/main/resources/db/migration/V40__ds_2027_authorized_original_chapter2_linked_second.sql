-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 2: 2.3.7/2.3.8 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH2-B

CREATE TABLE ds_2027_original_ch2_b_import (
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

INSERT INTO ds_2027_original_ch2_b_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(12, '00000000-0000-0000-0000-000000040012', 'MEDIUM', 'pp.52,59', '在线性表 a0,a1,…,a100 中，删除元素 a50 需要移动（ ）个元素。', 'D', '线性表有顺序存储和链式存储两种存储结构。若采用链式存储结构，则删除元素 a50 不需要移动元素；若采用顺序存储结构，则需要依次移动 50 个元素。', '0', '50', '51', '0 或 50'),
(13, '00000000-0000-0000-0000-000000040013', 'BASIC', 'pp.52-53,59', '通过含有 n（n>1）个元素的数组 a 采用头插法建立单链表 L，则 L 中的元素次序（ ）。', 'B', '当采用头插法建立单链表时，数组后面的元素插入到单链表 L 的最前端，所以 L 中的元素次序与数组 a 的元素次序相反。', '与数组 a 的元素次序相同', '与数组 a 的元素次序相反', '与数组 a 的元素次序无关', '以上都错误'),
(14, '00000000-0000-0000-0000-000000040014', 'MEDIUM', 'pp.53,59', '下面关于线性表的一些说法中，正确的是（ ）。', 'C', '选项 A 显然错误。选项 B 中第一个元素和最后一个元素不满足题设要求。双链表能很方便地访问前驱和后继，故删除和插入数据较为方便，选项 C 正确。选项 D 未考虑顺序存储的情况。', '对一个设有头指针和尾指针的单链表执行删除最后一个元素的操作与链表长度无关', '线性表中每个元素都有一个直接前驱和一个直接后继', '为了方便插入和删除数据，可以使用双链表存放数据', '取线性表第 i 个元素的时间与 i 的大小有关'),
(15, '00000000-0000-0000-0000-000000040015', 'MEDIUM', 'pp.53,59', '在双链表中向 p 所指的结点之前插入一个结点 q 的操作为（ ）。', 'D', '为了在 p 之前插入结点 q，可以将 p 的前一个结点的 next 域指向 q，将 q 的 next 域指向 p，将 q 的 prior 域指向 p 的前一个结点，将 p 的 prior 域指向 q。仅选项 D 满足条件。', 'p->prior=q; q->next=p; p->prior->next=q; q->prior=p->prior;', 'q->prior=p->prior; p->prior->next=q; q->next=p; p->prior=q->next;', 'q->next=p; p->next=q; q->prior->next=q; q->next=p;', 'p->prior->next=q; q->next=p; q->prior=p->prior; p->prior=q;'),
(16, '00000000-0000-0000-0000-000000040016', 'MEDIUM', 'pp.53,59', '在双链表存储结构中，删除 p 所指的结点时必须修改指针（ ）。', 'A', '与上一题的分析基本类似，只不过这里是删除一个结点，注意将 p 的前、后两结点链接起来。关键是要保证在结点指针的修改过程中不断链。', 'p->prior->next=p->next; p->next->prior=p->prior;', 'p->prior=p->prior->prior; p->prior->next=p;', 'p->next->prior=p; p->next=p->next->next;', 'p->next=p->prior->prior; p->prior=p->next->next;'),
(17, '00000000-0000-0000-0000-000000040017', 'HARD', 'pp.53,59', '在双链表中，已知指针 p 指向结点 A，若要在结点 A 和 C 之间插入指针 q 所指的结点 B，则依次执行的语句序列可以是（ ）。
① q->next=p->next;
② q->prior=p;
③ p->next=q;
④ p->next->prior=q;', 'A', '结点 A 和 B 分别由指针 p 和 q 指示，但结点 C 仅能由 p->next 间接指示，因此在改变 p->next 之前，必须先将 q->next 指向结点 C，即①要在③前面，且④要在③前面（因为若先执行③，则④相当于 q->prior 指向其自身，显然矛盾）。故只能选择选项 A。', '①②④③', '④③②①', '③④①②', '①③④②'),
(18, '00000000-0000-0000-0000-000000040018', 'BASIC', 'pp.53,59', '在双链表的两个结点之间插入一个新结点，需要修改（ ）个指针域。', 'C', '当在双链表的两个结点之间插入一个新结点时，需要修改四个指针域，分别是：新结点的前驱指针域、后继指针域，第一个结点的后继指针域，以及第二个结点的前驱指针域。', '1', '3', '4', '2'),
(19, '00000000-0000-0000-0000-000000040019', 'MEDIUM', 'pp.53,59', '在长度为 n 的有序单链表中插入一个新结点，并仍然保持有序的时间复杂度是（ ）。', 'B', '设单链表递增有序，首先要在单链表中找到第一个大于 x 的结点的直接前驱 p，在 p 之后插入该结点。查找的时间复杂度为 O(n)，插入的时间复杂度为 O(1)，总时间复杂度为 O(n)。', 'O(1)', 'O(n)', 'O(n^2)', 'O(nlog2n)'),
(20, '00000000-0000-0000-0000-000000040020', 'MEDIUM', 'pp.53,59', '与单链表相比，双链表的优点之一是（ ）。', 'D', '在插入和删除操作上，单链表和双链表都不用移动元素，都很方便，但双链表修改指针的操作更为复杂，选项 A 错误。双链表中可以快速访问任意一个结点的前驱和后继结点，选项 D 正确。', '插入、删除操作更方便', '可以进行随机访问', '可以省略表头指针或表尾指针', '访问前后相邻结点更灵活'),
(21, '00000000-0000-0000-0000-000000040021', 'BASIC', 'pp.53,59', '对于一个带头结点的循环单链表 L，判断该表为空表的条件是（ ）。', 'C', '带头结点的循环单链表为空表时，满足 L->next==L，即头结点的指针域与 L 的值相等，而不是头结点的指针域与 L 的地址相等。注意，带头结点的循环单链表中不存在空指针。', '头结点的指针域为空', 'L 的值为 NULL', '头结点的指针域与 L 的值相等', '头结点的指针域与 L 的地址相等'),
(22, '00000000-0000-0000-0000-000000040022', 'BASIC', 'pp.53,59', '对于一个带头结点的循环双链表 L，判断该表为空表的条件是（ ）。', 'D', '循环双链表判空的条件是头结点（头指针）的 prior 和 next 域都指向它自身。', 'L->prior==L && L->next==NULL', 'L->prior==NULL && L->next==NULL', 'L->prior==NULL && L->next==L', 'L->prior==L && L->next==L'),
(23, '00000000-0000-0000-0000-000000040023', 'MEDIUM', 'pp.53,59', '一个链表最常用的操作是在末尾插入结点和删除结点，则选用（ ）最节省时间。', 'A', '在链表的末尾插入和删除一个结点时，需要修改其相邻结点的指针域。而寻找尾结点及尾结点的前驱结点时，只有带头结点的循环双链表所需要的时间最少。', '带头结点的循环双链表', '循环单链表', '带尾指针的循环单链表', '单链表'),
(24, '00000000-0000-0000-0000-000000040024', 'HARD', 'pp.53-54,59', '设有 n（n>1）个元素的线性表的运算只有 4 种：删除第一个元素；删除最后一个元素；在第一个元素之前插入新元素；在最后一个元素之后插入新元素，则最好使用（ ）。', 'C', '对于选项 A，删除尾结点 *p 时，需要找到 *p 的前一个结点，时间复杂度为 O(n)。对于选项 B，删除首结点 *p 时，需要找到 *p 结点，这里没有直接给出头结点指针，而是通过尾结点的 prior 指针找到 *p 结点，时间复杂度为 O(n)。对于选项 D，删除尾结点 *p 时，需要找到 *p 的前一个结点，时间复杂度为 O(n)。对于选项 C，执行这四种算法的时间复杂度均为 O(1)。', '只有尾结点指针没有头结点指针的循环单链表', '只有尾结点指针没有头结点指针的非循环双链表', '只有头结点指针没有尾结点指针的循环双链表', '既有头结点指针又有尾结点指针的循环单链表'),
(25, '00000000-0000-0000-0000-000000040025', 'MEDIUM', 'pp.54,60', '有两个长度为 n 的循环单链表，若要求两个循环单链表头尾相接的时间复杂度为 O(1)，则对应两个循环单链表各设置一个指针，分别指向（ ）。', 'B', '要求用 O(1) 的时间将两个循环单链表头尾相接，并未指明哪个链表接在另一个链表之后，所以对两个链表都要在 O(1) 的时间找到头结点和尾结点。因此，两个指针应都指向尾结点。', '各自的头结点', '各自的尾结点', '各自的首结点', '一个表的头结点，另一个表的尾结点'),
(26, '00000000-0000-0000-0000-000000040026', 'HARD', 'pp.54,60', '有一个长度为 n 的循环单链表，若从表中删除首元结点的时间复杂度达到 O(n)，则此时采用的循环单链表的结构可能是（ ）。', 'A', '在循环单链表中，删除首元结点后，要保持链表的循环性，因此需要找到首元结点的前驱。当链表带头结点时，其前驱就是头结点，因此不论是表头指针还是表尾指针，删除首元结点的时间都为 O(1)。当链表不带头结点时，其前驱是尾结点，因此，若有表尾指针，就可在 O(1) 的时间找到尾结点；若只有表头指针，则需要遍历整个链表找到尾结点，时间为 O(n)。', '只有表头指针，没有头结点', '只有表尾指针，没有头结点', '只有表尾指针，带头结点', '只有表头指针，带头结点'),
(27, '00000000-0000-0000-0000-000000040027', 'MEDIUM', 'pp.54,60', '某线性表用带头结点的循环单链表存储，头指针为 head，当 head->next->next==head 成立时，线性表的长度可能是（ ）。', 'D', '对一个空循环单链表，有 head->next==head，推理 head->next->next==head->next==head。对含有一个元素的循环单链表，头结点（头指针 head 指示）的 next 域指向这个唯一的元素结点，该元素结点的 next 域指向头结点，因此也有 head->next->next==head。', '0', '1', '2', '可能为 0 或 1'),
(28, '00000000-0000-0000-0000-000000040028', 'HARD', 'pp.54,60', '有两个长度都为 n 的双链表，若以 h1 为头指针的双链表是非循环的，以 h2 为头指针的双链表是循环的，则下列叙述中正确的是（ ）。', 'D', '对于两种双链表，删除首结点的时间复杂度都是 O(1)。对于非循环双链表，删除尾结点的时间复杂度是 O(n)；对于循环双链表，删除尾结点的时间复杂度是 O(1)。', '对于双链表 h1，删除首结点的时间复杂度是 O(n)', '对于双链表 h2，删除首结点的时间复杂度是 O(n)', '对于双链表 h1，删除尾结点的时间复杂度是 O(1)', '对于双链表 h2，删除尾结点的时间复杂度是 O(1)'),
(29, '00000000-0000-0000-0000-000000040029', 'MEDIUM', 'pp.54,60', '一个链表最常用的操作是在最后一个元素后插入一个元素和删除第一个元素，则选用（ ）最节省时间。', 'D', '对于选项 A，在最后一个元素之后插入元素的情况与普通单链表相同，时间复杂度为 O(n)；而删除第一个元素时，为保持循环单链表的性质（尾结点指向第一个结点），要先遍历整个链表找到尾结点，再做删除操作，时间复杂度为 O(n)。对于选项 B，双链表的情况与单链表相同，一个是 O(n)，一个是 O(1)。对于选项 C，在最后一个元素之后插入一个元素，要遍历整个链表才能找到插入位置，时间复杂度为 O(n)；删除第一个元素的时间复杂度为 O(1)。对于选项 D，与选项 A 的分析对比，有尾结点的指针，省去了遍历链表的过程，因此时间复杂度均为 O(1)。', '不带头结点的循环单链表', '双链表', '单链表', '不带头结点且有尾指针的循环单链表'),
(30, '00000000-0000-0000-0000-000000040030', 'MEDIUM', 'pp.54,60', '需要分配较大连续空间，插入和删除不需要移动元素的线性表，其存储结构为（ ）。', 'B', '静态链表采用数组表示，因此需要预先分配较大的连续空间，静态链表同时还具有一般链表的特点，即插入和删除不需要移动元素。', '单链表', '静态链表', '顺序表', '双链表'),
(31, '00000000-0000-0000-0000-000000040031', 'MEDIUM', 'pp.54,60', '下列关于静态链表的说法中，正确的是（ ）。
I. 静态链表兼具顺序表和单链表的优点，因此存取表中第 i 个元素的时间与 i 无关
II. 静态链表能容纳的最大元素个数在表定义时就确定了，以后不能增加
III. 静态链表与动态链表在元素的插入、删除上类似，不需要移动元素
IV. 相比动态链表，静态链表可能浪费较多的存储空间', 'B', '静态链表的存储空间虽然是顺序分配的，但元素的存储不是顺序的，查找时仍然需要按链依次进行，而插入、删除都不需要移动元素。静态链表的存储空间是一次性申请的，能容纳的最大元素个数在定义时就已确定。并非每个空间都存储了元素，因此会造成存储空间的浪费。', 'I、II、III', 'II、III、IV', 'I、III、IV', 'I、II、IV');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 2 章 2.3.7 本节试题精选与 2.3.8 答案与解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch2_b_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_LINEAR_LIST';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000140', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch2_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000140', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch2_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000140', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch2_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000140', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch2_b_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch2_b_import q
JOIN knowledge_points kp ON kp.code = 'DS_LINEAR_LIST_BASIC';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000040701', 'DS-2027-ORIGINAL-CH2-B')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch2_b_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH2-B',
    '第2章线性表',
    '2.3线性表链式表示',
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

DROP TABLE ds_2027_original_ch2_b_import;
