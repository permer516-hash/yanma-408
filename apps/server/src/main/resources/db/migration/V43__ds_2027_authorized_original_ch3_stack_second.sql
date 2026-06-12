-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.1.4/3.1.5 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-B

CREATE TABLE ds_2027_original_ch3_b_import (
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

INSERT INTO ds_2027_original_ch3_b_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(14, '00000000-0000-0000-0000-000000043014', 'MEDIUM', 'pp.80,82', '设 a、b、c、d、e、f 以所给的次序入栈，若在入栈操作时，允许出栈操作，则下面不会出现的出栈序列为（ ）。', 'D', '根据栈“先进后出”的特点，且在入栈操作的同时允许出栈操作，选项 D 中 c 最先出栈，则此时栈内必定为 a 和 b，但因为 a 先于 b 入栈，所以 a 要晚于 b 出栈。对于某个出栈的元素，在它之前入栈却晚出栈的元素必定按逆序出栈，其余序列均是可能出现的情况。', 'fedcba', 'bcafed', 'dcefba', 'cabdef'),
(15, '00000000-0000-0000-0000-000000043015', 'MEDIUM', 'pp.80,83', '4 个元素依次入栈的次序为 abcd，则以 cd 开头的出栈序列的个数为（ ）。', 'A', '假设出栈序列为 cd...，分析栈的操作序列：a 入栈，b 入栈，c 入栈，c 出栈，d 入栈，d 出栈。此后只能是 b 出栈和 a 出栈一种情况，因此出栈序列只有 cdba。', '1', '2', '3', '4'),
(16, '00000000-0000-0000-0000-000000043016', 'MEDIUM', 'pp.80,83', '用 S 表示入栈操作，用 X 表示出栈操作，若元素的入栈顺序是 1234，为了得到 1342 的出栈顺序，相应的 S 和 X 的操作序列为（ ）。', 'D', '采用排除法，选项 A、B、C 得到的出栈序列分别不是 1342。由 1234 得到 1342 的进出栈序列为：1 进，1 出，2 进，3 进，3 出，4 进，4 出，2 出，所以选择选项 D。', 'SXSXSSXX', 'SSSXXSXX', 'SXSSXXSX', 'SXSSXSXX'),
(17, '00000000-0000-0000-0000-000000043017', 'MEDIUM', 'pp.80,83', '若栈的输入序列是 1,2,3,...,n，输出序列的第一个元素是 n，则第 i 个输出元素是（ ）。', 'D', '第 n 个元素第一个出栈，说明前 n-1 个元素都已经按顺序入栈。由“先进后出”的特点可知，此时的输出序列一定是输入序列的逆序，所以第 i 个输出元素是 n-i+1。', '不确定', 'n-i', 'n-i-1', 'n-i+1'),
(18, '00000000-0000-0000-0000-000000043018', 'MEDIUM', 'pp.80,83', '若栈的输入序列是 1,2,3,...,n，输出序列的第一个元素是 i，则第 j 个输出元素是（ ）。', 'D', '当第 i 个元素第一个出栈时，i 之前的元素可以依次排在 i 之后出栈，但剩余的元素也可在此时入栈，并且排在 i 之前的元素出栈，所以第 j 个出栈的元素是不确定的。', 'i-j-1', 'i-j', 'j-i+1', '不确定'),
(19, '00000000-0000-0000-0000-000000043019', 'MEDIUM', 'pp.80,83', '某栈的输入序列为 a、b、c、d，下面的 4 个序列中，不可能为其输出序列的是（ ）。', 'C', '选项 A、B、D 都可以通过相应的入栈、出栈操作得到。若出栈序列的第一个元素为 d，则出栈序列只能是 d、c、b、a，因此选项 C 不可能出现。', 'a,b,c,d', 'c,b,d,a', 'd,c,a,b', 'a,c,b,d'),
(20, '00000000-0000-0000-0000-000000043020', 'HARD', 'pp.80,83', '若栈的输入序列是 P1,P2,...,Pn，输出序列是 1,2,3,...,n，若 P3=1，则 P1 的值（ ）。', 'C', '输入序列是 P1,P2,P3,...,Pn，且 P3=1。P1、P2、P3 连续入栈后第一个出栈元素是 1，说明 P1、P2 已经按序入栈。根据先进后出的特点可知，P2 必定在 P1 之前出栈，而第二个出栈元素是 2，此时 P1 不是栈顶元素，所以 P1 的值不可能是 2。', '可能是 2', '一定是 2', '不可能是 2', '不可能是 3'),
(21, '00000000-0000-0000-0000-000000043021', 'HARD', 'pp.80,83', '若栈的输入序列是 P1,P2,...,Pn，输出序列是 1,2,3,...,n，若 P3=3，则 P1 的值（ ）。', 'A', '假设 P1 是 1，入栈后立即出栈，P2 是 2，入栈后立即出栈，P3 是 3，入栈后立即出栈，得到的序列符合题意。假设 P1 是 2，P2 是 1，P1、P2 依次入栈后全部出栈，P3 是 3，入栈后立即出栈，得到的序列也符合题意。因此，P1 既可能是 1，也可能是 2。', '可能是 2', '不可能是 1', '一定是 1', '一定是 2'),
(22, '00000000-0000-0000-0000-000000043022', 'HARD', 'pp.80,83', '已知栈的入栈序列是 1,2,3,4，其出栈序列为 P1,P2,P3,P4，则 P2、P4 不可能是（ ）。', 'C', '逐个判断每个选项可能的入栈出栈顺序。选项 C 没有对应的序列：当 4 在栈中时，意味着前面的所有元素 1、2、3 都已在栈中或曾经入过栈，若 4 第一个出栈，且栈中还有两个元素，则 P2 不可能为 3。', '2,4', '2,1', '4,3', '3,4'),
(23, '00000000-0000-0000-0000-000000043023', 'MEDIUM', 'pp.80,83-84', '设栈的初始状态为空，当字符序列“n1_”作为栈的输入时，输出长度为 3，且可用作 C 语言标识符的序列有（ ）个。', 'C', '标识符只能以英文字母或下划线开头，而不能以数字开头。符合条件且可由栈操作得到的标识符共有 3 个。', '4', '5', '3', '6'),
(24, '00000000-0000-0000-0000-000000043024', 'BASIC', 'pp.80,84', '采用共享栈的好处是（ ）。', 'B', '上溢是指存储器满还往里写，下溢是指存储器空还往外读。共享栈的提出就是为了在解决上溢的基础上节省存储空间，将两个栈放在同一段更大的存储空间内，当一个栈的元素增加时，可以利用另一个栈的空闲空间，从而降低发生上溢的可能性。', '减少存取时间，降低发生上溢的可能', '节省存储空间，降低发生上溢的可能', '减少存取时间，降低发生下溢的可能', '节省存储空间，降低发生下溢的可能'),
(25, '00000000-0000-0000-0000-000000043025', 'BASIC', 'pp.80,84', '设有一个顺序共享栈 Share[0:n-1]，其中第一个栈顶指针 top1 的初值为 -1，第二个栈顶指针 top2 的初值为 n，则判断共享栈满的条件是（ ）。', 'A', '两个栈共享同一段数组空间，分别从两端向中间增长。第一个栈从低地址向高地址增长，第二个栈从高地址向低地址增长，当两个栈顶相邻时共享栈满，即 top2-top1==1。', 'top2-top1==1', 'top1-top2==1', 'top1==top2', '都不对');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 3 章 3.1.4/3.1.5 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch3_b_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STACK_QUEUE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000143', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000143', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000143', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_b_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000143', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_b_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_b_import q
JOIN knowledge_points kp ON kp.code = 'DS_STACK_QUEUE_APPLICATION';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000043701', 'DS-2027-ORIGINAL-CH3-B')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_b_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-B',
    '第3章栈队列和数组',
    '3.1栈',
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

DROP TABLE ds_2027_original_ch3_b_import;
