-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 4: 网络层 (4.3 IPv6 Q01-Q07).
-- Text-only batch: 7 pure-text questions.
-- No deferred items in this batch.
-- Batch: CN-2027-ORIGINAL-CH4-E-TEXT-ONLY

-- ============================================================
-- Ensure knowledge point exists
-- ============================================================
INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000138301',
    c.id,
    'CN_IPV6',
    'IPv6',
    3
FROM chapters c WHERE c.code = 'CN_NETWORK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_IPV6');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch4_e_text_import (
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

INSERT INTO cn_2027_original_ch4_e_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 4.3 IPv6 Q01 (MOCK) - p.184
-- ============================================================
(1, '00000000-0000-0000-0000-000000138001', 'CN_NETWORK', 'CN_IPV6', 'BASIC', 'MOCK', 2027, '4.3 IPv6', 'p.184',
'下一代互联网核心协议IPv6的地址长度是（ ）。',
'D',
'IPv6的地址用16B（128比特）表示，比IPv4长得多，地址空间是IPv4的2^96倍。',
'32比特', '48比特', '64比特', '128比特'),

-- ============================================================
-- 4.3 IPv6 Q02 (MOCK) - p.184
-- ============================================================
(2, '00000000-0000-0000-0000-000000138002', 'CN_NETWORK', 'CN_IPV6', 'BASIC', 'MOCK', 2027, '4.3 IPv6', 'p.184',
'与IPv4相比，IPv6（ ）。',
'D',
'IPv6采用128位地址。IPv6减少了首部字段数量，仅包含8个字段。IPv6支持QoS（在有限的带宽资源下，为业务提供端到端的服务质量保证），以满足实时、多媒体通信的需要。因为目前网络传输介质的可靠性较高，所以出现比特错误的可能性很低，且数据链路层和传输层有自己的检验，为了效率，IPv6没有检验和字段。',
'使用32位IP地址', '增加了首部字段数量', '不提供QoS保障', '没有提供检验和字段'),

-- ============================================================
-- 4.3 IPv6 Q03 (MOCK) - p.184
-- ============================================================
(3, '00000000-0000-0000-0000-000000138003', 'CN_NETWORK', 'CN_IPV6', 'MEDIUM', 'MOCK', 2027, '4.3 IPv6', 'p.184',
'下列关于IPv6地址1A22:120D:0000:0000:72A2:0000:0000:00C0的表示中，错误的是（ ）。',
'C',
'使用零压缩法时，双冒号"::"（表示零压缩）在一个地址中只能出现一次。也就是说，当有多处不相邻的0时，只能用"::"代表其中的一处。选项C中1A22::120D和结尾的::都使用了零压缩，出现了两次"::"，因此错误。',
'1A22:120D::72A2:0000:0000:00C0',
'1A22:120D::72A2:0:0:C0',
'1A22::120D:72A2:00C0',
'1A22:120D:0:072A2::C0'),

-- ============================================================
-- 4.3 IPv6 Q04 (MOCK) - pp.184-185
-- ============================================================
(4, '00000000-0000-0000-0000-000000138004', 'CN_NETWORK', 'CN_IPV6', 'MEDIUM', 'MOCK', 2027, '4.3 IPv6', 'pp.184-185',
'一个IPv6地址的简化写法为8::D0:123:CDEF:89A，则其完整地址应该是（ ）。',
'D',
'冒号十六进制记法表示IPv6地址的规则：①多个连续区域为0，可进行零压缩，但一个地址仅可出现一次零压缩。②每个区域开头的0可省略，结尾的0不可省略。按照规则先将题中零压缩的部分展开，得到8:0000:0000:0000:D0:123:CDEF:89A；每个区域应该有4位十六进制数，不足4位则表示开头的0被省略，补充后得到0008:0000:0000:0000:00D0:0123:CDEF:089A。',
'8000:0000:0000:0000:00D0:1230:CDEF:89A0',
'0008:0000:0000:0000:00D0:0123:CDEF:89A0',
'8000:0000:0000:0000:D000:1230:CDEF:89A0',
'0008:0000:0000:0000:00D0:0123:CDEF:089A'),

-- ============================================================
-- 4.3 IPv6 Q05 (MOCK) - p.185
-- ============================================================
(5, '00000000-0000-0000-0000-000000138005', 'CN_NETWORK', 'CN_IPV6', 'MEDIUM', 'MOCK', 2027, '4.3 IPv6', 'p.185',
'下列关于IPv6的描述中，错误的是（ ）。',
'D',
'IPv6的首部长度是固定的，因此不需要首部长度字段。IPv6取消了检验和字段，这样就加快了路由器处理数据报的速度。数据链路层会丢弃检测出差错的帧，传输层也有相应的差错处理机制，因此网络层的差错检测可以精简掉。',
'IPv6的首部长度是不可变的',
'IPv6不允许在中间路由器进行分片',
'IPv6采用了16B的地址，在可预见的将来不会用尽',
'IPv6使用了首部检验和来保证传输的正确性'),

-- ============================================================
-- 4.3 IPv6 Q06 (MOCK) - p.185
-- ============================================================
(6, '00000000-0000-0000-0000-000000138006', 'CN_NETWORK', 'CN_IPV6', 'BASIC', 'MOCK', 2027, '4.3 IPv6', 'p.185',
'若一个路由器收到的IPv6数据报因太大而不能转发到出链路上，则路由器将把该数据报（ ）。',
'A',
'IPv6中不允许在中间路由器进行分片。因此，若路由器发现到来的数据报太大而不能转发到出链路上，则丢弃该数据报，并向发送方发送一个指示分组太大的ICMP报文。',
'丢弃', '暂存', '分片', '转发至能支持该数据报的链路上'),

-- ============================================================
-- 4.3 IPv6 Q07 (PAST_EXAM 2023) - p.185
-- ============================================================
(7, '00000000-0000-0000-0000-000000138007', 'CN_NETWORK', 'CN_IPV6', 'MEDIUM', 'PAST_EXAM', 2023, '4.3 IPv6', 'p.185',
'【2023统考真题】下列关于IPv4和IPv6的叙述中，正确的是（ ）。
I. IPv6地址空间是IPv4地址空间的96倍
II. IPv4首部和IPv6基本首部的长度均可变
III. IPv4向IPv6过渡可以采用双协议栈和隧道技术
IV. IPv6首部的Hop Limit字段等价于IPv4首部的TTL字段',
'D',
'IPv4地址为32位，地址空间为2^32；IPv6地址为128位，地址空间为2^128。IPv6地址空间是IPv4地址空间的2^96倍，说法I错误。IPv4首部长度是4B的倍数，长度可变；IPv6基本首部长度是40B，不可变，说法II错误。IPv4向IPv6过渡可以采用双协议栈（设备同时支持IPv4和IPv6）和隧道技术（IPv6数据报封装IPv4的数据部分），说法III正确。IPv6首部的Hop Limit字段和IPv4首部的TTL字段都用于限制数据报在网络中经过的路由器数量，说法IV正确。',
'仅I、II', '仅I、IV', '仅II、III', '仅III、IV');

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
    '原题来自《2027年计算机网络考研复习指导》第4章 网络层 4.3节 本节试题精选。原始页码：' || t.source_pages || '。本批为4.3 IPv6全部7道纯文本单选题（Q01-Q07，含1道2023统考真题），无图片/表格依赖题。4.3本节试题精选已全部完成。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch4_e_text_import t
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = t.chapter_code;

-- ============================================================
-- Insert question-knowledge_point relationships
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(t.id AS UUID), kp.id
FROM cn_2027_original_ch4_e_text_import t
JOIN knowledge_points kp ON kp.code = t.kp_code;

-- ============================================================
-- Insert options (4 per question)
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000138', LPAD(CAST((t.num*4-3) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'A',
    t.option_a,
    1
FROM cn_2027_original_ch4_e_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000138', LPAD(CAST((t.num*4-2) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'B',
    t.option_b,
    2
FROM cn_2027_original_ch4_e_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000138', LPAD(CAST((t.num*4-1) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'C',
    t.option_c,
    3
FROM cn_2027_original_ch4_e_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000138', LPAD(CAST((t.num*4-0) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'D',
    t.option_d,
    4
FROM cn_2027_original_ch4_e_text_import t;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000138901', 'CN-2027-ORIGINAL-CH4-E-TEXT-ONLY')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

-- Batch tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_e_text_import t
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH4-E-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Section tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_e_text_import t
JOIN question_tags tag ON tag.name = '4.3 IPv6'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Standard tags for all questions
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_e_text_import t
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Past exam tag for Q07 (num=7)
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_e_text_import t
JOIN question_tags tag ON tag.name = '真题'
WHERE t.source_type = 'PAST_EXAM'
AND NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- ============================================================
-- Clean up
-- ============================================================
DROP TABLE cn_2027_original_ch4_e_text_import;
