-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 4: 4.4 CISC 和 RISC 的基本概念 (Q1-Q6, pure text only).
-- Text-only batch: all 6 questions are conceptual with no image/table/code dependencies.
-- Batch: CO-2027-ORIGINAL-CH4-D-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000103301',
    c.id,
    'CO_CISC_RISC',
    'CISC和RISC的基本概念',
    5
FROM chapters c
WHERE c.code = 'CO_INSTRUCTION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CISC_RISC');

CREATE TABLE co_2027_original_ch4_d_text_import (
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

INSERT INTO co_2027_original_ch4_d_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 4.4 CISC 和 RISC 的基本概念 Q1-Q6
-- Q1-Q4: 模拟题; Q5: 2009统考真题; Q6: 2025统考真题
-- 全部6道均为纯文本单选题，无图片/表格/版式依赖
-- ============================================================

(1, '00000000-0000-0000-0000-000000103001', 'CO_INSTRUCTION', 'CO_CISC_RISC', 'BASIC', 'MOCK', 2027, '4.4CISC和RISC的基本概念', 'pp.192-193,193',
 '下列关于 RISC 的叙述中, 正确的是（ ）。',
 'A',
 'RISC 必然采用流水线技术, 这也是由其指令的特点决定的。而 CISC 则无此强制要求, 但为了提高指令执行速度, CISC 也往往采用流水线技术, 因此流水线技术并非 RISC 的专利。CISC 机可以兼容很多不同的高级语言和软件, 而 RISC 机的指令系统简单精简, 只包含一些基本的指令, 这些指令需要通过组合来实现复杂的功能, 从而增加了编译器的设计难度和程序员的编程难度, 因此 CISC 机的兼容性更好。CPU 配备很多通用寄存器是 RISC 机的主要特点。',
 'RISC 机一定采用流水技术', '采用流水技术的机器一定是 RISC 机', 'RISC 机的兼容性优于 CISC 机', 'CPU 配备很少的通用寄存器'),

(2, '00000000-0000-0000-0000-000000103002', 'CO_INSTRUCTION', 'CO_CISC_RISC', 'BASIC', 'MOCK', 2027, '4.4CISC和RISC的基本概念', 'pp.193,193',
 '下列描述中, 不符合 RISC 指令系统特点的是（ ）。',
 'B',
 'A、C 和 D 都是 RISC 的特点。对于 B, 寻址方式种类尽量减少是 RISC 的特点, 而增强指令的功能则是 CISC 的特点, RISC 指令功能简单, 复杂指令的功能由简单指令的组合来实现。',
 '指令长度固定, 指令种类少', '寻址方式种类尽量减少, 指令功能尽可能强', '增加寄存器的数目, 以尽量减少访存次数', '选取使用频率最高的一些简单指令, 以及很有用但不复杂的指令'),

(3, '00000000-0000-0000-0000-000000103003', 'CO_INSTRUCTION', 'CO_CISC_RISC', 'BASIC', 'MOCK', 2027, '4.4CISC和RISC的基本概念', 'pp.193,193',
 '以下有关 RISC 的描述中, 正确的是（ ）。',
 'D',
 'RISC 选择一些常用的寄存器型指令, 但不是为了兼容 CISC, RISC 也不可能兼容 CISC, 选项 A 错误。RISC 只是 CPU 的结构发生变化, 基本不影响整个计算机的结构, 并且即使是采用 RISC 技术的 CPU, 其架构也不可能像早期一样简单, 选项 B 错误。RISC 的指令功能简单, 通过简单指令的组合来实现复杂指令的功能, 选项 C 错误（但 RISC 的主要目标是减少指令数是正确的, 然而它不允许通过增加每条指令功能的方式来减少指令数）。因此 A、B、C 均错误, 选项 D 正确。',
 '为了实现兼容, 新设计的 RISC 是从原来 CISC 系统的指令系统中挑选一部分实现的', '采用 RISC 技术后, 计算机的体系结构又恢复到了早期的情况', 'RISC 的主要目标是减少指令数, 因此允许以增加每条指令的功能的方法来减少指令系统所包含的指令数', '以上说法都不对'),

(4, '00000000-0000-0000-0000-000000103004', 'CO_INSTRUCTION', 'CO_CISC_RISC', 'BASIC', 'MOCK', 2027, '4.4CISC和RISC的基本概念', 'pp.193,193',
 '下列关于 RISC 和 CISC 的说法中, 不正确的是（ ）。',
 'C',
 'RISC 指令格式种类少, 寻址方式少, 指令长度固定, 更容易用硬布线电路实现, 选项 A 正确。CISC 指令功能强大, 寻址方式多, 便于汇编程序员编程, 选项 B 正确。CISC 指令格式种类多, 增大了编译优化的复杂性, 因此不利于编译优化, 选项 C 错误。RISC 多数指令能够在一个时钟周期内完成, 特别适合流水线工作, 选项 D 正确。',
 'RISC 指令格式种类少, 寻址方式少, 指令长度固定, 更容易用硬布线电路实现', 'CISC 指令功能强大, 寻址方式多, 便于汇编程序员编程', 'CISC 指令格式种类多, 所以更有利于编译优化', 'RISC 多数指令能够在一个时钟周期内完成, 特别适合流水线工作'),

(5, '00000000-0000-0000-0000-000000103005', 'CO_INSTRUCTION', 'CO_CISC_RISC', 'BASIC', 'PAST_EXAM', 2009, '4.4CISC和RISC的基本概念', 'pp.193,193',
 '【2009 统考真题】下列关于 RISC 的说法中, 错误的是（ ）。',
 'A',
 '相对于 CISC, RISC 的特点是: 指令条数少; 指令长度固定, 指令格式和寻址种类少; 只有取数/存数指令访问存储器, 其余指令的操作均在寄存器之间进行; CPU 中通用寄存器多; 大部分指令在一个时钟周期内完成; 以硬布线逻辑为主, 不用或少用微程序控制。B、C 和 D 都是 RISC 的特点。RISC 的速度快, 因此普遍采用硬布线控制器, 选项 A 错误。',
 'RISC 普遍采用微程序控制器', 'RISC 大多数指令在一个时钟周期内完成', 'RISC 的内部通用寄存器数量相对 CISC 多', 'RISC 的指令数、寻址方式和指令格式种类相对 CISC 少'),

(6, '00000000-0000-0000-0000-000000103006', 'CO_INSTRUCTION', 'CO_CISC_RISC', 'BASIC', 'PAST_EXAM', 2025, '4.4CISC和RISC的基本概念', 'pp.193,193',
 '【2025 统考真题】下列关于 RISC 的叙述中, 错误的是（ ）。',
 'C',
 'RISC 指令集具有格式规整、数量少、寻址简单、采用 LOAD/STORE 访存、通用寄存器数量多及硬连线控制器等特点, 指令执行周期均匀, 非常适合流水线实现。相反, CISC 因指令复杂、长度可变而难以采用流水线。因此, 选项 C 错误, 其余选项均符合 RISC 特征。',
 '多采用硬连线方式实现控制器', '通常采用 LOAD/STORE 指令设计风格', '难以采用流水线数据通路实现微架构', '多采用寄存器传递过程调用时的参数');

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
    '原题来自《2027年计算机组成原理考研复习指导》第4章 4.4 CISC和RISC的基本概念 本节试题精选。原始页码：' || q.source_pages || '。本批共6道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch4_d_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000203', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch4_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000203', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch4_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000203', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch4_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000203', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch4_d_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch4_d_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000103101', 'CO-2027-ORIGINAL-CH4-D-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000103102', '4.4CISC和RISC的基本概念')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch4_d_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH4-D-TEXT-ONLY',
    '第4章指令系统',
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
DROP TABLE co_2027_original_ch4_d_text_import;
