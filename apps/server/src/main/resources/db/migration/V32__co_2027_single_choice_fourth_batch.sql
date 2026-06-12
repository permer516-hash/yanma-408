-- Fourth computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Batch: CO-2027-004

CREATE TABLE co_2027_batch4_import (
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

INSERT INTO co_2027_batch4_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000032001', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', '机器字长通常指 CPU 一次能直接处理的二进制数据位数，它通常与什么宽度相关？', 'A', '机器字长通常与通用寄存器和 ALU 的宽度密切相关。', '通用寄存器和 ALU 宽度', '显示器宽度', '磁盘扇区数', '文件名长度'),
(2, '00000000-0000-0000-0000-000000032002', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', '补码减法 x-y 在硬件中通常如何实现？', 'C', '补码减法通常转化为 x 加上 y 的补码相反数，即加法器完成。', '必须使用专用减法阵列', '把 x 和 y 都清零', '转化为加法运算', '通过 Cache 替换实现'),
(3, '00000000-0000-0000-0000-000000032003', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '浮点数加减运算中，规格化通常发生在什么之后？', 'B', '浮点加减通常先对阶、尾数运算，再对结果规格化并舍入。', '取指之前', '尾数加减之后', 'Cache 替换之前', '总线仲裁之前'),
(4, '00000000-0000-0000-0000-000000032004', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', '原码一位乘法中，乘积符号通常如何确定？', 'D', '原码乘法的符号位由两个操作数符号位异或得到，数值位再相乘。', '固定为正', '固定为负', '由尾数最低位决定', '由两个符号位异或决定'),
(5, '00000000-0000-0000-0000-000000032005', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', '存储系统中，速度最快但容量通常最小的是哪一层？', 'C', '寄存器位于 CPU 内部，速度最快，容量很小。', '磁盘', '主存', '寄存器', '光盘'),
(6, '00000000-0000-0000-0000-000000032006', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', 'Cache 写回法相比写直达法的主要优点通常是？', 'A', '写回法只在替换脏块时写主存，可减少主存写次数。', '减少主存写次数', '主存总是立即最新', '不需要有效位', '禁止写 Cache'),
(7, '00000000-0000-0000-0000-000000032007', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', 'Cache 写回法的主要风险或代价是什么？', 'D', '写回法中主存可能暂时不是最新内容，因此需要脏位和一致性维护。', '无法读取 Cache', '不能使用标记位', '块内地址消失', '主存内容可能暂时滞后'),
(8, '00000000-0000-0000-0000-000000032008', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '全相联 Cache 的主要优点是什么？', 'B', '全相联允许主存块放入任意 Cache 行，冲突缺失较少。', '硬件最简单', '冲突缺失较少', '无需比较标记', '只能有一行'),
(9, '00000000-0000-0000-0000-000000032009', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '全相联 Cache 的主要缺点通常是？', 'A', '全相联需要对多个标记并行比较，硬件复杂度和成本高。', '标记比较硬件复杂', '不能减少冲突', '只能用于磁盘', '必须按字寻址'),
(10, '00000000-0000-0000-0000-000000032010', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MEDIUM', '页式虚拟存储中，页表基址寄存器通常保存什么？', 'C', '页表基址寄存器保存当前进程页表在主存中的起始地址。', 'Cache 数据块', '外设端口号', '页表起始地址', '磁盘旋转速度'),
(11, '00000000-0000-0000-0000-000000032011', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', 'TLB 命中但 Cache 未命中时，通常下一步需要访问哪里？', 'B', 'TLB 命中说明地址转换完成，Cache 未命中时需要到主存取相应块。', '重新编译程序', '主存', '键盘控制器', '中断向量表'),
(12, '00000000-0000-0000-0000-000000032012', 'CO_CACHE', 'CO_CACHE_MAPPING', 'HARD', '访问一个虚拟地址时，若 TLB 未命中但页表项有效，通常表示什么？', 'D', 'TLB 未命中但页表有效说明页面在主存，只需查页表并回填 TLB。', '一定缺页', '程序必须终止', '主存损坏', '页面在主存但 TLB 无该项'),
(13, '00000000-0000-0000-0000-000000032013', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'BASIC', '指令格式设计中，地址码个数直接影响什么？', 'A', '地址码个数影响每条指令可显式指出的操作数个数。', '显式操作数个数', '显示颜色', '磁盘转速', '电源功率'),
(14, '00000000-0000-0000-0000-000000032014', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '三地址指令相比二地址指令的一个优点是什么？', 'C', '三地址指令可分别给出两个源操作数和一个结果地址，较少破坏源操作数。', '一定最短', '不能用于加法', '可显式给出结果地址', '无需操作码'),
(15, '00000000-0000-0000-0000-000000032015', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '二地址指令执行 A = A op B 时，一个地址通常兼作什么？', 'B', '二地址指令中一个操作数地址常兼作结果地址。', '中断入口', '源操作数和结果地址', '页表基址', 'Cache 脏位'),
(16, '00000000-0000-0000-0000-000000032016', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'MEDIUM', '采用定长操作码的直接结果是什么？', 'D', '定长操作码使所有指令的操作码字段位数相同，译码简单但指令种类受位数限制。', '所有指令无地址码', '操作码长度可任意变化', '不需要译码器', '操作码字段位数相同'),
(17, '00000000-0000-0000-0000-000000032017', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '扩展操作码中，短地址格式通常可以提供什么？', 'A', '地址码少的格式可把更多位分配给操作码，从而表示更多操作。', '更多操作码位', '更多显式地址', '更少指令种类', '无操作码指令'),
(18, '00000000-0000-0000-0000-000000032018', 'CO_INSTRUCTION', 'CO_INSTRUCTION_ADDRESSING', 'HARD', '堆栈型指令系统常使用零地址指令的原因是？', 'C', '操作数默认在栈顶，因而不需要显式地址码指出操作数。', '没有操作数', '只能访问主存', '操作数隐含在栈顶', '必须使用 DMA'),
(19, '00000000-0000-0000-0000-000000032019', 'CO_CPU', 'CO_CPU_PIPELINE', 'BASIC', '数据通路主要由寄存器、ALU、总线等组成，其作用是什么？', 'B', '数据通路负责在控制信号作用下完成数据传送和运算。', '管理文件目录', '完成数据传送和运算', '决定网络路由', '显示图像'),
(20, '00000000-0000-0000-0000-000000032020', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '单总线数据通路的主要限制是什么？', 'A', '单总线同一时刻通常只能完成一次数据传送，容易成为瓶颈。', '同一时刻传送能力有限', '不能连接寄存器', '不需要控制信号', '无法执行加法'),
(21, '00000000-0000-0000-0000-000000032021', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '多总线数据通路相比单总线的主要优点是什么？', 'D', '多总线允许更多并行传送，减少数据通路瓶颈。', '硬件一定更少', '控制一定最简单', '不能并行', '支持更多并行传送'),
(22, '00000000-0000-0000-0000-000000032022', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '取指阶段中，MAR 通常接收哪个寄存器的内容？', 'C', '取指时 PC 给出指令地址，该地址送入 MAR 访问主存。', 'IR', 'MDR', 'PC', 'ACC'),
(23, '00000000-0000-0000-0000-000000032023', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '取指完成后，主存读出的指令通常送入哪个寄存器？', 'B', '主存读出的指令先进入 MDR，再装入 IR 供译码。', 'PC', 'IR', 'MAR', 'PSW'),
(24, '00000000-0000-0000-0000-000000032024', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '条件转移指令是否转移通常取决于什么？', 'A', '条件转移依据状态标志位或条件码判断是否改变 PC。', '状态标志位', '磁盘容量', 'Cache 行数', '外设端口号'),
(25, '00000000-0000-0000-0000-000000032025', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '硬布线控制器产生控制信号的主要依据通常不包括下列哪项？', 'D', '硬布线控制通常依据指令操作码、时序信号和状态条件，不依据用户文件名。', '指令操作码', '时序信号', '状态条件', '用户文件名'),
(26, '00000000-0000-0000-0000-000000032026', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '微程序控制中，一条机器指令通常对应什么？', 'B', '一条机器指令通常由一段微程序解释执行。', '一个文件目录', '一段微程序', '一个磁盘扇区', '一条高级语言语句'),
(27, '00000000-0000-0000-0000-000000032027', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '微程序入口地址通常由什么产生？', 'C', '控制器根据机器指令操作码等信息形成对应微程序入口地址。', '页内偏移', '磁盘柱面号', '指令操作码译码', '显示器刷新率'),
(28, '00000000-0000-0000-0000-000000032028', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '流水线吞吐率的含义是什么？', 'A', '吞吐率表示单位时间内流水线完成的任务或指令数量。', '单位时间完成指令数', '单条指令最长延迟', 'Cache 容量', '主存地址位数'),
(29, '00000000-0000-0000-0000-000000032029', 'CO_CPU', 'CO_CPU_PIPELINE', 'MEDIUM', '流水线加速比通常定义为？', 'D', '加速比是非流水执行时间与流水执行时间之比。', '流水段数减 1', '主存容量除以 Cache 容量', 'Cache 命中率', '非流水时间与流水时间之比'),
(30, '00000000-0000-0000-0000-000000032030', 'CO_CPU', 'CO_CPU_PIPELINE', 'HARD', '流水线效率反映什么？', 'C', '流水线效率反映各流水段设备的利用程度。', '磁盘碎片率', '页表大小', '流水段利用率', '指令操作码长度'),
(31, '00000000-0000-0000-0000-000000032031', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'BASIC', '总线按传输信息类型可分为数据总线、地址总线和什么？', 'B', '系统总线通常包括数据总线、地址总线和控制总线。', '磁盘总线', '控制总线', '浮点总线', '文件总线'),
(32, '00000000-0000-0000-0000-000000032032', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', '地址总线宽度主要决定什么？', 'A', '地址总线宽度决定 CPU 可直接寻址的地址空间大小。', '可寻址空间大小', 'ALU 加法速度', '中断数量恒定值', '浮点尾数精度'),
(33, '00000000-0000-0000-0000-000000032033', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', '数据总线宽度主要影响什么？', 'C', '数据总线宽度影响一次总线传输可并行传送的数据位数。', '地址空间上限', '页表级数', '一次传输数据位数', '磁盘柱面数'),
(34, '00000000-0000-0000-0000-000000032034', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '同步总线通信的主要依据是什么？', 'D', '同步总线各部件按统一时钟节拍完成通信。', '外设随机请求', '磁盘扇区号', '高级语言语法', '统一时钟'),
(35, '00000000-0000-0000-0000-000000032035', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '异步总线通信通常依赖什么机制协调双方？', 'A', '异步通信常用握手信号协调发送方和接收方。', '握手信号', '统一固定时钟', 'Cache 标记', '浮点阶码'),
(36, '00000000-0000-0000-0000-000000032036', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', '集中式总线仲裁的特点是什么？', 'B', '集中式仲裁由一个中央仲裁器决定总线使用权。', '所有设备独立决定', '由中央仲裁器裁决', '不需要请求信号', '只能用于主存刷新'),
(37, '00000000-0000-0000-0000-000000032037', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '链式查询总线仲裁方式的一个缺点是什么？', 'C', '链式查询中靠近仲裁器的设备优先级高，后面的设备可能响应慢或饥饿。', '硬件完全不能实现', '优先级完全公平', '后级设备可能响应慢', '不需要仲裁线'),
(38, '00000000-0000-0000-0000-000000032038', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'MEDIUM', '中断响应的前提通常不包括下列哪项？', 'D', '中断响应通常要求有中断请求、中断未屏蔽且当前允许中断，不要求 Cache 全部无效。', '有中断请求', '中断未屏蔽', 'CPU 允许中断', 'Cache 全部无效'),
(39, '00000000-0000-0000-0000-000000032039', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', 'DMA 方式中，传送方向、主存地址和传送长度通常由谁在传送前设置？', 'A', 'DMA 开始前，CPU 需初始化 DMA 控制器的相关寄存器。', 'CPU 初始化 DMA 控制器', '显示器自动设置', '磁盘随机决定', '编译器在运行后修改'),
(40, '00000000-0000-0000-0000-000000032040', 'CO_IO', 'CO_IO_INTERRUPT_DMA', 'HARD', '通道程序主要由谁执行？', 'B', '通道具有独立控制能力，可执行通道程序管理 I/O 操作。', '普通用户进程', '通道控制器', '显示器', 'Cache 替换器');

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
    '基于 /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf 的第四批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_batch4_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000132', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_batch4_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000132', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_batch4_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000132', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_batch4_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000132', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_batch4_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_batch4_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000032701', 'CO-2027-004')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_batch4_import q
JOIN question_tags tag ON tag.name IN ('2027计算机组成原理', 'CO-2027-004', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE co_2027_batch4_import;
