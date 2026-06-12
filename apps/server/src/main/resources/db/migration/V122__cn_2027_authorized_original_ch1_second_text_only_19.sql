-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 1: 计算机网络体系结构 (1.2 计算机网络体系结构与参考模型, second batch).
-- Text-only batch: 19 remaining pure-text questions from 1.2.
-- Deferred: Q10 (TCP header diagram), Q23 (multi-blank 5 blanks), Q28 (multi-blank 3 blanks).
-- Batch: CN-2027-ORIGINAL-CH1-B-TEXT-ONLY

-- ============================================================
-- Ensure chapter exists (reuse from V117)
-- ============================================================
INSERT INTO chapters (id, subject_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000117201',
    s.id,
    'CN_OVERVIEW',
    '计算机网络体系结构',
    20
FROM subjects s
WHERE s.code = 'COMPUTER_NETWORK'
  AND NOT EXISTS (SELECT 1 FROM chapters c WHERE c.code = 'CN_OVERVIEW');

-- ============================================================
-- Ensure knowledge points exist (reuse from V117)
-- ============================================================
INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000117302',
    c.id,
    'CN_ARCHITECTURE',
    '计算机网络体系结构与参考模型',
    2
FROM chapters c
WHERE c.code = 'CN_OVERVIEW'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_ARCHITECTURE');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch1_b_text_import (
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

INSERT INTO cn_2027_original_ch1_b_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 1.2 计算机网络体系结构与参考模型 Q18-Q22, Q24-Q27, Q29-Q38 (19 questions)
-- Q18-Q22, Q24-Q27: 模拟题 (MOCK, 2027)
-- Q29-Q38: 统考真题 (PAST_EXAM)
-- Deferred: Q10 (TCP header diagram), Q23 (multi-blank), Q28 (multi-blank)
-- ============================================================

(1, '00000000-0000-0000-0000-000000121001', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,39',
'在ISO/OSI参考模型中，可同时提供无连接服务和面向连接服务的是（ ）。',
'C',
'ISO/OSI参考模型在网络层支持无连接和面向连接的通信，但在传输层仅支持面向连接的通信；TCP/IP模型在网络层仅有无连接的通信，而在传输层支持无连接和面向连接的通信。两类协议栈的区别是联考的考点。',
'物理层', '数据链路层', '网络层', '传输层'),

(2, '00000000-0000-0000-0000-000000121002', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,39',
'在OSI参考模型中，当两台计算机进行文件传输时，为防止中间出现网络故障而重传整个文件的情况，可通过在文件中插入同步点来解决，这个动作发生在（ ）。',
'B',
'在OSI参考模型中，会话层的两个主要服务是会话管理和同步。会话层使用检验点使通信会话在通信失效时从检验点继续恢复通信，实现数据同步。',
'表示层', '会话层', '网络层', '应用层'),

(3, '00000000-0000-0000-0000-000000121003', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,39',
'数据的格式转换及压缩属于OSI参考模型中（ ）的功能。',
'B',
'OSI参考模型表示层的功能有数据解密与加密、压缩、格式转换等。',
'应用层', '表示层', '会话层', '传输层'),

(4, '00000000-0000-0000-0000-000000121004', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,39',
'OSI参考模型中（ ）通过设置检验点，使通信双方在通信失效时可从检验点恢复通信。',
'D',
'会话层的主要功能是建立、管理和终止进程间的会话，以及使用检查点（或称检验点）使会话在通信失效时从检验点继续恢复通信，实现数据同步。',
'传输层', '应用层', '表示层', '会话层'),

(5, '00000000-0000-0000-0000-000000121005', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,39',
'下列说法中正确描述了OSI参考模型中数据的封装过程的是（ ）。',
'B',
'数据链路层在分组上除增加源和目的物理地址外，也增加控制信息；传输层的PDU不称为帧；表示层不负责将高层协议产生的数据分割成数据段，负责增加相应源和目的端口信息的应是传输层。选项B正确描述了OSI参考模型中数据的封装过程，数据经过网络层后，只是增加了第三层协议控制信息。',
'数据链路层在分组上仅增加了源物理地址和目的物理地址', '网络层将高层协议产生的数据封装成分组，并增加第三层的地址和控制信息', '传输层将数据流封装成数据帧，并增加可靠性和流控制信息', '表示层将高层协议产生的数据分割成数据段，并增加相应的源和目的端口信息'),

(6, '00000000-0000-0000-0000-000000121006', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,39-40',
'OSI参考模型中，（ ）利用通信子网提供的服务实现两个进程之间的端到端通信。',
'B',
'在OSI参考模型中，数据链路层提供链路上相邻节点之间的逻辑通信，网络层提供主机之间的逻辑通信，传输层在运行于不同主机上的进程之间（端到端）提供逻辑通信。',
'网络层', '传输层', '会话层', '表示层'),

(7, '00000000-0000-0000-0000-000000121007', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,40',
'互联网采用的核心技术是（ ）。',
'A',
'协议是网络上计算机之间进行信息交换和资源共享时共同遵守的约定，没有协议的存在，网络的作用也就无从谈起。在互联网中应用的网络协议是采用分组交换技术的TCP/IP，它是互联网的核心技术。',
'TCP/IP', '局域网技术', '远程通信技术', '光纤技术'),

(8, '00000000-0000-0000-0000-000000121008', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,40',
'在TCP/IP模型中，（ ）处理关于可靠性、流量控制和错误校正等问题。',
'C',
'TCP/IP模型的传输层提供端到端的通信，并且负责差错控制和流量控制，可以提供可靠的面向连接服务或不可靠的无连接服务。',
'网络接口层', '网际层', '传输层', '应用层'),

(9, '00000000-0000-0000-0000-000000121009', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'MOCK', 2027, '1.2计算机网络体系结构与参考模型', 'pp.36,40',
'上下相邻层实体之间的接口称为服务访问点，应用层的服务访问点也称（ ）。',
'A',
'在同一系统中，相邻两层的实体交换信息的逻辑接口称为服务访问点（SAP），N层的SAP是N+1层可以访问N层服务的地方。在5层体系结构中，数据链路层的服务访问点为帧的"类型"字段，网络层的服务访问点为IP数据报的"协议"字段，传输层的服务访问点为"端口号"字段，应用层的服务访问点为"用户接口"。',
'用户接口', '网卡接口', 'IP地址', 'MAC地址'),

-- Q29-Q38: 统考真题

(10, '00000000-0000-0000-0000-000000121010', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2009, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2009统考真题】在OSI参考模型中，自下而上第一个提供端到端服务的层是（ ）。',
'B',
'在OSI参考模型中，传输层是自下而上第一个提供端到端服务的层，通过端口号实现应用进程间的逻辑通信。数据链路层仅负责相邻节点（如交换机、路由器等中间设备）之间的通信，而网络层提供主机到主机的通信，不提供面向应用进程的服务。',
'数据链路层', '传输层', '会话层', '应用层'),

(11, '00000000-0000-0000-0000-000000121011', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2010, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2010统考真题】下列选项中，不属于网络体系结构所描述的内容是（ ）。',
'C',
'网络体系结构是指各层及其协议的集合，涵盖网络的层次划分、每层的功能及所用的协议，因此选项A、B、D均属于描述内容。而协议的内部实现细节属于实现问题，不由体系结构规定。',
'网络的层次', '每层使用的协议', '协议的内部实现细节', '每层必须完成的功能'),

(12, '00000000-0000-0000-0000-000000121012', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2013, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2013统考真题】在OSI参考模型中，功能需由应用层的相邻层实现的是（ ）。',
'B',
'在OSI参考模型中，应用层的相邻下层是表示层（第6层），负责处理与数据表示相关的问题。其主要功能包括数据字符集转换、数据格式转换、文本压缩以及加密与解密等。',
'对话管理', '数据格式转换', '路由选择', '可靠数据传输'),

(13, '00000000-0000-0000-0000-000000121013', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2014, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2014统考真题】在OSI参考模型中，直接为会话层提供服务的是（ ）。',
'C',
'在OSI参考模型中，各层直接为其上一层提供服务，而会话层的下一层是传输层。',
'应用层', '表示层', '传输层', '网络层'),

(14, '00000000-0000-0000-0000-000000121014', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2016, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2016统考真题】在OSI参考模型中，路由器、交换机（Switch）、集线器（Hub）实现的最高功能层分别是（ ）。',
'C',
'集线器（Hub）是多端口中继器，工作在物理层（第1层）；以太网交换机（Switch）是多端口网桥，工作在数据链路层（第2层）；路由器是网络层设备，最高工作在第3层。因此，三者实现的最高功能层分别为网络层、数据链路层和物理层。',
'2、2、1', '2、2、2', '3、2、1', '3、2、2'),

(15, '00000000-0000-0000-0000-000000121015', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2017, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2017统考真题】假设OSI参考模型的应用层欲发送400B的数据（无拆分），除物理层和应用层外，其他各层在封装PDU时均引入20B的额外开销，则应用层的数据传输效率约为（ ）。',
'A',
'OSI参考模型共7层，中间5层每层引入20B开销，共增加100B开销。原始数据为400B，总传输量为500B；故传输效率为400B÷500B = 80%。',
'80%', '83%', '87%', '91%'),

(16, '00000000-0000-0000-0000-000000121016', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2019, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2019统考真题】OSI参考模型的第5层（自下而上）完成的主要功能是（ ）。',
'C',
'OSI参考模型自下而上的第5层为会话层，主要功能是管理和协调不同主机上各种进程之间的通信（对话），即负责建立、管理和终止应用程序间的会话。',
'差错控制', '路由选择', '会话管理', '数据表示转换'),

(17, '00000000-0000-0000-0000-000000121017', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2020, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2020统考真题】下图描述的协议要素是（ ）。
I. 语法
II. 语义
III. 时序',
'C',
'协议由语法、语义和时序三要素组成：语法规定数据格式，语义定义控制信息含义，时序规定交互顺序。题图中发送方与接收方按特定顺序交互，体现了协议的时序要素。',
'仅I', '仅II', '仅III', 'I、II和III'),

(18, '00000000-0000-0000-0000-000000121018', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2021, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2021统考真题】在TCP/IP模型中，由传输层相邻的下一层实现的主要功能是（ ）。',
'B',
'在TCP/IP模型中，传输层的下一层是网际层，其主要功能是为分组选择路由并转发，即实现路由选择；它提供无连接、不可靠的尽力而为的服务，不保证有序交付。端到端报文段传输属于传输层功能，对话管理由应用层处理。TCP/IP网际层不提供节点到节点的流量控制功能。',
'对话管理', '路由选择', '端到端报文段传输', '节点到节点流量控制'),

(19, '00000000-0000-0000-0000-000000121019', 'CN_OVERVIEW', 'CN_ARCHITECTURE', 'BASIC', 'PAST_EXAM', 2022, '1.2计算机网络体系结构与参考模型', 'pp.37,40',
'【2022统考真题】在ISO/OSI参考模型中，实现两个相邻节点间流量控制功能的是（ ）。',
'B',
'在OSI参考模型中，流量控制功能在多个层次存在：数据链路层实现相邻节点之间的流量控制，网络层关注整个网络中的拥塞与流量调节，传输层则提供端到端的流量控制。本题明确要求"两个相邻节点间"的流量控制，因此由数据链路层实现。',
'物理层', '数据链路层', '网络层', '传输层');

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
    '原题来自《2027年计算机网络考研复习指导》第1章 计算机网络体系结构 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共19道纯文本单选题，无图片/表格/版式依赖题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch1_b_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000121', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch1_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000121', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch1_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000121', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch1_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000121', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch1_b_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch1_b_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new tags exist
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000121101', 'CN-2027-ORIGINAL-CH1-B-TEXT-ONLY')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags (reuse existing tags from V117 for book/chapter/section)
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch1_b_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机网络',
    'CN-2027-ORIGINAL-CH1-B-TEXT-ONLY',
    '第1章计算机网络体系结构',
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
DROP TABLE cn_2027_original_ch1_b_text_import;
