-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 5: 5.5 异常和中断机制 (Q1-Q13, pure text only).
-- Text-only batch: all 13 questions are conceptual with no image/table/code dependencies.
-- Batch: CO-2027-ORIGINAL-CH5-E-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000113301',
    c.id,
    'CO_CPU_EXCEPTION_INTERRUPT',
    '异常和中断机制',
    5
FROM chapters c
WHERE c.code = 'CO_CPU'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CPU_EXCEPTION_INTERRUPT');

CREATE TABLE co_2027_original_ch5_e_text_import (
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

INSERT INTO co_2027_original_ch5_e_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 5.5 异常和中断机制 Q1-Q13
-- Q1-Q9: 模拟题; Q10: 2015统考真题; Q11: 2016统考真题; Q12: 2020统考真题; Q13: 2021统考真题
-- 全部13道均为纯文本单选题，无图片/表格/版式依赖
-- ============================================================

(1, '00000000-0000-0000-0000-000000113001', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'BASIC', 'MOCK', 2027, '5.5异常和中断机制', 'pp.244,245',
 '以下关于"自陷"（Trap）异常的叙述中，错误的是（ ）。',
 'C',
 '自陷是人为设定的特殊中断机制，不是出现某些异常情况而产生的，选项 C 错误。自陷可由访管指令或自陷指令的执行进入，发生后 CPU 将进入操作系统内核程序并执行。',
 '"自陷"是人为预先设定的一种特定处理事件', '可由访管指令或自陷指令的执行进入"自陷"', '一定是出现某种异常情况才会发生"自陷"', '"自陷"发生后 CPU 将进入操作系统内核程序并执行'),

(2, '00000000-0000-0000-0000-000000113002', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'BASIC', 'MOCK', 2027, '5.5异常和中断机制', 'pp.244,245',
 '指令执行结果出现异常而引起的中断是（ ）。',
 'C',
 '异常是 CPU 执行指令过程中发生的与当前指令执行有关的意外事件，而中断请求则是 CPU 外部的 I/O 部件或时钟等向 CPU 发出的与当前指令执行无关的意外事件。指令执行结果出现异常（如运算溢出等），属于内中断中的故障。',
 'I/O 中断', '机器校验中断', '故障', '外部中断'),

(3, '00000000-0000-0000-0000-000000113003', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'BASIC', 'MOCK', 2027, '5.5异常和中断机制', 'pp.244,246',
 '访问主存时发生的校验错误属于（ ）。',
 'C',
 '若在执行指令的过程中发生严重错误，如控制器出错、存储器校验错等，则程序将无法继续执行，只能终止。严重情况下，甚至要调出中断服务程序来重启系统。',
 '故障', '自陷', '终止', '外中断'),

(4, '00000000-0000-0000-0000-000000113004', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'MEDIUM', 'MOCK', 2027, '5.5异常和中断机制', 'pp.244,246',
 '下列关于异常和中断响应的叙述中，错误的是（ ）。',
 'C',
 'CPU 对于异常和中断的响应处理大体是一致的，都需要保存断点和程序状态字并转到相应的处理程序去执行，但有些细节并不一样。例如，检测到中断请求后，CPU 必须通过"中断回答"信号启动中断控制器进行中断查询，以确定当前发出的优先级最高的中断请求，并通过数据线获取相应的中断类型号；而对于异常，CPU 无须进行中断回答。',
 '异常事件检测由 CPU 在执行每一条指令的过程中进行', '中断请求检测由 CPU 在每条指令执行结束、取下条指令之前进行', 'CPU 检测到异常事件后所做的处理和检测到中断请求后所做的处理完全相同', 'CPU 在中断响应时会关中断、保存断点和程序状态并转到相应的中断服务程序'),

(5, '00000000-0000-0000-0000-000000113005', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'BASIC', 'MOCK', 2027, '5.5异常和中断机制', 'pp.244,246',
 '下列给出的事件中，无须异常处理程序进行处理的是（ ）。',
 'B',
 '缺页、地址越界和除数为 0 都是执行某条指令时可能发生的故障，需要调出操作系统内核中相应的异常处理程序来处理，而 Cache 缺失则由 CPU 硬件实现，无须调出异常处理程序进行处理。',
 '缺页故障', 'Cache 缺失', '地址越界', '除数为 0'),

(6, '00000000-0000-0000-0000-000000113006', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'BASIC', 'MOCK', 2027, '5.5异常和中断机制', 'pp.244,246',
 'CPU 响应中断的时间是（ ）。',
 'A',
 '中断周期用于响应中断，若有中断，则在指令的执行周期后进入中断周期。CPU 总是在一条指令执行结束时检测中断请求。',
 '一条指令执行结束', 'I/O 设备提出中断', '取指周期结束', '指令周期结束'),

(7, '00000000-0000-0000-0000-000000113007', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'BASIC', 'MOCK', 2027, '5.5异常和中断机制', 'pp.244-245,246',
 '下列选项中，不属于外部中断事件的是（ ）。',
 'B',
 '无效操作码是由 CPU 在对某条指令译码时发现的，因此是内部异常。采样定时时间到、打印机缺纸、键盘缓冲满都与当前指令的执行无关，是由 CPU 外部的中断源发出的中断请求，属于外部中断事件。',
 '采样定时时间到', '无效操作码', '打印机缺纸', '键盘缓冲满'),

(8, '00000000-0000-0000-0000-000000113008', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'MEDIUM', 'MOCK', 2027, '5.5异常和中断机制', 'pp.245,246',
 '下列关于异常/中断机制与进程上下文切换机制的叙述中，错误的是（ ）。',
 'D',
 '进程上下文切换和异常/中断响应两者都会产生异常控制流。响应异常/中断请求后，CPU 执行的是异常/中断服务程序，是操作系统的内核程序。进程上下文切换由操作系统的内核程序实现，而异常/中断的响应则由硬件实现。选项 D 错误：进程上下文切换通过执行内核程序实现，但异常/中断响应是由硬件自动完成的。',
 '进程上下文切换和异常/中断响应两者都会产生异常控制流', '进程上下文切换后，CPU 执行的是另一个进程的代码', '响应异常/中断请求后，CPU 执行的是内核程序的代码', '进程上下文切换和异常/中断响应处理都通过执行内核程序实现'),

(9, '00000000-0000-0000-0000-000000113009', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'MEDIUM', 'MOCK', 2027, '5.5异常和中断机制', 'pp.245,246-247',
 '异常或中断处理结束后，返回到被中断原程序继续执行的指令地址称为"断点"，下列关于"断点"的说法中，错误的是（ ）。',
 'C',
 '外部中断请求信号的检测总是在一条指令执行完之后、取下一条指令之前。因此，若检测到有外部中断请求，则响应中断请求并转到中断服务程序执行后，应返回到原来被中断的程序中已经执行完成的指令的下一条指令执行，而不返回到刚执行完的指令执行。选项 C 错误：外部中断的断点应为下一条指令的地址，而非当前刚执行完的指令的地址。',
 '"陷阱"类异常的断点为陷阱指令下一条指令的地址', '"故障"类异常的断点为当前发生异常的指令的地址', '外部中断的断点总是当前刚执行完的指令的地址', '"终止"类异常的断点可以是当前指令或下一条指令的地址'),

(10, '00000000-0000-0000-0000-000000113010', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'MEDIUM', 'PAST_EXAM', 2015, '5.5异常和中断机制', 'pp.245,247',
 '【2015 统考真题】内部异常（内中断）可分为故障（fault）、陷阱（trap）和终止（abort）三类。下列有关内部异常的叙述中，错误的是（ ）。',
 'D',
 '内部异常是指来自 CPU 内部产生的中断，如非法指令、地址非法、校验错、页面失效、运算溢出和除数为零等，以上都是在指令的执行过程中产生的，选项 A 正确。内部异常的检测是由 CPU 自身完成的，不必通过外部的某个信号通知 CPU，选项 B 正确。内部异常不能被屏蔽，一旦出现应立即处理，选项 C 正确。对于非法指令、除数为零等异常，无法通过异常处理程序恢复故障，因此不能回到原断点执行，必须终止进程的执行，选项 D 错误。',
 '内部异常的产生与当前执行指令相关', '内部异常的检测由 CPU 内部逻辑实现', '内部异常的响应发生在指令执行过程中', '内部异常处理后返回到发生异常的指令继续执行'),

(11, '00000000-0000-0000-0000-000000113011', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'MEDIUM', 'PAST_EXAM', 2016, '5.5异常和中断机制', 'pp.245,247',
 '【2016 统考真题】异常是指令执行过程中在处理器内部发生的特殊事件，中断是来自处理器外部的请求事件。下列关于中断或异常情况的叙述中，错误的是（ ）。',
 'A',
 '中断是指来自 CPU 执行指令以外的事件，如设备发出的 I/O 结束中断，表示设备输入/输出已完成，希望处理机能向设备发出下一个输入/输出请求，同时让被中断的程序继续执行。异常也称内中断，指源自 CPU 执行指令内部的事件。"访存时缺页"属于异常（内中断），而非外部中断，选项 A 错误。',
 '"访存时缺页"属于中断', '"整数除以 0"属于异常', '"DMA 传送结束"属于中断', '"存储保护错"属于异常'),

(12, '00000000-0000-0000-0000-000000113012', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'MEDIUM', 'PAST_EXAM', 2020, '5.5异常和中断机制', 'pp.245,247',
 '【2020 统考真题】下列关于"自陷"（Trap，也称陷阱）的叙述中，错误的是（ ）。',
 'A',
 '自陷是一种内部异常，不是外部中断事件，选项 A 错误。在 x86 计算机中，用于程序调试的"断点设置"功能是通过自陷机制实现的，选项 B 正确。执行到自陷指令时，无条件或有条件地自动调出操作系统内核程序进行执行，选项 C 正确。CPU 执行陷阱指令后，会自动地根据不同陷阱类型进行相应的处理，然后返回到陷阱指令的下一条指令执行，选项 D 正确。',
 '自陷是通过陷阱指令预先设定的一类外部中断事件', '自陷可用于实现程序调试时的断点设置和单步跟踪', '自陷发生后 CPU 将转去执行操作系统内核相应程序', '自陷处理完成后返回到陷阱指令的下一条指令执行'),

(13, '00000000-0000-0000-0000-000000113013', 'CO_CPU', 'CO_CPU_EXCEPTION_INTERRUPT', 'MEDIUM', 'PAST_EXAM', 2021, '5.5异常和中断机制', 'pp.245,247',
 '【2021 统考真题】异常事件在当前指令执行过程中进行检测，中断请求则在当前指令执行后进行检测。下列事件中，相应处理程序执行后，必须回到当前指令重新执行的是（ ）。',
 'B',
 '系统调用属于自陷，"断点"为自陷指令的下一条指令地址，处理完成后返回到下一条指令，不用重新执行当前指令。DMA 传送结束后，DMA 控制器需要向 CPU 发送中断请求，属于外中断，外中断的"断点"为下一条指令地址。打印机缺纸同样属于外中断。页缺失属于内部异常中的故障，"断点"为发生故障的指令地址，执行完缺页异常处理程序之后必须返回发生故障的指令重新执行。',
 '系统调用', '页缺失', 'DMA 传送结束', '打印机缺纸');

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
    '原题来自《2027年计算机组成原理考研复习指导》第5章 5.5 异常和中断机制 本节试题精选。原始页码：' || q.source_pages || '。本批共13道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch5_e_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000213', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch5_e_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000213', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch5_e_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000213', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch5_e_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000213', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch5_e_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch5_e_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000113101', 'CO-2027-ORIGINAL-CH5-E-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000113102', '5.5异常和中断机制')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch5_e_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH5-E-TEXT-ONLY',
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
DROP TABLE co_2027_original_ch5_e_text_import;
