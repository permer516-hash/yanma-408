-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 7: 7.1 I/O系统基本概念 (Q1-Q3) + 7.2 I/O接口 (Q4-Q20), pure text only.
-- Q1-Q2: 7.1 MOCK; Q3: 7.1 PAST_EXAM 2010
-- Q4-Q16: 7.2 MOCK; Q17-Q20: 7.2 PAST_EXAM (2012/2014/2017/2021)
-- Batch: CO-2027-ORIGINAL-CH7-A-B-TEXT-ONLY

-- Ensure CO_IO knowledge points
INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000119301',
    c.id,
    'CO_IO_BASIC',
    'I/O系统基本概念',
    2
FROM chapters c
WHERE c.code = 'CO_IO'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_IO_BASIC');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000119302',
    c.id,
    'CO_IO_INTERFACE',
    'I/O接口',
    3
FROM chapters c
WHERE c.code = 'CO_IO'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_IO_INTERFACE');

CREATE TABLE co_2027_original_ch7_ab_text_import (
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

INSERT INTO co_2027_original_ch7_ab_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 7.1 I/O系统基本概念 Q1-Q3
-- Q1-Q2: 模拟题; Q3: 2010统考真题
-- ============================================================

(1, '00000000-0000-0000-0000-000000119001', 'CO_IO', 'CO_IO_BASIC', 'BASIC', 'MOCK', 2027, '7.1I/O系统基本概念', 'pp.292-293,293-294',
'在微型机系统中，I/O设备通过（ ）与主板的系统总线相连接。',
'B',
'I/O设备不可能直接与主板总线相连，它总是通过设备控制器来相连的。设备控制器负责在I/O设备与系统总线之间进行数据缓冲、格式转换和时序控制。',
'DMA控制器', '设备控制器', '中断控制器', 'I/O端口'),

(2, '00000000-0000-0000-0000-000000119002', 'CO_IO', 'CO_IO_BASIC', 'BASIC', 'MOCK', 2027, '7.1I/O系统基本概念', 'pp.292-293,293-294',
'显示汉字采用点阵字库，若每个汉字用16×16的点阵表示，7500个汉字的字库容量是（ ）。',
'B',
'每个汉字占用16×16/8=32B，则汉字字库容量=7500×32B=240000B≈240KB。',
'16KB', '240KB', '320KB', '1MB'),

(3, '00000000-0000-0000-0000-000000119003', 'CO_IO', 'CO_IO_BASIC', 'MEDIUM', 'PAST_EXAM', 2010, '7.1I/O系统基本概念', 'pp.292-293,293-294',
'【2010统考真题】假定一台计算机的显示存储器用DRAM芯片实现，若要求显示分辨率为1600×1200，颜色深度为24位，帧频为85Hz，显存总带宽的50%用来刷新屏幕，则需要显存总带宽约为（ ）。',
'D',
'刷新所需带宽=分辨率×颜色深度×帧频=1600×1200×24bit×85Hz=3916.8Mb/s。显存总带宽的50%用来刷新屏幕，因此需要的显存总带宽至少为3916.8/0.5=7833.6Mb/s≈7834Mb/s。',
'245Mb/s', '979Mb/s', '1958Mb/s', '7834Mb/s'),

-- ============================================================
-- 7.2 I/O接口 Q4-Q20
-- Q4-Q16: 模拟题; Q17-Q20: 统考真题 (2012/2014/2017/2021)
-- ============================================================

(4, '00000000-0000-0000-0000-000000119004', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'在统一编址的方式下，区分存储单元和I/O设备是靠（ ）。',
'A',
'在统一编址的情况下，没有专门的I/O指令，因此用访存指令来实现I/O操作，区分存储单元和I/O设备是靠它们各自不同的地址码。不同的地址码指向不同的地址空间范围，通过地址范围即可区分访问目标是内存还是I/O设备。',
'不同的地址码', '不同的地址线', '不同的控制线', '不同的数据线'),

(5, '00000000-0000-0000-0000-000000119005', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'下列功能中，属于I/O接口的功能的是（ ）。
I. 数据格式的转换
II. I/O过程中错误与状态检测
III. I/O操作的控制与定时
IV. 与主机和外设通信',
'D',
'I/O接口的功能包括：①选址功能；②传送命令功能；③传送数据功能；④反映I/O设备工作状态的功能。选项I（数据格式转换）是为弥合主机与外设的异构性而设置的功能；选项II属于④；选项III属于②；选项IV属于③。因此I、II、III和IV均属于I/O接口的功能。',
'I和IV', 'I、II和IV', 'II和IV', 'I、II、III和IV'),

(6, '00000000-0000-0000-0000-000000119006', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'下列关于I/O端口和接口的说法中，正确的是（ ）。',
'D',
'在独立编址方式下，I/O端口和主存使用不同的地址空间，CPU访问I/O端口时需要专门的输入/输出指令（如IN和OUT指令），而不能直接使用主存操作指令。在统一编址方式下，I/O端口和主存共享同一地址空间，存储保护措施通过相同的机制来实现。两种编址方式都是通过相同的地址总线进行访问的，通过不同的编址策略和控制信号来区分。',
'在统一编址方式下，对主存单元和I/O端口的存储保存措施是独立的', '在统一编址方式下，主存单元和I/O端口是靠不同的地址线来区分的', '在独立编址方式下，主存单元和I/O端口是靠不同的地址线来区分的', '在独立编址方式下，CPU需要设置专门的输入/输出指令访问I/O端口'),

(7, '00000000-0000-0000-0000-000000119007', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'下列属于I/O接口中寄存器的有（ ）。
I. 指令寄存器
II. 控制寄存器
III. 状态寄存器
IV. 数据缓冲寄存器
V. 存储器地址寄存器',
'B',
'I/O接口中的寄存器主要有数据缓冲寄存器、控制寄存器和状态寄存器。指令寄存器和存储器地址寄存器属于CPU内部的寄存器，不属于I/O接口。因此II、III和IV正确。',
'I、II、III和V', 'II、III和IV', 'II、III和V', 'III、IV和V'),

(8, '00000000-0000-0000-0000-000000119008', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'I/O的编址方式采用统一编址方式时，进行输入/输出的操作的指令是（ ）。',
'B',
'统一编址方式将I/O端口当作存储器的单元进行地址分配，CPU不需要设置专门的I/O指令，用统一的访存指令就可以访问I/O端口。独立编址时，则需要使用专门的输入/输出指令来完成输入/输出操作。',
'控制指令', '访存指令', '输入/输出指令', '都不对'),

(9, '00000000-0000-0000-0000-000000119009', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'下列关于I/O指令的说法中，错误的是（ ）。',
'D',
'I/O指令是指令系统的一部分，是机器指令的一类，但其为了反映与I/O设备交互的特点，格式和其他通用指令相比有所不同。因此选项D错误。',
'I/O指令是CPU系统指令的一部分', 'I/O指令是机器指令的一类', 'I/O指令反映CPU和I/O设备交换信息的特点', 'I/O指令的格式和通用指令的格式相同'),

(10, '00000000-0000-0000-0000-000000119010', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'下列叙述中，正确的是（ ）。',
'D',
'在统一编址的情况下，访存指令也可访问I/O设备，因此选项A、B、C均错误。在独立编址的方式下，访问I/O地址空间必须通过专门的I/O指令，因此只有在具有专门I/O指令的计算机中，I/O设备才可以单独编址，选项D正确。',
'只有I/O指令可以访问I/O设备', '在统一编址下，不能直接访问I/O设备', '访问存储器的指令一定不能访问I/O设备', '只有在具有专门I/O指令的计算机中，I/O设备才可以单独编址'),

(11, '00000000-0000-0000-0000-000000119011', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'在内存地址空间与接口地址空间统一编址的计算机中，不需要的指令是（ ）。',
'C',
'统一编址方式把I/O端口当作存储器的单元进行地址分配，CPU不需要设置专门的I/O指令（输入/输出类指令，如IN和OUT指令），用统一的访存指令就可以访问I/O端口。',
'数据传送类（如MOV指令）', '算术、逻辑运算类（如ADD、SUB、AND和OR指令）', '输入/输出类（如IN和OUT指令）', '程序控制类（如条件转移指令和子程序调用指令）'),

(12, '00000000-0000-0000-0000-000000119012', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'在统一编址的情况下，就I/O设备而言，其对应的I/O地址不可取的是（ ）。',
'D',
'在统一编址方式下，指令靠地址码区分内存和I/O设备，若随意在地址的任何地方编址，则会给编程造成极大的混乱，因此选项D错误。固定在地址高端、地址低端或相对固定在地址的某部分都是可取的做法。',
'要求固定在地址高端', '要求固定在地址低端', '要求相对固定在地址的某部分', '可以随意在地址的任何地方'),

(13, '00000000-0000-0000-0000-000000119013', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'磁盘驱动器向盘片磁道记录数据时采用（ ）方式写入。',
'B',
'磁盘驱动器向盘片磁道记录数据时采用串行方式写入。盘面上的信息按位串行记录在磁道上，读写时通过磁头一位一位地进行。',
'并行', '串行', '并行-串行', '串行-并行'),

(14, '00000000-0000-0000-0000-000000119014', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'采用中断方式进行打印控制时，在打印控制接口和打印机之间交换的信息不包括（ ）。',
'D',
'打印机的打印控制接口和打印机之间通过电缆交换的信息包括：打印字符点阵信息、打印控制信息（如"初始化""选通""自动走纸"等）以及打印机状态信息（如"联机""忙""缺纸"等）。中断请求信号是打印控制接口通过中断控制器发送给CPU的，不在打印控制接口和打印机之间交换。',
'打印字符点阵信息', '打印控制信息', '打印机状态信息', '中断请求信息'),

(15, '00000000-0000-0000-0000-000000119015', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'主机和外设之间的正确连接通路是（ ）。',
'B',
'CPU和主存通过I/O总线与I/O接口相连，I/O接口通过通信总线（电缆）与外设相连。I/O接口是连接主机侧系统总线与设备侧通信总线的桥梁。',
'CPU和主存—I/O总线—通信总线（电缆）—I/O接口—外设', 'CPU和主存—I/O总线—I/O接口—通信总线（电缆）—外设', 'CPU和主存—I/O接口—I/O总线—通信总线（电缆）—外设', 'CPU和主存—I/O接口—通信总线（电缆）—I/O总线—外设'),

(16, '00000000-0000-0000-0000-000000119016', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'MOCK', 2027, '7.2I/O接口', 'pp.295-297,297-298',
'下列有关I/O接口功能和结构的叙述中，错误的是（ ）。',
'A',
'I/O接口中主机侧通过I/O总线与主机相连，设备侧通过通信总线（电缆）与外设相连。I/O总线中的数据线宽度和连接设备的电缆中的数据线宽度不一定相同，因此选项A错误。',
'I/O接口中主机侧数据宽度与设备侧数据宽度总是一样的', 'I/O接口是像显卡或网卡之类的一种外设控制逻辑', 'CPU可以从I/O接口读取状态信息，以了解接口和外设的状态', 'CPU可以向I/O接口传送用来对设备进行控制的命令'),

(17, '00000000-0000-0000-0000-000000119017', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'PAST_EXAM', 2012, '7.2I/O接口', 'pp.295-297,297-298',
'【2012统考真题】下列选项中，在I/O总线的数据线上传输的信息包括（ ）。
I. I/O接口中的命令字
II. I/O接口中的状态字
III. 中断类型号',
'D',
'I/O总线分为三类：数据线、控制线和地址线。数据缓冲寄存器和命令/状态寄存器的内容都是通过数据线来传送的；地址线用以传送与CPU交换数据的端口地址；控制线用于给I/O端口发送读/写信号。中断类型号用于指出中断向量的地址，CPU响应某一外部中断后，就从数据总线上获取该中断源的中断类型号。因此I、II和III均通过数据线传输。',
'仅I、II', '仅I、III', '仅II、III', 'I、II、III'),

(18, '00000000-0000-0000-0000-000000119018', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'PAST_EXAM', 2014, '7.2I/O接口', 'pp.295-297,297-298',
'【2014统考真题】下列有关I/O接口的叙述中，错误的是（ ）。',
'D',
'采用统一编址时，CPU访存和访问I/O端口用的是一样的指令，所以访存指令可以访问I/O端口，选项D错误。状态端口和控制端口可以合用同一个寄存器（读时是状态端口，写时是控制端口）；I/O接口中CPU可访问的寄存器称为I/O端口；采用独立编址方式时，I/O端口地址和主存地址属于不同地址空间，可以相同。其他三个选项均为正确陈述。',
'状态端口和控制端口可以合用同一个寄存器', 'I/O接口中CPU可访问的寄存器称为I/O端口', '采用独立编址方式时，I/O端口地址和主存地址可能相同', '采用统一编址方式时，CPU不能用访存指令访问I/O端口'),

(19, '00000000-0000-0000-0000-000000119019', 'CO_IO', 'CO_IO_INTERFACE', 'MEDIUM', 'PAST_EXAM', 2017, '7.2I/O接口', 'pp.295-297,297-298',
'【2017统考真题】I/O指令实现的数据传送通常发生在（ ）。',
'D',
'I/O端口是指I/O接口中用于缓冲信息的寄存器。由于主机和I/O设备的工作方式和工作速度有很大差异，I/O端口应运而生。在执行一条I/O指令时，CPU使用地址总线选择所请求的I/O端口，使用数据总线在CPU寄存器和端口之间传输数据。因此I/O指令实现的数据传送通常发生在通用寄存器和I/O端口之间。',
'I/O设备和I/O端口之间', '通用寄存器和I/O设备之间', 'I/O端口和I/O端口之间', '通用寄存器和I/O端口之间'),

(20, '00000000-0000-0000-0000-000000119020', 'CO_IO', 'CO_IO_INTERFACE', 'BASIC', 'PAST_EXAM', 2021, '7.2I/O接口', 'pp.295-297,297-298',
'【2021统考真题】下列选项中，不属于I/O接口的是（ ）。',
'A',
'I/O接口即I/O控制器，其功能是接收主机发送的I/O控制信号，并实现主机和外部设备之间的信息交换。磁盘驱动器是由磁头、磁盘和读/写电路等组成的，也就是我们平常所说的磁盘本身，属于外部设备而非I/O接口。打印机适配器、网络控制器和可编程中断控制器均属于I/O控制器。',
'磁盘驱动器', '打印机适配器', '网络控制器', '可编程中断控制器');

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
    '原题来自《2027年计算机组成原理考研复习指导》第7章 7.1-7.2 本节试题精选。原始页码：' || q.source_pages || '。本批共20道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch7_ab_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000219', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch7_ab_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000219', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch7_ab_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000219', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch7_ab_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000219', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch7_ab_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch7_ab_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tags exist
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000119101', 'CO-2027-ORIGINAL-CH7-A-B-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000119102', '7.1I/O系统基本概念'),
    ('00000000-0000-0000-0000-000000119103', '7.2I/O接口')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch7_ab_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH7-A-B-TEXT-ONLY',
    '第7章输入输出系统',
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
DROP TABLE co_2027_original_ch7_ab_text_import;
