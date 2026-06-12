-- Authorized original operating-system single-choice import based on:
-- /Users/permer/Documents/408资料/2027操作系统-高清带书签.pdf
-- Chapter 5.1 finish (Q24-Q26) and Chapter 5.2 start (Q1-Q27), pure text only.
-- Batch: OS-2027-ORIGINAL-CH5-A-B-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT '00000000-0000-0000-0000-000000106301', c.id, 'OS_IO_DEVICE_INDEPENDENCE', '设备独立性软件与缓冲技术', 3
FROM chapters c
WHERE c.code = 'OS_IO'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'OS_IO_DEVICE_INDEPENDENCE');

CREATE TABLE os_2027_original_ch5_a_finish_ch5_b_text_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    chapter_tag VARCHAR(64) NOT NULL,
    section_tag VARCHAR(64) NOT NULL,
    original_no INTEGER NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO os_2027_original_ch5_a_finish_ch5_b_text_import (
    num, id, chapter_code, chapter_tag, section_tag, original_no, kp_code, difficulty, source_type, source_year, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000106001', 'OS_IO', '第5章输入/输出管理', '5.1I/O管理概述', 24, 'OS_IO_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2011, 'pp.316,319',
'【2011 统考真题】用户程序发出磁盘 I/O 请求后，系统的正确处理流程是（ ）。', 'B',
'I/O 软件一般从上到下分为 4 个层次：用户层、与设备无关的软件层、设备驱动程序及中断处理程序。用户程序发起系统调用，操作系统内核接到调用请求后，由系统调用处理程序处理，再转到相应设备驱动程序；当设备准备好或数据到达后，设备硬件发出中断，将数据按上述调用顺序逆向回传到用户程序中。', '用户程序→系统调用处理程序→中断处理程序→设备驱动程序', '用户程序→系统调用处理程序→设备驱动程序→中断处理程序', '用户程序→设备驱动程序→系统调用处理程序→中断处理程序', '用户程序→设备驱动程序→中断处理程序→系统调用处理程序'),
(2, '00000000-0000-0000-0000-000000106002', 'OS_IO', '第5章输入/输出管理', '5.1I/O管理概述', 25, 'OS_IO_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2012, 'pp.316-317,319',
'【2012 统考真题】操作系统的 I/O 子系统通常由 4 个层次组成，每层明确定义了与邻近层次的接口，其合理的层次组织排列顺序是（ ）。', 'A',
'设备管理软件一般分为 4 个层次：用户层、与设备无关的系统调用处理层、设备驱动程序及中断处理程序。即用户级 I/O 软件、设备无关软件、设备驱动程序、中断处理程序，从上到下依次排列。', '用户级 I/O 软件、设备无关软件、设备驱动程序、中断处理程序', '用户级 I/O 软件、设备无关软件、中断处理程序、设备驱动程序', '用户级 I/O 软件、设备驱动程序、设备无关软件、中断处理程序', '用户级 I/O 软件、中断处理程序、设备无关软件、设备驱动程序'),
(3, '00000000-0000-0000-0000-000000106003', 'OS_IO', '第5章输入/输出管理', '5.1I/O管理概述', 26, 'OS_IO_OVERVIEW', 'MEDIUM', 'PAST_EXAM', 2017, 'pp.317,319',
'【2017 统考真题】系统将数据从磁盘读到内存的过程包括以下操作：
① DMA 控制器发出中断请求
② 初始化 DMA 控制器并启动磁盘
③ 从磁盘传输一块数据到内存缓冲区
④ 执行"DMA 结束"中断服务程序
正确的执行顺序是（ ）。', 'B',
'DMA 的传送过程分为预处理、数据传送和后处理三个阶段。在预处理阶段，由 CPU 初始化 DMA 控制器中的有关寄存器、设置传送方向、测试并启动设备等（②）。在数据传送阶段，完全由 DMA 控制，DMA 控制器接管系统总线（③）。在后处理阶段，DMA 控制器向 CPU 发送中断请求（①），CPU 执行中断服务程序做 DMA 结束处理（④）。因此正确的执行顺序是 ②→③→①→④。', '③→①→②→④', '②→③→①→④', '②→①→③→④', '①→②→④→③'),
(4, '00000000-0000-0000-0000-000000106004', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 1, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.329,334',
'设备的独立性是指（ ）。', 'C',
'设备独立性是指用户编程时使用的设备与实际使用的设备无关，即应用程序使用逻辑设备名进行 I/O 操作，而无须指定具体的物理设备。', '设备独立于计算机系统', '系统对设备的管理是独立的', '用户编程时使用的设备与实际使用的设备无关', '每台设备都有唯一的编号'),
(5, '00000000-0000-0000-0000-000000106005', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 2, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.329,334',
'引入高速缓冲的主要目的是（ ）。', 'C',
'CPU 与 I/O 设备执行速度通常是不对等的，前者快、后者慢，通过高速缓冲技术来改善两者不匹配的问题。', '提高 CPU 的利用率', '提高 I/O 设备的利用率', '改善 CPU 与 I/O 设备速度不匹配的问题', '节省内存'),
(6, '00000000-0000-0000-0000-000000106006', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 3, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.329,334',
'为了使多个并发进程能有效地进行输入和输出，最好采用（ ）结构的缓冲技术。', 'A',
'缓冲池是系统的共用资源，可供多个进程共享，并且既能用于输入又能用于输出。其一般包含三种类型的缓冲：空闲缓冲区、装满输入数据的缓冲区、装满输出数据的缓冲区。选项 B、C、D 属专用缓冲，不能很好地适应多进程并发输入输出。', '缓冲池', '循环缓冲', '单缓冲', '双缓冲'),
(7, '00000000-0000-0000-0000-000000106007', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 4, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.329-330,334-335',
'缓冲技术中的缓冲池在（ ）中。', 'A',
'输入井和输出井是在磁盘上开辟的存储空间，而输入/输出缓冲区是在内存中开辟的，因为 CPU 速度比 I/O 设备高很多，缓冲池通常在主存中建立。', '主存', '外存', 'ROM', '寄存器'),
(8, '00000000-0000-0000-0000-000000106008', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 5, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330,335',
'支持双向传送的设备应使用（ ）。', 'B',
'支持双向发送和接收数据的设备（如网卡等）应使用双缓冲区，双缓冲区可以实现同一时刻的双向数据传输，提高设备的效率和利用率。单缓冲区只能实现单向数据传输。多缓冲区和缓冲池用于提高 I/O 性能，但不是必需的，也不一定适合所有的双向设备。', '单缓冲区', '双缓冲区', '多缓冲区', '缓冲池'),
(9, '00000000-0000-0000-0000-000000106009', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 6, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330,335',
'下列关于缓冲区的描述中，正确的是（ ）。', 'B',
'缓冲区是一个存储区域，可由专门的硬件寄存器组成，也可利用内存来实现。缓冲区的作用是提高 CPU 和 I/O 设备之间的速度匹配，因为 CPU 的速度远高于 I/O 设备的速度，若没有缓冲区，CPU 就要等待 I/O 设备完成操作，造成资源浪费。缓冲区可用于输入设备和输出设备，如键盘、打印机等。缓冲区也可用于块设备和字符设备，如磁盘、串口等。', '缓冲区是一种专门的硬件缓冲器，不能用内存来实现', '缓冲区的作用是提高 CPU 和 I/O 设备之间的速度匹配', '缓冲区只能用于输入设备，不能用于输出设备', '缓冲区只能用于块设备，不能用于字符设备'),
(10, '00000000-0000-0000-0000-000000106010', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 7, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330,335',
'使用单缓冲或双缓冲进行通信时，（ ）可以实现数据的双向并行传输。', 'B',
'两个进程之间若只设置单缓冲区，则同一时刻只能实现单向传输，但可在一段时间内用于发送数据，另一段时间内用于接收数据。若设置双缓冲区，则可以实现双向同时的并行传输。', '只有单缓冲', '只有双缓冲', '都', '都不'),
(11, '00000000-0000-0000-0000-000000106011', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 8, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330,335',
'下列各种算法中，（ ）是设备分配常用的一种算法。', 'D',
'选项 A 和 C 都是动态分区分配的常用算法，选项 B 是进程调度的常用算法，设备分配的常用算法主要有先来先服务算法和最高优先级优先算法。', '首次适应', '时间片分配', '最佳适应', '先来先服务'),
(12, '00000000-0000-0000-0000-000000106012', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 9, 'OS_IO_DEVICE_INDEPENDENCE', 'MEDIUM', 'MOCK', 2027, 'pp.330,335',
'设从磁盘将一块数据传送到缓冲区所用的时间为 80μs，将缓冲区中的数据传送到用户区所用的时间为 40μs，CPU 处理一个数据块所用的时间为 30μs。若有多块数据需要处理，并采用单缓冲区传送磁盘数据，则处理一块数据所用的总时间为（ ）。', 'A',
'采用单缓冲区传送数据时，设备与处理机对缓冲区的操作是串行的，当进行第 i 次读磁盘数据送至缓冲区时，系统再同时读出用户区中第 i-1 次数据进行计算，此两项操作可以并行，并与数据从缓冲区传送到用户区的操作串行进行，所以系统处理一块数据所用的总时间为 max(80μs, 30μs) + 40μs = 120μs。', '120μs', '110μs', '150μs', '70μs'),
(13, '00000000-0000-0000-0000-000000106013', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 10, 'OS_IO_DEVICE_INDEPENDENCE', 'MEDIUM', 'MOCK', 2027, 'pp.330,335-336',
'某操作系统采用双缓冲区传送磁盘上的数据。设从磁盘将数据传送到缓冲区所用的时间为 T1，将缓冲区中的数据传送到用户区所用的时间为 T2，CPU 处理一块数据所用的时间为 T3，假设一个磁盘块和一个缓冲区的大小相等，若系统在一段时间内连续处理一大批数据，则平均处理一个磁盘块数据的时间为（ ）。', 'D',
'计算处理一个磁盘块数据的平均时间，可以假定系统的初始状态：用户区为空，缓冲区 1 为满，缓冲区 2 为空。T2 时段，将缓冲区 1 中的数据送入用户区；T2+T3 时段，处理用户区中的数据；T1 时段，将数据从磁盘送入缓冲区 2。只有 T1 时间段与 T2+T3 时间段都完成后，系统才重新回到初始状态。因此平均处理一个磁盘块数据的时间为 max(T1, T2+T3)。', 'T1+T2+T3', 'max(T2,T3)+T1', 'max(T1,T3)+T2', 'max(T1,T2+T3)'),
(14, '00000000-0000-0000-0000-000000106014', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 11, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330,336',
'若 I/O 所花费的时间比 CPU 的处理时间短得多，则缓冲区（ ）。', 'B',
'缓冲区主要解决输入/输出速度比 CPU 处理的速度慢而造成数据积压的矛盾。所以当 I/O 花费的时间比 CPU 处理时间短很多时，缓冲区没有必要设置。', '最有效', '几乎无效', '均衡', '以上答案都不对'),
(15, '00000000-0000-0000-0000-000000106015', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 12, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330,336',
'缓冲区管理者重要考虑的问题是（ ）。', 'C',
'在缓冲机制中，无论是单缓冲、多缓冲还是缓冲池，因为缓冲区是一种临界资源，所以在使用缓冲区时都有一个申请和释放（互斥）的问题需要考虑，即实现进程访问缓冲区的同步。', '选择缓冲区的大小', '决定缓冲区的数量', '实现进程访问缓冲区的同步', '限制进程的数量'),
(16, '00000000-0000-0000-0000-000000106016', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 13, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330,336',
'考虑单用户计算机上的下列 I/O 操作，需要使用缓冲技术的是（ ）。
I. 图形用户界面下使用鼠标
II. 多任务操作系统下的磁盘驱动器（假设没有设备预分配）
III. 包含用户文件的磁盘驱动器
IV. 使用存储器映射 I/O，直接和总线相连的图形卡', 'D',
'在鼠标移动时，若有高优先级的操作产生，为了记录鼠标活动的情况，必须使用缓冲技术，说法 I 正确。由于磁盘驱动器和目标或源 I/O 设备间的吞吐量不同，必须采用缓冲技术，说法 II 正确。为了能使数据从用户作业空间传送到磁盘或从磁盘传送到用户作业空间，必须采用缓冲技术，说法 III 正确。为了便于多帧图形的存取及提高性能，缓冲技术是可以采用的，特别是在显示当前一帧图形又要得到下一帧图形时，应采用双缓冲技术，说法 IV 正确。', 'I、III', 'II、IV', 'II、III、IV', '全选'),
(17, '00000000-0000-0000-0000-000000106017', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 14, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.330-331,336',
'以下（ ）不属于设备管理数据结构。', 'A',
'DCT 是设备控制表；COCT 是控制器控制表；CHCT 是通道控制表。只有 PCB（进程控制块）不属于设备管理的数据结构，它属于进程管理。', 'PCB', 'DCT', 'COCT', 'CHCT'),
(18, '00000000-0000-0000-0000-000000106018', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 15, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,336',
'下列（ ）不是设备的分配方式。', 'D',
'设备的分配方式主要有独享分配、共享分配和虚拟分配，选项 D（分区分配）是内存的分配方式。', '独享分配', '共享分配', '虚拟分配', '分区分配'),
(19, '00000000-0000-0000-0000-000000106019', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 16, 'OS_IO_DEVICE_INDEPENDENCE', 'MEDIUM', 'MOCK', 2027, 'pp.331,336-337',
'设备分配程序需要访问一系列的数据结构来给进程分配设备，这些数据结构有：设备控制表（DCT）、控制器控制表（COCT）、通道控制表（CHCT）、系统设备表（SDT）。在设备分配的过程中，访问这些数据结构的正确顺序是（ ）。', 'A',
'在设备分配的过程中，访问数据结构的顺序通常是按设备管理的逻辑层次来安排的。设备分配过程通常从系统设备表（SDT）开始，然后依次获取设备控制表（DCT）、控制器控制表（COCT）和通道控制表（CHCT）中的信息，最终完成对设备的分配。', 'SDT，DCT，COCT，CHCT', 'DCT，COCT，CHCT，SDT', 'SDT，COCT，CHCT，DCT', 'COCT，CHCT，SDT，DCT'),
(20, '00000000-0000-0000-0000-000000106020', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 17, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337',
'下面设备中属于共享设备的是（ ）。', 'C',
'共享设备是指在一个时间间隔内可被多个进程同时访问的设备，只有磁盘满足。打印机在一个时间间隔内被多个进程访问时，打印出来的文档会乱；磁带机旋转到所需的读/写位置需要较长时间，若一个时间间隔内被多个进程访问，磁带机就只能一直旋转，没时间读/写。', '打印机', '磁带机', '磁盘', '磁带机和磁盘'),
(21, '00000000-0000-0000-0000-000000106021', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 18, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337',
'提高单机资源利用率的关键技术是（ ）。', 'D',
'在单机系统中，最关键的资源是处理器资源，最大化地提高处理器利用率，就是最大化地提高系统效率。多道程序设计技术是提高处理器利用率的关键技术，其他均为设备和内存的相关技术。', 'SPOOLing 技术', '虚拟技术', '交换技术', '多道程序设计技术'),
(22, '00000000-0000-0000-0000-000000106022', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 19, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337',
'虚拟设备是靠（ ）技术来实现的。', 'C',
'SPOOLing 技术是操作系统中采用的一种将独占设备改造为共享设备的技术。通过这种技术处理后的设备通常称为虚拟设备。', '通道', '缓冲', 'SPOOLing', '控制器'),
(23, '00000000-0000-0000-0000-000000106023', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 20, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337',
'SPOOLing 技术的主要目的是（ ）。', 'B',
'SPOOLing 技术将一台物理设备虚拟为多台逻辑设备，以减少设备的闲置时间，提高设备的并发度和吞吐量。因此 SPOOLing 技术的主要目的是提高独占设备的利用率。', '提高 CPU 和设备交换信息的速度', '提高独占设备的利用率', '减轻用户编程负担', '提供主、辅存接口'),
(24, '00000000-0000-0000-0000-000000106024', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 21, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337',
'在采用 SPOOLing 技术的系统中，用户的打印结果首先被送到（ ）。', 'A',
'输入井和输出井是在磁盘上开辟的两大存储空间。输入井模拟脱机输入时的磁盘，用于暂存 I/O 设备输入的数据；输出井模拟脱机输出时的磁盘，用于暂存用户程序的输出数据。用户的打印结果首先送到位于磁盘固定区域的输出井。', '磁盘固定区域', '内存固定区域', '终端', '打印机'),
(25, '00000000-0000-0000-0000-000000106025', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 22, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337',
'采用 SPOOLing 技术的计算机系统，外围计算机需要（ ）。', 'D',
'SPOOLing 技术需要使用磁盘空间（输入井和输出井）和内存空间（输入/输出缓冲区），不需要外围计算机的支持。SPOOLing 本身就是"假脱机"技术，用软件模拟脱机操作，因此外围计算机需要 0 台。', '一台', '多台', '至少一台', '0 台'),
(26, '00000000-0000-0000-0000-000000106026', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 23, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337',
'SPOOLing 系统由（ ）组成。', 'A',
'SPOOLing 系统主要包含三部分，即输入井和输出井、输入缓冲区和输出缓冲区以及输入进程和输出进程。这三部分由预输入程序、井管理程序和缓输出程序管理，以保证系统正常运行。', '预输入程序、井管理程序和缓输出程序', '预输入程序、井管理程序和井管理输出程序', '输入程序、井管理程序和输出程序', '预输入程序、井管理程序和输出程序'),
(27, '00000000-0000-0000-0000-000000106027', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 24, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,337-338',
'在 SPOOLing 系统中，用户进程实际分配到的是（ ）。', 'B',
'通过 SPOOLing 技术可将一台物理 I/O 设备虚拟为多台逻辑 I/O 设备，同样允许多个用户共享一台物理 I/O 设备。所以 SPOOLing 并不是将物理设备真的分配给用户进程，用户进程实际分配到的是外存区（即虚拟设备）。', '用户所要求的外设', '外存区，即虚拟设备', '设备的一部分存储区', '设备的一部分空间'),
(28, '00000000-0000-0000-0000-000000106028', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 25, 'OS_IO_DEVICE_INDEPENDENCE', 'MEDIUM', 'MOCK', 2027, 'pp.331,338',
'下面关于 SPOOLing 系统的说法中，正确的是（ ）。', 'D',
'构成 SPOOLing 系统的基本条件是不仅要有大容量、高速度的外存作为输入井和输出井，还要有 SPOOLing 软件，因此选项 A 错误、选项 B 不够全面。利用 SPOOLing 技术提高了系统和 I/O 设备的利用率，进程不必等待 I/O 操作的完成，因此选项 C 也不正确。SPOOLing 系统中的用户程序可以随时将输出数据送到输出井中，待输出设备空闲时再由 SPOOLing 系统完成数据的输出操作，因此选项 D 正确。', '构成 SPOOLing 系统的基本条件是有外围输入机与外围输出机', '构成 SPOOLing 系统的基本条件仅是要有高速的大容量硬盘作为输入井和输出井', '当输入设备忙时，SPOOLing 系统中的用户程序暂停执行，待 I/O 空闲时再被唤醒执行输出操作', 'SPOOLing 系统中的用户程序可以随时将输出数据送到输出井中，待输出设备空闲时再由 SPOOLing 系统完成数据的输出操作'),
(29, '00000000-0000-0000-0000-000000106029', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 26, 'OS_IO_DEVICE_INDEPENDENCE', 'MEDIUM', 'MOCK', 2027, 'pp.331,338',
'下面关于 SPOOLing 的叙述中，不正确的是（ ）。', 'A',
'SPOOLing 技术将独占设备虚拟成共享设备，因此必须先有独占设备才行，选项 A 的说法不正确。SPOOLing 技术使进程不需要等待打印机空闲，只需将输出数据送到输出井，然后继续执行其他操作，加快了作业执行速度；SPOOLing 技术将独占设备虚拟成共享设备、提高了独占设备的利用率，因此 B、C、D 均为正确叙述。', 'SPOOLing 系统中不需要独占设备', 'SPOOLing 系统加快了作业执行的速度', 'SPOOLing 系统使独占设备变成共享设备', 'SPOOLing 系统提高了独占设备的利用率'),
(30, '00000000-0000-0000-0000-000000106030', 'OS_IO', '第5章输入/输出管理', '5.2设备独立性软件', 27, 'OS_IO_DEVICE_INDEPENDENCE', 'BASIC', 'MOCK', 2027, 'pp.331,338',
'（ ）是操作系统中采用的以空间换取时间的技术。', 'A',
'SPOOLing 技术需有高速大容量且可随机存取的外存支持，通过预输入和缓输出来减少 CPU 等待慢速设备的时间，将独享设备改造成共享设备。这是一种典型的以空间（磁盘空间）换取时间（CPU 等待时间）的技术。', 'SPOOLing 技术', '虚拟存储技术', '覆盖与交换技术', '通道技术');

INSERT INTO questions (
    id, subject_id, chapter_id, type, difficulty, stem, answer, explanation,
    source, source_year, score, status, review_status, review_note, stem_format, stem_image_url,
    reviewed_at, created_at, updated_at
)
SELECT
    CAST(t.id AS UUID),
    s.id,
    c.id,
    'SINGLE_CHOICE',
    t.difficulty,
    t.stem,
    t.answer,
    t.explanation,
    CASE t.source_type WHEN 'PAST_EXAM' THEN 'PAST_EXAM' ELSE 'MOCK' END,
    t.source_year,
    2,
    'PUBLISHED',
    'APPROVED',
    CASE t.source_type
        WHEN 'PAST_EXAM' THEN CONCAT(t.source_type, ' ', t.source_year, ', ', t.chapter_tag, ' ', t.section_tag, ' 第', t.original_no, '题，原书', t.source_pages)
        ELSE CONCAT('MOCK基于本书习题改编, ', t.chapter_tag, ' ', t.section_tag, ' 第', t.original_no, '题，原书', t.source_pages)
    END,
    'PLAIN_TEXT',
    NULL,
    NOW(),
    NOW(),
    NOW()
FROM os_2027_original_ch5_a_finish_ch5_b_text_import t
JOIN subjects s ON s.code = 'OPERATING_SYSTEM'
JOIN chapters c ON c.code = t.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000206', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM os_2027_original_ch5_a_finish_ch5_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000206', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM os_2027_original_ch5_a_finish_ch5_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000206', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM os_2027_original_ch5_a_finish_ch5_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000206', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM os_2027_original_ch5_a_finish_ch5_b_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM os_2027_original_ch5_a_finish_ch5_b_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000106101', 'OS-2027-ORIGINAL-CH5-A-B-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000106102', '第5章输入/输出管理'),
    ('00000000-0000-0000-0000-000000106103', '5.1I/O管理概述'),
    ('00000000-0000-0000-0000-000000106104', '5.2设备独立性软件')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM os_2027_original_ch5_a_finish_ch5_b_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027操作系统',
    'OS-2027-ORIGINAL-CH5-A-B-TEXT-ONLY',
    q.chapter_tag,
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

DROP TABLE os_2027_original_ch5_a_finish_ch5_b_text_import;
