-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 4: 4.2.4/4.2.5 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH4-A

CREATE TABLE ds_2027_original_ch4_a_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch4_a_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000051001', 'BASIC', 'pp.130-131', '设有两个串 S1 和 S2，求 S2 在 S1 中首次出现的位置的运算称为（ ）。', 'C', '求子串操作是从串 S 中截取第 i 个字符起长度为 l 的子串。选项 A 错误。选项 B、D 明显错误。', '求子串', '判断是否相等', '模式匹配', '连接'),
(2, '00000000-0000-0000-0000-000000051002', 'BASIC', 'pp.130-131', 'KMP 算法的特点是在模式匹配时，指示主串的指针（ ）。', 'B', '在 KMP 算法的比较过程中，主串不会回溯，所以主串的指针不会变小。', '不会变大', '不会变小', '都有可能', '无法判断'),
(3, '00000000-0000-0000-0000-000000051003', 'MEDIUM', 'pp.130-131', '设主串的长度为 n，子串的长度为 m，则简单的模式匹配算法的时间复杂度为（ ），KMP 算法的时间复杂度为（ ）。候选项：A. O(m)；B. O(n)；C. O(mn)；D. O(m+n)。两个空依次应填（ ）。', 'C', '尽管实际应用中，一般情况下简单的模式匹配算法的时间复杂度近似为 O(m+n)，但它的理论时间复杂度仍是 O(mn)。KMP 算法的时间复杂度为 O(m+n)。', 'A、B', 'B、A', 'C、D', 'D、C'),
(4, '00000000-0000-0000-0000-000000051004', 'MEDIUM', 'pp.130-131', '在 KMP 算法中，用 next 数组存放模式串中的部分匹配信息，当模式串位 j 与主串位 i 比较时，两个字符不相等，则 j 的位移方式是（ ）。', 'D', '在 KMP 算法中，当主串的第 i 个字符和模式串的第 j 个字符不匹配时，主串的位置指针不变，将主串的第 i 个字符与模式串的第 next[j] 个字符比较，即 j=next[j]。', 'j=0', 'j=j+1', 'j 不变', 'j=next[j]'),
(5, '00000000-0000-0000-0000-000000051005', 'BASIC', 'pp.130-131', '在 KMP 算法中，用 next 数组存放模式串中的部分匹配信息，当模式串位 j 与主串位 i 比较时，两个字符不相等，则 i 的位移方式是（ ）。', 'B', '在 KMP 算法中，当主串的第 i 个字符和模式串的第 j 个字符失配时，主串指针 i 不回溯。', 'i=next[i]', 'i 不变', 'i=0', 'i=i+1'),
(6, '00000000-0000-0000-0000-000000051006', 'HARD', 'pp.130-131', '串 ''ababaaababaa'' 的 next 数组为（ ）。', 'C', '本题采用先求串 S=''ababaaababaa'' 的部分匹配值，再求 next 数组的方法。依次求出的部分匹配值整体右移一位并低位用 1 填充，可得 next 数组为 0,1,1,2,3,4,2,2,3,4,5,6。', '0,1,2,3,4,5,6,7,8,9,9', '0,1,2,1,2,1,1,1,1,2,1,2', '0,1,1,2,3,4,2,2,3,4,5,6', '0,1,2,3,0,1,2,3,2,2,3,4,5'),
(7, '00000000-0000-0000-0000-000000051007', 'MEDIUM', 'pp.130-132', '设主串 S=''aabaaaba''，模式串 T=''aaab''，采用 KMP 算法进行模式匹配，到匹配成功时为止，在匹配过程中进行的单个字符间的比较次数是（ ）。', 'B', '假设位序从 1 开始，手工计算出 T 的 next 数组为 0,1,2,3。采用 KMP 算法时：第一趟经过 3 次比较后发现 S[3] 与 T[3] 失配；第二趟用 S[3] 和 T[2] 比较，不相等；第三趟用 S[3] 和 T[1] 比较，不相等；第四趟从 S[4] 和 T[1] 开始，经过 4 次比较后匹配成功。总比较次数为 3+1+1+4=9。', '10', '9', '8', '7'),
(8, '00000000-0000-0000-0000-000000051008', 'MEDIUM', 'pp.130,132', '设主串 S=''aabaaaba''，模式串 T=''aaab''，采用改进后的 KMP 算法进行模式匹配，到匹配成功时为止，在匹配过程中进行的单个字符间的比较次数是（ ）。', 'C', '假设位序从 1 开始，T 的 nextval 数组为 0,0,0,3。采用改进的 KMP 算法时，第一趟经过 3 次比较后发现 S[3] 与 T[3] 失配；第二趟 nextval[3]=0，因此从 S[4] 和 T[1] 开始，经过 4 次比较后匹配成功。总比较次数为 3+4=7。', '9', '8', '7', '6'),
(9, '00000000-0000-0000-0000-000000051009', 'HARD', 'pp.130,132', 'KMP 算法使用 nextval 数组进行模式匹配，模式串为 S=''ababaaa''，当主串中的某个字符与 S 中的第 6 个字符失配时，S 向右滑动的距离是（ ）。', 'B', '假设位序从 0 开始，计算出 nextval 数组。当比较到 S[j] 失配时，模式串向右滑动的距离为 j-nextval[j]。当 j=5 时，向右滑动的距离为 5-3=2。此外，也可直接模拟：与第 6 个字符匹配失败，说明前面的 ababa 匹配成功，S 可向右滑动 2 位继续尝试匹配。', '1', '2', '3', '4');

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
    'MOCK',
    2027,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 4 章 4.2.4/4.2.5 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch4_a_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STRING';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000151', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch4_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000151', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch4_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000151', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch4_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000151', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch4_a_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch4_a_import q
JOIN knowledge_points kp ON kp.code = 'DS_STRING_KMP';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000051701', 'DS-2027-ORIGINAL-CH4-A'),
    ('00000000-0000-0000-0000-000000051702', '第4章串'),
    ('00000000-0000-0000-0000-000000051703', '4.2串的模式匹配')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch4_a_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH4-A',
    '第4章串',
    '4.2串的模式匹配',
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容'
)
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_original_ch4_a_import;
