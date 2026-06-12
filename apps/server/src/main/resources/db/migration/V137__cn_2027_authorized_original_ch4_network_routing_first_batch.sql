-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 4: 网络层 (4.4 路由算法与路由协议 Q01-Q21+Q24+Q26).
-- Text-only batch: 23 pure-text questions.
-- Deferred: Q22(距离向量网络图), Q23(OSPF拓扑图), Q25(RIP拓扑图), Q27(距离向量表).
-- Batch: CN-2027-ORIGINAL-CH4-D-TEXT-ONLY

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch4_d_text_import (
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

INSERT INTO cn_2027_original_ch4_d_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 4.4 路由算法与路由协议 Q01-Q21 (pp.196-198)
-- ============================================================
(1, '00000000-0000-0000-0000-000000137001', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.196',
'下列关于动态路由选择和静态路由选择的主要区别的描述中，正确的是（ ）。',
'B',
'静态路由选择使用手动配置的路由信息，实现简单且开销小，需要维护整个网络的拓扑结构信息，但不能及时适应网络状态的变化。动态路由选择通过路由选择协议，自动发现并维护路由信息，能及时适应网络状态的变化，实现复杂、开销大。动态路由选择和静态路由选择都使用路由表。',
'动态路由选择需要维护整个网络的拓扑结构信息，而静态路由选择只需要维护部分拓扑结构信息',
'动态路由选择可随网络的通信量或拓扑变化而自适应地调整，而静态路由选择则需要手工去调整相关的路由信息',
'动态路由选择简单且开销小，静态路由选择复杂且开销大',
'动态路由选择使用路由表，静态路由选择不使用路由表'),

(2, '00000000-0000-0000-0000-000000137002', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.196',
'下列关于路由算法的描述中，错误的是（ ）。',
'B',
'静态路由也称非自适应算法，它不会估计流量和结构来调整其路由决策。但是，这并不是说明路由选择是不能改变的，事实上用户可以随时配置路由表。而动态路由也称自适应算法，需要定时获取网络的状态，并根据网络的状态适时地改变路由决策。',
'静态路由有时也被称为非自适应算法',
'静态路由所使用的路由选择一旦启动就不能修改',
'动态路由也称自适应算法，会根据网络的拓扑变化和流量变化改变路由决策',
'动态路由算法需要实时获得网络的状态'),

(3, '00000000-0000-0000-0000-000000137003', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'下列关于链路状态协议的描述中，错误的是（ ）。',
'A',
'在链路状态算法中，每个路由器在自己的链路状态变化时，将链路状态信息用洪泛法发送给网络中的其他路由器。发送的链路状态信息包括该路由器的相邻路由器及所有相邻链路的状态。链路状态算法具有快速收敛的优点，它能在网络拓扑发生变化时，立即进行路由的重新计算，并及时向其他路由器发送最新的链路状态信息，使得各路由器的链路状态表能够尽量保持一致。',
'仅相邻路由器需要交换各自的路由表',
'全网路由器的拓扑数据库是一致的',
'采用洪泛技术更新链路变化信息',
'具有快速收敛的优点'),

(4, '00000000-0000-0000-0000-000000137004', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'在链路状态算法中，每个路由器都得到网络的完整拓扑结构后，使用（ ）算法来找出它到其他路由器的路径长度。',
'B',
'在链路状态算法中，路由器通过交换每个节点到邻居节点的代价来构建一个完整的网络拓扑结构。然后，路由器使用Dijkstra最短路径算法来计算到所有节点的最短路径。',
'Prim最小生成树算法',
'Dijkstra最短路径算法',
'Kruskal最小生成树算法',
'拓扑排序'),

(5, '00000000-0000-0000-0000-000000137005', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'下列关于分层路由的描述中，错误的是（ ）。',
'B',
'采用分层路由后，路由器被划分成区域，每个路由器知道如何将分组路由到自己所在区域内的目标地址，但对于其他区域内的结构毫不知情。当不同的网络相互连接时，可将每个网络当作一个独立的区域，这样做的好处是一个网络中的路由器不必知道其他网络的拓扑结构。',
'采用分层路由后，路由器被划分成区域',
'每个路由器不仅知道如何将分组路由到自己区域的目标地址，还知道如何路由到其他区域',
'采用分层路由后，可以将不同的网络连接起来',
'对于大型网络，可能需要多级的分层路由来管理'),

(6, '00000000-0000-0000-0000-000000137006', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'以下关于自治系统的描述中，错误的是（ ）。',
'B',
'划分区域的好处是，将利用洪泛法交换链路状态信息的范围局限在每个区域内，而不是整个自治系统。因此，在一个区域内部的路由器只知道本区域的网络拓扑情况，而不知道其他区域的网络拓扑情况。采用分层次划分区域的方法虽然使交换信息的种类增多了，同时也使OSPF协议更加复杂了，但是这样做却能使每个区域内部交换路由信息的通信量大大减少，进而使OSPF协议能够用于规模很大的自治系统中。',
'自治系统划分区域的好处是，将利用洪泛法交换链路状态信息的范围局限在每个区域内，而不是整个自治系统',
'采用分层划分区域的方法使交换信息的种类增多，同时也使OSPF协议更加简单',
'OSPF协议将一个自治系统再划分为若干个更小的范围称为区域',
'在一个区域内部的路由器只知道本区域的网络拓扑，而不知道其他区域的网络拓扑的情况'),

(7, '00000000-0000-0000-0000-000000137007', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'在计算机网络中，路由选择协议的功能不包括（ ）。',
'D',
'路由选择协议的功能通常包括：获取网络拓扑信息、构建路由表、在网络中更新路由信息、选择到达每个目的网络的最优路径、识别一个网络的无环路通路等。发现下一跳的物理地址一般是通过其他方式（如ARP）来实现的，不属于路由选择协议的功能。',
'交换网络状态或通路信息，选择到达目的地的最佳路径',
'构建路由表',
'更新路由表',
'发现下一跳的物理地址'),

(8, '00000000-0000-0000-0000-000000137008', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'用于域间路由的协议是（ ）。',
'B',
'BGP（边界网关协议）是域间路由协议。RIP和OSPF是域内路由协议，ARP不是路由协议。',
'RIP',
'BGP',
'OSPF',
'ARP'),

(9, '00000000-0000-0000-0000-000000137009', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'在RIP中，到某个网络的距离值为16，其意义是（ ）。',
'A',
'RIP规定的最大跳数为15，16表示网络不可达。',
'该网络不可达',
'存在循环路由',
'该网络为直接连接网络',
'到达该网络要经过15次转发'),

(10, '00000000-0000-0000-0000-000000137010', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'在RIP中，假设路由器X和路由器K互为邻居，X向K说"我到目的网络Y的距离为N"，则收到此信息的K就知道"若将到网络Y的下一个路由器选为X，则我到网络Y的距离为（ ）"。（假设N小于15）',
'D',
'RIP规定，每经过一个路由器，距离（跳数）加1。因此从K经过X到达网络Y的距离为N+1。',
'N',
'N-1',
'1',
'N+1'),

(11, '00000000-0000-0000-0000-000000137011', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'以下关于RIP的描述中，错误的是（ ）。',
'C',
'RIP规定一个路由器只向相邻路由器发布路由信息，而不像OSPF那样向整个域洪泛。RIP要求内部路由器按照一定的时间间隔发布路由信息。',
'RIP是基于距离-向量路由选择算法的',
'RIP要求内部路由器将它关于整个AS的路由信息发布出去',
'RIP要求内部路由器向整个AS的路由器发布路由信息',
'RIP要求内部路由器按照一定的时间间隔发布路由信息'),

(12, '00000000-0000-0000-0000-000000137012', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'BASIC', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.197',
'在RIP中，当路由器收到相邻路由器发来的路由更新信息时，若发现有更优的路由，则（ ）。',
'A',
'在RIP中，当路由器收到相邻路由器发来的路由更新信息时，若发现有更优的路由（跳数更小的路由），则直接更新自己的路由表，并向其他相邻路由器广播自己的新路由。',
'直接更新自己的路由表',
'向相邻路由器发送确认信息后再更新自己的路由表',
'向所有相邻路由器发送确认信息后再更新自己的路由表',
'不更新自己的路由表'),

(13, '00000000-0000-0000-0000-000000137013', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'对路由选择协议的一个要求是必须能够快速收敛，所谓"路由收敛"是指（ ）。',
'C',
'所谓收敛，是指当路由环境发生变化后，各路由器调整自己的路由表以适应网络拓扑结构的变化，最终达到稳定状态（路由表与网络拓扑状态保持一致）。收敛越快，路由器就能越快适应网络拓扑结构的变化。',
'路由器能把分组发送到预定的目标',
'路由器处理分组的速度足够快',
'网络设备的路由表与网络拓扑结构保持一致',
'能把多个子网合并成一个超网'),

(14, '00000000-0000-0000-0000-000000137014', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'下列关于RIP和OSPF协议的叙述中，错误的是（ ）。',
'A',
'RIP是应用层协议，它使用UDP传送数据，OSPF才是网络层协议。选项A错误。RIP中的路由器仅向自己相邻的路由器发送信息，OSPF协议中的路由器向本自治系统中的所有路由器发送信息。RIP中的路由器发送的信息是整个路由表，OSPF协议中的路由器发送的信息只是路由表的一部分。RIP的路由器不知道全网的拓扑结构，OSPF协议的任何路由器都知道自己所在区域的拓扑结构。',
'RIP和OSPF协议都是网络层协议',
'在进行路由信息交换时，RIP中的路由器仅向自己相邻的路由器发送信息，OSPF协议中的路由器向本自治系统中的所有路由器发送信息',
'在进行路由信息交换时，RIP中的路由器发送的信息是整个路由表，OSPF协议中的路由器发送的信息只是路由表的一部分',
'RIP的路由器不知道全网的拓扑结构，OSPF协议的任何路由器都知道自己所在区域的拓扑结构'),

(15, '00000000-0000-0000-0000-000000137015', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'OSPF协议使用（ ）分组来保持与其邻居的连接。',
'A',
'OSPF协议使用Hello分组来保持与其邻居的连接。',
'Hello',
'Keepalive',
'SPF（最短路径优先）',
'LSU（链路状态更新）'),

(16, '00000000-0000-0000-0000-000000137016', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'以下关于OSPF协议的描述中，最准确的是（ ）。',
'A',
'OSPF协议是一种用于自治系统内的路由协议，是一种基于链路状态路由选择算法的协议，能适用大型全局IP网络的扩展，支持可变长子网掩码。OSPF协议维护一张它所连接的所有链路状态信息的邻居表和拓扑数据库，使用多播链路状态更新报文实现路由更新，并且只有当网络发生变化时才传送链路状态更新报文。',
'OSPF协议基于链路状态法计算最佳路由',
'OSPF协议是用于自治系统之间的外部网关协议',
'OSPF协议不能根据网络通信情况动态地改变路由',
'OSPF协议只适用于小型网络'),

(17, '00000000-0000-0000-0000-000000137017', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'在OSPF协议中，划分区域的最主要目的是（ ）。',
'B',
'链路状态算法让每个路由器都知道整个自治系统的完整拓扑，从而计算最短路径。若不划分区域，则会导致链路状态数据包的个数和占用空间非常大，占用大量的网络带宽资源，影响网络效率和稳定性。划分区域后，每个路由器只需要知道自己所在区域内的完整拓扑，把交换链路状态信息的范围局限在每个区域，这样就大大减少了链路状态数据包的数量和大小。',
'减少路由表的大小',
'减少洪泛法交换的通信量',
'增加路由选择的灵活性',
'增加网络的安全性'),

(18, '00000000-0000-0000-0000-000000137018', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'下列关于OSPF协议特征的描述中，错误的是（ ）。',
'D',
'主干区域中，用于连接主干区域和其他下层区域的路由器称为区域边界路由器。只要是在主干区域中的路由器，就都称为主干路由器，因此主干路由器可以兼作区域边界路由器。自治系统中有4类路由器：区域内部路由器、主干路由器、区域边界路由器和自治域边界路由器。',
'OSPF协议将一个自治域划分成若干域，有一种特殊的域称为主干区域',
'域之间通过区域边界路由器互连',
'在自治系统中有4类路由器：区域内部路由器、主干路由器、区域边界路由器和自治域边界路由器',
'主干路由器不能兼作区域边界路由器'),

(19, '00000000-0000-0000-0000-000000137019', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'BGP交换的网络可达性信息是（ ）。',
'A',
'因为BGP仅力求寻找一条能够到达目的网络且较好的路由（不能兜圈子），而非寻找一条最佳路由。BGP交换的路由信息是到达某个目的网络所要经过的各个自治系统序列，而不仅仅是下一跳。',
'到达某个网络所经过的路径',
'到达某个网络的下一跳路由器',
'到达某个网络的链路状态摘要信息',
'到达某个网络的最短距离及下一跳路由器'),

(20, '00000000-0000-0000-0000-000000137020', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'RIP、OSPF协议、BGP的路由选择过程分别使用（ ）。',
'D',
'RIP是一种分布式的基于距离向量的路由选择协议，它使用跳数来度量距离。OSPF协议采用分布式的链路状态协议，通过与相邻路由器频繁交流链路状态信息，来建立全网的拓扑结构图，然后使用Dijkstra算法计算从自己到各个目的网络的最优路径。BGP采用路径向量路由选择协议，每个自治系统选出一个BGP发言人，通过相互交换路径向量（网络可达性信息）后，可找出到达各自自治系统的较好路由。',
'路径向量协议、链路状态协议、距离向量协议',
'距离向量协议、路径向量协议、链路状态协议',
'路径向量协议、距离向量协议、链路状态协议',
'距离向量协议、链路状态协议、路径向量协议'),

(21, '00000000-0000-0000-0000-000000137021', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'MOCK', 2027, '4.4 路由算法与路由协议', 'p.198',
'从数据封装的角度看，下列（ ）协议属于TCP/IP模型的应用层。
I. OSPF  II. RIP  III. BGP  IV. ICMP',
'B',
'RIP和BGP属于应用层，OSPF和ICMP属于网络层。RIP使用UDP传送数据，BGP使用TCP传送数据，均属于应用层协议。OSPF直接封装在IP数据报中，属于网络层协议。ICMP是网络层协议，用于报告差错和异常情况。',
'I、II',
'II、III',
'I、IV',
'I、II、III、IV'),

-- ============================================================
-- 4.4 Q24 (PAST_EXAM 2010) - p.199
-- ============================================================
(22, '00000000-0000-0000-0000-000000137022', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'PAST_EXAM', 2010, '4.4 路由算法与路由协议', 'p.199',
'【2010统考真题】某自治系统内采用RIP，若该自治系统内的路由器R1收到其邻居路由器R2的距离向量，距离向量中包含信息<Net1, 16>，则能得出的结论是（ ）。',
'D',
'R1在收到信息并更新路由表后，若需要经过R2到达Net1，则其跳数为17，因为距离为16表示不可达，所以R1不能经过R2到达Net1，R2也不可能到达Net1。题目中并未给出R1向R2发送的信息，因此选项A也不正确。',
'R2可以经过R1到达Net1，跳数为17',
'R2可以到达Net1，跳数为16',
'R1可以经过R2到达Net1，跳数为17',
'R1不能经过R2到达Net1'),

-- ============================================================
-- 4.4 Q26 (PAST_EXAM 2017) - p.200
-- ============================================================
(23, '00000000-0000-0000-0000-000000137023', 'CN_NETWORK', 'CN_NETWORK_ROUTING', 'MEDIUM', 'PAST_EXAM', 2017, '4.4 路由算法与路由协议', 'p.200',
'【2017统考真题】直接封装RIP、OSPF、BGP报文的协议分别是（ ）。',
'D',
'RIP是一种分布式的基于距离向量的路由选择协议，它通过广播UDP报文来交换路由信息。OSPF是一个内部网关协议，要交换的信息量较大，应使报文的长度尽量短，所以不使用传输层协议（如UDP或TCP），而直接采用IP。BGP是一个外部网关协议，在不同的自治系统之间交换路由信息，因为网络环境复杂，需要保证可靠传输，所以采用TCP。因此，答案为选项D。',
'TCP、UDP、IP',
'TCP、IP、UDP',
'UDP、TCP、IP',
'UDP、IP、TCP');

-- ============================================================
-- Insert into questions
-- ============================================================
INSERT INTO questions (
    id, subject_id, chapter_id, type, difficulty, stem, answer, explanation,
    source, source_year, score, status, review_status, review_note,
    stem_format, stem_image_url, reviewed_at, created_at, updated_at
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
    t.source_type,
    t.source_year,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '原题来自《2027年计算机网络考研复习指导》第4章 网络层 4.4节 本节试题精选。原始页码：' || t.source_pages || '。本批为4.4路由算法与路由协议首批，共23道纯文本单选题（Q01-Q21+Q24+Q26），跳过Q22（距离向量网络图）、Q23（OSPF拓扑图）、Q25（RIP拓扑图）、Q27（距离向量表）共4道需手工导入。4.4本节试题精选尚未完成。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch4_d_text_import t
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = t.chapter_code;

-- ============================================================
-- Insert question-knowledge_point relationships
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(t.id AS UUID), kp.id
FROM cn_2027_original_ch4_d_text_import t
JOIN knowledge_points kp ON kp.code = t.kp_code;

-- ============================================================
-- Insert options (4 per question)
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000137', LPAD(CAST((t.num*4-3) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'A',
    t.option_a,
    1
FROM cn_2027_original_ch4_d_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000137', LPAD(CAST((t.num*4-2) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'B',
    t.option_b,
    2
FROM cn_2027_original_ch4_d_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000137', LPAD(CAST((t.num*4-1) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'C',
    t.option_c,
    3
FROM cn_2027_original_ch4_d_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000137', LPAD(CAST((t.num*4-0) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'D',
    t.option_d,
    4
FROM cn_2027_original_ch4_d_text_import t;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000137901', 'CN-2027-ORIGINAL-CH4-D-TEXT-ONLY')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

-- Batch tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_d_text_import t
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH4-D-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Section tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_d_text_import t
JOIN question_tags tag ON tag.name = '4.4 路由算法与路由协议'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Standard tags for all questions
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_d_text_import t
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Past exam tag for Q24 and Q26 (nums 22-23)
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_d_text_import t
JOIN question_tags tag ON tag.name = '真题'
WHERE t.source_type = 'PAST_EXAM'
AND NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- ============================================================
-- Clean up
-- ============================================================
DROP TABLE cn_2027_original_ch4_d_text_import;
