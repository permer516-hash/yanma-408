-- Third computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Batch: CO-2027-003

CREATE TABLE co_2027_batch3_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    stem VARCHAR(1000) NOT NULL,
    answer VARCHAR(1) NOT NULL,
    explanation VARCHAR(1000) NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL
);

INSERT INTO co_2027_batch3_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000031001', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '定点小数补码 1.1010 表示的真值接近下列哪一个？', 'C', '补码小数 1.1010 为负数，取反加 1 得 0.0110，因此真值为 -0.375。', '+0.625', '-0.625', '-0.375', '+0.375'),
(2, '00000000-0000-0000-0000-000000031002', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '补码乘法中，Booth 算法主要利用什么信息决定加减被乘数？', 'A', 'Booth 算法根据乘数相邻位的变化决定加、减或不操作。', '乘数相邻位变化', 'Cache 组号', '指令长度', '中断优先级'),
(3, '00000000-0000-0000-0000-000000031003', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '浮点乘法运算中，阶码通常如何处理？', 'B', '浮点乘法需要阶码相加，并结合偏置或规格化进行修正。', '阶码相减', '阶码相加并修正偏置', '阶码全部清零', '阶码与尾数互换'),
(4, '00000000-0000-0000-0000-000000031004', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '浮点运算结果舍入的主要目的是什么？', 'D', '舍入用于把超出尾数字段可表示位数的结果近似到目标格式。', '扩大寄存器个数', '删除阶码', '避免访存', '适配有限尾数位数'),
(5, '00000000-0000-0000-0000-000000031005', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', '主存按字节编址时，地址每增加 1 通常表示什么？', 'A', '按字节编址时，相邻地址对应相邻字节。', '下一个字节', '下一个字', '下一个 Cache 组', '下一个磁道'),
(6, '00000000-0000-0000-0000-000000031006', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '若主存容量为 1MB，按字节编址，则主存地址至少需要多少位？', 'C', '1MB = 2^20B，按字节编址需要 20 位地址。', '10 位', '16 位', '20 位', '24 位'),
(7, '00000000-0000-0000-0000-000000031007', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '直接映射 Cache 中，若 Cache 行数为 128，则行号字段需要多少位？', 'B', '128 = 2^7，因此行号字段需要 7 位。', '6 位', '7 位', '8 位', '128 位'),
(8, '00000000-0000-0000-0000-000000031008', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '在组相联 Cache 中，若主存块号为 37，Cache 共有 8 组，则该块映射到哪一组？', 'D', '组号通常为主存块号 mod 组数，37 mod 8 = 5。', '1 组', '3 组', '4 组', '5 组'),
(9, '00000000-0000-0000-0000-000000031009', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'Cache 替换算法 LRU 的淘汰依据是什么？', 'A', 'LRU 淘汰最近最久未使用的块，利用时间局部性。', '最近最久未使用', '块号最大', '块号最小', '最先写入主存'),
(10, '00000000-0000-0000-0000-000000031010', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '虚拟存储器中，发生缺页时通常由谁负责调入页面？', 'C', '缺页异常由操作系统处理，负责从外存调入所需页面并更新页表。', 'Cache 替换器', '编译器', '操作系统', '显示控制器'),
(11, '00000000-0000-0000-0000-000000031011', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '页表项中的有效位通常表示什么？', 'B', '有效位表示该虚拟页是否已调入主存。', '页面是否可执行机器语言', '页面是否在主存中', '页面大小是否为 0', '页面是否为 Cache 标记'),
(12, '00000000-0000-0000-0000-000000031012', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '采用多级页表的主要目的是什么？', 'D', '多级页表可以避免为未使用的虚拟地址空间分配完整页表，节省页表空间。', '提高 ALU 速度', '取消页内偏移', '扩大指令操作码', '节省页表存储空间'),
(13, '00000000-0000-0000-0000-000000031013', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'BASIC', '指令字长固定的一个主要优点是什么？', 'A', '固定长度指令便于取指和译码，硬件控制较简单。', '便于取指和译码', '代码一定最短', '无需操作码', '无法流水执行'),
(14, '00000000-0000-0000-0000-000000031014', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '操作数在主存中、指令地址码给出主存地址的寻址方式是？', 'C', '直接寻址中，地址码字段直接给出操作数所在主存地址。', '立即寻址', '寄存器寻址', '直接寻址', '隐含寻址'),
(15, '00000000-0000-0000-0000-000000031015', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '寄存器寻址相比主存寻址的主要优点是什么？', 'D', '寄存器在 CPU 内部，访问速度快，指令地址字段也可较短。', '需要更多访存', '必须访问磁盘', '只能用于转移指令', '访问速度快'),
(16, '00000000-0000-0000-0000-000000031016', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '基址寻址中，有效地址通常如何形成？', 'A', '基址寻址的有效地址通常为基址寄存器内容加位移量。', '基址寄存器内容加位移量', 'PC 取反', '操作数本身', 'Cache 标记加脏位'),
(17, '00000000-0000-0000-0000-000000031017', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '变址寻址常用于哪类程序结构？', 'B', '变址寻址常用于数组、循环等按下标访问的数据结构。', '固定中断入口', '数组元素访问', '硬件刷新', '微指令译码'),
(18, '00000000-0000-0000-0000-000000031018', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '相对寻址的一个重要优点是什么？', 'C', '相对寻址以 PC 为基准，便于实现位置无关代码和程序浮动。', '取消指令地址', '只能访问寄存器', '便于程序浮动', '必须访问外设'),
(19, '00000000-0000-0000-0000-000000031019', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', 'RISC 指令系统通常强调什么特点？', 'A', 'RISC 通常强调指令简单、格式规整、便于流水线实现。', '简单规整、便于流水线', '指令越复杂越好', '大量隐含访存', '所有指令长度可任意变化'),
(20, '00000000-0000-0000-0000-000000031020', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', 'CISC 指令系统的典型特点是？', 'D', 'CISC 通常指令种类多、功能复杂，可能支持复杂寻址方式。', '只允许一条指令', '没有寻址方式', '只能定长编码', '指令功能较复杂'),
(21, '00000000-0000-0000-0000-000000031021', 'CO_CPU', 'CO_CPU_PIPELINE', 'BASIC', 'ALU 的主要功能是执行什么操作？', 'B', 'ALU 负责算术运算和逻辑运算。', '文件目录管理', '算术和逻辑运算', '网络路由选择', '磁盘寻道'),
(22, '00000000-0000-0000-0000-000000031022', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '控制器的核心作用是什么？', 'A', '控制器取指、译码并产生控制信号，协调各部件完成指令执行。', '产生控制信号协调执行', '长期保存用户文件', '替代主存', '只负责显示输出'),
(23, '00000000-0000-0000-0000-000000031023', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '指令周期通常指什么时间间隔？', 'C', '指令周期是从取出并开始执行一条指令到下一条指令开始的全过程时间。', '一个时钟脉冲', '一次 Cache 替换', '完成一条指令所需时间', '一次磁盘格式化时间'),
(24, '00000000-0000-0000-0000-000000031024', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', 'CPU 周期通常与什么操作密切相关？', 'D', 'CPU 周期常以完成一次基本总线或寄存器传送/访存步骤为单位，比指令周期更细。', '完整程序运行', '操作系统启动', '所有指令执行完', '一次基本微操作或访存步骤'),
(25, '00000000-0000-0000-0000-000000031025', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '微命令的含义通常是什么？', 'A', '微命令是控制部件向执行部件发出的基本控制信号。', '控制信号', '高级语言语句', '页表项', 'Cache 数据块'),
(26, '00000000-0000-0000-0000-000000031026', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '一条微指令通常由什么组成？', 'B', '微指令一般包含操作控制字段和顺序控制字段。', '源程序和目标程序', '操作控制字段和顺序控制字段', '文件名和目录项', 'IP 地址和端口号'),
(27, '00000000-0000-0000-0000-000000031027', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '水平型微指令相比垂直型微指令的特点通常是？', 'C', '水平型微指令可同时给出多个微命令，并行性强但字长较长。', '字长一定最短', '只能定义一个微操作', '并行性强但字长较长', '不能产生控制信号'),
(28, '00000000-0000-0000-0000-000000031028', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '流水线数据相关中的 RAW 相关指的是什么？', 'D', 'RAW 是写后读相关，后续指令需要读取前一指令尚未写回的结果。', '读后写', '写后写', '读后读', '写后读'),
(29, '00000000-0000-0000-0000-000000031029', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '数据旁路技术主要用于缓解哪类流水线冲突？', 'A', '旁路把前面阶段产生的结果直接送给后续指令，减少数据相关导致的停顿。', '数据相关', '结构相关中的存储容量不足', '缺页异常', '外设中断'),
(30, '00000000-0000-0000-0000-000000031030', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '分支预测主要用于缓解哪类流水线问题？', 'B', '分支预测提前猜测转移方向和目标，以降低控制相关造成的流水线损失。', '算术溢出', '控制相关', 'Cache 容量', 'DRAM 刷新'),
(31, '00000000-0000-0000-0000-000000031031', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'BASIC', 'I/O 接口的主要作用是什么？', 'C', 'I/O 接口用于连接主机和外设，完成数据、状态和控制信息交换。', '替代 CPU', '保存页表', '连接主机与外设', '执行浮点乘法'),
(32, '00000000-0000-0000-0000-000000031032', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', 'I/O 端口统一编址方式的特点是什么？', 'A', '统一编址把 I/O 端口和主存单元放在同一地址空间中。', 'I/O 端口与主存共享地址空间', '必须使用专用 I/O 指令', 'I/O 端口无地址', '只能用于 DMA'),
(33, '00000000-0000-0000-0000-000000031033', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', 'I/O 端口独立编址方式通常需要什么？', 'B', '独立编址下 I/O 端口有独立地址空间，通常需要专门的 I/O 指令访问。', '取消外设地址', '专门 I/O 指令', '页表项', 'Cache 组号'),
(34, '00000000-0000-0000-0000-000000031034', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '中断屏蔽字的主要作用是什么？', 'D', '中断屏蔽字用于允许或禁止某些中断请求，实现中断控制。', '扩大主存容量', '改变浮点阶码', '选择 Cache 替换块', '控制中断允许与屏蔽'),
(35, '00000000-0000-0000-0000-000000031035', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '多重中断中，中断优先级主要用于决定什么？', 'A', '优先级用于决定多个中断请求同时到来或嵌套时的响应顺序。', '中断响应顺序', 'Cache 块大小', '指令字长', '浮点尾数位数'),
(36, '00000000-0000-0000-0000-000000031036', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', 'DMA 控制器中的当前地址寄存器通常保存什么？', 'C', 'DMA 当前地址寄存器保存下一次传送要访问的主存地址。', '中断入口地址', '设备类型号', '当前主存传送地址', '指令操作码'),
(37, '00000000-0000-0000-0000-000000031037', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', 'DMA 周期窃取方式的含义是什么？', 'B', 'DMA 在需要传送时占用一个或若干总线周期，使 CPU 暂停访存。', '完全停止 CPU 程序', '占用部分总线周期完成传送', '删除 CPU 寄存器', '只在关机时传送'),
(38, '00000000-0000-0000-0000-000000031038', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', '磁盘访问时间通常不包括下列哪一项？', 'D', '磁盘访问时间通常包括寻道时间、旋转等待时间和传输时间，不包括编译时间。', '寻道时间', '旋转等待时间', '数据传输时间', '高级语言编译时间'),
(39, '00000000-0000-0000-0000-000000031039', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '磁盘平均旋转等待时间通常等于什么？', 'A', '平均旋转等待时间约为磁盘旋转一周时间的一半。', '旋转周期的一半', '完整寻道时间', '传输时间平方', 'Cache 命中时间'),
(40, '00000000-0000-0000-0000-000000031040', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', '总线仲裁的主要目的是什么？', 'C', '总线仲裁用于在多个主设备请求总线时决定谁获得总线使用权。', '改变机器数符号', '刷新 DRAM 行', '决定总线使用权', '计算浮点阶码');

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
    '基于 /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf 的第三批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_batch3_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000131', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_batch3_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000131', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_batch3_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000131', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_batch3_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000131', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_batch3_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_batch3_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000031701', 'CO-2027-003')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_batch3_import q
JOIN question_tags tag ON tag.name IN ('2027计算机组成原理', 'CO-2027-003', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE co_2027_batch3_import;
