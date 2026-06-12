-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 1: computer system overview and performance indicators, text-only batch.
-- Questions whose stem or original answer explanation depends on tables are deferred.
-- Batch: CO-2027-ORIGINAL-CH1-A-TEXT-ONLY

CREATE TABLE co_2027_original_ch1_a_text_import (
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

INSERT INTO co_2027_original_ch1_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000072001', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.8-10', '完整的计算机系统应包括（ ）。', 'D', '计算机系统由硬件系统和软件系统共同组成。运算器、存储器和控制器只是主机的组成部分，外部设备和主机、主机和应用程序都只覆盖了系统的一部分。', '运算器、存储器、控制器', '外部设备和主机', '主机和应用程序', '配套的硬件设备和软件系统'),
(2, '00000000-0000-0000-0000-000000072002', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.8-10', '冯·诺依曼机的基本工作方式是（ ）。', 'A', '冯·诺依曼机以控制流驱动方式工作，按照指令执行序列依次取指令，并根据指令中的控制信息调用数据进行处理。', '控制流驱动方式', '多指令多数据流方式', '微程序控制方式', '数据流驱动方式'),
(3, '00000000-0000-0000-0000-000000072003', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.8-10', '冯·诺依曼机工作方式的基本特点是（ ）。', 'C', '冯·诺依曼机的核心特点是存储程序、程序和数据统一存储、按地址访问，以及指令自动顺序执行。', '程序一边被输入计算机一边被执行', '程序直接从磁盘读到 CPU 执行', '按地址访问指令并自动按序执行程序', '程序自动执行时数据手工输入'),
(4, '00000000-0000-0000-0000-000000072004', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.8-10', '以下关于计算机各部件功能的叙述中，错误的是（ ）。', 'A', '运算器不仅负责算术运算，还负责逻辑运算，选项 A 将其限定为只完成算术运算，表述错误。', '运算器（ALU）仅用来完成算术运算', '存储器用来存放指令和数据', '控制器负责指挥和协调计算机各部件', '输入/输出设备用来完成用户和计算机之间的信息交换'),
(5, '00000000-0000-0000-0000-000000072005', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.8-10', '计算机系统采用层次化结构，从最上层的应用程序到底层的硬件，其典型层次自上而下依次为（ ）。', 'C', '用户程序以高级语言编写，先在高级语言虚拟机层运行；编译后生成汇编代码，在汇编语言虚拟机层抽象执行；实际指令由操作系统加载、调度和管理资源；最后由机器语言机器执行。', '高级语言虚拟机→操作系统虚拟机→汇编语言虚拟机→机器语言机器', '高级语言虚拟机→汇编语言虚拟机→机器语言机器→操作系统虚拟机', '高级语言虚拟机→汇编语言虚拟机→操作系统虚拟机→机器语言机器', '操作系统虚拟机→高级语言虚拟机→汇编语言虚拟机→机器语言机器'),
(6, '00000000-0000-0000-0000-000000072006', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.8-10', '下列关于计算机系统层次结构的说法中，正确的是（ ）。', 'C', 'ISA 是软硬件抽象接口，定义软件可见的处理器行为；同一 ISA 可由不同微体系结构实现，软件通常无需修改即可兼容。', '高级语言程序经编译生成汇编语言后，可直接在机器上执行', 'ISA 仅定义指令功能，不涉及硬件实现细节', '同一 ISA 可由不同微体系结构实现，软件无须修改即可兼容', '高级语言中的每条语句与 ISA 的机器指令一一对应'),
(7, '00000000-0000-0000-0000-000000072007', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.9-10', '关于编译程序和解释程序，下列说法中错误的是（ ）。', 'C', '解释程序逐句翻译并边翻译边执行，运行速度通常较慢；选项 C 说解释程序方法简单且运行速度较快，表述错误。', '编译程序和解释程序的作用都是将高级语言程序转换为机器语言程序', '编译程序编译时间较长，运行速度较快', '解释程序方法较简单，运行速度也较快', '解释程序将源程序翻译成机器语言，并且翻译一条以后，立即执行这条语句'),
(8, '00000000-0000-0000-0000-000000072008', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.9-10', '只有当程序执行时才将源程序翻译成机器语言，并且一次只能翻译一行语句，边翻译边执行的是（ ）程序，把汇编语言源程序转换为机器语言程序的过程是（ ）。\nI. 编译\nII. 目标\nIII. 汇编\nIV. 解释', 'C', '解释程序的特点是翻译一句执行一句；把汇编语言源程序翻译成机器语言程序的过程称为汇编。', 'I、II', 'IV、II', 'IV、III', 'IV、I'),
(9, '00000000-0000-0000-0000-000000072009', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.9-10', '下列关于各种级别语言的描述中，错误的是（ ）。', 'D', '特定汇编语言与特定机器语言指令集一一对应，和机器结构有关，不同平台之间不能直接移植；因此说“汇编语言与机器结构无关”是错误的。', '可用高级语言和低级语言编写出功能等价的程序', '低级语言的执行效率一般情况下高于高级语言', '机器语言源程序可在机器上直接执行，而高级语言和汇编语言源程序不可以', '汇编语言与机器结构无关'),
(10, '00000000-0000-0000-0000-000000072010', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.2计算机系统层次结构', 'pp.9-10', '下列关于机器指令和汇编指令的叙述中，错误的是（ ）。', 'B', '计算机只能直接执行机器指令，汇编指令需要经汇编程序转换为机器指令后才能执行。', '可以直接用机器语言（机器指令）编写程序', '汇编指令和机器指令都能被计算机直接执行', '汇编语言和机器语言都与计算机系统结构相关', '汇编指令和机器指令一一对应，功能相同'),
(11, '00000000-0000-0000-0000-000000072011', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'PAST_EXAM', 2015, '1.2计算机系统层次结构', 'pp.9-10', '【2015 统考真题】计算机硬件能够直接执行的是（ ）。\nI. 机器语言程序\nII. 汇编语言程序\nIII. 硬件描述语言程序', 'A', '硬件只能直接执行机器语言（二进制编码）。汇编语言需要汇编后才能执行，硬件描述语言并非由 CPU 直接执行的程序。', '仅 I', '仅 I、II', '仅 I、III', 'I、II、III'),
(12, '00000000-0000-0000-0000-000000072012', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'PAST_EXAM', 2016, '1.2计算机系统层次结构', 'pp.9-10', '【2016 统考真题】将高级语言源程序转换为机器级目标代码文件的程序是（ ）。', 'C', '编译程序将高级语言源程序一次性翻译为目标程序，并生成目标代码文件；解释程序逐句翻译执行，汇编程序把汇编语言翻译为机器语言。', '汇编程序', '链接程序', '编译程序', '解释程序'),
(13, '00000000-0000-0000-0000-000000072013', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'PAST_EXAM', 2019, '1.2计算机系统层次结构', 'pp.9-11', '【2019 统考真题】下列关于冯·诺依曼机基本思想的叙述中，错误的是（ ）。', 'C', '指令和数据均以二进制形式存储在存储器中，形式上无差别；但程序执行时二者含义不同。数据并不是都在指令中直接给出，除立即寻址外，数据通常存放在存储器中。', '程序的功能都通过中央处理器执行指令实现', '指令和数据都用二进制数表示，形式上无差别', '指令按地址访问，数据都在指令中直接给出', '程序执行前，指令和数据需预先存放在存储器中'),
(14, '00000000-0000-0000-0000-000000072014', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'PAST_EXAM', 2022, '1.2计算机系统层次结构', 'pp.9-11', '【2022 统考真题】将高级语言源程序转换为可执行目标文件的主要过程是（ ）。', 'A', '源程序转换为可执行目标文件通常经历预处理、编译、汇编、链接四个阶段。', '预处理→编译→汇编→链接', '预处理→汇编→编译→链接', '预处理→编译→链接→汇编', '预处理→汇编→链接→编译'),
(15, '00000000-0000-0000-0000-000000072015', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-15', '关于 CPU 主频、CPI、MIPS、MFLOPS，说法正确的是（ ）。', 'D', 'CPU 主频是 CPU 使用的时钟频率；CPI 是执行一条指令平均使用的 CPU 时钟周期数。MIPS 描述每秒执行多少百万条指令，MFLOPS 描述每秒执行多少百万次浮点运算。', 'CPU 主频是指 CPU 执行指令的频率，CPI 是执行一条指令平均使用的频率', 'CPI 是执行一条指令平均使用 CPU 时钟的个数，MIPS 描述一条 CPU 指令平均使用的 CPU 时钟周期数', 'MIPS 是描述 CPU 执行指令的频率，MFLOPS 是计算机系统的浮点数指令', 'CPU 主频是 CPU 使用的时钟频率，CPI 是执行一条指令平均使用的 CPU 时钟周期数'),
(16, '00000000-0000-0000-0000-000000072016', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-15', '在用于科学计算的计算机中，标志系统性能的最有用的参数是（ ）。', 'C', 'MFLOPS 表示每秒执行多少百万次浮点运算，适合描述科学计算场景中的浮点运算性能。', '主时钟频率', '主存容量', 'MFLOPS', 'MIPS'),
(17, '00000000-0000-0000-0000-000000072017', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-15', '在计算机 M1 和计算机 M2 上分别运行功能完全相同的高级语言程序，程序在 M1 和 M2 上的平均 CPI 相等，则对于该类程序而言（ ）。', 'D', 'CPU 执行时间由指令条数、CPI 和时钟周期共同决定。即使平均 CPI 相同，不同机器编译生成的指令条数和主频也可能不同，因此不能确定哪台机器更快。', 'M1 和 M2 执行速度相等', 'M1 和 M2 中主频高的计算机执行速度快', 'M1 和 M2 中主频低的计算机执行速度快', '无法确定哪台机器的执行速度快'),
(18, '00000000-0000-0000-0000-000000072018', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-15', '计算机中，CPU 的 CPI 与下列（ ）因素无关。', 'A', 'CPI 是执行一条指令所需的平均时钟周期数，受系统结构、指令集和计算机组织影响；时钟频率不会影响 CPI，但会影响指令执行速度。', '时钟频率', '系统结构', '指令集', '计算机组织'),
(19, '00000000-0000-0000-0000-000000072019', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-16', '某基准程序在机器 A 上运行的时间是 20s，而在机器 B 上运行的时间是 16s，那么相对来说，下列给出的结论中，（ ）是正确的。', 'B', '机器速度与基准程序在该机器上的运行时间呈反比，机器 B 的速度/机器 A 的速度 = 20/16 = 1.25，因此机器 B 的速度是机器 A 的 1.25 倍。', '所有程序在机器 A 上都比在机器 B 上运行速度慢', '机器 B 的速度是机器 A 的 1.25 倍', '机器 A 的速度是机器 B 的 1.25 倍', '机器 A 比机器 B 慢 1.25 倍'),
(20, '00000000-0000-0000-0000-000000072020', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-16', '机器 A 的主频为 800MHz，某程序在机器 A 上运行需要 12s。现在硬件设计人员想设计机器 B，希望该程序在机器 B 上的运行时间能够缩短为 8s，使用新技术后可使机器 B 的主频大幅度提高，但在机器 B 上运行该程序所需的时钟周期数为在机器 A 上的 1.5 倍，则机器 B 的主频至少应为（ ）。', 'D', '程序在机器 A 上的时钟周期数为 12×800M=9600M。机器 B 需要的时钟周期数为 9600M×1.5=14400M，要在 8s 内完成，主频至少为 14400M/8=1.8GHz。', '800MHz', '1.2GHz', '1.5GHz', '1.8GHz'),
(21, '00000000-0000-0000-0000-000000072021', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-16', '下列可用于评价计算机系统性能的指标是（ ）。\nI. MIPS\nII. IPC\nIII. CPI\nIV. 字长', 'C', 'MIPS、CPI 和字长都是常见性能评价指标；IPC 表示每个时钟周期运行多少条指令，是 CPI 的倒数。题目给出的正确组合为 I、II 和 III。', 'I、III', 'I、III 和 IV', 'I、II 和 III', '全部'),
(22, '00000000-0000-0000-0000-000000072022', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.3计算机性能指标', 'pp.13-16', '计算机的机器字长与下列（ ）指标最密切相关。', 'D', '机器字长越长，数据位数越多，定点数或浮点数所表示和运算的精度越高，因此与运算精度最密切相关。', '运算速度', '存取速度', '内存容量', '运算精度'),
(23, '00000000-0000-0000-0000-000000072023', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'MOCK', 2027, '1.3计算机性能指标', 'pp.14,16', '下列给出了改善计算机性能的 4 种措施：\nI. 用更快的处理器来替换原来的慢速处理器\nII. 增加同类处理器个数，使得不同的处理器同时执行程序\nIII. 优化编译生成的代码，使得程序执行的总时钟周期数减少\nIV. 减少指令执行过程中的访存时间\n对于某个特定的程序，在以上措施中，能缩短其执行时间的措施是（ ）。', 'D', '更快处理器可减少单条指令执行时间；增加处理器个数可提高并行性；优化编译代码可减少指令间冲突和总时钟周期数；减少访存时间同样可加快指令执行，因此四项均可缩短执行时间。', 'I、II 和 III', 'I、II 和 IV', 'I、III 和 IV', '全部'),
(24, '00000000-0000-0000-0000-000000072024', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'PAST_EXAM', 2010, '1.3计算机性能指标', 'pp.14,16', '【2010 统考真题】下列选项中，能缩短程序执行时间的措施是（ ）。\nI. 提高 CPU 时钟频率\nII. 优化数据通路结构\nIII. 对程序进行编译优化', 'D', 'CPU 时钟频率越高，执行步骤耗时越短；优化数据通路可有效提高吞吐量；编译优化可得到更优指令序列，从而缩短程序执行时间。', '仅 I 和 II', '仅 I 和 III', '仅 II 和 III', 'I、II、III'),
(25, '00000000-0000-0000-0000-000000072025', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'BASIC', 'PAST_EXAM', 2011, '1.3计算机性能指标', 'pp.14,17', '【2011 统考真题】下列选项中，描述浮点数操作速度指标的是（ ）。', 'D', 'MIPS 衡量每秒执行多少百万条指令，CPI 是平均每条指令的时钟周期数，IPC 是 CPI 的倒数，MFLOPS 用于描述浮点运算速度。', 'MIPS', 'CPI', 'IPC', 'MFLOPS'),
(26, '00000000-0000-0000-0000-000000072026', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'PAST_EXAM', 2012, '1.3计算机性能指标', 'pp.14,17', '【2012 统考真题】假定基准程序 A 在某计算机上的运行时间为 100s，其中 90s 为 CPU 时间，其余为 I/O 时间。若 CPU 速度提高 50%，I/O 速度不变，则运行基准程序 A 所耗费的时间是（ ）。', 'D', 'CPU 提速 50% 后，原 90s CPU 时间变为 90/1.5=60s，I/O 时间仍为 10s，总时间为 70s。', '55s', '60s', '65s', '70s'),
(27, '00000000-0000-0000-0000-000000072027', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'PAST_EXAM', 2014, '1.3计算机性能指标', 'pp.14,17', '【2014 统考真题】程序 P 在机器 M 上的执行时间是 20s，编译优化后，P 执行的指令数减少到原来的 70%，而 CPI 增加到原来的 1.2 倍，则 P 在 M 上的执行时间是（ ）。', 'D', '设原指令数为 x、原 CPI 为 20f/x。优化后指令数为 0.7x，CPI 变为原来的 1.2 倍，因此执行时间变为原来的 0.7×1.2=0.84，即 20s×0.84=16.8s。', '8.4s', '11.7s', '14s', '16.8s'),
(28, '00000000-0000-0000-0000-000000072028', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'PAST_EXAM', 2017, '1.3计算机性能指标', 'pp.15,17', '【2017 统考真题】假定计算机 M1 和 M2 具有相同的指令集体系结构（ISA），主频分别为 1.5GHz 和 1.2GHz。在 M1 和 M2 上运行某基准程序 P，平均 CPI 分别为 2 和 1，则程序 P 在 M1 和 M2 上运行时间的比值是（ ）。', 'C', '运行时间 = 指令条数×CPI/主频。两机 ISA 相同且运行同一基准程序，指令条数相同，因此时间比为 (2/1.5):(1/1.2)=1.6。', '0.4', '0.625', '1.6', '2.5'),
(29, '00000000-0000-0000-0000-000000072029', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'PAST_EXAM', 2021, '1.3计算机性能指标', 'pp.15,17', '【2021 统考真题】2017 年公布的全球超级计算 TOP 500 排名中，我国“神威·太湖之光”超级计算机蝉联第一，其浮点运算速度为 93.0146 PFLOPS，说明该计算机每秒完成的浮点操作次数约为（ ）。', 'D', 'PFLOPS 表示每秒千万亿次，即 10^15 次浮点运算。93.0146 PFLOPS 约为每秒 9.3×10^16 次，也就是每秒 9.3 亿亿次浮点运算。', '9.3×10^13 次', '9.3×10^15 次', '9.3 千万亿次', '9.3 亿亿次'),
(30, '00000000-0000-0000-0000-000000072030', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'PAST_EXAM', 2022, '1.3计算机性能指标', 'pp.15,17', '【2022 统考真题】某计算机主频为 1GHz，程序 P 运行过程中，共执行了 10000 条指令，其中，80%的指令执行平均需 1 个时钟周期，20%的指令执行平均需 10 个时钟周期。程序 P 的平均 CPI 和 CPU 执行时间分别是（ ）。', 'A', '平均 CPI=80%×1+20%×10=2.8。主频 1GHz，程序执行 10000 条指令，因此 CPU 执行时间 = 10000×2.8/10^9 s = 28us。', '2.8,28us', '28,28us', '2.8,28ms', '28,28ms');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 1 章 1.2.7/1.2.8 与 1.3.2/1.3.3 本节试题精选及答案解析；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch1_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000172', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch1_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000172', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch1_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000172', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch1_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000172', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch1_a_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch1_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000072701', 'CO-2027-ORIGINAL-CH1-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000072702', '第1章计算机系统概述'),
    ('00000000-0000-0000-0000-000000072703', '1.2计算机系统层次结构'),
    ('00000000-0000-0000-0000-000000072704', '1.3计算机性能指标')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch1_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH1-A-TEXT-ONLY',
    '第1章计算机系统概述',
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

DROP TABLE co_2027_original_ch1_a_text_import;
