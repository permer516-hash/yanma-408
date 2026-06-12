-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 5: 5.2 指令执行过程 (Q1-Q11, pure text only).
-- Text-only batch: all 11 questions are conceptual with no image/table/code dependencies.
-- Batch: CO-2027-ORIGINAL-CH5-B-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000111301',
    c.id,
    'CO_CPU_INSTRUCTION_EXEC',
    '指令执行过程',
    3
FROM chapters c
WHERE c.code = 'CO_CPU'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CPU_INSTRUCTION_EXEC');

CREATE TABLE co_2027_original_ch5_b_text_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    section_tag VARCHAR(64) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO co_2027_original_ch5_b_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 5.2 指令执行过程 Q1-Q11
-- Q1-Q9: 模拟题; Q10: 2009统考真题; Q11: 2011统考真题
-- 全部11道均为纯文本单选题，无图片/表格/版式依赖
-- ============================================================

(1, '00000000-0000-0000-0000-000000111001', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'BASIC', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '计算机工作的最小时间周期是（ ）。',
 'A',
 '时钟周期是计算机内部最基本、最小的时间单位。指令周期是指完成一条指令所需的时间，可以包含多个时钟周期。存取周期是指访问一次存储器（读或写）的时间，通常也需要多个时钟周期。总线周期是指总线进行数据传输所需的时间，也可包含多个时钟周期。',
 '时钟周期', '指令周期', '存取周期', '总线周期'),

(2, '00000000-0000-0000-0000-000000111002', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'BASIC', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '指令周期是指（ ）。',
 'C',
 '指令周期是指 CPU 从主存取出一条指令加上执行这条指令的时间。间址周期不是必需的。',
 'CPU 从主存取出一条指令的时间', 'CPU 执行一条指令的时间', 'CPU 从主存取出一条指令加上执行这条指令的时间', '时钟周期时间'),

(3, '00000000-0000-0000-0000-000000111003', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'BASIC', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '在一条无条件转移指令的指令周期内（不含中断），程序计数器的值被修改了（ ）次。',
 'B',
 '首先在取指周期结束时 PC 值自动加 1；在执行周期中，PC 值修改为要转移到的地址。综上，在一条无条件转移指令的指令周期内，程序计数器（PC）的值被修改了 2 次。',
 '1', '2', '3', '不能确定'),

(4, '00000000-0000-0000-0000-000000111004', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'BASIC', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '取指操作后，程序计数器中存放的是（ ）。',
 'D',
 '在取指操作后，程序计数器中的内容将被修改为下一条指令的地址，而不是当前指令的地址。',
 '当前指令的地址', '程序中指令的数量', '已执行的指令数量', '下一条指令的地址'),

(5, '00000000-0000-0000-0000-000000111005', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'BASIC', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '下列关於指令执行的叙述中，错误的是（ ）。',
 'B',
 '取指操作是自动进行的，控制器不需要得到相应的指令。指令周期的第一个操作是取指令。取指操作是控制器自动进行的。指令执行时有些操作是相同或相似的。',
 '指令周期的第一个操作是取指令', '为了进行取指操作，控制器需要得到相应的指令', '取指操作是控制器自动进行的', '指令执行时有些操作是相同或相似的'),

(6, '00000000-0000-0000-0000-000000111006', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'BASIC', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '下列关於指令执行过程的叙述中，错误的是（ ）。',
 'B',
 '不同长度的指令，其取指操作可能是不同的。例如，双字指令、三字指令与单字指令的取指操作是不同的。中断周期是在每条指令执行完成后检查中断请求，若检测到中断则进入中断周期。',
 '取指操作是控制器固有的功能，不需要在操作码控制下完成', '所有指令的取指操作是相同的', '在指令长度相同的情况下，所有指令的取指操作是相同的', '中断周期是在指令执行完成后才可能出现'),

(7, '00000000-0000-0000-0000-000000111007', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'BASIC', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '下列关於指令周期的叙述中，错误的是（ ）。',
 'B',
 '无论哪种指令，指令周期的第一个阶段都是取指令（从主存中获得指令）。乘法指令通常比加法指令复杂，若是多周期 CPU，则乘法指令通常需要更多的时钟周期，选项 B 错误。多周期 CPU 的指令周期由若干时钟周期组成。在单周期 CPU 中，指令执行的所有阶段（取指令、译码、执行等）都在一个时钟周期内完成，因此其指令周期就是一个时钟周期。',
 '指令周期的第一个阶段一定是取指令阶段', '乘法指令和加法指令的指令周期总是一样长', '一个指令周期可由若干时钟周期组成', '单周期 CPU 中的指令周期就是一个时钟周期'),

(8, '00000000-0000-0000-0000-000000111008', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'MEDIUM', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205',
 '下列关於多周期 CPU 的说法中，合理的是（ ）。',
 'C',
 '多周期 CPU 把指令的执行分为多个阶段来实现，每个阶段在一个时钟周期内完成，时钟周期以最复杂的阶段所花的时间为准，阶段的划分原则是：将一条指令的执行过程尽量分成大致相等的若干阶段。不同的指令（根据指令的复杂程度）所含的时钟周期数可以不同。',
 '执行各条指令的时钟周期数相同，各时钟周期的长度均匀', '执行各条指令的时钟周期数相同，各时钟周期的长度可变', '执行各条指令的时钟周期数可变，各时钟周期的长度均匀', '执行各条指令的时钟周期数可变，各时钟周期的长度可变'),

(9, '00000000-0000-0000-0000-000000111009', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'MEDIUM', 'MOCK', 2027, '5.2指令执行过程', 'pp.204,205-206',
 '关於指令执行过程，下列叙述中正确的是（ ）。',
 'D',
 '指令执行的基本步骤通常包括取指令、译码、地址计算、取操作数、执行和写回结果，其中取指令和译码是所有指令执行的必经阶段，而后续操作因指令而异。取指令和译码是每条指令必须执行的操作，但取数或写结果不一定访问主存（可能仅涉及寄存器）。选项 A 错在取操作数不一定访存；选项 B 错在地址计算属于执行阶段，而非译码阶段；选项 C 错在并非所有指令都需要访问主存或 I/O。',
 '取指令和取操作数阶段都一定需要通过总线访问主存', '指令译码阶段需要计算操作数在内存中的地址', '所有指令在执行阶段必然包含访问主存或 I/O 端口的操作', '取指令和译码是每条指令必须执行的操作，但取数或写结果不一定访问主存'),

(10, '00000000-0000-0000-0000-000000111010', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'MEDIUM', 'PAST_EXAM', 2009, '5.2指令执行过程', 'pp.205,206',
 '【2009 统考真题】冯·诺依曼机中指令和数据均以二进制形式存放在存储器中，CPU 区分它们的依据是（ ）。',
 'C',
 '虽然指令和数据都以二进制形式存放在存储器中，但 CPU 可以根据指令周期的不同阶段来区分是指令还是数据，通常在取指阶段取出的是指令，在执行阶段取出的是数据。本题容易误选选项 A，需要清楚的是，CPU 只有在确定取出的是指令后，才会将其操作码送去译码，因此不可能依据译码的结果来区分指令和数据。',
 '指令操作码的译码结果', '指令和数据的寻址方式', '指令周期的不同阶段', '指令和数据所在的存储单元'),

(11, '00000000-0000-0000-0000-000000111011', 'CO_CPU', 'CO_CPU_INSTRUCTION_EXEC', 'MEDIUM', 'PAST_EXAM', 2011, '5.2指令执行过程', 'pp.205,206',
 '【2011 统考真题】假定不采用 Cache 和指令预取技术，且机器处於"开中断"状态，则在下列有关指令执行的叙述中，错误的是（ ）。',
 'C',
 '每个指令周期中 CPU 都至少访存一次（取指令操作），选项 A 正确。每个指令周期一定大于或等于一个 CPU 时钟周期，选项 B 正确。即使是空操作指令（NOP），指令周期中 PC 的值也会被修改（自增），因此"任何寄存器的内客都不会被改变"的说法错误，选项 C 错误。当前程序在每条指令执行结束时，CPU 都会检测中断请求，若检测到外部中断请求则可能被打断，选项 D 正确。',
 '每个指令周期中 CPU 都至少访存一次', '每个指令周期一定大於或等於一个 CPU 时钟周期', '空操作指令的指令周期中任何寄存器的内客都不会被改变', '当前程序在每条指令执行结束时都可能被外部中断打断');

-- ============================================================
-- Insert into questions
-- ============================================================
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
    '原题来自《2027年计算机组成原理考研复习指导》第5章 5.2 指令执行过程 本节试题精选。原始页码：' || q.source_pages || '。本批共11道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch5_b_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000211', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch5_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000211', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch5_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000211', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch5_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000211', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch5_b_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch5_b_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000111101', 'CO-2027-ORIGINAL-CH5-B-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000111102', '5.2指令执行过程')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch5_b_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH5-B-TEXT-ONLY',
    '第5章中央处理器',
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

-- ============================================================
-- Cleanup
-- ============================================================
DROP TABLE co_2027_original_ch5_b_text_import;
