-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 6: 6.1 总线概述 (Q1-Q25, pure text only).
-- Text-only batch: all 25 questions are conceptual or calculation-based with no image/table/code dependencies.
-- Batch: CO-2027-ORIGINAL-CH6-A-TEXT-ONLY

-- ============================================================
-- Create CO_BUS chapter (总线, Chapter 6, between CO_CPU and CO_IO)
-- ============================================================
INSERT INTO chapters (id, subject_id, code, name, sort_order)
SELECT CAST('00000000-0000-0000-0000-000000116201' AS UUID), s.id, 'CO_BUS', '总线', 17
FROM subjects s
WHERE s.code = 'COMPUTER_ORGANIZATION'
  AND NOT EXISTS (SELECT 1 FROM chapters c WHERE c.code = 'CO_BUS');

-- Bump CO_IO sort_order from 17 to 18 to make room for CO_BUS
UPDATE chapters SET sort_order = 18
WHERE code = 'CO_IO' AND sort_order = 17;

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000116301',
    c.id,
    'CO_BUS_OVERVIEW',
    '总线概述',
    1
FROM chapters c
WHERE c.code = 'CO_BUS'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_BUS_OVERVIEW');

CREATE TABLE co_2027_original_ch6_a_text_import (
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

INSERT INTO co_2027_original_ch6_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 6.1 总线概述 Q1-Q25
-- Q1-Q15: 模拟题; Q16-Q25: 统考真题 (2009-2025)
-- ============================================================

(1, '00000000-0000-0000-0000-000000116001', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'挂接在总线上的多个部件（ ）。',
'B',
'为了使总线上的数据不发生"冲突"，挂在总线上的多个设备只能分时地向总线发送数据，即每个时刻只能有一个设备向总线传送数据，而从总线接收数据的设备可以有多个，因为接收数据的设备不会对总线产生"干扰"。',
'只能分时向总线发送数据，并只能分时从总线接收数据', '只能分时向总线发送数据，但可同时从总线接收数据', '可同时向总线发送数据，并同时从总线接收数据', '可同时向总线发送数据，但只能分时从总线接收数据'),

(2, '00000000-0000-0000-0000-000000116002', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'在计算机系统中，多个系统部件之间信息传送的公共通路称为总线，就其所传送的信息的性质而言，下列（ ）不是在公共通路上传送的信息。',
'C',
'总线包括数据线、地址线和控制线，传送的信息分别为数据信息、地址信息和控制信息，系统信息不是总线上的信息分类。',
'数据信息', '地址信息', '系统信息', '控制信息'),

(3, '00000000-0000-0000-0000-000000116003', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'系统总线用来连接（ ）。',
'C',
'系统总线用于连接计算机中的各个功能部件（如CPU、主存和I/O设备）。',
'寄存器和运算器部件', '运算器和控制器部件', 'CPU、主存和外设部件', '接口和外部设备'),

(4, '00000000-0000-0000-0000-000000116004', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'计算机使用总线结构便于增减外设，同时（ ）。',
'C',
'计算机使用总线结构便于增减外设，同时减少信息传输线的条数。但相对于专线结构，其实际上也降低了信息传输的并行性及信息的传输速度。',
'减少信息传输量', '提高信息的传输速度', '减少信息传输线的条数', '提高信息传输的并行性'),

(5, '00000000-0000-0000-0000-000000116005', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'间址寻址第一次访问内存所得到的信息经系统总线的（ ）传送到CPU。',
'A',
'间址寻址首次访问内存所得到的信息是操作数的有效地址，该地址作为数据通过数据总线传送至CPU，地址总线是用于CPU选择主存单元地址和I/O端口地址的单向总线，不能回传。',
'数据总线', '地址总线', '控制总线', '总线控制器'),

(6, '00000000-0000-0000-0000-000000116006', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'系统总线中地址线的功能是（ ）。',
'D',
'地址总线上的代码用来指明CPU要访问的存储单元或I/O端口的地址。',
'选择主存单元地址', '选择进行信息传输的设备', '选择外存地址', '指定主存和I/O设备接口电路的地址'),

(7, '00000000-0000-0000-0000-000000116007', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'系统总线中控制线的主要功能是（ ）。',
'C',
'系统总线中控制线的主要功能是提供定时信号、操作命令和各种请求/回答信号等。',
'提供时序信号', '提供主存和I/O模块的回答信号', '提供定时信号、操作命令和各种请求/回答信号等', '提供数据信息'),

(8, '00000000-0000-0000-0000-000000116008', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'不同信号在同一条信号线上分时传输的方式称为（ ）。',
'A',
'串行传输是指数据的传输在一条线路上按位进行；并行传输是指每个数据位有一条单独的传输线，所有数据位同时传输。不同信号在同一条信号线上分时传输的方式，称为总线复用。',
'总线复用方式', '并串行传输方式', '并行传输方式', '串行传输方式'),

(9, '00000000-0000-0000-0000-000000116009', 'CO_BUS', 'CO_BUS_OVERVIEW', 'BASIC', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'主存通过（ ）来识别信息是地址还是数据。',
'A',
'地址和数据在不同的总线上传输，根据总线传输信息的内容进行区分，地址在地址总线上传输，数据在数据总线上传输。',
'总线的类型', '存储器数据寄存器（MDR）', '存储器地址寄存器（MAR）', '控制单元（CU）'),

(10, '00000000-0000-0000-0000-000000116010', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'在32位总线系统中，若时钟频率为500MHz，传送一个32位字需要5个时钟周期，则该总线的数据传输速率是（ ）。',
'B',
'总线带宽=总线宽度×总线频率，本题中的总线宽度为32位，即4B，总线频率为500MHz/5=100MHz，因此总线的数据传输速率为4B×(500MHz/5)=400MB/s。',
'200MB/s', '400MB/s', '600MB/s', '800MB/s'),

(11, '00000000-0000-0000-0000-000000116011', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'传输一幅分辨率为640像素×480像素、颜色数量为65536的照片（采用无压缩方式），假设有效数据的传输速率为56kb/s，则大约需要的时间是（ ）。',
'D',
'65536=2^16，因此颜色深度为16位，占据的存储空间为640×480×16=4915200位。有效传输时间=4915200÷(56×10^3)s≈87.77s。',
'34.82s', '43.86s', '85.71s', '87.77s'),

(12, '00000000-0000-0000-0000-000000116012', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'某总线有104根信号线，其中数据线（DB）为32根，若总线工作频率为33MHz，则其理论最大传输速率为（ ）。',
'C',
'数据总线32根，因此每次传输32位，即4B数据，总线工作频率为33MHz，因此理论最大传输速率为33×4=132MB/s。',
'33MB/s', '64MB/s', '132MB/s', '164MB/s'),

(13, '00000000-0000-0000-0000-000000116013', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'在一个16位的总线系统中，若时钟频率为100MHz，总线周期为5个时钟周期传输一个字，则总线带宽是（ ）。',
'B',
'时钟频率为100MHz，因此时钟周期=1/100MHz=0.01μs，总线周期=5个时钟周期=5×0.01μs=0.05μs，总线工作频率=1/0.05=20MHz，因总线是16位的，即2B，因此总线带宽=20×(16/8)=40MB/s。',
'4MB/s', '40MB/s', '16MB/s', '64MB/s'),

(14, '00000000-0000-0000-0000-000000116014', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'下列信号中，可在系统总线中的控制总线上传输的有（ ）。
I. 存储器和I/O设备的地址信息
II. 存储器和I/O设备的时序信号、控制信号
III. 存储器和I/O设备的响应信号
IV. 存储器中存放的数据',
'B',
'控制总线主要用来传输计算机内各种控制信号，控制信号包括存储器和I/O设备的时序信号和响应信号，说法II、III正确。存储器和I/O设备的地址信息通过地址总线传输，说法I错误。存储器中存放的数据通过数据总线传输，说法IV错误。',
'I和IV', 'II和III', 'I、II和III', 'II、III和IV'),

(15, '00000000-0000-0000-0000-000000116015', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'MOCK', 2027, '6.1总线概述', 'pp.278-280,281-283',
'总线中，有些信息是单向传输的，有些信息是双向传输的，下列说法中正确的是（ ）。',
'B',
'总线中，数据总线是双向传输的，数据信息既可由CPU传送至内存或外设，又可由内存、外设传送至CPU，选项A错误。地址总线是单向传输的，地址信息只能由CPU发送至内存或外设，选项B正确。控制信息和状态信息也是单向传输的，它们的传输方向正好相反，控制信息通过控制总线由CPU发送至内存或外设，而状态信息则通过状态总线由内存或外设发送至CPU。',
'数据信息是单向传输的，由内存或外设传送至CPU', '地址信息是单向传输的，由CPU发送至内存或外设', '控制信息是双向传输的，由CPU发送至内存或外设，也可反向', '状态信息是双向传输的，由CPU发送至内存或外设，也可反向'),

(16, '00000000-0000-0000-0000-000000116016', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2009, '6.1总线概述', 'pp.278-280,281-283',
'【2009统考真题】假设某系统总线在一个总线周期中并行传输4字节信息，一个总线周期占用2个时钟周期，总线时钟频率为10MHz，则总线带宽是（ ）。',
'B',
'总线带宽是指单位时间内总线上传输数据的位数，通常用每秒传送信息的字节数来衡量，单位为B/s。由题意可知，在1个总线周期（=2个时钟周期）内传输了4字节信息，时钟周期=1/10MHz=0.1μs，因此总线带宽为4B÷(2×0.1μs)=4B÷(0.2×10^-6s)=20MB/s。',
'10MB/s', '20MB/s', '40MB/s', '80MB/s'),

(17, '00000000-0000-0000-0000-000000116017', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2010, '6.1总线概述', 'pp.278-280,281-283',
'【2010统考真题】下列选项中的英文缩写均为总线标准的是（ ）。',
'D',
'选项A中的CRT表示阴极射线管显示器；选项B中的CPI表示每条指令的时钟周期数；选项C中的RAM表示半导体随机存储器、MIPS表示每秒执行多少百万条指令数。只有选项D中ISA、EISA、PCI、PCI-Express均为总线标准。',
'PCI、CRT、USB、EISA', 'ISA、CPI、VESA、EISA', 'ISA、SCSI、RAM、MIPS', 'ISA、EISA、PCI、PCI-Express'),

(18, '00000000-0000-0000-0000-000000116018', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2011, '6.1总线概述', 'pp.278-280,281-283',
'【2011统考真题】在系统总线的数据线上，不可能传输的是（ ）。',
'C',
'取指令时，指令便是在数据线上传输的。操作数显然在数据线上传输。中断类型号用于指出中断向量（中断服务程序的入口地址）的地址，CPU响应某一外部中断后，就会从数据总线上获取该中断源的中断类型号，然后据此计算对应中断向量在中断向量表（存放在内存中）的位置。而握手（应答）信号属于总线定时的控制信号，应在控制总线上传输。',
'指令', '操作数', '握手（应答）信号', '中断类型号'),

(19, '00000000-0000-0000-0000-000000116019', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2012, '6.1总线概述', 'pp.278-280,281-283',
'【2012统考真题】下列关于USB总线特性的描述中，错误的是（ ）。',
'D',
'USB的特点有：①即插即用；②热插拔；③具有很强的连接能力，采用菊花链形式将众多外设连接起来；④有很好的可扩充性，一个USB控制器可扩充高达127个外部USB设备；⑤高速传输，速率可达480Mb/s。USB是串行总线，不能同时传输2位数据，选项D错误。',
'可实现外设的即插即用和热拔插', '可通过级联方式连接多台外设', '是一种通信总线，连接不同外设', '同时可传输2位数据，数据传输速率高'),

(20, '00000000-0000-0000-0000-000000116020', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2013, '6.1总线概述', 'pp.278-280,281-283',
'【2013统考真题】下列选项中，用于设备和设备控制器之间互连的接口标准是（ ）。',
'B',
'USB是一种连接外部设备的I/O总线标准，属于设备总线，是设备和设备控制器之间的接口。而PCI、AGP、PCI-E作为计算机系统的局部总线标准，通常用来连接主存、网卡、视频卡等。',
'PCI', 'USB', 'AGP', 'PCI-Express'),

(21, '00000000-0000-0000-0000-000000116021', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2014, '6.1总线概述', 'pp.278-280,281-283',
'【2014统考真题】某同步总线采用数据线和地址线复用方式，其中地址/数据线有32根，总线时钟频率为66MHz，每个时钟周期传送两次数据（上升沿和下降沿各传送一次数据），该总线的最大数据传输速率（总线带宽）是（ ）。',
'C',
'数据线有32根，也就是一次可以传送32b/8=4B的数据，66MHz意味着有66M个时钟周期，而每个时钟周期传送两次数据，可知总线每秒传送的最大数据量为66M×2×4B=528MB，所以总线的最大数据传输速率为528MB/s。',
'132MB/s', '264MB/s', '528MB/s', '1056MB/s'),

(22, '00000000-0000-0000-0000-000000116022', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2019, '6.1总线概述', 'pp.278-280,281-283',
'【2019统考真题】某计算机采用3通道存储器总线，配套的内存条型号为DDR3-1333，即内存条所接插的存储器总线的工作频率为1333MHz，总线宽度为64位，则存储器总线的总带宽大约是（ ）。',
'B',
'由题目可知，计算机采用3通道存储器总线，存储器总线的工作频率为1333MHz，即1s内传送1333M次数据，总线宽度为64位即单条总线工作一次可传输8字节，因此存储器总线的总带宽为3×8×1333MB/s，约为32GB/s。',
'10.66GB/s', '32GB/s', '64GB/s', '96GB/s'),

(23, '00000000-0000-0000-0000-000000116023', 'CO_BUS', 'CO_BUS_OVERVIEW', 'HARD', 'PAST_EXAM', 2020, '6.1总线概述', 'pp.278-280,281-283',
'【2020统考真题】QPI总线是一种点对点全双工同步串行总线，总线上的设备可同时接收和发送信息，每个方向可同时传输20位信息（16位数据+4位校验位），每个QPI数据包有80位信息，分2个时钟周期传送，每个时钟周期传递2次。因此，QPI总线带宽为：每秒传送次数×2B×2。若QPI时钟频率为2.4GHz，则总线带宽为（ ）。',
'C',
'每个时钟周期传送2次，所以每秒传送的次数=时钟频率×2=2.4G×2/s。总线带宽=每秒传送次数×2B×2=2.4G×2×2B×2/s=19.2GB/s。题中已给出总线带宽公式，降低了难度。公式中的"×2B"是因为每次传输16位数据。注意，计算总线带宽或数据传输速率时，是否包含校验位、控制位等开销并无统一标准，要以题干为准。尽管QPI每周期实际传输20位（含4位校验），但本题明确按16位有效数据计算带宽。无特别说明时，通常默认仅计入有效用户数据，不含额外开销。',
'4.8GB/s', '9.6GB/s', '19.2GB/s', '38.4GB/s'),

(24, '00000000-0000-0000-0000-000000116024', 'CO_BUS', 'CO_BUS_OVERVIEW', 'HARD', 'PAST_EXAM', 2024, '6.1总线概述', 'pp.278-280,281-283',
'【2024统考真题】某存储器总线的时钟频率为420MHz，总线宽度为64位，每个时钟周期传送2次数据；其总线事务支持突发传送方式，最多传送8次数据，第1个时钟周期传送地址和读/写命令，从第4个至第7个时钟周期连续传送8次数据。该总线的总线带宽（最大数据传输率）为（ ）。',
'B',
'总线带宽（最大数据传输率）是理想情况（所有总线周期都在传送数据）下单位时间内传输的数据量，不考虑具体总线事务的情况，而计算（平均）数据传输率才需考虑每个总线事务的具体情况。因此，题中"其总线事务支持……连续传送8次数据"这句话属于干扰条件。根据定义，总线带宽=总线宽度×总线时钟频率×每个时钟周期传送数据的次数=64bit×420MHz×2=6.72GB/s。',
'3.84GB/s', '6.72GB/s', '30.72GB/s', '53.76GB/s'),

(25, '00000000-0000-0000-0000-000000116025', 'CO_BUS', 'CO_BUS_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2025, '6.1总线概述', 'pp.278-280,281-283',
'【2025统考真题】某处理器总线采用同步并行传输方式，每个总线时钟周期传送4次数据（quad pumped技术），若该总线的工作频率为1333MHz（实际单位是MT/s，表示每秒传送1333M次），总线宽度为64位，则总线带宽约为（ ）。',
'A',
'总线带宽=每秒传输次数×每次传输的数据量。题中每秒传输1333M次，每次传输64位（8字节）。因此，带宽=1333M×8B/s=10664MB/s，约为10.66GB/s。',
'10.66GB/s', '42.66GB/s', '85.31GB/s', '341.25GB/s');

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
    '原题来自《2027年计算机组成原理考研复习指导》第6章 6.1 总线概述 本节试题精选。原始页码：' || q.source_pages || '。本批共25道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch6_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000216', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch6_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000216', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch6_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000216', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch6_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000216', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch6_a_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch6_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000116101', 'CO-2027-ORIGINAL-CH6-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000116102', '6.1总线概述')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch6_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH6-A-TEXT-ONLY',
    '第6章总线',
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
DROP TABLE co_2027_original_ch6_a_text_import;
