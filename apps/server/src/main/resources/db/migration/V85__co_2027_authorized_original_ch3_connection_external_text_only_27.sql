-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 3: 3.3 主存储器与CPU的连接 (Q1-Q15) and 3.4 外部存储器 (Q1-Q12).
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Batch: CO-2027-ORIGINAL-CH3-C-D-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000085301',
    c.id,
    'CO_CACHE_CONNECTION',
    '主存储器与CPU的连接',
    3
FROM chapters c
WHERE c.code = 'CO_CACHE'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CACHE_CONNECTION');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000085302',
    c.id,
    'CO_CACHE_EXTERNAL',
    '外部存储器',
    4
FROM chapters c
WHERE c.code = 'CO_CACHE'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CACHE_EXTERNAL');

CREATE TABLE co_2027_original_ch3_c_d_text_import (
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

INSERT INTO co_2027_original_ch3_c_d_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 3.3 主存储器与CPU的连接 Q1-Q15
-- ============================================================
(1, '00000000-0000-0000-0000-000000085001', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'BASIC', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.99,101',
 '用存储容量为 16K×1 位的存储芯片来组成一个 64K×8 位的存储器，则在字方向和位方向分别扩展了（ ）倍。',
 'D',
 '字方向扩展了 64K/16K = 4 倍，位方向扩展了 8bit/1bit = 8 倍。',
 '4, 2', '8, 4', '2, 4', '4, 8'),

(2, '00000000-0000-0000-0000-000000085002', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'BASIC', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.99,101',
 '80386DX 是 32 位系统，以 4B 为编址单位，当在该系统中用 8KB（8K×8 位）的存储芯片构造 32KB 的存储体时，应完成存储器的（ ）设计。',
 'A',
 '因为以 4B 为编址单位，要扩展到 32KB，即扩展到 8K×32bit，所以只用进行位扩展。',
 '位扩展', '字扩展', '字位扩展', '字位均不扩展'),

(3, '00000000-0000-0000-0000-000000085003', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.99,101',
 '4 片 16K×8 位的存储芯片，可设计为（ ）容量的存储器。',
 'A',
 '4 片 16K×8 位的存储芯片构成的存储器容量 = 4×16K×8 位 = 512K 位或 64KB，只有选项 A 的容量为 64KB。注意，若有选项为 128K×4 位，则此选项不能选，因为芯片为 8 位，不可能将字长"扩展"成 4 位。',
 '32K×16 位', '16K×16 位', '32K×8 位', '8K×16 位'),

(4, '00000000-0000-0000-0000-000000085004', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.99,101',
 '16 片 2K×4 位的存储器可以设计为（ ）存储容量的 16 位存储器。',
 'C',
 '设存储容量为 M，则有 (M×16)÷(2K×4) = 16，因此 M = 8K。',
 '16K', '32K', '8K', '2K'),

(5, '00000000-0000-0000-0000-000000085005', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.99,101',
 '设 CPU 地址总线有 24 根，数据总线有 32 根，用 512K×8 位的 RAM 芯片构成该计算机的主存储器，则该计算机主存最多需要（ ）片这样的存储芯片。',
 'D',
 '地址线为 24 根，寻址范围是 2^24；数据线为 32 根，字长为 32 位。主存的总容量 = 2^24×32 位，因此所需存储芯片数 = (2^24×32)÷(512K×8) = 128。',
 '256', '512', '64', '128'),

(6, '00000000-0000-0000-0000-000000085006', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.99,101',
 '地址总线 A15（高位）~ A0（低位），用 4K×4 位的存储芯片组成 16KB 存储器，则产生片选信号的译码器的输入地址线应该是（ ）。',
 'A',
 'A0~A11 为地址线的低 12 位，接入各芯片地址端；共有 8 个芯片（16KB/4K = 4，并且位扩展时每组两片共分为 4 组）组成 16KB 的存储器，因此由高两位地址 A15、A14 作为译码器的输入。',
 'A15, A14', 'A0, A1', 'A2, A3', 'A14, A15'),

(7, '00000000-0000-0000-0000-000000085007', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.99,101',
 '若内存地址区间为 4000H~43FFH，每个存储单元可存储 16 位二进制数，该内存区域用 4 片存储芯片构成，构成该内存所用的存储芯片的容量是（ ）。',
 'C',
 '43FFH − 4000H + 1 = 400H，即内存区域为 1K 个单元，总容量为 1K×16 位。现该内存由 4 片存储芯片构成，则构成该内存的芯片容量为 1K×16 位/4 = 256×16 位。',
 '512×16bit', '256×8bit', '256×16bit', '1024×8bit'),

(8, '00000000-0000-0000-0000-000000085008', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.100,101',
 '内存按字节编址，地址从 90000H 到 CFFFFH，若用存储容量为 16K×8 位的芯片构成该内存，至少需要的芯片数是（ ）。',
 'D',
 'CFFFFH − 90000H + 1 = 40000H，即内存区域有 256K 个单元。若用存储容量为 16K×8 位的芯片，则需要的芯片数 = (256K×8)/(16K×8) = 16。',
 '2', '4', '8', '16'),

(9, '00000000-0000-0000-0000-000000085009', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'MOCK', 2027, '3.3主存储器与CPU的连接', 'pp.100,101',
 '若片选地址为 111 时，选定某一 32K×16 位的存储芯片工作，则该芯片在存储器中的首地址和末地址分别为（ ）。',
 'B',
 '32K×16 的存储芯片有地址线 15 根（A14~A0），片选地址为 3 位，因此地址总位数为 18 位。现高 3 位为 111，则首地址为 111000000000000000B = 38000H，末地址为 111111111111111111B = 3FFFFH。',
 '00000H, 01000H', '38000H, 3FFFFH', '3800H, 3FFFH', '0000H, 0100H'),

(10, '00000000-0000-0000-0000-000000085010', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'PAST_EXAM', 2009, '3.3主存储器与CPU的连接', 'pp.100,101',
 '【2009 统考真题】某计算机主存容量为 64KB，其中 ROM 区为 4KB，其余为 RAM 区，按字节编址。现要用 2K×8 位的 ROM 芯片和 4K×4 位的 RAM 芯片来设计该存储器，需要上述规格的 ROM 芯片数和 RAM 芯片数分别是（ ）。',
 'D',
 '首先确定 ROM 的个数，ROM 区为 4KB，选用 2K×8 位的 ROM 芯片，需要 (4K×8)/(2K×8) = 2 片，采用字扩展方式；RAM 区为 60KB，选用 4K×4 位的 RAM 芯片，需要 (60K×8)/(4K×4) = 30 片，采用字和位同时扩展的方式。',
 '1, 15', '2, 15', '1, 30', '2, 30'),

(11, '00000000-0000-0000-0000-000000085011', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'PAST_EXAM', 2010, '3.3主存储器与CPU的连接', 'pp.100,101',
 '【2010 统考真题】假定用若干 2K×4 位的芯片组成一个 8K×8 位的存储器，则地址 0B1FH 所在芯片的最小地址是（ ）。',
 'D',
 '用 2K×4 位的芯片组成一个 8K×8 位的存储器，共需 8 片 2K×4 位的芯片，分为 4 组，每组由 2 片 2K×4 位的芯片并联组成 2K×8 位的芯片，各组芯片的地址分配如下：
第一组（两个芯片并联）：0000H~07FFH。
第二组（两个芯片并联）：0800H~0FFFH。
第三组（两个芯片并联）：1000H~17FFH。
第四组（两个芯片并联）：1800H~1FFFH。
地址 0B1FH 所在的芯片属于第二组，所以其所在芯片的最小地址为 0800H。',
 '0000H', '0600H', '0700H', '0800H'),

(12, '00000000-0000-0000-0000-000000085012', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'BASIC', 'PAST_EXAM', 2011, '3.3主存储器与CPU的连接', 'pp.100,101',
 '【2011 统考真题】某计算机存储器按字节编址，主存地址空间大小为 64MB，现用 4M×8 位的 RAM 芯片组成 32MB 的主存储器，则存储器地址寄存器 MAR 的位数至少是（ ）。',
 'D',
 '主存按字节编址，地址空间大小为 64MB，MAR 的寻址范围为 64M = 2^26，因此是 26 位。实际的主存容量 32MB 不能代表 MAR 的位数，考虑到存储器扩展的需要，MAR 应保证能访问到整个主存地址空间，反过来，MAR 的位数决定了主存地址空间的大小。',
 '22 位', '23 位', '25 位', '26 位'),

(13, '00000000-0000-0000-0000-000000085013', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'PAST_EXAM', 2016, '3.3主存储器与CPU的连接', 'pp.100,101',
 '【2016 统考真题】某存储器容量为 64KB，按字节编址，地址 4000H~5FFFH 为 ROM 区，其余为 RAM 区。若采用 8K×4 位的 SRAM 芯片进行设计，则需要该芯片的数量是（ ）。',
 'C',
 '5FFFH − 4000H + 1 = 2000H，即 ROM 区容量为 2^13B = 8KB（2000H = 2×16^3 = 2^13），RAM 区容量为 56KB（64KB − 8KB = 56KB）。需要 8K×4 位的 SRAM 芯片的数量为 56KB/(8K×4 位) = 14。',
 '7', '8', '14', '16'),

(14, '00000000-0000-0000-0000-000000085014', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'PAST_EXAM', 2021, '3.3主存储器与CPU的连接', 'pp.100,102',
 '【2021 统考真题】某计算机存储器总线共有 34 根地址线、32 位数据线，按字编址，字长为 32 位。若 000000H~3FFFFFH 为 RAM 区，则需要 512K×8 位的 RAM 芯片数为（ ）。',
 'C',
 '000000H~3FFFFFH，共有 3FFFFFH − 000000H + 1H = 400000H = 2^22 个地址，按字编址，字长为 32 位（4B），因此 RAM 区大小为 2^22×4B = 2^22×32bit。每个 RAM 芯片的容量为 512K×8bit = 2^19×8bit，所以需要 RAM 芯片的数量为 (2^22×32bit)/(2^19×8bit) = 32。',
 '8', '16', '32', '64'),

(15, '00000000-0000-0000-0000-000000085015', 'CO_CACHE', 'CO_CACHE_CONNECTION', 'MEDIUM', 'PAST_EXAM', 2023, '3.3主存储器与CPU的连接', 'pp.100,102',
 '【2023 统考真题】某计算机的 CPU 有 30 根地址线，按字节编址，CPU 和主存连接时，要求主存芯片占满所有可能的存储地址空间，且 RAM 区和 ROM 区所分配的空间大小比是 3:1。若 RAM 在低地址区，ROM 在高地址区，则 ROM 的地址范围是（ ）。',
 'C',
 '地址空间为 2^30，地址范围为 0000 0000H~3FFF FFFFH。RAM:ROM = 3:1，则 ROM 可分配的地址空间为 2^28，从 3FFF FFFFH 往前数 2^28 个地址，即 ROM 的地址范围是 3000 0000H~3FFF FFFFH。',
 '0000 0000H~0FFF FFFFH', '1000 0000H~2FFF FFFFH', '3000 0000H~3FFF FFFFH', '4000 0000H~4FFF FFFFH'),

-- ============================================================
-- 3.4 外部存储器 Q1-Q12
-- ============================================================
(16, '00000000-0000-0000-0000-000000085016', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'MOCK', 2027, '3.4外部存储器', 'pp.105,107',
 '下列关于磁盘的说法中，错误的是（ ）。',
 'B',
 '闪存是在 EPROM 的基础上发展起来的，本质上是只读存储器。RAID 将多个物理盘组成像单个逻辑盘，不会影响磁记录密度，也不可能提高磁盘利用率。在磁盘的格式化过程中，要对磁盘划分扇区，每个扇区要写入一些控制信息，扇区尾部还要留有一定的空隙，这些均需占用一些存储空间，因此导致格式化后的实际容量比非格式化的容量要小。',
 '本质上，U 盘（闪存）是一种只读存储器',
 'RAID 技术可以提高磁盘的磁记录密度和磁盘利用率',
 '未格式化的硬盘容量要大于格式化后的实际容量',
 '计算磁盘的存取时间时，"寻道时间"和"旋转等待时间"常取其平均值'),

(17, '00000000-0000-0000-0000-000000085017', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'MOCK', 2027, '3.4外部存储器', 'pp.106,107',
 '下列关于磁盘驱动器的叙述中，错误的是（ ）。',
 'A',
 '因为每个盘面对应一个磁头，所以盘面号和磁头号是同一个概念，显然 A 的说法是错误的，磁盘地址应该由磁道号（柱面号）、磁头号（盘面号）和扇区号组成。',
 '送到磁盘驱动器的地址由磁头号、盘面号和扇区号组成',
 '能控制磁头移动到指定磁道，并发回"寻道结束"信号',
 '能控制磁盘片转过指定的扇区，并发回"扇区符合"信号',
 '能控制对指定盘面的指定扇区进行数据的读/写操作'),

(18, '00000000-0000-0000-0000-000000085018', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'MOCK', 2027, '3.4外部存储器', 'pp.106,107',
 '下列有关磁盘存储器读/写操作的叙述中，错误的是（ ）。',
 'D',
 '磁盘存储器以成批（组）方式进行数据读/写，CPU 中没有那么多通用寄存器用于存放交换的数据，且磁盘与通用寄存器的传输速率相差过大，因此磁盘存储器通常直接和主存交换信息。',
 '最小读/写单位可以是一个扇区',
 '采用直接存储器存取（DMA）方式进行输入/输出',
 '按批处理方式进行一个数据块的读/写',
 '磁盘存储器可与 CPU 交换盘面上的存储信息'),

(19, '00000000-0000-0000-0000-000000085019', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'MOCK', 2027, '3.4外部存储器', 'pp.106,107',
 '若磁盘的转速提高一倍，则（ ）。',
 'C',
 '磁盘存取的步骤为：启动磁头、寻找磁道（寻道时间）、查找扇区（旋转等待时间）、传输数据。转速提高对寻道时间无影响；存取速度取决于所有步骤的时间，虽然会提高，但不会提高一倍；平均旋转等待时间为旋转半周的时间，因此会减少一半；转速提高则传输速率也提高。',
 '平均寻道时间减少一半', '存取速度也提高一倍', '平均旋转等待时间减少一半', '不影响磁盘传输速率'),

(20, '00000000-0000-0000-0000-000000085020', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'MOCK', 2027, '3.4外部存储器', 'pp.106,107',
 '下列关于固态硬盘（SSD）的叙述中，不正确的是（ ）。',
 'B',
 '固态硬盘的擦除以块为单位，读/写以页为单位，选项 B 错误。固态硬盘的写入速度比读取速度要慢很多，因为在写入时需要擦除，且写入次数有限，否则相应块就会因为磨损而无法再次写入。',
 '固态硬盘的读/写是以页为单位的',
 '固态硬盘的擦除是以页为单位的',
 '固态硬盘的写入速度比读取速度慢很多',
 '固态硬盘的写入次数有限，引入磨损均衡可以延长使用寿命'),

(21, '00000000-0000-0000-0000-000000085021', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'MOCK', 2027, '3.4外部存储器', 'pp.106,107',
 '下列关于固态硬盘（SSD）的说法中，错误的是（ ）。',
 'D',
 '固态硬盘基于闪存技术，没有机械部件，随机读/写不需要机械操作，因此速度明显高于磁盘，选项 A 和 B 正确。选项 C 已在考点讲解中解释过。SSD 常用作外存而非主存，选项 D 错误。',
 '基于闪存的存储技术', '随机读/写性能明显高于磁盘', '随机写比较慢', '读/写速度快，常用作主存'),

(22, '00000000-0000-0000-0000-000000085022', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'MEDIUM', 'MOCK', 2027, '3.4外部存储器', 'pp.106,107',
 '一个磁盘的转速为 7200 转/分，每个磁道有 160 个扇区，每个扇区有 512 字节，则在理想情况下，磁盘每秒传输的数据量是（ ）。',
 'C',
 '磁盘的转速为 7200 转/分 = 120 转/秒，转一圈经过 160 个扇区，每个扇区为 512B，所以磁盘每秒传输的数据量为 120×160×512/1024 = 9600KB。',
 '7200×160KB', '7200KB', '9600KB', '19200KB'),

(23, '00000000-0000-0000-0000-000000085023', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'MEDIUM', 'MOCK', 2027, '3.4外部存储器', 'pp.106,108',
 '某磁盘有 200 个磁道，盘面总存储容量为 60MB，磁盘旋转一周的时间为 25ms，每个磁道有 8 个扇区，各扇区之间有一间隙，磁头通过每个间隙需 1.25ms。则磁盘接口所需的最大传输速率是（ ）。',
 'D',
 '每个磁道的容量 = 60MB/200 = 0.3MB，读一个磁道数据的时间等于磁盘旋转一周的时间减去通过扇区间隙的总时间（每个磁道有 8 个间隙），即 25ms − 1.25ms×8 = 15ms，数据传输速率 = 0.3MB/15ms = 20MB/s。',
 '10MB/s', '60MB/s', '83.3MB/s', '20MB/s'),

(24, '00000000-0000-0000-0000-000000085024', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'MEDIUM', 'PAST_EXAM', 2013, '3.4外部存储器', 'pp.106,108',
 '【2013 统考真题】某磁盘的转速为 10000 转/分，平均寻道时间是 6ms，磁盘传输速率是 20MB/s，磁盘控制器延迟为 0.2ms，读取一个 4KB 的扇区所需的平均时间约为（ ）。',
 'B',
 '磁盘转速是 10000 转/分，转一圈的时间为 6ms，因此平均查询扇区的时间为 3ms，平均寻道时间为 6ms，读取 4KB 扇区信息的时间为 4KB÷20MB/s = 0.2ms，磁盘控制器延迟为 0.2ms，总时间为 3 + 6 + 0.2 + 0.2 = 9.4ms。',
 '9ms', '9.4ms', '12ms', '12.4ms'),

(25, '00000000-0000-0000-0000-000000085025', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'PAST_EXAM', 2013, '3.4外部存储器', 'pp.106,108',
 '【2013 统考真题】下列选项中，用于提高 RAID 可靠性的措施有（ ）。
I. 磁盘镜像
II. 条带化
III. 奇偶校验
IV. 增加 Cache 机制',
 'B',
 'RAID0 方案是无冗余和无校验的磁盘阵列技术，而 RAID1~RAID5 方案均是加入了冗余（镜像）或校验的磁盘阵列技术。因此，提高 RAID 可靠性的措施主要是对磁盘进行镜像和奇偶校验，其余选项不符合条件。条带化是一种将数据分片，分别存储至不同的磁盘，提高读/写速度的技术。条带化的优点是读/写速度快，缺点是没有冗余，若其中一块磁盘损坏，则数据就会丢失。因此，条带化通常和其他技术如磁盘镜像或奇偶校验结合使用，形成不同的 RAID 级别。',
 '仅 I, II', '仅 I, III', 'I, III, IV', 'II, III 和 IV'),

(26, '00000000-0000-0000-0000-000000085026', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'MEDIUM', 'PAST_EXAM', 2015, '3.4外部存储器', 'pp.106,108',
 '【2015 统考真题】若磁盘转速为 7200 转/分，平均寻道时间为 8ms，每个磁道包含 1000 个扇区，则访问一个扇区的平均存取时间大约是（ ）。',
 'B',
 '存取时间 = 寻道时间 + 旋转等待时间 + 传输时间。存取一个扇区的平均旋转等待时间为旋转半周的时间，即 (60/7200)/2 ≈ 4.17ms，传输时间为 (60/7200)/1000 ≈ 0.01ms，因此访问一个扇区的平均存取时间为 4.17 + 0.01 + 8 = 12.18ms，保留一位小数则为 12.2ms。',
 '8.1ms', '12.2ms', '16.3ms', '20.5ms'),

(27, '00000000-0000-0000-0000-000000085027', 'CO_CACHE', 'CO_CACHE_EXTERNAL', 'BASIC', 'PAST_EXAM', 2019, '3.4外部存储器', 'pp.107,108',
 '【2019 统考真题】下列关于磁盘存储器的叙述中，错误的是（ ）。',
 'C',
 '磁盘存储器的最小读/写单位为一个扇区，即磁盘按块存取。磁盘存储数据之前需要进行格式化，将磁盘分成扇区并写入信息，因此磁盘的格式化容量比非格式化容量小。磁盘扇区中包含数据、地址和校验等信息。磁盘存储器由磁盘控制器、磁盘驱动器和盘片组成。',
 '磁盘的格式化容量比非格式化容量小',
 '扇区中包含数据、地址和校验等信息',
 '磁盘存储器的最小读/写单位为 1 字节',
 '磁盘存储器由磁盘控制器、磁盘驱动器和盘片组成');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 3 章 3.3.3/3.3.4 本节试题精选及答案解析（Q1-Q15），以及第 3 章 3.4.3/3.4.4 本节试题精选及答案解析（Q1-Q12）；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch3_c_d_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000185', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch3_c_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000185', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch3_c_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000185', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch3_c_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000185', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch3_c_d_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch3_c_d_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000085701', 'CO-2027-ORIGINAL-CH3-C-D-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000085702', '3.3主存储器与CPU的连接'),
    ('00000000-0000-0000-0000-000000085703', '3.4外部存储器')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch3_c_d_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH3-C-D-TEXT-ONLY',
    '第3章存储系统',
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

DROP TABLE co_2027_original_ch3_c_d_text_import;
