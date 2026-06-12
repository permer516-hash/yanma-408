-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 3: 数据链路层 (3.7 广域网 Q9-Q12 + 3.8 数据链路层设备 Q1-Q23 text-only subset).
-- Text-only batch: 23 pure-text questions (4 from 3.7, 19 from 3.8).
-- Deferred from 3.8: Q13 (topology diagram + triple-blank), Q18 (topology diagram), Q21 (2014 topology diagram), Q23 (2016 topology diagram).
-- Batch: CN-2027-ORIGINAL-CH3-E-TEXT-ONLY

-- ============================================================
-- Ensure knowledge points exist
-- ============================================================
-- CN_WAN already exists from V132 (used by 3.7)

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000133301',
    c.id,
    'CN_LAN_DEVICE',
    '数据链路层设备',
    8
FROM chapters c
WHERE c.code = 'CN_DATA_LINK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_LAN_DEVICE');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch3_e_text_import (
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

INSERT INTO cn_2027_original_ch3_e_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 3.7 广域网 Q9-Q12 (4 questions, MOCK 2027)
-- ============================================================
(1, '00000000-0000-0000-0000-000000133001', 'CN_DATA_LINK', 'CN_WAN', 'MEDIUM', 'MOCK', 2027, '3.7广域网', 'pp.116-117',
'PPP提供的功能有（ ）。',
'D',
'PPP协议主要由三部分组成：①链路控制协议(LCP)；②网络控制协议(NCP)；③一个将IP数据报封装到串行链路的方法。因此，选项A、B、C都正确。',
'一种组帧方法', '链路控制协议(LCP)', '网络控制协议(NCP)', 'A、B、C都是'),

(2, '00000000-0000-0000-0000-000000133002', 'CN_DATA_LINK', 'CN_WAN', 'MEDIUM', 'MOCK', 2027, '3.7广域网', 'pp.116-117',
'PPP中的LCP协议的作用是（ ）。',
'A',
'PPP帧在默认配置下，地址和控制域总是常量，所以LCP提供了必要的机制，允许双方协商一个选项。在建立状态阶段，LCP协商数据链路协议中的选项，它并不关心这些选项本身，只提供一个协商选择的机制。',
'在建立状态阶段协商数据链路协议的选项', '配置网络层协议', '检查数据链路层的错误，并通知错误信息', '安全控制，保护通信双方的数据安全'),

(3, '00000000-0000-0000-0000-000000133003', 'CN_DATA_LINK', 'CN_WAN', 'MEDIUM', 'MOCK', 2027, '3.7广域网', 'pp.116-117',
'下列关于PPP的叙述中，正确的是（ ）。',
'D',
'PPP是数据链路层协议，A错误。根据PPP的特点可知B、C错误，D正确。',
'PPP是网络层协议', 'PPP支持半双工或全双工通信', 'PPP两端的网络层必须运行相同的网络层协议', 'PPP是面向字节的协议'),

(4, '00000000-0000-0000-0000-000000133004', 'CN_DATA_LINK', 'CN_WAN', 'MEDIUM', 'MOCK', 2027, '3.7广域网', 'pp.116-117',
'PPP提供的是（ ）。',
'C',
'PPP是一种面向连接的点对点数据链路层协议，虽然它在连接建立的过程中使用了确认机制，但在数据帧的发送过程中只保证无差错接收(CRC检验)，检验正确就接收这个帧，否则丢弃这个帧，其他什么也不做。因此PPP提供的是有连接的不可靠服务。',
'无连接的不可靠服务', '无连接的可靠服务', '有连接的不可靠服务', '有连接的可靠服务'),

-- ============================================================
-- 3.8 数据链路层设备 Q1-Q12 (12 questions, all MOCK 2027)
-- ============================================================
(5, '00000000-0000-0000-0000-000000133005', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.120-121',
'下列网络连接设备都工作在数据链路层的是（ ）。',
'C',
'中继器和集线器都属于物理层设备，网桥和局域网交换机属于数据链路层设备。',
'中继器和集线器', '集线器和网桥', '网桥和局域网交换机', '集线器和局域网交换机'),

(6, '00000000-0000-0000-0000-000000133006', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'下列关于数据链路层设备的叙述中，错误的是（ ）。',
'D',
'交换机的优点是每个接口节点所占用的带宽不会因为接口节点数量的增加而减少，且整个交换机的总带宽会随着接口节点的增加而增加。另外，利用交换机可以实现虚拟局域网(VLAN)，VLAN不仅可以隔离冲突域，还可以隔离广播域。因此选项C正确，选项D错误。',
'交换机将网络划分成多个网段，一个网段的故障不会影响到另一个网段的运行',
'交换机可互连不同的物理层、不同的MAC子层及不同速率的以太网',
'交换机的每个接口节点所占用的带宽不会因为接口节点数量的增加而减少，且整个交换机的总带宽会随着接口节点的增加而增加',
'利用交换机可以实现虚拟局域网(VLAN)，VLAN可以隔离冲突域，但不能隔离广播域'),

(7, '00000000-0000-0000-0000-000000133007', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'下列（ ）不是使用交换机分割网络所带来的好处。',
'D',
'交换机可以隔离信息，将网络划分成多个网段，隔离出安全网段，防止其他网段内的用户非法访问。因为网络分段，各网段相对独立，所以一个网段的故障不影响另一个网段的运行。因此B、C正确。根据交换机的特点可知A正确，D错误。',
'减少冲突域的范围', '在一定条件下增加了网络的带宽', '过滤网段之间的数据', '缩小了广播域的范围'),

(8, '00000000-0000-0000-0000-000000133008', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'下列不能分割冲突域的设备是（ ）。',
'A',
'冲突域是指共享同一信道的各个站点可能发生冲突的范围。物理层设备集线器既不能分割冲突域也不能分割广播域，数据链路层设备交换机和网桥可以分割冲突域但不能分割广播域，而网络层设备路由器既可分割冲突域又可分割广播域。',
'集线器', '交换机', '路由器', '网桥'),

(9, '00000000-0000-0000-0000-000000133009', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'局域网交换机实现的主要功能在（ ）。',
'A',
'局域网交换机是数据链路层设备，能实现数据链路层和物理层的功能。',
'物理层和数据链路层', '数据链路层和网络层', '物理层和网络层', '数据链路层和应用层'),

(10, '00000000-0000-0000-0000-000000133010', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'交换机能比集线器提供更好的网络性能的原因是（ ）。',
'A',
'交换机能隔离冲突域，在全双工方式下支持多对节点同时通信，从而提高了网络的效率。',
'交换机支持多对用户同时通信', '交换机使用差错控制减少出错率', '交换机使网络的覆盖范围更大', '交换机无须设置，使用更方便'),

(11, '00000000-0000-0000-0000-000000133011', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'通过交换机连接的一组工作站（ ）。',
'B',
'交换机是数据链路层的设备，数据链路层的设备可以隔离冲突域，但不能隔离广播域，因此本题选B。另外，物理层设备（集线器等）既不能隔离冲突域，又不能隔离广播域；网络层设备（路由器）既可以隔离冲突域，又可以隔离广播域。',
'组成一个冲突域，但不是一个广播域', '组成一个广播域，但不是一个冲突域', '既是一个冲突域，又是一个广播域', '既不是冲突域，又不是广播域'),

(12, '00000000-0000-0000-0000-000000133012', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'一个16接口的集线器的冲突域和广播域的个数分别是（ ）。',
'C',
'物理层设备（中继器和集线器）既不能分割冲突域，又不能分割广播域。所以16接口的集线器的冲突域个数是1，广播域个数也是1。',
'16,1', '16,16', '1,1', '1,16'),

(13, '00000000-0000-0000-0000-000000133013', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121',
'一个16接口的以太网交换机，冲突域和广播域的个数分别是（ ）。',
'D',
'以太网交换机的各接口之间都是冲突域的终止点，但LAN交换机不隔离广播，所以冲突域的个数是16，广播域的个数是1。',
'1,1', '16,16', '1,16', '16,1'),

(14, '00000000-0000-0000-0000-000000133014', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.121-122',
'下列关于用集线器连接的共享式以太网的说法中，正确的是（ ）。',
'C',
'用集线器连接的以太网逻辑上是总线形结构，物理上是星形结构，选项A错误。以太网设计的原则是简化通信，因此采用的是无确认、无连接的服务，选项B错误。以太网属于局域网的一种设计标准，只包括物理层和数据链路层，比如在物理层以太网规定采用曼彻斯特编码，在数据链路层规定采用CSMA/CD协议，选项C正确。用集线器连接的以太网一定工作在半双工方式下，因此一定要采用CSMA/CD协议，选项D错误。',
'以太网的物理拓扑是总线形结构', '以太网提供有确认的无连接服务', '以太网参考模型一般只包括物理层和数据链路层', '以太网不一定使用CSMA/CD协议'),

(15, '00000000-0000-0000-0000-000000133015', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.122',
'下列关于广播式网络的说法中，错误的是（ ）。',
'D',
'广播式网络使用共享的广播信道进行通信，通常是局域网的一种通信方式（局域网工作在数据链路层），因此可以不需要网络层，也就不存在路由选择问题。但数据链路层使用物理层的服务必须通过服务接入点，数据链路层向高层提供服务也必须通过服务接入点。',
'共享广播信道', '不存在路由选择问题', '可以不要网络层', '不需要服务接入点'),

(16, '00000000-0000-0000-0000-000000133016', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.122',
'对于由交换机连接的10Mb/s以太网，若有10个用户，则每个用户能占有的带宽为（ ）。',
'C',
'对于集线器连接的10Mb/s共享式以太网，若有N个用户，则每个用户的平均带宽仅为总带宽的1/N。当采用交换机连接时，虽然从每个接口到主机的带宽还是10Mb/s，但因为一个用户通信时是独占带宽的，而不是和其他用户共享带宽的，所以每个用户仍可得到10Mb/s的带宽。',
'1Mb/s', '2Mb/s', '10Mb/s', '100Mb/s'),

-- ============================================================
-- 3.8 数据链路层设备 Q14-Q17 (4 questions, MOCK 2027)
-- ============================================================
(17, '00000000-0000-0000-0000-000000133017', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.122',
'假设以太网A中80%的通信量在本局域网内进行，其余20%在本局域网与因特网之间进行，而以太网B正好相反。在这两个局域网中，一个使用集线器，另一个使用交换机，则交换机应放置的局域网是（ ）。',
'A',
'交换机能将网络分成较小的冲突域，而集线器连接的设备属于同一个冲突域。当一个局域网中80%的通信量在本局域网内进行时，若使用集线器，则会增加冲突和延迟，降低整个网络的效率，而若使用交换机将不同网段的通信隔开，则可以提高网络性能。',
'以太网A', '以太网B', '任意以太网', '都不合适'),

(18, '00000000-0000-0000-0000-000000133018', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.122',
'在使用以太网交换机的局域网中，以下（ ）是正确的。',
'B',
'交换机可以隔离冲突域，因此它的每个接口所连接的网段都属于不同的冲突域，选项A错误。交换机可在同一时段内支持多个接口之间的并行通信，而不会相互干扰，这是因交换机有一条高带宽的背部总线和内部交换矩阵，可以根据帧的目的MAC地址快速地将帧转发到相应的接口。交换机不能隔离广播域，选项C错误。LLC是逻辑链路控制，它在MAC层上，用于向网络提供一个接口，以隐藏各种802网络之间的差异，交换机是按MAC地址转发的，选项D错误。',
'局域网中只包含一个冲突域', '交换机的多个接口可以并行传输', '交换机可以隔离广播域', '交换机根据LLC目的地址转发'),

(19, '00000000-0000-0000-0000-000000133019', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.122',
'以太网交换机的自学习功能是指（ ）。',
'A',
'以太网交换机的自学习功能是指记录帧的源MAC地址与该帧进入交换机的接口号，并将这些信息存储在交换机的交换表中，以便于后续的转发决策。',
'记录帧的源MAC地址与该帧进入交换机的接口号', '记录帧的目的MAC地址与该帧进入交换机的接口号', '记录分组的源IP地址与该分组进入交换机的接口号', '记录分组的目的IP地址与该分组进入交换机的接口号'),

(20, '00000000-0000-0000-0000-000000133020', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'MOCK', 2027, '3.8数据链路层设备', 'pp.122',
'当以太网交换机某接口收到帧时，若在交换表中未找到目的MAC地址，则（ ）。',
'C',
'当以太网交换机的某个接口收到帧时，若在交换表中未找到目的MAC地址，则将该帧从除本接口外的所有接口发送出去，这种发送方法也称洪泛法。',
'将帧发送到特定接口进行ARP查询', '丢弃该帧', '将帧发送到除本接口外的所有接口', '将帧发送给DHCP服务器'),

-- ============================================================
-- 3.8 数据链路层设备 Q19-Q20 (2 PAST_EXAM)
-- ============================================================
(21, '00000000-0000-0000-0000-000000133021', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'PAST_EXAM', 2009, '3.8数据链路层设备', 'pp.122',
'以太网交换机进行转发决策时使用的PDU地址是（ ）。',
'A',
'交换机工作在数据链路层，数据链路层使用物理地址进行转发，而转发到目的地需要使用目的地址。因此PDU地址是目的物理地址。',
'目的物理地址', '目的IP地址', '源物理地址', '源IP地址'),

(22, '00000000-0000-0000-0000-000000133022', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'PAST_EXAM', 2013, '3.8数据链路层设备', 'pp.122-123',
'对于100Mb/s的以太网交换机，当输出端口无排队，以直通交换方式转发一个以太网帧（不包括前导码）时，引入的转发时延至少是（ ）。',
'B',
'直通交换方式的输入接口接收到一个帧时，只检查帧的目的MAC地址决定输出接口，引入的转发时延至少为读取目的MAC地址所需的时间。目的MAC地址共6B，引入的转发时延至少为6×8bit÷100Mb/s=0.48μs。存储转发方式引入的转发时延则至少为读取整个帧的时间。',
'0μs', '0.48μs', '5.12μs', '121.44μs'),

-- ============================================================
-- 3.8 数据链路层设备 Q22 (2015 PAST_EXAM)
-- ============================================================
(23, '00000000-0000-0000-0000-000000133023', 'CN_DATA_LINK', 'CN_LAN_DEVICE', 'MEDIUM', 'PAST_EXAM', 2015, '3.8数据链路层设备', 'pp.122-123',
'下列关于交换机的叙述中，正确的是（ ）。',
'A',
'本质上说，交换机就是一个多接口的网桥（选项A正确），工作在数据链路层（因此不能实现不同网络层协议的网络互连，选项D错误），交换机能经济地将网络分成小的冲突域（选项B错误）。广播域属于网络层概念，只有网络层设备（如路由器）才能分割广播域（选项C错误）。',
'以太网交换机本质上是一种多端口网桥',
'通过交换机互连的一组工作站构成一个冲突域',
'交换机每个接口所连的网络构成一个独立的广播域',
'以太网交换机可实现采用不同网络层协议的网络互连');

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
    '原题来自《2027年计算机网络考研复习指导》第3章 数据链路层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共23道纯文本单选题，含3道统考真题（2009/2013/2015），4道含图题后置（Q13拓扑图三空题/Q18拓扑图/Q21 2014拓扑图/Q23 2016拓扑图）。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch3_e_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000133', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch3_e_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000133', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch3_e_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000133', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch3_e_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000133', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch3_e_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch3_e_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000133901', 'CN-2027-ORIGINAL-CH3-E-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000133902', '3.7广域网'),
    ('00000000-0000-0000-0000-000000133903', '3.8数据链路层设备')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

-- Batch tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_e_text_import q
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH3-E-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id
);

-- Section tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_e_text_import q
JOIN question_tags tag ON tag.name = '3.7广域网'
WHERE q.section_tag = '3.7广域网'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_e_text_import q
JOIN question_tags tag ON tag.name = '3.8数据链路层设备'
WHERE q.section_tag = '3.8数据链路层设备'
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
FROM cn_2027_original_ch3_e_text_import q
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容')
WHERE NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- PAST_EXAM questions get 真题 tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_e_text_import q
JOIN question_tags tag ON tag.name = '真题'
WHERE q.source_type = 'PAST_EXAM'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- ============================================================
-- Cleanup
-- ============================================================
DROP TABLE cn_2027_original_ch3_e_text_import;
