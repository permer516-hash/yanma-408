-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 3: 数据链路层 (3.5 continuation Q15-Q21 + 3.6 局域网 Q1-Q23).
-- Text-only batch: 30 pure-text questions (7 from 3.5, 23 from 3.6).
-- Deferred: 3.6 Q31 (802.11 MAC frame with address diagram).
-- Batch: CN-2027-ORIGINAL-CH3-C-TEXT-ONLY

-- ============================================================
-- Ensure knowledge points exist
-- ============================================================
-- CN_MEDIA_ACCESS already exists from V130 (used by 3.5)

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000131301',
    c.id,
    'CN_LAN',
    '局域网',
    6
FROM chapters c
WHERE c.code = 'CN_DATA_LINK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_LAN');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch3_c_text_import (
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

INSERT INTO cn_2027_original_ch3_c_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 3.5 介质访问控制 Q15-Q21 (7 questions, continuation from V130)
-- Q15-Q19: 模拟题 (MOCK 2027)
-- Q20-Q21: 统考真题 (PAST_EXAM 2013/2014)
-- ============================================================

(1, '00000000-0000-0000-0000-000000131001', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'在令牌环网络中，当网络空闲时，环路中（ ）。',
'A',
'在令牌环网络中，当网络空闲时，环路中只有令牌帧在循环传递。当某个站点要发送数据时，必须等待令牌到达，然后修改令牌中的标志位，并附加数据，将令牌变成一个数据帧。',
'只有令牌帧在循环传递', '只有数据帧在循环传递', '令牌帧和数据帧都在循环传递', '令牌帧和数据帧都不在循环传递'),

(2, '00000000-0000-0000-0000-000000131002', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'在令牌环网络中，当一个站点收到自己发出去的数据帧后，它将（ ）。',
'A',
'在令牌环网络中，一个站点收到自己发出去的数据帧后，不再转发该帧，而重新产生一个令牌，然后将该令牌发送给下一个站点。这样可以回收数据帧，避免环路上的冗余，并释放传输权限。',
'不再转发该帧，并重新产生一个令牌', '不再转发该帧，并等待下一个令牌', '继续转发该帧，并重新产生一个令牌', '继续转发该帧，并等待下一个令牌'),

(3, '00000000-0000-0000-0000-000000131003', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'在令牌环网络中，当所有站点都有数据帧要发送时，一个站点在最坏情况下等待获得令牌和发送数据帧的时间等于（ ）。',
'B',
'令牌环网络在逻辑上采用环状控制结构。因为令牌总沿逻辑环单向逐站传送，所以节点总可在确定的时间内获得令牌并发送数据。在最坏情况下，即在所有节点都要发送数据的情况下，一个节点获得令牌的等待时间等于逻辑环上所有其他节点依次获得令牌，并在令牌持有时间内发送数据的时间之和。',
'所有站点传送令牌的时间总和', '所有站点传送令牌和发送帧的时间总和', '所有站点传送令牌的时间总和的一半', '所有站点传送令牌和发送帧的时间总和的一半'),

(4, '00000000-0000-0000-0000-000000131004', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'MEDIUM', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'一条广播信道上连有4个站点a、b、c、d，采用码分复用技术，当a、b、c要向d发送数据时，设a的码片序列为(1, -1, 1, -1)，则b和c的码片序列可以为（ ）。',
'C',
'要实现码分复用，a、b、c三个站点的码片序列必须满足正交性，即两两之间的规格化内积等于0。分别计算各选项与(1, -1, 1, -1)两两之间的规格化内积，只有选项C满足要求：b=(-1, 1, 1, -1)与a的内积为-1-1+1+1=0，c=(1, 1, -1, -1)与a的内积为1+1-1+1=2...经重新计算，c与a内积为1-1-1+1=0，b与c的内积为-1+1-1+1=0，三者两两正交。',
'(-1, 1, 1, 1)和(-1, -1, -1, 1)', '(-1, -1, 1, 1)和(-1, 1, -1, 1)', '(-1, 1, 1, -1)和(1, 1, -1, -1)', '(-1, -1, -1, -1)和(1, 1, 1, 1)'),

(5, '00000000-0000-0000-0000-000000131005', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'MEDIUM', 'MOCK', 2027, '3.5介质访问控制', 'pp.96-97,98',
'站A、B、C、D通过CDMA共享链路，A、B、C要向D发送数据，A、B、C的码片序列分别是(+1, -1, -1, +1)、(-1, +1, -1, +1)和(+1, +1, +1, +1)。若D从链路上收到的序列是(3, -1, 1, 1)，则A、B、C发送的数据分别是（ ）。',
'A',
'分别计算接收序列与各站点码片序列的规格化内积。对于A站：(3×1+(-1)×(-1)+1×(-1)+1×1)/4=(3+1-1+1)/4=1，A发送的数据为1。对于B站：(3×(-1)+(-1)×1+1×(-1)+1×1)/4=(-3-1-1+1)/4=-1，B发送的数据为0。对于C站：(3×1+(-1)×1+1×1+1×1)/4=(3-1+1+1)/4=1，C发送的数据为1。因此A、B、C发送的数据分别是1、0、1。',
'1, 0, 1', '0, 0, 1', '1, 0, 0', '0, 1, 0'),

(6, '00000000-0000-0000-0000-000000131006', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'PAST_EXAM', 2013, '3.5介质访问控制', 'pp.97,99',
'【2013统考真题】下列介质访问控制方法中，可能发生冲突的是（ ）。',
'B',
'CSMA（载波监听多路访问）属于随机访问介质访问控制方法，各站点通过争用方式获得信道使用权，因此可能发生冲突。CDMA（码分多址）、TDMA（时分多址）和FDMA（频分多址）都属于信道划分介质访问控制方法，各站点被分配独立的码片序列、时隙或频率，不会发生冲突。',
'CDMA', 'CSMA', 'TDMA', 'FDMA'),

(7, '00000000-0000-0000-0000-000000131007', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'MEDIUM', 'PAST_EXAM', 2014, '3.5介质访问控制', 'pp.97,99',
'【2014统考真题】站A、B、C通过CDMA共享链路，A、B、C的码片序列分别是(1, 1, 1, 1)、(1, -1, 1, -1)和(1, 1, -1, -1)。若C从链路上收到的序列是(2, 0, 2, 0, 0, -2, 0, -2, 0, 2, 0, 2)，则C收到A发送的数据是（ ）。',
'B',
'收到的序列有12个元素，对应3个比特（每个比特用4位码片表示）。将序列按4位一组分为三组：(2,0,2,0)、(0,-2,0,-2)、(0,2,0,2)。用A的码片序列(1,1,1,1)分别与每组计算规格化内积：第一组(2×1+0×1+2×1+0×1)/4=1，对应比特1；第二组(0×1+(-2)×1+0×1+(-2)×1)/4=-1，对应比特0；第三组(0×1+2×1+0×1+2×1)/4=1，对应比特1。因此C收到A发送的数据是101。',
'000', '101', '110', '111'),

-- ============================================================
-- 3.6 局域网 Q1-Q23 (23 questions)
-- Q1-Q23: 模拟题 (MOCK 2027)
-- NOTE: 3.6 Q31 (802.11 MAC frame with address diagram) deferred
-- ============================================================

(8, '00000000-0000-0000-0000-000000131008', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.112,118',
'下列以太网中，采用双绞线作为传输介质的是（ ）。',
'C',
'这里Base前面的数字代表数据率，单位为Mb/s；Base指介质上的信号为基带信号（基带传输，采用曼彻斯特编码）；后面的5或2表示每段电缆的最长长度为500m或200m（实际上为185m），T表示双绞线，F表示光纤。10Base-2和10Base-5使用同轴电缆，10Base-F使用光纤。',
'10Base-2', '10Base-5', '10Base-T', '10Base-F'),

(9, '00000000-0000-0000-0000-000000131009', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.112,118',
'10Base-T以太网采用的传输介质是（ ）。',
'A',
'局域网通常采用类似10Base-T的方式来表示，其中第1部分的数字表示数据传输速率，如10表示10Mb/s、100表示100Mb/s；第2部分的Base表示基带传输；第3部分若是字母，则表示传输介质，如T表示双绞线、F表示光纤；若是数字，则表示所支持的最大传输距离。',
'双绞线', '同轴电缆', '光纤', '微波'),

(10, '00000000-0000-0000-0000-000000131010', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.112,118',
'就交换技术而言，以太网采用的是（ ）。',
'A',
'在以太网中，数据以帧的形式传输。源端用户的较长报文需要分为若干数据块，这些数据块在各层中还要加上相应的控制信息，在网络层中是分组，在数据链路层中是以太网的帧。以太网采用分组交换技术，以存储转发方式传输数据帧。',
'分组交换技术', '电路交换技术', '报文交换技术', '混合交换技术'),

(11, '00000000-0000-0000-0000-000000131011', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.112,118',
'网卡实现的主要功能在（ ）。',
'A',
'通常情况下，网卡是用来实现以太网协议的，网卡不仅能实现与局域网传输介质之间的物理连接和电信号匹配，还涉及帧的发送与接收、帧的封装与拆封、介质访问控制、数据的编码与解码及数据缓存等功能，因此实现的功能主要在物理层和数据链路层。',
'物理层和数据链路层', '数据链路层和网络层', '物理层和网络层', '数据链路层和应用层'),

(12, '00000000-0000-0000-0000-000000131012', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.112,118',
'每个以太网卡都有自己的时钟，每个网卡在互相通信时为了知道什么时候一位结束、下一位开始，即具有同样的频率，它们采用了（ ）。',
'B',
'10Base-T以太网使用曼彻斯特编码。曼彻斯特编码提取每个比特中间的电平跳变作为收发双方的同步信号，不需要额外的同步信号，是一种"自含时钟编码"的编码方式。通过曼彻斯特编码，接收方可以从接收到的信号中提取时钟信息，从而与发送方保持同步。',
'量化机制', '曼彻斯特机制', '奇偶检验机制', '定时令牌机制'),

(13, '00000000-0000-0000-0000-000000131013', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.112,118',
'以下关于以太网地址的描述，错误的是（ ）。',
'C',
'域名解析（DNS）用于将主机名解析成对应的IP地址，它不涉及MAC地址。实际上，MAC地址通常是通过ARP（地址解析协议）查得的。以太网地址就是通常所说的MAC地址，也称局域网硬件地址，通常存储在网卡中。',
'以太网地址就是通常所说的MAC地址', 'MAC地址也称局域网硬件地址', 'MAC地址是通过域名解析查得的', '以太网地址通常存储在网卡中'),

(14, '00000000-0000-0000-0000-000000131014', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.112-113,118',
'下列关于用光纤连接的以太网和用双绞线连接的以太网的说法中，错误的是（ ）。',
'D',
'用集线器连接的以太网一定工作在半双工状态，用交换机连接的以太网既可以工作在半双工状态，又可以工作在全双工状态，选项A、B正确。光纤主要是为了扩大以太网的覆盖范围，用于支持点对点通信（中继设备之间的传输），通常不会直接连接终端设备，选项C正确。一根光纤线内部至少包含两条光纤，用以实现全双工通信，因此用光纤连接的以太网不采用CSMA/CD协议，选项D错误。',
'用集线器连接的双绞线以太网一定工作在半双工状态', '用交换机连接的双绞线以太网可以工作在全双工状态', '光纤以太网主要用于支持点对点通信，目的是扩大以太网的覆盖范围', '光纤以太网也可以选用CSMA/CD协议'),

(15, '00000000-0000-0000-0000-000000131015', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.113,118',
'一个长度为40B的IP数据报需要封装成802.1Q帧进行传输，则此802.1Q帧的数据载荷部分需要填充的字节数是（ ）。',
'A',
'以太网MAC帧的最小帧长为64B，数据字段的长度至少为46B，但802.1Q帧会额外插入4B的VLAN标签，所以802.1Q帧的数据字段的长度至少为42B。IP数据报长度为40B，小于42B，因此需要额外填充2字节。',
'2', '4', '6', '8'),

(16, '00000000-0000-0000-0000-000000131016', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.113,118',
'在以太网中，若网卡发现某个帧的目的MAC地址不是自己的，则（ ）。',
'C',
'当网卡收到一个帧时，首先检查该帧的目的MAC地址是否与当前网卡的物理地址相同，若相同，则做下一步处理；若不同，则直接丢弃，并不需要向网络层报告错误消息。以太网提供的是不可靠的尽力交付服务。',
'它将该帧递交给网络层，由网络层决定如何处理', '它将丢弃该帧，并向网络层报告错误消息', '它将丢弃该帧，不向网络层报告错误消息', '它将向发送主机发回一个NAK帧'),

(17, '00000000-0000-0000-0000-000000131017', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.113,119',
'在CSMA/CD以太网中，站点（ ）进行全双工通信，（ ）进行半双工通信。',
'C',
'CSMA/CD协议是一种用于解决共享介质上的冲突问题的方法，它在半双工通信中使用，而在全双工通信中无须用到CSMA/CD协议。因此站点可以进行半双工通信，不可以进行全双工通信。',
'可以，不可以', '可以，可以', '不可以，可以', '不可以，不可以'),

(18, '00000000-0000-0000-0000-000000131018', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.113,119',
'在CSMA/CD协议的定义中，"争用期"指的是（ ）。',
'A',
'CSMA/CD协议中定义的争用期是指信号在最远两个端点之间往返传输的时间。争用期又称为冲突窗口，只有在争用期内检测到冲突，才能确保发送方能够感知到冲突的发生。',
'信号在最远两个端点之间往返传输的时间', '信号从线路一端传输到另一端的时间', '从发送开始到收到应答的时间', '从发送完毕到收到应答的时间'),

(19, '00000000-0000-0000-0000-000000131019', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.113,119',
'在CSMA/CD协议中，若不对帧的长度加以限制，当一个站在发送完毕之前没有检测到冲突，则该站所发送的帧（ ）和其他站发送的帧发生冲突。',
'B',
'即使一个站在发送完帧之前没有检测到冲突，也不能肯定该站所发送的帧不会和其他站发送的帧发生冲突。因为存在这样的可能，当一个站发送完后，另一个站刚好开始发送，而两个站之间的往返传播时延大于帧的发送时间，使得第一个站无法及时检测到冲突。',
'肯定不会', '可能会', '肯定会', '无法判断'),

(20, '00000000-0000-0000-0000-000000131020', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.113,119',
'在以太网中，当数据传输速率提高时，帧的发送时间相应地缩短，这样可能会影响到冲突的检测。为了能有效地检测冲突，可以使用的解决方案有（ ）。',
'B',
'CSMA/CD协议要求：发送帧的时间大于等于争用期的时间（信号在最远两个端点之间往返传输的时间）。因此，当数据传输速率提高时，发送帧的时间就缩短，此时可通过增加最短帧长来增加发送帧的时间，或缩短电缆的长度来减少争用期的时间，以便仍然满足"发送帧的时间>=争用期的时间"这个要求。',
'减少电缆介质的长度或减少最短帧长', '减少电缆介质的长度或增加最短帧长', '增加电缆介质的长度或减少最短帧长', '增加电缆介质的长度或增加最短帧长'),

(21, '00000000-0000-0000-0000-000000131021', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.113,119',
'长度为10km、数据传输速率为10Mb/s的CSMA/CD以太网，信号传播速率为200m/μs。那么该网络的最小帧长为（ ）。',
'D',
'来回路程=10000×2m，RTT=10000×2÷(200×10^6)=10^(-4)s，最小帧长=RTT×数据传输速率=10^(-4)×10×10^6=1000bit。',
'20bit', '200bit', '100bit', '1000bit'),

(22, '00000000-0000-0000-0000-000000131022', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.113,119',
'以太网中若发生信道访问冲突，则按照二进制指数退避算法决定下一次重发的时间。使用二进制指数退避算法的理由是（ ）。',
'C',
'以太网采用CSMA/CD协议技术，网络上的流量越大、负载越多时，发生冲突的概率也越大。二进制指数退避算法可以动态地适应发送站点的数量，后退时延的取值范围与重发次数形成二进制指数关系。当网络负载小时，后退时延的取值范围也小；当网络负载大时，后退时延的取值范围也随着增大。二进制指数退避算法的优点是它将后退时延的平均取值与负载的大小联系起来了。',
'这种算法简单', '这种算法执行速度快', '这种算法考虑了网络负载对冲突的影响', '这种算法与网络的规模大小无关'),

(23, '00000000-0000-0000-0000-000000131023', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.113-114,119',
'以太网中采用二进制指数退避算法处理冲突问题。下列数据帧重传时再次发生冲突的概率最低的是（ ）。',
'D',
'根据IEEE 802.3标准的规定，以太网采用二进制指数退避算法处理冲突问题。K越大（冲突发生次数越多），随机选择的退避时间范围越大（0至2^min(K,10)-1），与其他站点发生冲突的概率越低。因此发生四次重传的帧再次发生冲突的概率最低。',
'首次重传的帧', '发生两次冲突的帧', '发生三次重传的帧', '发生四次重传的帧'),

(24, '00000000-0000-0000-0000-000000131024', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.114,119',
'若100Mb/s以太网使用CSMA/CD协议，该以太网中的某个站在发送帧时检测到冲突，并准备进行第二次重传，则所需等待的最大退避时间是（ ）。',
'B',
'与10Mb/s以太网相同，100Mb/s以太网的争用期仍是512bit的发送时间，即512b÷100Mb/s=5.12μs。根据CSMA/CD协议的退避算法，第K次重传需要退避的时间为：从整数集合{0,1,...,2^K-1}中随机取出一个数r，退避时间就是r倍的争用期。本题中K=2（第二次重传），最大r=2^2-1=3，最大退避时间为3×5.12μs=15.36μs。',
'5.12μs', '15.36μs', '25.6μs', '51.2μs'),

(25, '00000000-0000-0000-0000-000000131025', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.114,119',
'在以太网的二进制指数退避算法中，在11次冲突之后，站点会在0～（ ）之间选择一个随机数。',
'C',
'一般来说，在第i（i<10）次冲突后，站点会在0到2^i-1之间随机选择一个数M，然后等待M倍的争用期再发送数据。达到10次冲突后，随机数的区间固定在最大值1023上，以后不再增加。若连续超过16次冲突，则丢弃相应的数据帧。因此11次冲突后，随机数区间为0～1023。',
'255', '511', '1023', '2047'),

(26, '00000000-0000-0000-0000-000000131026', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.114,119-120',
'根据CSMA/CD协议的工作原理，需要提高最短帧长的是（ ）。',
'B',
'CSMA/CD协议要求：发送帧的时间大于等于争用期的时间。最短帧长=数据传输速率×争用期。对于选项A，最大距离变短会使争用期变短，最短帧长变短。对于选项B，数据传输速率提高，最短帧长变长。选项C对最短帧长没有影响。对于选项D，在冲突域不变的情况下减少线路中的中继器数量会降低传播时延，争用期变短，最短帧长变短。',
'网络传输速率不变，冲突域的最大距离变短', '冲突域的最大距离不变，网络传输速率提高', '上层协议使用TCP的概率增加', '在冲突域不变的情况下减少线路中的中继器数量'),

(27, '00000000-0000-0000-0000-000000131027', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.114,120',
'在一个CSMA/CD局域网中，使用一个Hub连接所有站点，且限定站点到Hub的最长距离为100m，信号的传播速率为200000km/s，则站点的最长冲突检测时间是（ ）。',
'A',
'限定站点到集线器（Hub）的最长距离为100m，则两个站点之间的最长距离为200m，最长冲突检测时间等于信号在两个最远站点之间的往返传输时间，即2×200m÷200000km/s=2μs。',
'2μs', '2ms', '1μs', '1ms'),

(28, '00000000-0000-0000-0000-000000131028', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.114,120',
'IEEE 802.3标准规定，若采用同轴电缆作为传输介质，在无中继的情况下，传输介质的最大长度不能超过（ ）。',
'A',
'以太网常用的传输介质有4种：粗缆、细缆、双绞线和光纤。10Base-5为粗缆以太网，数据率为10Mb/s，每段电缆最大长度为500m，使用特殊的收发器连接到电缆上。10Base-2为细缆以太网，数据率为10Mb/s，每段电缆最大长度为185m。',
'500m', '200m', '100m', '50m'),

(29, '00000000-0000-0000-0000-000000131029', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.114,120',
'下列几种以太网中，只能工作在全双工模式下的是（ ）。',
'D',
'10Base-T以太网、100Base-T以太网、吉比特以太网都使用CSMA/CD协议，因此可以工作在半双工模式。10吉比特以太网只工作在全双工方式，没有争用问题，也不使用CSMA/CD协议，使用光纤或双绞线作为传输介质。',
'10Base-T以太网', '100Base-T以太网', '吉比特以太网', '10吉比特以太网'),

(30, '00000000-0000-0000-0000-000000131030', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.114,120',
'IEEE 802局域网标准对应OSI参考模型的（ ）。',
'B',
'IEEE 802为局域网制定的标准相当于OSI参考模型的数据链路层和物理层，其中的数据链路层又被进一步分为逻辑链路控制（LLC）和介质访问控制（MAC）两个子层。',
'数据链路层和网络层', '物理层和数据链路层', '物理层', '数据链路层');

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
    '原题来自《2027年计算机网络考研复习指导》第3章 数据链路层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共30道纯文本单选题，含2道统考真题（2013/2014）。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch3_c_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000131', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch3_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000131', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch3_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000131', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch3_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000131', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch3_c_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch3_c_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000131901', 'CN-2027-ORIGINAL-CH3-C-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000131902', '3.5介质访问控制'),
    ('00000000-0000-0000-0000-000000131903', '3.6局域网')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

-- Batch tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_c_text_import q
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH3-C-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id
);

-- Section tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_c_text_import q
JOIN question_tags tag ON tag.name = '3.5介质访问控制'
WHERE q.section_tag = '3.5介质访问控制'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_c_text_import q
JOIN question_tags tag ON tag.name = '3.6局域网'
WHERE q.section_tag = '3.6局域网'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- Standard tags (ensure they exist first)
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000000031', '2027计算机网络'),
    ('00000000-0000-0000-0000-000000000089', '无图片题目'),
    ('00000000-0000-0000-0000-000000000090', '授权原题'),
    ('00000000-0000-0000-0000-000000000091', '本节试题精选'),
    ('00000000-0000-0000-0000-000000000092', '原答案解析'),
    ('00000000-0000-0000-0000-000000000093', '选择题扩容'),
    ('00000000-0000-0000-0000-000000000094', '真题')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_c_text_import q
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容')
WHERE NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- PAST_EXAM questions get 真题 tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_c_text_import q
JOIN question_tags tag ON tag.name = '真题'
WHERE q.source_type = 'PAST_EXAM'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- ============================================================
-- Cleanup
-- ============================================================
DROP TABLE cn_2027_original_ch3_c_text_import;
