-- Authorized original CN single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 2 remaining: 2.1 Q26-Q28 (PAST_EXAM 2022/2023/2024),
--   2.2 Q11-Q12 (PAST_EXAM 2012/2018), 2.3 Q1-Q9 (MOCK).
-- Batch: CN-2027-ORIGINAL-CH2-B-TEXT-ONLY

-- Ensure knowledge point: CN_PHYSICAL_DEVICE (2.3 物理层设备)
INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000127301',
    c.id,
    'CN_PHYSICAL_DEVICE',
    '物理层设备',
    3
FROM chapters c
WHERE c.code = 'CN_PHYSICAL'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_PHYSICAL_DEVICE');

CREATE TABLE cn_2027_original_ch2_b_text_import (
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

INSERT INTO cn_2027_original_ch2_b_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 2.1 通信基础 Q26-Q28（3道统考真题）
-- ============================================================
(1, '00000000-0000-0000-0000-000000127001', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'PAST_EXAM', 2022, '2.1通信基础', 'pp.49,52',
'【2022统考真题】在一条带宽为200kHz的无噪声信道上，若采用4个幅值的ASK调制，则该信道的最大数据传输速率是（ ）。',
'C',
'在ASK调制中，4个幅值表示4种信号状态（N=4），每个码元携带log₂4=2比特。根据奈奎斯特定理，最大数据传输速率=2Hlog₂N，已知带宽H=200kHz，代入得800kb/s。',
'200kb/s',
'400kb/s',
'800kb/s',
'1600kb/s'),

(2, '00000000-0000-0000-0000-000000127002', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'PAST_EXAM', 2023, '2.1通信基础', 'pp.49,52',
'【2023统考真题】某个无噪声理想信道带宽为4MHz，采用QAM调制，若该信道的最大数据传输速率是48Mb/s，则该信道采用的QAM调制方案是（ ）。',
'C',
'由奈奎斯特定理：最大数据传输速率=2Hlog₂N，N表示码元的信号状态数。已知带宽H=4MHz，最大速率为48Mb/s，代入得log₂N=6，求得N=2⁶=64，即采用QAM-64调制。',
'QAM-16',
'QAM-32',
'QAM-64',
'QAM-128'),

(3, '00000000-0000-0000-0000-000000127003', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'PAST_EXAM', 2024, '2.1通信基础', 'pp.49,52',
'【2024统考真题】在下列二进制数字调制方法中，需要2个不同频率载波的是（ ）。',
'C',
'FSK（Frequency Shift Keying，频移键控）使用两个不同频率的载波分别表示0和1，是唯一需要两个载波频率的二进制调制方式。ASK（Amplitude Shift Keying，幅移键控）改变幅度，PSK（Phase Shift Keying，相移键控）和DPSK（差分相移键控）改变相位，均使用单一频率载波。',
'ASK',
'PSK',
'FSK',
'DPSK'),

-- ============================================================
-- 2.2 传输介质 Q11-Q12（2道统考真题）
-- ============================================================
(4, '00000000-0000-0000-0000-000000127004', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'PAST_EXAM', 2012, '2.2传输介质', 'pp.56,57',
'【2012统考真题】在物理层接口特性中，用于描述完成每种功能的事件发生顺序的是（ ）。',
'C',
'物理层的接口特性包括机械、电气、功能和过程四类。其中，过程特性用于描述完成各种功能时事件发生的先后顺序，即规定各操作（如建立连接、传输数据、释放线路等）的时序关系。',
'机械特性',
'功能特性',
'过程特性',
'电气特性'),

(5, '00000000-0000-0000-0000-000000127005', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'PAST_EXAM', 2018, '2.2传输介质', 'pp.56,57',
'【2018统考真题】下列选项中，不属于物理层接口规范定义范畴的是（ ）。',
'C',
'物理层接口规范涵盖四类特性：机械特性（如接口形状、尺寸）、电气特性（如信号电平、电压范围）、功能特性（如引脚功能、电平含义）和过程特性（事件发生顺序）。而物理地址（MAC地址）用于标识数据链路层的设备，属于数据链路层的范畴，不在物理层定义范围内。',
'接口形状',
'引脚功能',
'物理地址',
'信号电平'),

-- ============================================================
-- 2.3 物理层设备 Q1-Q9（9道模拟题）
-- ============================================================
(6, '00000000-0000-0000-0000-000000127006', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'下列关于物理层设备的叙述中，错误的是（ ）。',
'B',
'中继器的原理是将衰减的信号再生（再生=放大+整形），而不是简单地放大。',
'中继器仅作用于信号的电气部分',
'利用中继器来扩大网络传输距离的原理是将衰减的信号进行放大',
'集线器实质上相当于一个多端口的中继器',
'物理层设备连接的几个网段仍是一个局域网'),

(7, '00000000-0000-0000-0000-000000127007', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'为了使数字信号传输得更远，可采用的设备是（ ）。',
'A',
'放大器通常用于远距离地传输模拟信号，但同时会放大噪声，引发失真。中继器用于数字信号的传输，其工作原理是信号再生，因此会减少失真。网桥用来连接两个网段以扩展物理网络的覆盖范围。路由器是网络层的互连设备，可以实现不同网络的互联。',
'中继器',
'放大器',
'网桥',
'路由器'),

(8, '00000000-0000-0000-0000-000000127008', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'以太网遵循IEEE 802.3标准，用粗缆组网时每段的长度不能大于500m，超过500m时就要分段，段间相连利用的是（ ）。',
'B',
'中继器的主要功能是将信号复制、整形和放大再转发出去，以消除信号经过一长段电缆而造成的失真和衰减，使信号的波形和强度达到所需的要求，进而扩大网络传输的距离。',
'网络适配器',
'中继器',
'调制解调器',
'网关'),

(9, '00000000-0000-0000-0000-000000127009', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'由集线器连接多台设备构成的网络在物理上和逻辑上的结构分别是（ ）。',
'D',
'集线器将多个设备连接在以它为中心的节点上，因此使用它的网络在物理拓扑上属于星形结构。当集线器工作时，一个端口接收到数据信号后，集线器将该信号整形放大，紧接着转发到其他所有处于工作状态的端口。因为集线器不具备交换机所具有的交换表，所以它发送数据时是没有针对性的，而采用广播方式发送。因此，使用集线器的星形以太网逻辑上仍然是总线网。',
'总线形、环形',
'网状、星形',
'总线形、星形',
'星形、总线形'),

(10, '00000000-0000-0000-0000-000000127010', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'用集线器连接的工作站集合（ ）。',
'A',
'集线器的功能是将从一个端口收到的数据通过所有其他端口转发出去。集线器在物理层上扩大了网络的覆盖范围，但无法解决冲突域（第二层交换机可解决）与广播域（第三层交换机可解决）的问题，而且增大了冲突的范围。注意，冲突域和广播域的概念涉及后面章节的内容。',
'同属一个冲突域，也同属一个广播域',
'不同属一个冲突域，但同属一个广播域',
'不同属一个冲突域，也不同属一个广播域',
'同属一个冲突域，但不同属一个广播域'),

(11, '00000000-0000-0000-0000-000000127011', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'中继器可以用来连接（ ）。',
'C',
'中继器工作在物理层，无法对帧进行解封与重新封装（无法实现协议转换），其功能仅限于对接收到的帧对应的二进制串进行无差别转发，因此无法连接不同链路层协议的网段。中继器可以连接不同介质的局域网，如光纤和双绞线，只要它们具有相同协议。',
'不同类型的局域网',
'广域网和局域网',
'不同介质的局域网',
'不同协议的局域网'),

(12, '00000000-0000-0000-0000-000000127012', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'若有5台计算机连接到10Mb/s的集线器上，则每台计算机分得的平均带宽至多为（ ）。',
'A',
'集线器以广播的方式将信号从除输入端口外的所有端口输出，因此任意时刻只能有一个端口的有效数据输入。理想情况（无冲突）下，每秒通过集线器的数据量都是10Mb，假设5台计算机占用相同大小的时间片来收发数据，则平均带宽的上限为10Mb/s÷5=2Mb/s。若有多台计算机同时发送数据，则会导致每台计算机实际获得的平均带宽低于2Mb/s。',
'2Mb/s',
'5Mb/s',
'10Mb/s',
'50Mb/s'),

(13, '00000000-0000-0000-0000-000000127013', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'当集线器的一个端口收到数据后，将其（ ）。',
'B',
'集线器没有寻址功能，一个端口接收到数据信号后，从其他所有端口转发出去。',
'从所有端口广播出去',
'从除输入端口外的所有端口广播出去',
'根据目的地地址从合适的端口转发出去',
'随机选择一个端口转发出去'),

(14, '00000000-0000-0000-0000-000000127014', 'CN_PHYSICAL', 'CN_PHYSICAL_DEVICE', 'BASIC', 'MOCK', 2027, '2.3物理层设备', 'pp.58,59',
'下列关于中继器和集线器的说法中，不正确的是（ ）。',
'C',
'中继器和集线器均工作在物理层，集线器本质上是一个多端口中继器，它们都能对信号进行放大和整形（再生=放大+整形）。因为中继器不仅传送有用信号，也传送噪声和冲突信号，因此互相串联的个数只能在规定的范围内进行，否则网络将不可用。注意"5-4-3规则"。',
'二者都工作在OSI参考模型的物理层',
'二者都可以对信号进行放大和整形',
'通过中继器或集线器互连的网段数量不受限制',
'中继器通常只有2个端口，而集线器通常有4个或更多端口');

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
    '原题来自《2027年计算机网络考研复习指导》第2章 物理层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共14道纯文本单选题，含5道统考真题（2022/2023/2024/2012/2018）。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch2_b_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000127', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch2_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000127', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch2_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000127', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch2_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000127', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch2_b_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch2_b_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new tags exist
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000127101', 'CN-2027-ORIGINAL-CH2-B-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000127102', '2.3物理层设备')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch2_b_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机网络',
    'CN-2027-ORIGINAL-CH2-B-TEXT-ONLY',
    '第2章物理层',
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
DROP TABLE cn_2027_original_ch2_b_text_import;
