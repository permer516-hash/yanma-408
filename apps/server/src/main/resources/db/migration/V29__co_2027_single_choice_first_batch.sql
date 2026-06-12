-- First computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Batch: CO-2027-001

INSERT INTO chapters (id, subject_id, code, name, sort_order)
SELECT CAST(seed.id AS UUID), s.id, seed.code, seed.name, seed.sort_order
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000029201', 'CO_OVERVIEW', '计算机系统概述', 13)
) AS seed(id, code, name, sort_order)
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
WHERE NOT EXISTS (SELECT 1 FROM chapters c WHERE c.code = seed.code);

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT CAST(seed.id AS UUID), c.id, seed.code, seed.name, seed.sort_order
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000029301', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', '计算机系统层次与工作方式', 1)
) AS seed(id, chapter_code, code, name, sort_order)
JOIN chapters c ON c.code = seed.chapter_code
WHERE NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = seed.code);

CREATE TABLE co_2027_batch1_import (
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

INSERT INTO co_2027_batch1_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000029001', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', '完整的计算机系统通常由哪两大部分组成？', 'D', '计算机系统包括硬件系统和软件系统，二者配合才能完成任务。', '运算器和控制器', '主机和显示器', 'CPU 和主存', '硬件系统和软件系统'),
(2, '00000000-0000-0000-0000-000000029002', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', '冯·诺依曼计算机的基本工作方式通常称为什么？', 'A', '冯·诺依曼机采用存储程序、按地址访问并自动顺序执行指令的控制流驱动方式。', '控制流驱动方式', '数据流驱动方式', '人工逐条输入方式', '多程序并发解释方式'),
(3, '00000000-0000-0000-0000-000000029003', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', '冯·诺依曼机中，程序执行前指令和数据通常应放在哪里？', 'B', '存储程序思想要求程序和数据预先存入主存，CPU 再逐条取指执行。', '外设控制器', '主存储器', '显示缓冲区', '网络接口'),
(4, '00000000-0000-0000-0000-000000029004', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'HARD', '指令集体系结构 ISA 主要定义的是哪一层可见的计算机行为？', 'C', 'ISA 是软硬件接口，定义软件可见的指令、寄存器、寻址方式等行为，而非具体硬件实现。', '电源散热层', '磁盘机械结构', '软件可见的硬件功能接口', '显示器像素排列'),
(5, '00000000-0000-0000-0000-000000029005', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', '同一 ISA 可以由不同微体系结构实现，这通常意味着什么？', 'B', 'ISA 相同的软件可见行为一致，底层流水线、缓存等微结构可不同而保持二进制兼容。', '软件必须全部重写', '软件通常可兼容运行', '指令格式必然不同', '无法使用操作系统'),
(6, '00000000-0000-0000-0000-000000029006', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', '把汇编语言源程序翻译成机器语言目标程序的软件称为什么？', 'A', '汇编程序负责把汇编语言翻译成机器语言。', '汇编程序', '解释程序', '链接程序', '装入程序'),
(7, '00000000-0000-0000-0000-000000029007', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'C 语言源程序生成可执行文件的典型过程是？', 'D', '典型流程是预处理、编译、汇编、链接，最终得到可执行目标文件。', '编译、预处理、链接、汇编', '汇编、编译、预处理、链接', '链接、预处理、编译、汇编', '预处理、编译、汇编、链接'),
(8, '00000000-0000-0000-0000-000000029008', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'n 位补码有符号整数的表示范围通常是？', 'C', 'n 位补码范围为 -2^(n-1) 到 2^(n-1)-1。', '0 到 2^n-1', '-2^n 到 2^n-1', '-2^(n-1) 到 2^(n-1)-1', '-2^(n-1)+1 到 2^(n-1)-1'),
(9, '00000000-0000-0000-0000-000000029009', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '8 位补码 11111111 表示的十进制数是？', 'A', '补码全 1 表示 -1。', '-1', '1', '127', '-128'),
(10, '00000000-0000-0000-0000-000000029010', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '补码加法中，两个正数相加却得到负数，通常说明发生了什么？', 'B', '同号数相加结果变号是补码溢出的典型判据。', '借位', '正溢出', '规格化', '主存缺页'),
(11, '00000000-0000-0000-0000-000000029011', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '采用双符号位判断补码溢出时，结果符号位为 01 通常表示什么？', 'A', '双符号位不同表示溢出，其中 01 表示正溢出，10 表示负溢出。', '正溢出', '负溢出', '未溢出且为负数', '机器零'),
(12, '00000000-0000-0000-0000-000000029012', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '负数补码进行算术右移时，高位通常补什么？', 'D', '算术右移需要保持符号，负数最高位为 1，因此高位补 1。', '0', '最低位', '随机位', '1'),
(13, '00000000-0000-0000-0000-000000029013', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '浮点数规格化的主要目的是什么？', 'C', '规格化通过约束尾数形式，减少同一数的多种表示并提高有效精度。', '取消阶码', '扩大磁盘容量', '提高有效位利用率', '避免使用符号位'),
(14, '00000000-0000-0000-0000-000000029014', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '浮点数阶码上溢通常表示什么？', 'B', '阶码超过可表示范围通常说明结果绝对值过大，当前格式无法表示。', '结果太接近 0', '结果绝对值过大', '尾数刚好为 0', 'Cache 未命中'),
(15, '00000000-0000-0000-0000-000000029015', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', '存储器层次结构主要基于程序的什么性质？', 'A', '程序局部性使近期访问过或邻近的数据和指令很可能再次被访问，是层次存储有效的基础。', '局部性原理', '完全随机性', '不可中断性', '互斥性'),
(16, '00000000-0000-0000-0000-000000029016', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'Cache 与主存之间数据交换的基本单位通常是什么？', 'D', 'Cache 调入和替换主存内容时通常以块为单位。', '位', '字母', '文件', '块'),
(17, '00000000-0000-0000-0000-000000029017', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '直接映射 Cache 中，一个主存块可以映射到多少个 Cache 行？', 'A', '直接映射规定每个主存块只能映射到唯一的 Cache 行。', '1 个', '任意多个', '全部行', '至少 2 个'),
(18, '00000000-0000-0000-0000-000000029018', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '组相联 Cache 的替换算法通常在哪个范围内选择被替换块？', 'C', '组相联映射中主存块只能进入对应组，替换也只在该组内进行。', '整个主存', '全部 Cache 行', '对应组内', 'CPU 寄存器内'),
(19, '00000000-0000-0000-0000-000000029019', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'DRAM 需要定期刷新的根本原因是什么？', 'B', 'DRAM 用电容保存信息，电荷会泄漏，因此需要周期性刷新。', '指令必须重新译码', '存储电荷会泄漏', 'Cache 块太小', '总线位宽不足'),
(20, '00000000-0000-0000-0000-000000029020', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '低位交叉编址多模块存储器提升连续访问速度的关键原因是？', 'A', '连续地址分布到不同存储体，可让多个存储体流水式交叉工作。', '连续地址分散到不同存储体', '所有地址都进入同一存储体', '取消主存访问', '把 DRAM 改为 ROM'),
(21, '00000000-0000-0000-0000-000000029021', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'TLB 的主要作用是什么？', 'D', 'TLB 缓存近期页表项，命中时可减少页表访问，加快地址转换。', '执行算术加法', '保存所有磁盘块', '替代 Cache 数据区', '加快虚实地址转换'),
(22, '00000000-0000-0000-0000-000000029022', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', 'Cache 缺失处理与缺页处理相比，通常哪个时间开销更大？', 'B', '缺页需要访问磁盘等外存，时间开销远大于 Cache 缺失调主存块。', 'Cache 缺失一定更大', '缺页处理通常更大', '二者完全相同', '都不需要访存'),
(23, '00000000-0000-0000-0000-000000029023', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'BASIC', '指令中的操作码字段主要指出什么？', 'A', '操作码用于指出指令要完成的操作类型。', '操作类型', '主存容量', 'Cache 行号', '中断屏蔽字'),
(24, '00000000-0000-0000-0000-000000029024', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '立即寻址方式中，地址码字段给出的通常是什么？', 'B', '立即寻址把操作数本身直接放在指令中。', '操作数地址', '操作数本身', '下一条指令地址', '页表基址'),
(25, '00000000-0000-0000-0000-000000029025', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '寄存器间接寻址中，寄存器内容表示什么？', 'C', '寄存器间接寻址时，寄存器中保存操作数所在主存单元的地址。', '操作数本身', '操作码', '操作数所在主存地址', 'Cache 组号'),
(26, '00000000-0000-0000-0000-000000029026', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '相对寻址方式形成目标地址时，通常以哪个寄存器内容为基准？', 'D', '相对寻址通常以 PC 内容加偏移量形成目标地址。', 'MAR', 'MDR', 'IR', 'PC'),
(27, '00000000-0000-0000-0000-000000029027', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '按字节编址且采用小端方式时，多字节数据的最低有效字节存放在哪里？', 'A', '小端方式把最低有效字节放在最低地址。', '最低地址', '最高地址', 'Cache 标记位', '指令操作码字段'),
(28, '00000000-0000-0000-0000-000000029028', 'CO_CPU', 'CO_CPU_PIPELINE', 'BASIC', 'CPU 执行指令的基本循环通常可概括为哪三个阶段？', 'C', '抽象来看，指令执行过程通常包括取指、译码和执行。', '输入、打印、关机', '刷新、擦除、写回', '取指、译码、执行', '分配、回收、压缩'),
(29, '00000000-0000-0000-0000-000000029029', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '程序计数器 PC 通常保存什么信息？', 'B', 'PC 保存下一条待取指令的地址，顺序执行时按指令长度更新。', '当前 ALU 结果', '下一条指令地址', '磁盘块号', 'Cache 替换位'),
(30, '00000000-0000-0000-0000-000000029030', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '指令流水线的时钟周期通常由什么决定？', 'A', '流水线节拍通常受最慢流水段延迟限制。', '最慢流水段延迟', '最快流水段延迟', '指令条数平方', '磁盘容量'),
(31, '00000000-0000-0000-0000-000000029031', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '流水线结构相关通常由什么引起？', 'D', '结构相关是多条指令同一时刻争用同一硬件资源造成的冲突。', '分支预测正确', '数据已经旁路', '程序没有循环', '硬件资源冲突'),
(32, '00000000-0000-0000-0000-000000029032', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '流水线数据相关常用的缓解方法不包括下列哪一项？', 'C', '旁路、暂停和指令调度可处理数据相关，扩大显示器分辨率与数据相关无关。', '数据旁路', '插入暂停周期', '扩大显示器分辨率', '编译器调整指令顺序'),
(33, '00000000-0000-0000-0000-000000029033', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '微程序控制器中的控制存储器主要存放什么？', 'B', '控制存储器存放微指令序列，用于产生控制信号。', '用户源代码', '微指令', '页表项', '外设数据块'),
(34, '00000000-0000-0000-0000-000000029034', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '硬布线控制器相比微程序控制器的典型优点是什么？', 'A', '硬布线控制直接由组合逻辑产生控制信号，速度通常较快，但灵活性较差。', '速度较快', '一定更容易修改', '不需要时钟', '只能执行高级语言'),
(35, '00000000-0000-0000-0000-000000029035', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'BASIC', '程序查询方式 I/O 的主要缺点是什么？', 'C', '程序查询方式需要 CPU 反复查询设备状态，容易造成 CPU 等待。', '不需要 CPU', '传输速度必为 0', 'CPU 需要反复轮询设备状态', '不能连接外设'),
(36, '00000000-0000-0000-0000-000000029036', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', '中断方式 I/O 相比程序查询方式的主要优点是？', 'B', '中断方式使 CPU 不必持续轮询设备，可在设备就绪时再响应。', '取消所有外设', '减少 CPU 无效等待', '不需要中断向量', '只能传输一个字节'),
(37, '00000000-0000-0000-0000-000000029037', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', 'CPU 响应中断时，为了返回原程序继续执行，通常首先需要保存什么？', 'A', '保存断点和现场是中断处理后恢复原程序执行的基础。', '断点和必要现场', '所有磁盘文件', '显示器分辨率', '网络域名'),
(38, '00000000-0000-0000-0000-000000029038', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', 'DMA 方式传送数据块时，数据传送过程主要由谁控制？', 'D', 'DMA 控制器接管总线完成主存与外设之间的数据块传送。', '应用程序员', '编译器', '显示控制器', 'DMA 控制器'),
(39, '00000000-0000-0000-0000-000000029039', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', 'DMA 传送完成后，通常通过什么方式通知 CPU？', 'C', 'DMA 传送结束后通常由 DMA 控制器向 CPU 发出中断请求。', '删除源程序', '修改 Cache 标记', '中断', '重新编译程序'),
(40, '00000000-0000-0000-0000-000000029040', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '通道方式 I/O 相比 DMA 的一个典型特点是？', 'B', '通道具有更强的 I/O 控制能力，可执行通道程序并管理多个设备的数据传送。', '只能传送一个字节', '可执行通道程序管理 I/O', '完全不需要主存', '只能用于 Cache 替换');

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
    '基于 /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf 的首批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_batch1_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000129', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_batch1_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000129', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_batch1_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000129', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_batch1_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000129', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_batch1_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_batch1_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000029701', '2027计算机组成原理'),
    ('00000000-0000-0000-0000-000000029702', 'CO-2027-001')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_batch1_import q
JOIN question_tags tag ON tag.name IN ('2027计算机组成原理', 'CO-2027-001', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE co_2027_batch1_import;
