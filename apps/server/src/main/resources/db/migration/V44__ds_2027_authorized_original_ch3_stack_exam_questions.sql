-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.1.4/3.1.5 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-C

CREATE TABLE ds_2027_original_ch3_c_import (
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

INSERT INTO ds_2027_original_ch3_c_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(26, '00000000-0000-0000-0000-000000044026', 'HARD', 'pp.80,84', '【2009 统考真题】设栈 S 和队列 Q 的初始状态均为空，元素 abcdefg 依次入栈 S。若每个元素出栈后立即进入队列 Q，且 7 个元素出队的顺序是 bdcfeag，则栈 S 的容量至少是（ ）。', 'C', '因为元素的出队顺序和入队顺序相同，所以元素的出栈顺序就是 b、d、c、f、e、a、g。对应的出入栈次序为 Push(S,a)、Push(S,b)、Pop(S,b)、Push(S,c)、Push(S,d)、Pop(S,d)、Pop(S,c)、Push(S,e)、Push(S,f)、Pop(S,f)、Pop(S,e)、Pop(S,a)、Push(S,g)、Pop(S,g)。初始所需容量为 0，每做一次 Push 操作容量加 1，每做一次 Pop 操作容量减 1，记录的容量最大值为 3，所以栈的容量至少是 3。', '1', '2', '3', '4'),
(27, '00000000-0000-0000-0000-000000044027', 'HARD', 'pp.80,84', '【2010 统考真题】若元素 a,b,c,d,e,f 依次入栈，允许入栈、出栈操作交替进行，但不允许连续 3 次进行出栈操作，不可能得到的出栈序列是（ ）。', 'D', '选项 A、B、C 均可通过合法的入栈、出栈交替操作得到。对于选项 D，若先入栈的元素后出栈，入栈序列为 a,b,c,d,e,f，则出栈序列中出现了长度大于或等于 3 的逆序子序列，与“不允许连续 3 次进行出栈操作”的限制冲突，因此选项 D 不可能得到。', 'dcebfa', 'cbdaef', 'bcaefd', 'afedcb'),
(28, '00000000-0000-0000-0000-000000044028', 'HARD', 'pp.80-81,84-85', '【2011 统考真题】元素 a,b,c,d,e 依次进入初始为空的栈中，若元素入栈后可停留、可出栈，直到所有元素都出栈，则在所有可能的出栈序列中，以元素 d 开头的序列个数是（ ）。', 'B', 'd 第一个出栈，则 a、b、c 必然已经留在栈中，此时栈中元素自栈顶到栈底为 c、b、a，后续元素 e 仍可在不同位置入栈和出栈。可得到以 d 开头的合法出栈序列共有 4 个。', '3', '4', '5', '6'),
(29, '00000000-0000-0000-0000-000000044029', 'HARD', 'pp.81,85', '【2013 统考真题】一个栈的入栈序列为 1,2,3,...,n，出栈序列是 P1,P2,P3,...,Pn。若 P2=3，则 P3 可能取值的个数是（ ）。', 'C', '3 之后的 4,5,...,n 都可能成为 P3。再分析 1 和 2 是否可能：P3 可以是 3 之前入栈的数，也可以是 4；当 P1 为 1 时，P3 可取 2；当 P1 为 2 时，P3 可取 1。因此 P3 可能取除 3 外的所有数，个数为 n-1。', 'n-3', 'n-2', 'n-1', '无法确定'),
(30, '00000000-0000-0000-0000-000000044030', 'MEDIUM', 'pp.81,85', '【2020 统考真题】对空栈 S 进行 Push 和 Pop 操作，入栈序列为 a,b,c,d,e，经过 Push、Push、Pop、Push、Pop、Push、Push、Pop 操作后得到的出栈序列是（ ）。', 'D', '按题意模拟：Push a，Push b，Pop 得 b；Push c，Pop 得 c；Push d，Push e，Pop 得 e。因此出栈序列为 b,c,e。', 'b,a,c', 'b,a,e', 'b,c,a', 'b,c,e'),
(31, '00000000-0000-0000-0000-000000044031', 'HARD', 'pp.81,85', '【2022 统考真题】给定有限符号集 S，in 和 out 均为 S 中所有元素的任意排列。对于初始为空的栈 ST，下列叙述中，正确的是（ ）。', 'D', '通过模拟出入栈操作，可以判断入栈序列 in 和出栈序列 out 是否匹配。因此，已知 in 序列可以判断 out 序列是否为其可能的出栈序列；已知 out 序列也可以判断 in 序列是否为可能的入栈序列，选项 A 和 B 错误。若每个元素入栈后立即出栈，则 in 序列和 out 序列相同，选项 C 错误。若所有元素先全部入栈再依次出栈，则 in 序列和 out 序列互为倒序，选项 D 正确。', '若 in 是 ST 的入栈序列，则不能判断 out 是否为其可能的出栈序列', '若 out 是 ST 的出栈序列，则不能判断 in 是否为其可能的入栈序列', '若 in 是 ST 的入栈序列，out 是对应 in 的出栈序列，则 in 与 out 一定不同', '若 in 是 ST 的入栈序列，out 是对应 in 的出栈序列，则 in 与 out 可能互为倒序');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 3 章 3.1.4/3.1.5 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch3_c_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STACK_QUEUE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000144', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000144', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000144', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000144', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_c_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_c_import q
JOIN knowledge_points kp ON kp.code = 'DS_STACK_QUEUE_APPLICATION';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000044701', 'DS-2027-ORIGINAL-CH3-C')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_c_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-C',
    '第3章栈队列和数组',
    '3.1栈',
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

DROP TABLE ds_2027_original_ch3_c_import;
