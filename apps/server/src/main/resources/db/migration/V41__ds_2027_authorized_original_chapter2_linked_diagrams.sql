-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 2: 2.3.7/2.3.8 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH2-C

CREATE TABLE ds_2027_original_ch2_c_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    stem_format VARCHAR(32) NOT NULL,
    stem_image_url TEXT,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch2_c_import (
    num, id, difficulty, source_pages, stem, answer, explanation, stem_format, stem_image_url,
    option_a, option_b, option_c, option_d
) VALUES
(32, '00000000-0000-0000-0000-000000041032', 'MEDIUM', 'pp.54,60', '【2016 统考真题】已知一个带有表头结点的循环双链表 L，结点结构为 [prev|data|next]，其中 prev 和 next 分别是指向其直接前驱和直接后继结点的指针。现要删除指针 p 所指的结点，正确的语句序列是（ ）。', 'D', '选项 A 的第二句代码，相当于将 p 前驱结点的后继指针指向其自身，错误；选项 B 和 C 的第一句代码，相当于将 p 后继结点的前驱指针指向其自身，错误。只有选项 D 正确。', 'PLAIN_TEXT', NULL, 'p->next->prev=p->prev; p->prev->next=p->prev; free(p);', 'p->next->prev=p->next; p->prev->next=p->next; free(p);', 'p->next->prev=p->next; p->prev->next=p->prev; free(p);', 'p->next->prev=p->prev; p->prev->next=p->next; free(p);'),
(33, '00000000-0000-0000-0000-000000041033', 'HARD', 'pp.54-55,60', '【2016 统考真题】已知表头元素为 c 的单链表在内存中的存储状态如下表所示。现将 f 存放于 1014H 处并插入单链表，若 f 在逻辑上位于 a 和 e 之间，则 a、e、f 的“链接地址”依次是（ ）。', 'D', '根据存储状态，单链表的逻辑结构为 c、a、e、b、d，其中“链接地址”是指结点 next 所指的内存地址。当结点 f 插入后，a 指向 f，f 指向 e，e 指向 b。显然 a、e、f 的“链接地址”分别是 f、b、e 的内存地址，即 1014H、1004H、1010H。', 'DIAGRAM', '/question-assets/ds-2027/ch2/q33-memory-table.png', '1010H、1014H、1004H', '1010H、1004H、1014H', '1014H、1010H、1004H', '1014H、1004H、1010H'),
(34, '00000000-0000-0000-0000-000000041034', 'HARD', 'pp.55,60-61', '【2021 统考真题】已知头指针 h 指向一个带头结点的非空循环单链表，结点结构为 [data|next]，其中 next 是指向直接后继结点的指针，p 是尾指针，q 是临时指针。现要删除该链表的第一个元素，正确的语句序列是（ ）。', 'D', '要删除带头结点的非空循环单链表中的第一个元素，就要先用临时指针 q 指向待删结点，即 q=h->next；然后将 q 从链表中断开，即 h->next=q->next。若待删结点是链表的尾结点，即循环单链表中只有一个元素，p 和 q 指向同一个结点，则删除后要将尾指针指向头结点，即 if (p==q) p=h；最后释放 q 结点即可。', 'PLAIN_TEXT', NULL, 'h->next=h->next->next; q=h->next; free(q);', 'q=h->next; h->next=h->next->next; free(q);', 'q=h->next; h->next=q->next; if (p!=q) p=h; free(q);', 'q=h->next; h->next=q->next; if (p==q) p=h; free(q);'),
(35, '00000000-0000-0000-0000-000000041035', 'HARD', 'pp.55,61', '【2023 统考真题】现有非空双链表 L，其结点结构为 [prev|data|next]，prev 是指向直接前驱结点的指针，next 是指向直接后继结点的指针。若要在 L 中指针 p 所指向的结点（非尾结点）之后插入指针 s 指向的新结点，则在执行语句序列“s->next=p->next; p->next=s;”后，下列语句序列中还需要执行的是（ ）。', 'C', '链表的插入操作要保证不会造成断链。执行 s->next=p->next; p->next=s; 后，s 的 next 已指向原 p 的后继，p 的 next 已指向 s。此时还需要让 s 的 prev 指向原 p 的后继结点的 prev，即 p；再让原 p 的后继结点的 prev 指向 s，因此选项 C 正确。', 'PLAIN_TEXT', NULL, 's->next->prev=p; s->prev=p;', 'p->next->prev=s; s->prev=p;', 's->prev=s->next->prev; s->next->prev=s;', 'p->next->prev=s->prev; s->next->prev=p;'),
(36, '00000000-0000-0000-0000-000000041036', 'HARD', 'pp.55,61', '【2024 统考真题】已知带头结点的非空单链表 L 的头指针为 h，结点结构为 [data|next]，其中 next 是指向直接后继结点的指针。现有指针 p 和 q，若 p 指向 L 中非首且非尾的任意一个结点，则执行语句序列“q=p->next; p->next=q->next; q->next=h->next; h->next=q;”的结果是（ ）。', 'D', '执行 q=p->next 后，q 指向 p 的后继结点；执行 p->next=q->next 后，结点 p 的 next 指向 q 的后继结点；执行 q->next=h->next 后，结点 q 的 next 指向 h 的后继结点；执行 h->next=q 后，q 所指结点移至 L 的头结点 h 之后，选项 D 正确。', 'PLAIN_TEXT', NULL, '在 p 所指结点后插入 q 所指结点', '在 q 所指结点后插入 p 所指结点', '将 p 所指结点移至 L 的头结点之后', '将 q 所指结点移动到 L 的头结点之后');

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
    'PAST_EXAM',
    2027,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 2 章 2.3.7 本节试题精选与 2.3.8 答案与解析，参考页：' || q.source_pages || '。',
    q.stem_format,
    q.stem_image_url,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch2_c_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_LINEAR_LIST';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000141', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch2_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000141', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch2_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000141', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch2_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000141', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch2_c_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch2_c_import q
JOIN knowledge_points kp ON kp.code = 'DS_LINEAR_LIST_BASIC';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000041701', 'DS-2027-ORIGINAL-CH2-C')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch2_c_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH2-C',
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

DROP TABLE ds_2027_original_ch2_c_import;
