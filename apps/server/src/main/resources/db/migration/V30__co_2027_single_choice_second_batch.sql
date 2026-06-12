-- Second computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Batch: CO-2027-002

CREATE TABLE co_2027_batch2_import (
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

INSERT INTO co_2027_batch2_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000030001', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', '8 位无符号整数的表示范围是？', 'D', '8 位无符号整数可表示 0 到 2^8-1，即 0 到 255。', '-128 到 127', '-127 到 127', '1 到 256', '0 到 255'),
(2, '00000000-0000-0000-0000-000000030002', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '8 位补码 10000000 表示的十进制数是？', 'A', 'n 位补码最小值为 -2^(n-1)，8 位时 10000000 表示 -128。', '-128', '-127', '0', '128'),
(3, '00000000-0000-0000-0000-000000030003', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '十进制 -5 的 8 位补码表示是？', 'C', '+5 为 00000101，取反加 1 得 11111011。', '10000101', '11111010', '11111011', '00000101'),
(4, '00000000-0000-0000-0000-000000030004', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '8 位补码 01111111 加 00000001 后得到 10000000，这表示什么情况？', 'B', '127 加 1 超出 8 位补码最大正数范围，结果符号异常变化，发生正溢出。', '未溢出且结果为 128', '正溢出', '负溢出', '逻辑右移'),
(5, '00000000-0000-0000-0000-000000030005', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '补码加法中，判断溢出的进位判据通常比较哪两个进位？', 'A', '最高有效位进位与符号位进位不同，则发生溢出。', '最高有效位进位和符号位进位', '最低位进位和块内偏移', '阶码进位和尾数最低位', 'Cache 组号和标记位'),
(6, '00000000-0000-0000-0000-000000030006', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '补码算术左移时，低位通常补什么？', 'C', '算术左移与逻辑左移一样，低位补 0，但可能发生溢出。', '符号位', '1', '0', '随机位'),
(7, '00000000-0000-0000-0000-000000030007', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '8 位补码 10010101 算术右移 1 位后的结果是？', 'D', '负数算术右移高位补 1，10010101 右移后为 11001010。', '01001010', '10001010', '11010101', '11001010'),
(8, '00000000-0000-0000-0000-000000030008', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '采用原码表示时，真值 0 通常存在什么特点？', 'B', '原码有 +0 和 -0 两种编码，这是原码的一个特点。', '没有 0 的表示', '存在 +0 和 -0', '只有唯一补码 0', '只能用移码表示'),
(9, '00000000-0000-0000-0000-000000030009', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '移码常用于表示浮点数的哪一部分？', 'A', '浮点数阶码常用移码表示，便于比较阶码大小。', '阶码', '尾数最低位', 'Cache 标记', '指令操作码'),
(10, '00000000-0000-0000-0000-000000030010', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '浮点数尾数采用规格化表示时，通常能带来什么效果？', 'C', '规格化让尾数最高有效位满足约定形式，从而尽量保留有效数字。', '减少主存容量', '取消舍入', '提高有效数字利用率', '避免所有溢出'),
(11, '00000000-0000-0000-0000-000000030011', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '浮点数阶码下溢通常表示结果怎样？', 'D', '阶码下溢通常表示结果绝对值过小，接近 0，难以规格化表示。', '结果绝对值过大', '指令地址越界', 'Cache 块过大', '结果绝对值过小'),
(12, '00000000-0000-0000-0000-000000030012', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'IEEE 754 单精度浮点数中，阶码字段通常占多少位？', 'B', 'IEEE 754 单精度格式为 1 位符号、8 位阶码和 23 位尾数字段。', '1 位', '8 位', '16 位', '23 位'),
(13, '00000000-0000-0000-0000-000000030013', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '浮点加减运算中，对阶操作的主要目的是什么？', 'A', '对阶使两个操作数阶码一致，便于尾数相加减。', '使阶码相同', '删除符号位', '扩大 Cache 容量', '改变寻址方式'),
(14, '00000000-0000-0000-0000-000000030014', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '浮点加减运算中，若需要对阶，通常移动哪一个操作数的尾数？', 'C', '通常将阶码较小的数的尾数右移，使其阶码增大到与另一个数相同。', '阶码较大的数左移', '两个尾数都左移', '阶码较小的数右移', '符号位取反'),
(15, '00000000-0000-0000-0000-000000030015', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'Cache 命中率提高且其他条件不变时，平均访存时间通常如何变化？', 'A', '命中率提高意味着更多访问以较短命中时间完成，平均访存时间降低。', '降低', '升高', '恒为 0', '变为磁盘访问时间'),
(16, '00000000-0000-0000-0000-000000030016', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '主存块大小为 64B 时，块内地址字段需要多少位？', 'B', '64B = 2^6B，因此块内偏移需要 6 位。', '4 位', '6 位', '8 位', '64 位'),
(17, '00000000-0000-0000-0000-000000030017', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '一个 Cache 有 64 行，采用 4 路组相联，则共有多少组？', 'C', '组数 = Cache 行数 / 路数 = 64 / 4 = 16。', '4 组', '8 组', '16 组', '64 组'),
(18, '00000000-0000-0000-0000-000000030018', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '32 位物理地址、块大小 64B、Cache 共 16 组时，组号字段需要多少位？', 'A', '16 组需要 log2(16)=4 位组号字段。', '4 位', '6 位', '16 位', '22 位'),
(19, '00000000-0000-0000-0000-000000030019', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '32 位物理地址、块大小 64B、Cache 共 16 组时，标记字段位数为多少？', 'D', '块内偏移 6 位，组号 4 位，标记位数为 32-6-4=22。', '6 位', '10 位', '16 位', '22 位'),
(20, '00000000-0000-0000-0000-000000030020', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'Cache 写策略中，写直达法的特点是什么？', 'B', '写直达在更新 Cache 的同时更新主存，主存内容较新但写流量较大。', '只写 Cache 不写主存', '同时写 Cache 和主存', '只写磁盘', '必须禁止读操作'),
(21, '00000000-0000-0000-0000-000000030021', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', 'Cache 回写法通常需要在每行中增加哪类状态位？', 'C', '回写法需要记录 Cache 行是否被修改，常设置脏位。', '奇偶校验位', '符号位', '脏位', '页号位'),
(22, '00000000-0000-0000-0000-000000030022', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'Cache 行中的有效位主要用于表示什么？', 'A', '有效位表示该 Cache 行中内容是否有效，可用于判断命中。', '该行内容是否有效', '该行是否为浮点数', '该行是否为中断向量', '该行是否为立即数'),
(23, '00000000-0000-0000-0000-000000030023', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', 'TLB 采用全相联映射时，查找通常依赖什么硬件实现并行比较？', 'D', '全相联查找常依赖相联存储器或 CAM 进行并行比较。', '串行磁带', '机械硬盘', '只读光盘', '相联存储器'),
(24, '00000000-0000-0000-0000-000000030024', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '页大小为 4KB 时，页内偏移字段需要多少位？', 'C', '4KB = 4096B = 2^12B，因此页内偏移为 12 位。', '4 位', '8 位', '12 位', '32 位'),
(25, '00000000-0000-0000-0000-000000030025', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '虚拟地址和物理地址在分页地址转换中通常哪一部分保持不变？', 'B', '分页只转换页号，页内偏移在虚拟地址和物理地址中保持不变。', '虚拟页号', '页内偏移', '物理页框号', 'TLB 标记全部'),
(26, '00000000-0000-0000-0000-000000030026', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'SRAM 相比 DRAM 的典型特点是？', 'A', 'SRAM 不需要周期刷新，速度快但成本高、容量密度低。', '速度快但成本高', '必须按行刷新', '只能作为磁盘', '断电后保持数据'),
(27, '00000000-0000-0000-0000-000000030027', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'DRAM 刷新通常以什么为单位进行？', 'D', 'DRAM 刷新通常按行进行。', '位', '字节', 'Cache 行', '行'),
(28, '00000000-0000-0000-0000-000000030028', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '若单个存储体存取周期为 100ns，总线传输周期为 20ns，低位交叉编址至少需要多少个存储体才能连续供应数据？', 'C', '存储体数至少为存取周期/总线周期 = 100/20 = 5。', '2 个', '4 个', '5 个', '20 个'),
(29, '00000000-0000-0000-0000-000000030029', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '零地址指令通常隐含使用哪种结构保存操作数？', 'A', '零地址指令常见于栈式计算机，操作数隐含在栈顶。', '栈', 'TLB', '磁盘目录', 'Cache 标记阵列'),
(30, '00000000-0000-0000-0000-000000030030', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '一地址指令中，另一个操作数常隐含在哪个寄存器中？', 'B', '许多一地址指令将累加器作为隐含操作数。', 'PC', '累加器 ACC', 'MAR', 'MDR'),
(31, '00000000-0000-0000-0000-000000030031', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '变长指令字结构的主要优点是什么？', 'D', '变长指令可按不同功能分配不同长度，代码紧凑性较好。', '译码一定最简单', '所有指令长度相同', '无需操作码', '有利于提高代码紧凑性'),
(32, '00000000-0000-0000-0000-000000030032', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '扩展操作码技术的主要目的是什么？', 'C', '扩展操作码通过在不同地址数格式间复用字段，扩大可表示指令种类。', '减少主存容量', '取消地址码', '扩大操作码可表示范围', '让所有指令无法译码'),
(33, '00000000-0000-0000-0000-000000030033', 'CO_CPU', 'CO_CPU_PIPELINE', 'BASIC', '指令寄存器 IR 通常保存什么？', 'A', 'IR 保存当前正在译码或执行的指令。', '当前指令', '下一条指令地址', '外设状态', 'Cache 脏位'),
(34, '00000000-0000-0000-0000-000000030034', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '存储器地址寄存器 MAR 通常保存什么？', 'B', 'MAR 保存即将访问的主存单元地址。', '主存读出的数据', '主存地址', '指令操作码', '中断类型号'),
(35, '00000000-0000-0000-0000-000000030035', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '存储器数据寄存器 MDR 通常保存什么？', 'C', 'MDR 保存从主存读出或准备写入主存的数据。', '下一条指令地址', '微指令地址', '主存读写数据', '页内偏移位数'),
(36, '00000000-0000-0000-0000-000000030036', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '流水线控制相关通常由哪类指令引起？', 'D', '控制相关通常由分支、转移等改变指令流的指令引起。', '普通加法指令', '无条件顺序指令', '访存装入指令', '分支转移指令'),
(37, '00000000-0000-0000-0000-000000030037', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '五段流水线执行大量无冲突指令时，理想加速比上限约等于什么？', 'A', '理想情况下 k 段流水线最大加速比接近 k，五段约为 5。', '流水段数 5', '指令条数 n', 'Cache 行数', '主存模块数平方'),
(38, '00000000-0000-0000-0000-000000030038', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'BASIC', '中断向量通常用于指出什么？', 'C', '中断向量通常给出中断服务程序入口地址或其索引信息。', 'Cache 块大小', '浮点阶码', '中断服务程序入口', '主存模块数'),
(39, '00000000-0000-0000-0000-000000030039', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', 'DMA 方式中，CPU 通常在什么时候介入？', 'D', 'DMA 传送中 CPU 主要负责传送前初始化和传送后处理，中间数据块传送由 DMA 控制器完成。', '每传送 1 位都介入', '每传送 1 字节都执行程序查询', '完全不能介入', '传送前初始化和传送后处理'),
(40, '00000000-0000-0000-0000-000000030040', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', 'DMA 与主存交换数据时，可能与 CPU 发生哪类资源竞争？', 'B', 'DMA 控制器访问主存和总线时，可能与 CPU 争用总线或主存周期。', '争用显示颜色', '争用总线或主存周期', '争用高级语言变量名', '争用汇编助记符');

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
    '基于 /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf 的第二批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_batch2_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000130', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_batch2_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000130', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_batch2_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000130', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_batch2_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000130', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_batch2_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_batch2_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000030701', 'CO-2027-002')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_batch2_import q
JOIN question_tags tag ON tag.name IN ('2027计算机组成原理', 'CO-2027-002', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE co_2027_batch2_import;
