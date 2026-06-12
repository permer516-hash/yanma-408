-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 3: 数据链路层 (3.6 局域网 Q24-Q49 text-only subset + 3.7 广域网 Q1-Q8).
-- Text-only batch: 30 pure-text questions (22 from 3.6, 8 from 3.7).
-- Deferred from 3.6: Q31 (802.11 MAC address diagram), Q41 (2016 Hub topology), Q42 (2017 802.11 address diagram), Q46 (2020 CSMA/CA IFS timing diagram).
-- Batch: CN-2027-ORIGINAL-CH3-D-TEXT-ONLY

-- ============================================================
-- Ensure knowledge points exist
-- ============================================================
-- CN_LAN already exists from V131 (used by 3.6)

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000132301',
    c.id,
    'CN_WAN',
    '广域网',
    7
FROM chapters c
WHERE c.code = 'CN_DATA_LINK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_WAN');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch3_d_text_import (
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

INSERT INTO cn_2027_original_ch3_d_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 3.6 局域网 Q24-Q30 (7 pure-text questions, continuation from V131)
-- Q24-Q30: 模拟题 (MOCK 2027)
-- SKIPPED: Q31 (802.11 MAC frame with address diagram)
-- ============================================================

(1, '00000000-0000-0000-0000-000000132001', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.114,120',
'高速以太网使用的MAC帧格式与标准以太网的帧格式（ ）。',
'A',
'高速以太网的MAC帧格式与标准以太网的帧格式完全相同，以保证升级和向后兼容。无论是100Mb/s快速以太网、吉比特以太网还是10吉比特以太网，其MAC帧格式都保持不变。',
'完全相同', '完全不同', '部分相同', '不确定'),

(2, '00000000-0000-0000-0000-000000132002', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.114,120',
'下列关于吉比特以太网的说法中，错误的是（ ）。',
'B',
'吉比特以太网的物理层有两个标准：IEEE 802.3z和IEEE 802.3ab，前者采用光纤通道，后者采用4对UTP5类线。吉比特以太网并不只采用曼彻斯特编码——在光纤介质上采用8B/10B编码，在双绞线介质上采用PAM5编码。因此选项B错误。吉比特以太网支持流量控制、数据的传输时间主要受线路传输延迟的制约、同时支持全双工和半双工模式。',
'支持流量控制', '采用曼彻斯特编码，利用光纤进行数据传输', '数据的传输时间主要受线路传输延迟的制约', '同时支持全双工模式和半双工模式'),

(3, '00000000-0000-0000-0000-000000132003', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.114,120',
'无线局域网不使用CSMA/CD协议而使用CSMA/CA协议的原因是，无线局域网（ ）。',
'B',
'无线局域网不能简单地使用CSMA/CD协议，特别是冲突检测部分，原因如下：第一，在无线局域网的适配器上，接收信号的强度往往远小于发送信号的强度，因此要实现冲突检测，硬件费用就会过大；第二，在无线局域网中，并非所有站点都能听见对方，即存在隐蔽站和暴露站问题。而"所有站点都能听见对方"正是实现CSMA/CD协议的前提。选项A是CSMA/CD协议和CSMA/CA协议共同的特点，但不是无线局域网使用CSMA/CA协议的原因。',
'不能同时收发，无法在发送时接收信号', '难以实现冲突检测，存在隐蔽站和暴露站问题', '由于广播特性，不会出现冲突', '覆盖范围很小，不进行冲突检测，不影响正确性'),

(4, '00000000-0000-0000-0000-000000132004', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.114,121',
'下列关于CSMA/CA协议的叙述中，正确的是（ ）。',
'A',
'CSMA/CA协议只能尽量降低冲突发生的概率，在无线信道中冲突是无法完全避免的。检测到信道空闲后，CSMA/CA协议规定还必须等待DIFS的时间才能开始发送。无线信道中可能发生冲突，所以CSMA/CA协议也需要退避算法，但是和CSMA/CD协议的退避算法有一定的区别。接收方收到数据帧后需要向发送方返回确认帧，以保证可靠传输。',
'接收方收到数据帧后，需要向发送方返回确认帧', 'CA表示Collision Avoidance，即冲突避免，因而此类网络中不会出现冲突', '按照载波监听的工作原理，发送站点在检测到信道空闲后立即启动发送', 'CSMA/CA协议和CSMA/CD协议的区别之一是前者不需要使用退避算法'),

(5, '00000000-0000-0000-0000-000000132005', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.114,121',
'CSMA/CA协议的主要特点是（ ）。',
'D',
'在CSMA/CA协议中，发送方发送数据帧后等待接收方的确认帧，如果在规定时间内未收到确认帧，则重传该数据帧。CSMA/CA不会进行冲突检测（"边发送边检测"是CSMA/CD的特点），预约信道并不是CSMA/CA协议的强制规定（在普通模式下不进行信道预约），且检测到信道空闲后还必须等待DIFS时间才能发送数据。',
'发送前先检测信道，信道空闲就立即发送，信道忙就随机推迟发送', '边发送边检测信道，一旦发现冲突就立即停止发送', '发送前先预约信道，获得信道授权后再发送', '发送后等待确认帧，在规定时间内未收到确认帧就重传'),

(6, '00000000-0000-0000-0000-000000132006', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.114-115,121',
'在CSMA/CA协议中，有三种不同的时间参数：短帧间间隔SIFS、分布式协调帧间间隔DIFS和点协调帧间间隔PIFS。它们之间的长度关系是（ ）。',
'A',
'SIFS最短，网络中的控制帧和确认帧都采用SIFS作为发送之前的等待时延。DIFS最长，所有的数据帧都采用DIFS作为等待时延。PIFS中等，用于AP发送管理帧或探测帧的等待时延。因此SIFS < PIFS < DIFS。',
'SIFS < PIFS < DIFS', 'SIFS < DIFS < PIFS', 'PIFS < SIFS < DIFS', 'PIFS < DIFS < SIFS'),

(7, '00000000-0000-0000-0000-000000132007', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.115,121',
'在802.11协议中，MAC帧首部中的地址字段的含义和作用取决于（ ）。',
'C',
'802.11帧首部中的地址字段的含义和作用取决于帧的"去往DS"位和"来自DS"位（即To DS和From DS位）。这两个比特位构成四种组合，分别对应不同的通信场景（如站点到AP、AP到站点、AP到AP等），决定了地址1到地址4的含义。',
'帧的类型和子类型', '帧的源和目的站点', '帧的去往DS和来自DS位', '帧的BSSID和SSID位'),

-- ============================================================
-- 3.6 局域网 Q32-Q40 (9 pure-text questions)
-- Q32-Q36: 模拟题 (MOCK 2027) — VLAN相关
-- Q37-Q40: 统考真题 (PAST_EXAM 2009/2011/2012/2015)
-- SKIPPED: Q31 (figure), Q41 (2016 Hub figure), Q42 (2017 802.11 figure)
-- ============================================================

(8, '00000000-0000-0000-0000-000000132008', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.115,121',
'下列关于802.1Q帧的描述中，错误的是（ ）。',
'B',
'A和D是VLAN的规定：在原始以太网帧中加入一个4B的标签字段就构成了802.1Q帧；若同一个交换机下的同一个VLAN的两台主机通信，则不使用802.1Q帧。插入VLAN标签后，以太网的最大帧长变为1522字节（原最大帧长1518B + 4B VLAN标签），因此选项B错误。VLAN标签中有标识符字段VID，用于标志该帧属于哪个VLAN。',
'在原始的以太网帧中加入一个4B的标签字段，就构成802.1Q帧', '插入VLAN标签后，以太网的最大帧长也需要保持不变', 'VLAN标签中有标识符字段，称为VID，标志该帧属于哪个VLAN', '划分VLAN后，两台主机之间通信也不一定使用802.1Q帧'),

(9, '00000000-0000-0000-0000-000000132009', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.115,121',
'下列关于虚拟局域网（VLAN）的叙述中，错误的是（ ）。',
'B',
'802.1Q帧在以太网帧的基础上增加了4B的VLAN标签，因此最大长度也增加了4B，变为1522B。属于同一VLAN的主机无论是否连接到同一台交换机上，都能互相通信。而属于不同VLAN的主机即使连接到同一台交换机上，也不能直接在数据链路层进行通信——交换机使用VLAN标签来区分不同的VLAN。VLAN只是局域网为用户提供的一种逻辑服务，并不是一种新型局域网。',
'VLAN使用的802.1Q帧的最大长度为1522B', '属于不同VLAN的主机，若连在同一台交换机上，则可进行数据链路层的通信', 'VLAN是为局域网用户提供的一种服务，而不是一种新型的局域网', '同一个VLAN的主机可以处于不同的局域网中'),

(10, '00000000-0000-0000-0000-000000132010', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'MOCK', 2027, '3.6局域网', 'pp.115,121',
'下列关于虚拟局域网（VLAN）的说法中，错误的是（ ）。',
'B',
'VLAN建立在交换技术的基础上，以软件方式实现逻辑分组与管理，VLAN中的计算机不受物理位置的限制。当计算机从一个VLAN转移到另一个VLAN时，只需简单地通过软件设定，而无须改变它在网络中的物理位置。要进行跨VLAN的通信，必须通过上层的路由器解决，不同VLAN的主机处于不同的广播域，因此不能直接在数据链路层进行通信。',
'虚拟局域网建立在交换技术的基础上', '虚拟局域网通过硬件方式实现逻辑分组与管理', '虚拟网的划分与计算机的实际物理位置无关', '不同虚拟局域网的主机之间无法直接进行数据链路层的通信'),

(11, '00000000-0000-0000-0000-000000132011', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.115,121-122',
'划分虚拟局域网（VLAN）有多种方式，（ ）不是正确的划分方式。',
'C',
'一般有三种划分VLAN的方法：①基于交换机接口；②基于MAC地址（网卡地址）；③基于IP地址（网络层地址）。基于用户名不是VLAN的划分方式。',
'基于交换机接口划分', '基于网卡地址划分', '基于用户名划分', '基于网络层地址划分'),

(12, '00000000-0000-0000-0000-000000132012', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'MOCK', 2027, '3.6局域网', 'pp.115,122',
'下列选项中，（ ）不是虚拟局域网（VLAN）的优点。',
'C',
'"虚拟"两个字的基本上都有一个优点，即有效共享资源。通过虚拟局域网，可将一个较大的局域网分割成一些较小的与地理位置无关的逻辑上的虚拟局域网，而每个虚拟局域网都是一个较小的局域网，因此简化了网络管理，提高了信息的保密性和网络的安全性。链路聚合是解决交换机之间的宽带瓶颈问题的技术，而不是虚拟局域网的技术。',
'有效共享网络资源', '简化网络管理', '链路聚合', '提高网络安全性'),

(13, '00000000-0000-0000-0000-000000132013', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'PAST_EXAM', 2009, '3.6局域网', 'pp.115,122',
'【2009统考真题】在一个采用CSMA/CD协议的网络中，传输介质是一根完整的电缆，传输速率为1Gb/s，电缆中的信号传播速率是200000km/s。若最小数据帧长减少800比特，则最远的两个站点之间的距离至少需要（ ）。',
'D',
'有关最短帧长的题要抓住两个公式来分析：①发送帧的时间≥争用期的时间；②最短帧长=数据传输速率×争用期的时间。题中，最短帧长减少800比特，则发送帧的时间减少0.8μs，要使①和②依然成立，就需要至少将争用期（信号的往返时间）的时间减少0.8μs，所以往返传播的总距离至少需要减少200000km/s×0.8μs=160m，即单程距离至少需要减少80m。',
'增加160m', '增加80m', '减少160m', '减少80m'),

(14, '00000000-0000-0000-0000-000000132014', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'PAST_EXAM', 2011, '3.6局域网', 'pp.115,122',
'【2011统考真题】下列选项中，对正确接收到的数据帧进行确认的MAC协议是（ ）。',
'D',
'CSMA/CA协议是无线局域网标准802.11中的协议，它在CSMA协议的基础上增加了冲突避免的功能。ACK帧是CSMA/CA协议避免冲突的机制之一，也就是说，只有当发送方收到接收方发回的ACK帧时，才确认发出的数据帧已正确到达目的地。CSMA、CDMA和CSMA/CD均不需要对正确接收到的数据帧进行确认。',
'CSMA', 'CDMA', 'CSMA/CD', 'CSMA/CA'),

(15, '00000000-0000-0000-0000-000000132015', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'PAST_EXAM', 2012, '3.6局域网', 'pp.115,122',
'【2012统考真题】以太网的MAC协议提供的是（ ）。',
'A',
'考虑到局域网信道质量好，以太网采取了两项重要的措施来使通信更简单：①采用无连接的工作方式；②不对发送的数据帧进行编号，也不要求对方发回确认。因此，以太网提供的服务是不可靠的服务，即尽最大努力的交付。差错的纠正由高层完成。',
'无连接的不可靠服务', '无连接的可靠服务', '有连接的可靠服务', '有连接的不可靠服务'),

(16, '00000000-0000-0000-0000-000000132016', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'PAST_EXAM', 2015, '3.6局域网', 'pp.116,122',
'【2015统考真题】下列关于CSMA/CD协议的叙述中，错误的是（ ）。',
'B',
'CSMA/CD协议适用于有线网络，而CSMA/CA协议广泛应用于无线局域网。因此选项B错误。选项A、C关于CSMA/CD协议的描述都是正确的（边发送边检测、需要根据网络跨距和数据传输速率限定最小帧长）。对于选项D，因为在CSMA/CD协议中，信号传播时延会影响冲突检测的效率，若信号传播时延趋于零，则冲突检测就会非常及时，从而减少重传的时间和次数，提高信道利用率。',
'边发送数据帧，边检测是否发生冲突', '适用于无线网络，以实现无线链路共享', '需要根据网络跨距和数据传输速率限定最小帧长', '当信号传播延迟趋近0时，信道利用率趋近100%'),

-- ============================================================
-- 3.6 局域网 Q43-Q45, Q47-Q49 (6 pure-text questions)
-- Q43-Q45: PAST_EXAM 2018/2019/2019
-- Q47-Q49: PAST_EXAM 2023/2024/2025
-- SKIPPED: Q46 (2020 CSMA/CA IFS timing diagram)
-- ============================================================

(17, '00000000-0000-0000-0000-000000132017', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'PAST_EXAM', 2018, '3.6局域网', 'pp.116,122-123',
'【2018统考真题】IEEE 802.11无线局域网的MAC协议CSMA/CA进行信道预约的方法是（ ）。',
'D',
'当CSMA/CA协议进行信道预约时，主要使用的是请求发送RTS帧和清除发送CTS帧。当一台主机想要发送信息时，先向无线站点发送一个RTS帧，说明要传输的数据及相应的时间。无线站点收到RTS帧后，将广播一个CTS帧作为对此的响应，既给发送方发送许可，又指示其他主机不要在这个时间内发送数据，从而预约信道，避免冲突。发送确认帧的目的主要是保证信息的可靠传输。二进制指数退避算法是CSMA/CD协议中的一种冲突处理方法。',
'发送确认帧', '采用二进制指数退避', '使用多个MAC地址', '交换RTS与CTS帧'),

(18, '00000000-0000-0000-0000-000000132018', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'PAST_EXAM', 2019, '3.6局域网', 'pp.116,123',
'【2019统考真题】假设一个采用CSMA/CD协议的100Mb/s局域网，最小帧长是128B，则在一个冲突域内，两个站点之间的单向传播时延最多是（ ）。',
'B',
'有关最短帧长的题，要抓住两个公式来分析：①发送帧的时间≥争用期的时间；②最短帧长=数据传输速率×争用期时间。对于本题，数据传输速率为100Mb/s，最短帧长为128B，根据公式②可得争用期时间（往返时延）为128B÷100Mb/s=10.24×10^(-6)s=10.24μs，所以单向传播时延为5.12μs。',
'2.56μs', '5.12μs', '10.24μs', '20.48μs'),

(19, '00000000-0000-0000-0000-000000132019', 'CN_DATA_LINK', 'CN_LAN', 'BASIC', 'PAST_EXAM', 2019, '3.6局域网', 'pp.116,123',
'【2019统考真题】100Base-T快速以太网使用的导向传输介质是（ ）。',
'A',
'100Base-T是一种以速率100Mb/s工作的快速以太网标准，且使用UTP（非屏蔽双绞线）铜质电缆。100Base-T中：100标识传输速率为100Mb/s；Base标识采用基带传输；T表示传输介质为双绞线（包括5类UTP或1类STP），为F时表示光纤。',
'双绞线', '单模光纤', '多模光纤', '同轴电缆'),

(20, '00000000-0000-0000-0000-000000132020', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'PAST_EXAM', 2023, '3.6局域网', 'pp.117,123',
'【2023统考真题】已知10Base-T以太网的争用时间片为51.2μs。若网卡在发送某帧时发生了连续4次冲突，则基于二进制指数退避算法确定的再次尝试重发该帧前等待的最长时间是（ ）。',
'C',
'10Base-T以太网采用CSMA/CD协议，CSMA/CD协议采用截断二进制指数退避算法来确定冲突后重传的时机。从整数集合[0, 1, ..., 2^K-1]中随机取出一个数r，参数K=min[重传次数, 10]，站点重传所需等待的时间=r×争用期。连续4次冲突意味着第4次重传，K=4，r的取值范围为[0, 15]，等待的最长时间为(2^4-1)×51.2μs=15×51.2μs=768μs。',
'51.2μs', '204.8μs', '768μs', '819.2μs'),

(21, '00000000-0000-0000-0000-000000132021', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'PAST_EXAM', 2024, '3.6局域网', 'pp.117,123',
'【2024统考真题】在采用CSMA/CA协议的802.11无线局域网中，DIFS=128μs，SIFS=28μs，RTS帧、CTS帧和ACK帧的传输时延分别是5μs、2μs和2μs，忽略信号传播时延。若主机A向AP发送一个总长度为1998B的数据帧，无线链路带宽为54Mb/s，则隐蔽站B收到AP发送的CTS帧时，设置的网络分配向量NAV的值是（ ）。',
'B',
'数据帧的长度为1998B，链路带宽为54Mb/s，因此数据帧的发送时延为1998B÷54Mb/s=296μs。网络分配向量（NAV）指出了信道忙的持续时间，含义是正在通信的两个站点以外的站点都不能在这段时间内发送数据。当AP收到RTS帧后，广播一个CTS帧，将占用信道的持续时间(SIFS+DATA+SIFS+ACK)写入CTS帧的首部。因此隐蔽站B收到AP发送的CTS帧时，设置自己的NAV值为SIFS+DATA+SIFS+ACK=28μs+296μs+28μs+2μs=354μs。',
'326μs', '354μs', '385μs', '513μs'),

(22, '00000000-0000-0000-0000-000000132022', 'CN_DATA_LINK', 'CN_LAN', 'MEDIUM', 'PAST_EXAM', 2025, '3.6局域网', 'pp.117,123',
'【2025统考真题】在某个10Base-T以太网的冲突域内，若主机甲向主机乙发送数据帧时发生了连续11次冲突，则甲再次尝试发送该数据帧的最大间隔时间是（ ）。',
'C',
'以太网采用二进制指数退避算法：在前10次冲突（第1~10次重传）中，第i次冲突后在[0, 2^i-1]个争用期（51.2μs）内随机退避；在第11次冲突后，退避窗口上限固定为1023（即K不再增大，固定为10）。因此，第11次冲突后可能的最大退避时间为1023×51.2μs≈52.3776ms。',
'0.512ms', '0.5632ms', '52.3776ms', '104.8064ms'),

-- ============================================================
-- 3.7 广域网 Q1-Q8 (8 pure-text questions)
-- Q1-Q8: 模拟题 (MOCK 2027)
-- ============================================================

(23, '00000000-0000-0000-0000-000000132023', 'CN_DATA_LINK', 'CN_WAN', 'BASIC', 'MOCK', 2027, '3.7广域网', 'pp.127-128,128-129',
'局域网和广域网的差异不仅在于它们所覆盖的范围不同，还主要在于它们（ ）。',
'B',
'广域网和局域网之间的差异不仅在于它们所覆盖的范围不同，还在于它们所采用的协议和网络技术不同，广域网使用点对点等技术，局域网使用广播技术。',
'所使用的介质不同', '所使用的协议不同', '所能支持的通信量不同', '所提供的服务不同'),

(24, '00000000-0000-0000-0000-000000132024', 'CN_DATA_LINK', 'CN_WAN', 'BASIC', 'MOCK', 2027, '3.7广域网', 'pp.128,129',
'广域网覆盖的地理范围从几十千米到几千千米，它的通信子网主要使用（ ）。',
'B',
'广域网的通信子网主要使用分组交换技术，将分布在不同地区的局域网或计算机系统互连起来，达到资源共享的目的。',
'报文交换技术', '分组交换技术', '文件交换技术', '电路交换技术'),

(25, '00000000-0000-0000-0000-000000132025', 'CN_DATA_LINK', 'CN_WAN', 'BASIC', 'MOCK', 2027, '3.7广域网', 'pp.128,129',
'广域网所使用的传输方式是（ ）。',
'B',
'广域网通常指覆盖范围很广的长距离网络，它由一些节点交换机及连接这些交换机的链路组成，其中节点交换机执行分组存储、转发功能。因此广域网使用存储转发式传输方式。',
'广播式', '存储转发式', '集中控制式', '分布控制式'),

(26, '00000000-0000-0000-0000-000000132026', 'CN_DATA_LINK', 'CN_WAN', 'BASIC', 'MOCK', 2027, '3.7广域网', 'pp.128,129',
'广域网的拓扑结构通常采用（ ）。',
'C',
'广域网覆盖范围较广、节点较多，为了保证可靠性和可扩展性，通常需要采用网状结构。网状拓扑结构中，每个节点与多个其他节点相连，当某条链路出现故障时，数据可以通过其他路径绕行，从而提高了网络的可靠性。',
'星形', '总线形', '网状', '环形'),

(27, '00000000-0000-0000-0000-000000132027', 'CN_DATA_LINK', 'CN_WAN', 'BASIC', 'MOCK', 2027, '3.7广域网', 'pp.128,129',
'现在大量的计算机是通过诸如以太网这样的局域网连入广域网的，而局域网与广域网的互联是通过（ ）实现的。',
'A',
'中继器和桥接器通常是指用于局域网的物理层和数据链路层的联网设备。目前局域网接入广域网主要是通过称为路由器的互联设备实现的。路由器工作在网络层，能够连接不同类型的网络。',
'路由器', '资源子网', '桥接器', '中继器'),

(28, '00000000-0000-0000-0000-000000132028', 'CN_DATA_LINK', 'CN_WAN', 'BASIC', 'MOCK', 2027, '3.7广域网', 'pp.128,129',
'下列协议中不属于TCP/IP协议族的是（ ）。',
'D',
'TCP/IP协议族包括TCP、IP、ICMP、IGMP、ARP、RARP、UDP、DNS、FTP、HTTP等。HDLC是ISO提出的一个面向比特型的数据链路层协议，它不属于TCP/IP协议族。',
'ICMP', 'TCP', 'FTP', 'HDLC'),

(29, '00000000-0000-0000-0000-000000132029', 'CN_DATA_LINK', 'CN_WAN', 'MEDIUM', 'MOCK', 2027, '3.7广域网', 'pp.128,129',
'为实现透明传输（默认为异步线路），PPP使用的填充方法是（ ）。',
'B',
'PPP是一种面向字节的协议，所有的帧长都是整数个字节。在异步线路中，PPP采用字节填充法实现透明传输；在同步线路中，PPP采用零比特填充法实现透明传输。题目明确默认为异步线路，因此使用字节填充。',
'位填充', '字符填充', '对字符数据使用字符填充，对非字符数据使用位填充', '对字符数据使用位填充，对非字符数据使用字符填充'),

(30, '00000000-0000-0000-0000-000000132030', 'CN_DATA_LINK', 'CN_WAN', 'MEDIUM', 'MOCK', 2027, '3.7广域网', 'pp.128,129',
'以下对PPP的描述中，错误的是（ ）。',
'B',
'PPP提供差错检测功能，但不提供纠错功能。PPP两端的网络层可以运行不同的网络层协议，但仍能使用同一个PPP进行通信，因此选项B错误（PPP不是仅支持IP协议）。PPP可用于拨号连接，因此支持动态分配IP地址。PPP双方建立LCP链路后，接着进入身份鉴别状态（可选）。',
'具有差错控制能力', '仅支持IP协议', '支持动态分配IP地址', '支持身份验证');

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
    '原题来自《2027年计算机网络考研复习指导》第3章 数据链路层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共30道纯文本单选题，含11道统考真题（2009/2011/2012/2015/2018/2019x2/2023/2024/2025）。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch3_d_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000132', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch3_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000132', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch3_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000132', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch3_d_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000132', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch3_d_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch3_d_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000132901', 'CN-2027-ORIGINAL-CH3-D-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000132902', '3.6局域网'),
    ('00000000-0000-0000-0000-000000132903', '3.7广域网')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

-- Batch tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_d_text_import q
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH3-D-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id
);

-- Section tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_d_text_import q
JOIN question_tags tag ON tag.name = '3.6局域网'
WHERE q.section_tag = '3.6局域网'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_d_text_import q
JOIN question_tags tag ON tag.name = '3.7广域网'
WHERE q.section_tag = '3.7广域网'
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
FROM cn_2027_original_ch3_d_text_import q
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容')
WHERE NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- PAST_EXAM questions get 真题 tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_d_text_import q
JOIN question_tags tag ON tag.name = '真题'
WHERE q.source_type = 'PAST_EXAM'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- ============================================================
-- Cleanup
-- ============================================================
DROP TABLE cn_2027_original_ch3_d_text_import;
