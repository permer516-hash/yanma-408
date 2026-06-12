-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 5: 5.7 多处理器的基本概念 (Q1-Q12, pure text only).
-- Text-only batch: all 12 questions are conceptual with no image/table/code dependencies.
-- Batch: CO-2027-ORIGINAL-CH5-G-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000115301',
    c.id,
    'CO_CPU_MULTIPROCESSOR',
    '多处理器的基本概念',
    7
FROM chapters c
WHERE c.code = 'CO_CPU'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CPU_MULTIPROCESSOR');

CREATE TABLE co_2027_original_ch5_g_text_import (
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

INSERT INTO co_2027_original_ch5_g_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 5.7 多处理器的基本概念 Q1-Q12
-- Q1-Q11: 模拟题; Q12: 2022统考真题
-- 全部12道均为纯文本单选题，无图片/表格/版式依赖
-- ============================================================

(1, '00000000-0000-0000-0000-000000115001', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'BASIC', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,271',
'当前设计高性能计算机的重要技术途径是（ ）。',
'D',
'单纯提高CPU主频已难以为继，受限于功耗和散热；扩大主存容量只能支持更大的程序，却无法直接加快计算速度；非冯·诺依曼结构目前仍处于探索阶段；相比之下，并行处理技术通过同时执行多个任务或操作，有效突破了性能瓶颈，已成为现代高性能计算机的核心设计途径。',
'提高CPU主频', '扩大主存容量', '采用非冯·诺依曼结构', '采用并行处理技术'),

(2, '00000000-0000-0000-0000-000000115002', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'BASIC', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,271',
'按照Flynn提出的计算机系统分类方法，多处理机属于（ ）。',
'D',
'Flynn分类法将计算机体系结构分为SISD、SIMD、MISD和MIMD四类。常规的单处理器属于SISD，常规的多处理机属于MIMD。',
'SISD', 'SIMD', 'MISD', 'MIMD'),

(3, '00000000-0000-0000-0000-000000115003', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'BASIC', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,271',
'从体系结构的角度来看，阵列处理机属于（ ）结构。',
'B',
'阵列处理机包含一个计算阵列，此阵列由多个处理单元组成。它使用单一的控制部件控制多个处理单元，使每个处理单元对各自的数据进行同样的操作，属于SIMD结构。',
'SISD', 'SIMD', 'MIMD', 'MISD'),

(4, '00000000-0000-0000-0000-000000115004', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'BASIC', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,271',
'以下机器中，不属于SIMD结构的是（ ）。',
'D',
'并行处理机、阵列处理机和向量处理机通常可理解为同一种概念，是SIMD结构。标量流水线处理机是SISD结构。',
'并行处理机', '阵列处理机', '向量处理机', '标量流水线处理机'),

(5, '00000000-0000-0000-0000-000000115005', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'BASIC', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,271',
'具有一个控制部件和多个处理单元的计算机系统属于（ ）结构。',
'B',
'单指令流多数据流（SIMD）结构的计算机通常由一个指令控制部件、多个处理单元组成，不同处理单元执行的同一条指令所处理的数据可以不同。',
'SISD', 'SIMD', 'MISD', 'MIMD'),

(6, '00000000-0000-0000-0000-000000115006', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'MEDIUM', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,271-272',
'下列关于超线程（HT）技术的描述中，正确的是（ ）。',
'C',
'超线程技术是在一个CPU中，提供两套线程处理单元，让单个处理器实现线程级并行。虽然采用超线程技术能够同时执行两个线程，但是当两个线程同时需要某个资源时，其中一个线程必须暂时挂起，直到这些资源空闲后才能继续运行。因此，超线程的性能并不等于两个CPU的性能。而且，超线程技术的CPU需要芯片组、操作系统（如Windows 98不支持超线程技术）和应用软件的支持，才能发挥该项技术的优势。仅选项C正确。',
'超线程技术可以让四核的Intel Core i处理器变成八核', '超线程技术是一项硬件技术，能使系统性能大幅提升，与操作系统和应用软件无关', '具有超线程技术的CPU需要芯片组的支持才能发挥技术优势', '超线程技术模拟出的每个CPU核都具有独立的资源，各自工作互不干扰'),

(7, '00000000-0000-0000-0000-000000115007', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'MEDIUM', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,272',
'双核CPU和超线程CPU的共同点是（ ）。',
'B',
'超线程技术是在CPU内部仅复制必要的线程资源来让两个线程同时运行，能并行执行两个线程，模拟实体双核。两者都能同时执行两个运算。仅选项B正确。',
'都有两个内核', '都能同时执行两个运算', '都包含两个CPU', '都不会出现争抢资源的现象'),

(8, '00000000-0000-0000-0000-000000115008', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'BASIC', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,272',
'下列关于双核技术的叙述中，正确的是（ ）。',
'C',
'双核是指将两个CPU核心集成到一个封装中，核心也称内核，是CPU最重要的组成部分，选项C正确。主板上有两个CPU属于多处理器。超线程技术是模拟实体双核，不能算作真正意义上的双核。时间并行是指流水线技术，空间并行则是指硬件资源的重复，空间并行导致了两类并行机的产生，按Flynn分类法分为SIMD和MIMD。',
'双核是指主板上有两个CPU', '双核是利用超线程技术实现的', '双核是指在CPU上集成两个运算核心', '双核CPU是时间并行的并行计算'),

(9, '00000000-0000-0000-0000-000000115009', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'MEDIUM', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.270,272',
'下列有关多核CPU和单核CPU的描述中，错误的是（ ）。',
'D',
'多核CPU的核心通常都是对称的，因此2.4GHz双核CPU中两个核的主频也是2.4GHz。在同等性能下，采用双核CPU可以降低计算机系统的功耗和体积。多核CPU共用一组内存，数据共享，选项C正确。在多核CPU上运行一个不支持多线程的程序，显然不能发挥多核CPU的优势，选项D错误。',
'双核的频率为2.4GHz，那么其中每个核心的频率也是2.4GHz', '同等性能下，采用双核CPU可以降低计算机系统的功耗和体积', '多核CPU共用一组内存，数据共享', '所有程序在多核CPU上运行速度都快'),

(10, '00000000-0000-0000-0000-000000115010', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'MEDIUM', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.271,272',
'下列关于多核CPU的描述中，正确的是（ ）。',
'C',
'多核CPU的各核心既可以有独自的Cache，又可以共享同一个Cache。只有支持多线程的并行处理程序才能同时在多个核心上运行，发挥多核的优势。选项C正确。多任务系统也称多道程序系统，可以运行在单核CPU上，宏观上并行，微观上串行。',
'各核心完全对称，拥有各自的Cache', '任何程序都可以同时在多个核心上运行', '一颗CPU中集成了多个完整的执行内核，可同时进行多个运算', '只有使用了多核CPU的计算机，才支持多任务操作系统'),

(11, '00000000-0000-0000-0000-000000115011', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'MEDIUM', 'MOCK', 2027, '5.7多处理器的基本概念', 'pp.271,272',
'下列关于多核处理器的说法中，不正确的是（ ）。',
'C',
'单线程程序只有一个执行流，因此多核处理器并不能使其执行速度加快。多核处理器属于Flynn分类法的MIMD系统。多核处理器是在一个CPU上集成了多个执行内核而非控制核心的处理器，选项C错误。多核处理器可在一个时钟周期内处理多个并行任务，因此能耗通常更高。',
'多核处理器并不能使单线程程序的执行速度加快', '多核处理器在Flynn分类法中属于MIMD系统', '多核处理器实际上就是在一个CPU上集成了多个控制核心', '多核处理器通常比单核处理器的能耗更高'),

(12, '00000000-0000-0000-0000-000000115012', 'CO_CPU', 'CO_CPU_MULTIPROCESSOR', 'MEDIUM', 'PAST_EXAM', 2022, '5.7多处理器的基本概念', 'pp.271,272',
'【2022统考真题】下列关于并行处理技术的叙述中，不正确的是（ ）。',
'C',
'MIMD结构分为多计算机系统和多处理器系统。向量处理器是SIMD的变体，属于SIMD结构。硬件多线程技术在一个核中处理多个线程，可用于单核处理器，选项C错误。共享内存多处理器（SMP）具有共享的单一物理地址空间，所有核都可通过存取指令来访问同一片主存地址空间。',
'多核处理器属于MIMD结构', '向量处理器属于SIMD结构', '硬件多线程技术只可用于多核处理器', 'SMP中所有处理器共享单一物理地址空间');

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
    '原题来自《2027年计算机组成原理考研复习指导》第5章 5.7 多处理器的基本概念 本节试题精选。原始页码：' || q.source_pages || '。本批共12道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch5_g_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000215', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch5_g_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000215', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch5_g_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000215', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch5_g_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000215', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch5_g_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch5_g_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000115101', 'CO-2027-ORIGINAL-CH5-G-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000115102', '5.7多处理器的基本概念')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch5_g_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH5-G-TEXT-ONLY',
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
DROP TABLE co_2027_original_ch5_g_text_import;
