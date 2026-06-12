-- Authorized original operating-system single-choice import based on:
-- /Users/permer/Documents/408资料/2027操作系统-高清带书签.pdf
-- Chapter 2: section 2.4 deadlock finish.
-- Text-only batch: questions whose stem/options/explanation can be rendered without images, tables, or code layout.
-- Deferred in this section: Q35-Q36, Q43 and Q45 table questions.
-- Batch: OS-2027-ORIGINAL-CH2-I-TEXT-ONLY

CREATE TABLE os_2027_original_ch2_i_text_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    section_tag VARCHAR(64) NOT NULL,
    kp_code VARCHAR(64) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO os_2027_original_ch2_i_text_import (
    num, id, difficulty, source_type, source_year, section_tag, kp_code, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000092001', 'BASIC', 'PAST_EXAM', 2009, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.162,170',
'【2009 统考真题】某计算机系统中有 8 台打印机，由 K 个进程竞争使用，每个进程最多需要 3 台打印机。该系统可能发生死锁的 K 的最小值是（ ）。', 'C',
'这类题可用鸽巢原理分析。考虑最极端的情况，因为每个进程最多需要 3 台打印机，若每个进程已经占有 2 台打印机，则只要还有多的打印机，总能满足一个进程达到 3 台并顺利执行。将 8 台打印机分给 K 个进程，每个进程 2 台时，K 为 4。根据死锁公式逆推，若 M<=K(R-1)，则系统可能发生死锁；代入 8<=K(3-1)，得 K>=4，因此最小值为 4。', '2', '3', '4', '5'),
(2, '00000000-0000-0000-0000-000000092002', 'BASIC', 'PAST_EXAM', 2013, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.163,170',
'【2013 统考真题】下列关于银行家算法的叙述中，正确的是（ ）。', 'B',
'银行家算法是避免死锁的方法，不能预防死锁，也没有破坏死锁必要条件中的“请求和保持”条件。当系统处于安全状态时，系统中一定无死锁进程；当系统处于不安全状态时，只是有可能出现死锁进程，不是一定出现。', '银行家算法可以预防死锁', '当系统处于安全状态时，系统中一定无死锁进程', '当系统处于不安全状态时，系统中一定会出现死锁进程', '银行家算法破坏了死锁必要条件中的“请求和保持”条件'),
(3, '00000000-0000-0000-0000-000000092003', 'MEDIUM', 'PAST_EXAM', 2014, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.163,170',
'【2014 统考真题】某系统有 n 台互斥使用的同类设备，三个并发进程分别需要 3、4、5 台设备，可确保系统不发生死锁的设备数 n 最小为（ ）。', 'B',
'根据死锁公式，当资源数量大于各个进程所需资源数减 1 的总和时，不发生死锁。三个进程分别需要 3、4、5 台设备，即资源数量大于 (3-1)+(4-1)+(5-1)=9 时不发生死锁。因此保证系统不发生死锁的最小设备数为 10。', '9', '10', '11', '12'),
(4, '00000000-0000-0000-0000-000000092004', 'MEDIUM', 'PAST_EXAM', 2015, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.163,170-171',
'【2015 统考真题】若系统 S1 采用死锁避免方法，S2 采用死锁检测方法。下列叙述中，正确的是（ ）。
I. S1 会限制用户申请资源的顺序，而 S2 不会
II. S1 需要进程运行所需的资源总量信息，而 S2 不需要
III. S1 不会给可能导致死锁的进程分配资源，而 S2 会', 'B',
'死锁避免并不会限制用户申请资源的固定顺序，限制申请顺序属于死锁预防中破坏循环等待条件的方法，因此 I 错。银行家算法需要最大需求矩阵等进程资源总量信息，而死锁检测不需要提前知道进程所需总资源量，II 正确。死锁避免不会给可能导致死锁的进程分配资源，死锁检测则是在分配后再检测和解除死锁，III 正确。', '仅 I、II', '仅 II、III', '仅 I、III', 'I、II、III'),
(5, '00000000-0000-0000-0000-000000092005', 'MEDIUM', 'PAST_EXAM', 2016, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.163,171',
'【2016 统考真题】系统中有 3 个不同的临界资源 R1、R2 和 R3，被 4 个进程 P1、P2、P3、P4 共享。各进程对资源的需求为：P1 申请 R1 和 R2，P2 申请 R2 和 R3，P3 申请 R1 和 R3，P4 申请 R2。若系统出现死锁，则处于死锁状态的进程数至少是（ ）。', 'C',
'若系统出现死锁，则必然出现循环等待。根据资源需求关系，形成循环等待时至少需要 P1、P2、P3 三个进程在等待环中；不可能只有两个进程形成循环等待。因此若系统出现死锁，处于死锁状态的进程至少是 3 个。', '1', '2', '3', '4'),
(6, '00000000-0000-0000-0000-000000092006', 'MEDIUM', 'PAST_EXAM', 2018, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.163,171',
'【2018 统考真题】假设系统中有 4 个同类资源，进程 P1、P2 和 P3 需要的资源数分别为 4、3 和 1，P1、P2 和 P3 已申请到的资源数分别为 2、1 和 0，则执行安全性检测算法的结果是（ ）。', 'A',
'由题意可知，仅剩最后一个同类资源。若将其分给 P1 或 P2，均无法正常执行；若分给 P3，则 P3 正常执行完成后，释放的这一个资源仍无法使 P1、P2 正常执行。因此不存在安全序列，系统处于不安全状态。', '不存在安全序列，系统处于不安全状态', '存在多个安全序列，系统处于安全状态', '存在唯一安全序列 P3、P1、P2，系统处于安全状态', '存在唯一安全序列 P3、P2、P1，系统处于安全状态'),
(7, '00000000-0000-0000-0000-000000092007', 'BASIC', 'PAST_EXAM', 2019, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.163,171',
'【2019 统考真题】下列关于死锁的叙述中，正确的是（ ）。
I. 可以通过剥夺进程资源解除死锁
II. 死锁的预防方法能确保系统不发生死锁
III. 银行家算法可以判断系统是否处于死锁状态
IV. 当系统出现死锁时，必然有两个或两个以上的进程处于阻塞态', 'B',
'剥夺进程资源并分配给其他死锁进程，可以解除死锁，I 正确。死锁预防通过破坏死锁产生的必要条件之一，可以确保系统不发生死锁，II 正确。银行家算法是死锁避免算法，用于判断动态资源分配是否安全，不能判断系统是否已经处于死锁状态，III 错误。当系统出现死锁时，必然有两个或两个以上进程处于阻塞态，IV 正确。', '仅 II、III', '仅 I、II、IV', '仅 I、II、III', '仅 I、III、IV'),
(8, '00000000-0000-0000-0000-000000092008', 'MEDIUM', 'PAST_EXAM', 2021, '2.4死锁', 'OS_DEADLOCK_HANDLING', 'pp.163-164,171-172',
'【2021 统考真题】若系统中有 n（n>=2）个进程，每个进程均需要使用某类临界资源 2 个，则系统不会发生死锁所需的该类资源总数至少是（ ）。', 'C',
'考虑极端情况，当临界资源数为 n 时，每个进程都拥有 1 个临界资源并等待另一个资源，会发生死锁。当临界资源数为 n+1 时，n 个进程中至少有一个进程可以获得 2 个临界资源，顺利运行完后释放资源，使其他进程也能顺利运行。因此该类资源总数至少为 n+1。', '2', 'n', 'n+1', '2n');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027操作系统-高清带书签.pdf，第 2 章 2.4.6/2.4.7 本节习题精选及答案解析；本批收尾 2.4 纯文本单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM os_2027_original_ch2_i_text_import q
JOIN subjects s ON s.code = 'OPERATING_SYSTEM'
JOIN chapters c ON c.code = 'OS_PROCESS';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000192', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM os_2027_original_ch2_i_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000192', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM os_2027_original_ch2_i_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000192', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM os_2027_original_ch2_i_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000192', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM os_2027_original_ch2_i_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM os_2027_original_ch2_i_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000092701', 'OS-2027-ORIGINAL-CH2-I-TEXT-ONLY')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM os_2027_original_ch2_i_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027操作系统',
    'OS-2027-ORIGINAL-CH2-I-TEXT-ONLY',
    '第2章进程与线程',
    q.section_tag,
    '无图片题目',
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容'
) OR (q.source_type = 'PAST_EXAM' AND tag.name = '真题')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE os_2027_original_ch2_i_text_import;
