-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 4: 网络层 (4.2 IPv4 Q67+Q70, completing the section).
-- Text-only batch: 2 pure-text questions (last 2 text-only in 4.2).
-- Deferred from Q67-Q72 range: Q68(2022拓扑图), Q69(2023 NAT拓扑图), Q71(2024 VLAN图), Q72(2025 DHCP图).
-- Batch: CN-2027-ORIGINAL-CH4-C-TEXT-ONLY

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch4_c_text_import (
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

INSERT INTO cn_2027_original_ch4_c_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 4.2 IPv4 Q67 (PAST_EXAM 2022)
-- ============================================================
(1, '00000000-0000-0000-0000-000000136001', 'CN_NETWORK', 'CN_IPV4', 'BASIC', 'PAST_EXAM', 2022, '4.2 IPv4', 'pp.163-164',
'【2022统考真题】若某主机的IP地址是183.80.72.48，子网掩码是255.255.192.0，则该主机所在网络的网络地址是（ ）。',
'B',
'主机所在网络的网络地址可以通过主机的IP地址和子网掩码逐位"与"得到。子网掩码255.255.192.0的二进制前18位为1、后14位为0。183.80.72.48的第三段72=01001000，子网掩码第三段192=11000000，逐位"与"得01000000=64。把主机IP地址的后14位变为0，得到的结果为183.80.64.0，即为主机所在网络的网络地址。',
'183.80.0.0', '183.80.64.0', '183.80.72.0', '183.80.192.0'),

-- ============================================================
-- 4.2 IPv4 Q70 (PAST_EXAM 2023)
-- ============================================================
(2, '00000000-0000-0000-0000-000000136002', 'CN_NETWORK', 'CN_IPV4', 'MEDIUM', 'PAST_EXAM', 2023, '4.2 IPv4', 'pp.163-164',
'【2023统考真题】主机168.16.84.24/20所在子网的最小可分配IP地址和最大可分配IP地址分别是（ ）。',
'B',
'网络号位数为20=8×2+4，子网掩码为11111111 11111111 11110000 00000000即255.255.240.0。将它与主机地址168.16.84.24进行逐位"与"：84=01010100，240=11110000，相"与"得01010000=80，因此网络地址为168.16.80.0/20。该网段共有2¹²−2个可供分配的IP地址，地址范围是168.16.80.1～168.16.95.254（广播地址为168.16.95.255）。因此最小可分配IP地址为168.16.80.1，最大为168.16.95.254。',
'168.16.80.1, 168.16.84.254', '168.16.80.1, 168.16.95.254', '168.16.84.1, 168.16.84.254', '168.16.84.1, 168.16.95.254');

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
    '原题来自《2027年计算机网络考研复习指导》第4章 网络层 4.2节 本节试题精选。原始页码：' || t.source_pages || '。本批为4.2 IPv4收尾，共2道纯文本单选题（Q67+Q70，均为统考真题），跳过Q68/Q69/Q71/Q72（含拓扑图/VLAN图/DHCP图需手工导入）。4.2 IPv4本节试题精选已全部完成。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch4_c_text_import t
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = t.chapter_code;

-- ============================================================
-- Insert question-knowledge_point relationships
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(t.id AS UUID), kp.id
FROM cn_2027_original_ch4_c_text_import t
JOIN knowledge_points kp ON kp.code = t.kp_code;

-- ============================================================
-- Insert options (4 per question)
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000136', LPAD(CAST((t.num*4-3) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'A',
    t.option_a,
    1
FROM cn_2027_original_ch4_c_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000136', LPAD(CAST((t.num*4-2) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'B',
    t.option_b,
    2
FROM cn_2027_original_ch4_c_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000136', LPAD(CAST((t.num*4-1) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'C',
    t.option_c,
    3
FROM cn_2027_original_ch4_c_text_import t
UNION ALL
SELECT
    CAST(CONCAT('00000000-0000-0000-0001-000000136', LPAD(CAST((t.num*4-0) AS VARCHAR), 3, '0')) AS UUID),
    CAST(t.id AS UUID),
    'D',
    t.option_d,
    4
FROM cn_2027_original_ch4_c_text_import t;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000136901', 'CN-2027-ORIGINAL-CH4-C-TEXT-ONLY')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

-- Batch tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_c_text_import t
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH4-C-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Section tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_c_text_import t
JOIN question_tags tag ON tag.name = '4.2 IPv4'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- Standard tags for all questions
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(t.id AS UUID), tag.id
FROM cn_2027_original_ch4_c_text_import t
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容', '真题')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(t.id AS UUID) AND r.tag_id = tag.id
);

-- ============================================================
-- Clean up
-- ============================================================
DROP TABLE cn_2027_original_ch4_c_text_import;
