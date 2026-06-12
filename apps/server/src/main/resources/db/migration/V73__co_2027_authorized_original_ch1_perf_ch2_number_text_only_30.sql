-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 1: finish 1.3 performance indicators; Chapter 2: start 2.1 number representation.
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Batch: CO-2027-ORIGINAL-CH1-B-CH2-A-TEXT-ONLY

CREATE TABLE co_2027_original_ch1b_ch2a_text_import (
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

INSERT INTO co_2027_original_ch1b_ch2a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000073001', 'CO_OVERVIEW', 'CO_OVERVIEW_SYSTEM', 'MEDIUM', 'PAST_EXAM', 2023, '1.3计算机性能指标', 'pp.15,17', '【2023 统考真题】若机器 M 的主频为 1.5GHz，在 M 上执行程序 P 的指令条数为 5×10^5，P 的平均 CPI 为 1.2，则 P 在 M 上的指令执行速度和用户 CPU 时间分别为（ ）。', 'C', '指令执行速度 = 主频 / 平均 CPI = 1.5×10^9 / 1.2 = 1.25GIPS。总时钟周期数 = 5×10^5×1.2 = 6×10^5，用户 CPU 时间 = 6×10^5 / 1.5×10^9 s = 0.4ms。', '0.8GIPS，0.4ms', '0.8GIPS，0.4us', '1.25GIPS，0.4ms', '1.25GIPS，0.4us'),
(2, '00000000-0000-0000-0000-000000073002', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,29-30', '若十进制数为 137.5，则其八进制数为（ ）。', 'B', '整数部分采用除基取余法，小数部分采用乘基取整法。137 的八进制为 211，0.5×8=4，因此十进制数 137.5 转换为八进制数为 211.4。', '89.8', '211.4', '211.5', '1011111.101'),
(3, '00000000-0000-0000-0000-000000073003', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '一个 16 位无符号二进制数的表示范围是（ ）。', 'B', '16 位无符号二进制数的表示范围是 0～2^16-1，即 0～65535。', '0～65536', '0～65535', '-32768～32767', '-32768～32768'),
(4, '00000000-0000-0000-0000-000000073004', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '下列说法有误的是（ ）。', 'D', '二进制整数和十进制整数可以相互转换；二进制小数也可以用十进制表示。但二进制小数位只能表示 1/2、1/4、1/8 等权值的组合，因此无法精确表示所有十进制小数。', '任何二进制整数都可以用十进制表示', '任何二进制小数都可以用十进制表示', '任何十进制整数都可以用二进制表示', '任何十进制小数都可以用二进制表示'),
(5, '00000000-0000-0000-0000-000000073005', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '对真值 0 表示形式唯一的机器数是（ ）。', 'B', '原码和反码中 0 有 +0 和 -0 两种形式；补码和移码中 0 的表示形式唯一。', '原码', '补码和移码', '反码', '以上都不对'),
(6, '00000000-0000-0000-0000-000000073006', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '若 [X]补=1.1101010，则 [X]原=（ ）。', 'B', 'X 为负数时，补码转换为原码的规则是符号位不变，数值位取反，末位加 1。对 1101010 的数值位处理得 0010110，因此 [X]原=1.0010110。', '1.0010101', '1.0010110', '0.0010110', '0.1101010'),
(7, '00000000-0000-0000-0000-000000073007', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '若 X 为负数，则由 [X]补 求 [-X]补 是将（ ）。', 'D', '求相反数的补码可对原补码连同符号位一起取反，末位加 1。', '[X]补各位保持不变', '[X]补符号位变反，其他各位不变', '[X]补除符号位外，各位变反，末位加 1', '[X]补连同符号位一起变反，末位加 1'),
(8, '00000000-0000-0000-0000-000000073008', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '8 位原码能表示的不同数据有（ ）个。', 'C', '8 个二进制位共有 2^8=256 种不同表示。原码中 0 有两种表示，因此能表示的不同数据个数为 2^8-1=255。', '15', '16', '255', '256'),
(9, '00000000-0000-0000-0000-000000073009', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '一个 n+1 位整数 x 原码的数值范围是（ ）。', 'D', 'n+1 位整数原码含 1 位符号位和 n 位数值位，最大正数为 2^n-1，最小负数为 -(2^n-1)，因此范围为 -2^n+1≤x≤2^n-1。', '-2^n+1<x<2^n-1', '-2^n+1≤x<2^n-1', '-2^n+1<x≤2^n-1', '-2^n+1≤x≤2^n-1'),
(10, '00000000-0000-0000-0000-000000073010', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27,30', '若定点整数为 64 位，含 1 位符号位，则采用补码表示的绝对值最大的负数为（ ）。', 'C', '对于含 1 位符号位的 64 位定点整数，补码能表示的最小值为 -2^63，这也是绝对值最大的负数。', '-2^64', '-(2^64-1)', '-2^63', '-(2^63-1)'),
(11, '00000000-0000-0000-0000-000000073011', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.27-28,30', '下列关于补码和移码关系的叙述中，（ ）是不正确的。', 'B', '相同位数的补码和移码具有相同的数据表示范围；同一个数的补码和移码数值部分相同、符号位相反。0 的补码为全 0，而移码为符号位为 1、其余位为 0，二者表示不同。', '相同位数的补码和移码表示具有相同的数据表示范围', '0 的补码和移码表示相同', '同一个数的补码和移码表示，其数值部分相同，而符号位相反', '一般用移码表示浮点数的阶码，而补码表示定点整数'),
(12, '00000000-0000-0000-0000-000000073012', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.1数制与编码', 'pp.28,30', '若[x]补=1,x1x2x3x4x5x6，其中 xi 取 0 或 1，若要 x>-32，应当满足（ ）。', 'C', '-32 的补码为 1.100000。对负数补码，数值位越小，绝对值越大；若要 x>-32，则数值位 x1x2x3x4x5x6 必须大于 100000，即 x1 为 1 且 x2～x6 中至少有一位为 1。', 'x1 为 0，其他各位任意', 'x1 为 1，其他各位任意', 'x1 为 1，x2～x6 中至少有一位为 1', 'x1 为 0，x2～x6 中至少有一位为 1'),
(13, '00000000-0000-0000-0000-000000073013', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.1数制与编码', 'pp.28,30', '设 x 为整数，[x]补=1,x1x2x3x4x5，若要 x<-16，x1～x5 应满足的条件是（ ）。', 'C', '-16 的补码为 1.10000。对负数补码，数值位越小，绝对值越大；若要 x<-16，则数值位 x1x2x3x4x5 需小于 10000，即 x1 必须为 0，x2～x5 任意。', 'x1～x5 至少有一个为 1', 'x1 必须为 0，x2～x5 至少有一个为 1', 'x1 必须为 0，x2～x5 任意', 'x1 必须为 1，x2～x5 任意'),
(14, '00000000-0000-0000-0000-000000073014', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.1数制与编码', 'pp.28,30', '设 x 为真值，x* 为其绝对值，满足 [-x*]补=[-x]补，当且仅当（ ）。', 'D', '当 x 为 0 或正数时可满足该关系，但“x 为正数”只是充分条件；当 x 为负数时，x* 为正数而 -x* 为负数，[-x*]补 与 [-x]补 不等。因此给出的 A、B、C 均不成立。', 'x 任意', 'x 为正数', 'x 为负数', '以上说法都不对'),
(15, '00000000-0000-0000-0000-000000073015', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '假定一个十进制数为 -66，按补码形式存放在一个 8 位寄存器中，该寄存器的内容用十六进制表示为（ ）。', 'B', '-66 的 8 位原码为 11000010，按负数补码转换规则可得补码为 10111110，即 BEH。', 'C2H', 'BEH', 'BDH', '42H'),
(16, '00000000-0000-0000-0000-000000073016', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '该机器数采用补码表示（含 1 位符号位），若寄存器内容为 9BH，则对应的十进制数为（ ）。', 'C', '9BH=(10011011)2，最高位为 1，表示负数。按补码求真值得 -(64+32+4+1)=-101。', '-27', '-97', '-101', '155'),
(17, '00000000-0000-0000-0000-000000073017', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '若寄存器内容为 10000000，若它等于 -0，则为（ ）。', 'A', '补码和移码中 0 的表示唯一，没有 +0 和 -0 之分；8 位原码的 -0 表示为 10000000。', '原码', '补码', '反码', '移码'),
(18, '00000000-0000-0000-0000-000000073018', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '若寄存器内容为 11111111，若它等于 +127，则为（ ）。', 'D', '8 位 +127 的原码、反码和补码均为 01111111。同一数值的移码和补码除最高位相反外，其余各位相同，因此 +127 的移码为 11111111。', '反码', '补码', '原码', '移码'),
(19, '00000000-0000-0000-0000-000000073019', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '若寄存器内容为 11111111，若它等于 -1，则为（ ）。', 'B', '8 位 -1 的补码为 11111111，因此该机器数为补码。', '原码', '补码', '反码', '移码'),
(20, '00000000-0000-0000-0000-000000073020', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '若寄存器内容为 00000000，若它等于 -128，则为（ ）。', 'D', '8 位移码可表示 -128，其移码为 2^7+(-128)=00000000。', '原码', '补码', '反码', '移码'),
(21, '00000000-0000-0000-0000-000000073021', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '若二进制定点小数真值是 -0.1101，机器表示为 1.0010，则为（ ）。', 'C', '真值 -0.1101 的原码为 1.1101，补码为 1.0011，反码为 1.0010；移码通常用于表示阶码，不用于表示定点小数。', '原码', '补码', '反码', '移码'),
(22, '00000000-0000-0000-0000-000000073022', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '下列为 8 位移码机器数[x]移，求[-x]补时，（ ）将会发生溢出。', 'B', '选项 B 对应 8 位移码能表示的最小值 -128，而 -x=128 超出 8 位带符号补码可表示范围，因此发生溢出。', '11111111', '00000000', '10000000', '01111111'),
(23, '00000000-0000-0000-0000-000000073023', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '一个 8 位的二进制整数由 2 个“0”和 6 个“1”组成，采用补码或者移码表示，则下列说法中正确的是（ ）。', 'A', '采用补码时，最大值为 01111110B=126，最小值为 10011111B=-97；采用移码且偏置值为 127 时，最小值为 00111111B-01111111B=-64，因此选项 A 正确。', '若采用移码表示，偏置值为 127，则此整数最小为 -64', '若采用移码表示，偏置值为 128，则此整数最大为 123', '若采用补码表示，则此整数最小为 -96', '若采用补码表示，则此整数最大为 252'),
(24, '00000000-0000-0000-0000-000000073024', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '用 2 个“1”和 6 个“0”组成的 8 位二进制补码，所能表示的最大整数和最小整数之差为（ ）。', 'A', '8 位补码中，要使数值最大，符号位为 0 且两个 1 尽可能置于高位，得 01100000B=96；要使数值最小，符号位为 1 且另一个 1 置于最低位，得 10000001B=-127。二者之差为 223。', '223', '128', '191', '159'),
(25, '00000000-0000-0000-0000-000000073025', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28,31', '计算机内部的定点数大多用补码表示，以下是一些关于补码特点的叙述：\nI. 零的表示是唯一的\nII. 符号位可以和数值部分一起参加运算\nIII. 和其真值的对应关系简单、直观\nIV. 减法可用加法来实现\n在以上叙述中，（ ）是补码表示的特点。', 'D', '补码中 0 的表示唯一；补码运算时符号位可作为数的一部分参加运算；减法可以通过加负数补码实现。补码与真值的对应关系不如原码直观，因此 III 错误。', 'I 和 II', 'I 和 III', 'I 和 II 和 III', 'I 和 II 和 IV'),
(26, '00000000-0000-0000-0000-000000073026', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.28-29,31', '在计算机中，通常用来表示主存地址的是（ ）。', 'D', '主存地址均为非负值，不需要符号位，因此通常采用无符号数表示。', '移码', '补码', '原码', '无符号数'),
(27, '00000000-0000-0000-0000-000000073027', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.1数制与编码', 'pp.29,31', '16 位补码整数 0x8FA0 扩展为 32 位应该是（ ）。', 'B', '补码整数由 16 位扩展为 32 位时需要符号扩展。0x8FA0 最高位为 1，是负数，扩展高位应补 1，因此为 0xFFFF 8FA0。', '0x0000 8FA0', '0xFFFF 8FA0', '0xFFFF FFA0', '0x8000 8FA0'),
(28, '00000000-0000-0000-0000-000000073028', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2012, '2.1数制与编码', 'pp.29,31', '【2012 统考真题】假定编译器规定 int 型和 short 型长度分别为 32 位和 16 位，执行下列 C 语言语句：\nunsigned short x=65530;\nunsigned int y=x;\n得到 y 的机器数为（ ）。', 'B', '16 位 unsigned short 转换为 32 位 unsigned int 时，高位补 0。65530=65535-5，十六进制表示为 FFFAH，因此 y 的机器数为 0000 FFFAH。', '0000 7FFAH', '0000 FFFAH', 'FFFF 7FFAH', 'FFFF FFFAH'),
(29, '00000000-0000-0000-0000-000000073029', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2015, '2.1数制与编码', 'pp.29,32', '【2015 统考真题】由 3 个“1”和 5 个“0”组成的 8 位二进制补码，能表示的最小整数是（ ）。', 'B', '8 位补码中，负数的符号位为 1。要使数值最小，应让剩下两个 1 放在最低位，得补码 10000011B，转换为真值为 -125。', '-126', '-125', '-32', '-3'),
(30, '00000000-0000-0000-0000-000000073030', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2016, '2.1数制与编码', 'pp.29,32', '【2016 统考真题】有如下 C 语言程序段：\nshort si = -32767;\nunsigned short usi = si;\n执行上述两条语句后，usi 的值为（ ）。', 'D', 'C 语言中的整数在内存中通常按补码表示。-32767 的 16 位补码为 1000000000000001B；将 signed short 转换为等长 unsigned short 后机器码不变，但按无符号数解释，其值为 32769。', '-32767', '32767', '32768', '32769');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 1 章 1.3.2/1.3.3 收尾与第 2 章 2.1.5/2.1.6 本节试题精选及答案解析；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch1b_ch2a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000173', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch1b_ch2a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000173', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch1b_ch2a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000173', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch1b_ch2a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000173', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch1b_ch2a_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch1b_ch2a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000073701', 'CO-2027-ORIGINAL-CH1-B-CH2-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000073702', '第2章数据的表示和运算'),
    ('00000000-0000-0000-0000-000000073703', '2.1数制与编码')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch1b_ch2a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH1-B-CH2-A-TEXT-ONLY',
    CASE WHEN q.chapter_code = 'CO_OVERVIEW' THEN '第1章计算机系统概述' ELSE '第2章数据的表示和运算' END,
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

DROP TABLE co_2027_original_ch1b_ch2a_text_import;
