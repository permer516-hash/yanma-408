-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 5: 5.1 CPU的功能和基本结构 (Q1-Q24, pure text only).
-- Text-only batch: all 24 questions are conceptual with no image/table/code dependencies.
-- Batch: CO-2027-ORIGINAL-CH5-A-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000110301',
    c.id,
    'CO_CPU_OVERVIEW',
    'CPU的功能和基本结构',
    1
FROM chapters c
WHERE c.code = 'CO_CPU'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CPU_OVERVIEW');

CREATE TABLE co_2027_original_ch5_a_text_import (
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

INSERT INTO co_2027_original_ch5_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 5.1 CPU的功能和基本结构 Q1-Q24
-- Q1-Q21: 模拟题; Q22: 2010统考真题; Q23: 2016统考真题; Q24: 2020统考真题
-- 全部24道均为纯文本单选题，无图片/表格/版式依赖
-- ============================================================

(1, '00000000-0000-0000-0000-000000110001', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.197,199',
 'CPU 的核心功能是执行程序，下列不属于 CPU 的基本功能的是（ ）。',
 'D',
 'CPU 的基本功能包括：通过时序控制协调指令执行节奏，响应并处理异常与中断事件，以及利用 ALU 执行算术与逻辑运算。数据存储由主存、Cache 等存储器承担；CPU 仅包含少量寄存器用于临时暂存，不负责持久性或主体数据存储，因此不属于其基本功能，选项 D 错误。',
 '时序控制', '异常与中断处理', '执行算术和逻辑运算', '数据存储'),

(2, '00000000-0000-0000-0000-000000110002', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.197,199',
 '通用寄存器是（ ）。',
 'D',
 '存放指令的寄存器是指令寄存器，选项 A 错误。存放程序状态字的寄存器是程序状态字寄存器，选项 B 错误。通用寄存器本身并不一定具有计数逻辑和移位逻辑功能，选项 C 错误。',
 '可存放指令的寄存器', '可存放程序状态字的寄存器', '本身具有计数逻辑与移位逻辑的寄存器', '可编程指定多种功能的寄存器'),

(3, '00000000-0000-0000-0000-000000110003', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.197,199',
 'CPU 中保存当前正在执行指令的寄存器是（ ）。',
 'A',
 '指令寄存器用于存放当前正在执行的指令。',
 '指令寄存器', '指令译码器', '数据寄存器', '地址寄存器'),

(4, '00000000-0000-0000-0000-000000110004', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.197,199',
 '在 CPU 中，跟踪后继指令地址的寄存器是（ ）。',
 'B',
 '程序计数器用于存放下一条指令在主存储器中的地址，具有地址自增功能。',
 '指令寄存器', '程序计数器', '地址寄存器', '状态寄存器'),

(5, '00000000-0000-0000-0000-000000110005', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.197,199',
 '条件转移指令执行时所依据的条件来自（ ）。',
 'B',
 '指令寄存器用于存放当前正在执行的指令；程序计数器用于存放下一条指令的地址；地址寄存器用于暂存指令或数据的地址；程序状态字寄存器用于保存系统的运行状态。条件转移指令执行时，需要对标志寄存器的内容进行测试，判断是否满足转移条件。',
 '指令寄存器', '标志寄存器', '程序计数器', '地址寄存器'),

(6, '00000000-0000-0000-0000-000000110006', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.197,199-200',
 '在 CPU 的寄存器中，（ ）对汇编语言程序员是完全透明的。',
 'C',
 '对汇编语言程序员透明是指无法通过汇编指令直接访问或修改。指令寄存器由硬件自动加载，程序员不可读/写，故完全透明，选项 C 正确。程序计数器可通过转移/调用间接控制，通用寄存器可直接读写，状态寄存器用户虽不能直接修改但可读取其值，因此它们对程序员都不是完全透明的。',
 '程序计数器', '状态寄存器', '指令寄存器', '通用寄存器'),

(7, '00000000-0000-0000-0000-000000110007', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.197-198,200',
 '指令（ ）从主存储器中读出。',
 'A',
 'CPU 根据程序计数器（PC）中的内容从主存储器中取指令。当前指令正在执行时，PC 已经是下一条指令的地址。若遇到无条件转移指令，则只需简单地用转移地址覆盖原 PC 的内容即可，最终的结果还是根据 PC 从主存储器中读出。地址寄存器用来指出所取数据在主存储器中的地址。',
 '总是根据程序计数器', '有时根据程序计数器，有时根据转移指令', '根据地址寄存器', '有时根据程序计数器，有时根据地址寄存器'),

(8, '00000000-0000-0000-0000-000000110008', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 '程序计数器（PC）属于（ ）的部件。',
 'B',
 '控制器是计算机中处理指令的部件，包含程序计数器。',
 '运算器', '控制器', '存储器', 'ALU'),

(9, '00000000-0000-0000-0000-000000110009', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 '下面有关程序计数器（PC）的叙述中，错误的是（ ）。',
 'C',
 'PC 中存放下一条要执行的指令的地址，选项 A 正确。PC 的值会根据 CPU 在执行指令的过程中修改（确切地说是在取指周期），或自增，或转移到程序的某处，选项 B 正确。转移指令时，需要判别转移是否成功，若成功则 PC 修改为转移指令的目标地址，否则下一条指令的地址仍然为 PC 自增后的地址，选项 C 错误。PC 的位数通常和 MAR 的位数一样，选项 D 正确。',
 'PC 中总是存放指令地址', 'PC 的值由 CPU 在执行指令过程中进行修改', '执行转移指令时，PC 的值总是修改为转移指令的目标地址', 'PC 的位数一般和存储器地址寄存器（MAR）的位数一样'),

(10, '00000000-0000-0000-0000-000000110010', 'CO_CPU', 'CO_CPU_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 '若指令按字边界对齐存放，程序计数器（PC）可以使用字地址，其位数取决于（ ）。 I. 存储器的容量 II. 机器字长 III. 指令字长',
 'B',
 '当指令按字边界对齐且 PC 采用字地址时，PC 的值表示下一条指令所在"字"的地址。设主存容量为 M 字节，机器字长为 W 字节，则主存最多容纳 M/W 个字，PC 至少需要 log₂(M/W) 位。因此，PC 的位数取决于存储器容量和机器字长，而与指令字长无直接关系。',
 '仅 I', 'I 和 II', 'I 和 III', 'I、II 和 III'),

(11, '00000000-0000-0000-0000-000000110011', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 '下列关於程序计数器（PC）的叙述中，错误的是（ ）。',
 'B',
 '机器指令中不能显式地使用 PC，PC 的值是自增的，或者是由转移类指令设置的。指令顺序执行时，PC 自动加"1"，这里的"1"是指一条指令的长度，PC 的值不一定总是自动加 1，而是根据指令长度来确定的（具体取决于指令长度占几个编址单位）。其余说法均正确。',
 '机器指令中不能显式地使用 PC', '指令顺序执行时，PC 值总是自动加 1', '调用指令执行后，PC 值一定是被调用过程的入口地址', '无条件转移指令执行后，PC 值一定是转移目标地址'),

(12, '00000000-0000-0000-0000-000000110012', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 '指令寄存器（IR）的位数取决于（ ）。',
 'C',
 '指令寄存器中保存当前正在执行的指令，所以其位数取决于指令字长。',
 '存储器的容量', '机器字长', '指令字长', '存储字长'),

(13, '00000000-0000-0000-0000-000000110013', 'CO_CPU', 'CO_CPU_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 'CPU 中通用寄存器的位数取决于（ ）。',
 'C',
 '通用寄存器用于存放操作数和各种地址信息等，其位数与机器字长相等，因此便于操作控制。',
 '存储器的容量', '指令字长', '机器字长', '都不对'),

(14, '00000000-0000-0000-0000-000000110014', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 'CPU 中的通用寄存器，（ ）。',
 'B',
 '通用寄存器供用户自由编程，可以存放数据和地址。而指令寄存器是专门用于存放指令的专用寄存器，不能由通用寄存器代替。',
 '只能存放数据，不能存放地址', '可以存放数据和地址', '既不能存放数据，又不能存放地址', '可以存放数据和地址，还可以替代指令寄存器'),

(15, '00000000-0000-0000-0000-000000110015', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200',
 '在计算机系统中表示程序和机器运行状态的部件是（ ）。',
 'D',
 '程序状态字寄存器用于存放程序状态字，而程序状态字的各位表征程序和机器的运行状态，如含有进位标志（CF）、结果为零标志（ZF）等。',
 '程序计数器', '指令寄存器', '中断寄存器', '程序状态字寄存器'),

(16, '00000000-0000-0000-0000-000000110016', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200-201',
 '状态寄存器用来存放（ ）。',
 'D',
 '程序状态字寄存器用于保留算术、逻辑运算及测试指令的结果状态。',
 '算术运算结果', '逻辑运算结果', '运算类型', '算术、逻辑运算及测试指令的结果状态'),

(17, '00000000-0000-0000-0000-000000110017', 'CO_CPU', 'CO_CPU_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,200-201',
 '下列关於标志寄存器（EFLAGS 寄存器或 PSW 寄存器）的叙述中，错误的是（ ）。',
 'C',
 '标志寄存器是专用寄存器，不需要编号，也不能在指令中直接指定编号来访问；标志寄存器中的内容是执行指令的过程中，CPU 根据指令执行的结果生成的各种标志信息，用户不能直接修改它的值。标志寄存器中的标志位主要用于条件转移或条件设置类指令的条件判断。',
 '不需要像通用寄存器那样，对标志寄存器进行编号', '条件转移指令根据其中的一些标志位来确定 PC 的值', '可以通过指令直接访问标志寄存器并修改它的值', '可以用它来存放执行指令得到的各种标志信息'),

(18, '00000000-0000-0000-0000-000000110018', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,201',
 '下列表述中，对 CPU 中控制器功能描述最完整的是（ ）。',
 'D',
 '控制器的核心功能是在时序驱动下完成取指、译码，并根据操作码生成相应的控制信号，协调各部件工作。选项 A 仅描述其子功能（时序生成），选项 B 和 C 均只涉及单一环节；而选项 D 抓住了控制器"分析指令并发出控制命令"的本质，因此是对其功能最完整的描述。',
 '产生 CPU 工作所需的时序信号', '控制从主存取出一条指令', '完成指令操作码的译码', '完成指令操作码译码，并产生相应的操作控制信号'),

(19, '00000000-0000-0000-0000-000000110019', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.198,201',
 'CPU 中不包括（ ）。',
 'C',
 '地址译码器是主存等存储器的组成部分，其作用是根据输入的地址码唯一选定一个存储单元，它不是 CPU 的组成部分。而 MAR、IR、PC 都是 CPU 的组成部分。',
 '存储器地址寄存器（MAR）', '指令寄存器（IR）', '地址译码器', '程序计数器（PC）'),

(20, '00000000-0000-0000-0000-000000110020', 'CO_CPU', 'CO_CPU_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.199,201',
 '以下关于计算机系统的概念中，正确的是（ ）。 I. CPU 不包括地址译码器 II. CPU 的程序计数器中存放的是操作数地址 III. CPU 中决定指令执行顺序的是程序计数器 IV. CPU 的状态寄存器对用户是完全透明的',
 'A',
 '地址译码器位于存储器，说法 I 正确；程序计数器中存放的是欲执行指令的地址，它决定程序的执行顺序，说法 II 错误、说法 III 正确；程序状态字寄存器对用户不完全透明（用户可读出标志位，但不能在用户态直接修改），说法 IV 错误。',
 'I、III', 'I、IV', 'I、II、IV', 'I、II、III'),

(21, '00000000-0000-0000-0000-000000110021', 'CO_CPU', 'CO_CPU_OVERVIEW', 'BASIC', 'MOCK', 2027, '5.1CPU的功能和基本结构', 'pp.199,201',
 '间址周期结束后，CPU 内寄存器 MDR 中的内容为（ ）。',
 'B',
 '间址周期的作用是取操作数的有效地址，因此，间址周期结束后，MDR 中的内容为操作数地址。',
 '指令', '操作数地址', '操作数', '无法确定'),

(22, '00000000-0000-0000-0000-000000110022', 'CO_CPU', 'CO_CPU_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2010, '5.1CPU的功能和基本结构', 'pp.199,201',
 '【2010 统考真题】下列寄存器中，汇编语言程序员可见的是（ ）。',
 'B',
 '汇编语言程序员可见的是程序计数器（PC），即汇编语言程序员通过汇编程序可以对某个寄存器进行访问。汇编语言程序员可以通过指定待执行指令的地址来设置 PC 的值，如转移指令、子程序调用指令等。而 IR、MAR、MDR 是 CPU 的内部工作寄存器，对程序员不可见。',
 '存储器地址寄存器（MAR）', '程序计数器（PC）', '存储器数据寄存器（MDR）', '指令寄存器（IR）'),

(23, '00000000-0000-0000-0000-000000110023', 'CO_CPU', 'CO_CPU_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2016, '5.1CPU的功能和基本结构', 'pp.199,201',
 '【2016 统考真题】某计算机的主存储器空间为 4GB，字长为 32 位，按字节编址，采用 32 位字长指令字格式。若指令按字边界对齐存放，则程序计数器（PC）和指令寄存器（IR）的位数至少分别是（ ）。',
 'B',
 'PC 用于指出下一条指令的主存地址，虽然可以用 32 位的地址来表示指令地址，但实际上内存中最多只能存放 4GB/32 位 = 2³⁰ 条指令，所以可以用 30 位的字地址来表示指令地址，这种情况下指令必须采用按边界对齐的方式存放，所以 PC 的位数至少是 30 位，即 PC 给出的地址是字地址。题干已说明指令按字边界对齐的方式存放，也就是说，指令地址都是 4 字节的整数倍，因此为了让 PC 的位数最少，可以采用字地址，取指令时将 PC 值左移 2 位到主存中取指令。指令寄存器（IR）用于存放从内存中取出的指令，它取决于指令字长，所以 IR 的位数至少是 32 位。',
 '30, 30', '30, 32', '32, 30', '32, 32'),

(24, '00000000-0000-0000-0000-000000110024', 'CO_CPU', 'CO_CPU_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2020, '5.1CPU的功能和基本结构', 'pp.199,201',
 '【2020 统考真题】下列给出的部件中，其位数（宽度）一定与机器字长相同的是（ ）。 I. ALU II. 指令寄存器 III. 通用寄存器 IV. 浮点寄存器',
 'B',
 '机器字长是指 CPU 内部用于整数运算的数据通路的宽度。数据通路是指数据在指令执行过程中所经过的路径及路径上的部件，主要是 CPU 内部进行数据运算、存储和传送的部件，这些部件的宽度基本上要一致才能相互匹配。因此，机器字长等于 ALU 位数和通用寄存器宽度。',
 '仅 I', '仅 I、III', '仅 I、II', '仅 II、III、IV');

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
    '原题来自《2027年计算机组成原理考研复习指导》第5章 5.1 CPU的功能和基本结构 本节试题精选。原始页码：' || q.source_pages || '。本批共24道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch5_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000210', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch5_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000210', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch5_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000210', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch5_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000210', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch5_a_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch5_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000110101', 'CO-2027-ORIGINAL-CH5-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000110102', '5.1CPU的功能和基本结构')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch5_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH5-A-TEXT-ONLY',
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
DROP TABLE co_2027_original_ch5_a_text_import;
