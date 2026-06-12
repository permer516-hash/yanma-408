-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 4: 4.1 指令格式 (Q1-Q16, pure text only).
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Deferred in this section: none (all 16 single-choice questions are text-only).
-- Batch: CO-2027-ORIGINAL-CH4-A-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000098301',
    c.id,
    'CO_INSTRUCTION_FORMAT',
    '指令格式',
    2
FROM chapters c
WHERE c.code = 'CO_INSTRUCTION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_INSTRUCTION_FORMAT');

CREATE TABLE co_2027_original_ch4_a_text_import (
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

INSERT INTO co_2027_original_ch4_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 4.1 指令格式 Q1-Q12 (模拟题), Q13 (2017真题), Q14-Q15 (2022真题), Q16 (2025真题)
-- 全部16道单选题均为纯文本，无图片/表格依赖
-- ============================================================
(1, '00000000-0000-0000-0000-000000098001', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '下列关于指令集体系结构和指令系统的说法中，错误的是（ ）。',
 'D',
 '指令集体系结构（ISA）完整定义了软件和硬件之间的接口，是机器语言或汇编语言程序员所应熟悉的。指令系统是计算机硬件的语言系统，这显然和机器语言有关。',
 '指令集体系结构位于计算机软/硬件的交界面上', '指令集体系结构是指低级语言程序员所看到的概念结构和功能特性', '任何程序运行前都要先转换为机器语言程序', '指令系统和机器语言是无关的'),

(2, '00000000-0000-0000-0000-000000098002', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '下列有关指令集体系结构（ISA）的叙述中，错误的是（ ）。',
 'A',
 '指令集体系结构（ISA）是软件和硬件之间接口的一个完整定义，包含了基本数据类型、指令集、寄存器、寻址模式、存储体系、中断和异常处理及外部I/O。ISA规定了执行每条指令时所需要的操作码、操作数、寻址方式等信息，以及指令的功能和效果。控制信号是由控制单元根据ISA生成的，它属于微架构层面的实现细节，而不是ISA层面的抽象定义。',
 'ISA规定了执行每条指令时所包含的控制信号', 'ISA规定了指令获取操作数的方式，即寻址方式', 'ISA规定了所有指令的集合，包括指令格式和操作类型', 'ISA规定了程序可访问的寄存器个数、存储空间大小、编址方式和大端/小端方式'),

(3, '00000000-0000-0000-0000-000000098003', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '运算型指令的寻址与转移型指令的寻址的不同点在于（ ）。',
 'A',
 '运算型指令寻址的是操作数，而转移型指令寻址的是下次欲执行的指令的地址。',
 '前者取操作数，后者决定程序转移地址', '后者取操作数，前者决定程序转移地址', '前者是短指令，后者是长指令', '前者是长指令，后者是短指令'),

(4, '00000000-0000-0000-0000-000000098004', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '程序控制类指令的功能是（ ）。',
 'D',
 '程序控制类指令用于改变程序执行的顺序，并使程序具有测试、分析、判断和循环执行的能力。',
 '进行算术运算和逻辑运算', '进行主存与CPU之间的数据传送', '进行CPU和I/O设备之间的数据传送', '改变程序执行的顺序'),

(5, '00000000-0000-0000-0000-000000098005', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '下列指令中不属于程序控制类指令的是（ ）。',
 'C',
 '程序控制类指令主要包括无条件转移、条件转移、子程序调用和返回指令、循环指令等。中断隐指令是由硬件实现的，并不是指令系统中存在的指令，更不可能属于程序控制类指令。',
 '无条件转移指令', '条件转移指令', '中断隐指令', '循环指令'),

(6, '00000000-0000-0000-0000-000000098006', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '以下叙述错误的是（ ）。',
 'B',
 '指令的地址个数与指令的长度是否固定没有必然联系，即使是单地址指令，也可能由于单地址的寻址方式不同而导致指令长度不同。',
 '为了便于取指令，指令的长度通常为存储字长的整数倍', '单地址指令是固定长度的指令', '单字长指令可加快取指令的速度', '单地址指令可能有一个操作数，也可能有两个操作数'),

(7, '00000000-0000-0000-0000-000000098007', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '某指令系统有200条指令，对操作码采用固定长度二进制编码，最少需要用（ ）位。',
 'B',
 '因128=2^7<200≤2^8=256，因此采用定长操作码时，至少需要8位。',
 '4', '8', '16', '32'),

(8, '00000000-0000-0000-0000-000000098008', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'BASIC', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '在指令格式中，采用扩展操作码设计方案的目的是（ ）。',
 'C',
 '扩展操作码并未改变指令的长度，而是使操作码长度随地址码的减少而增加。',
 '减少指令字长度', '增加指令字长度', '保持指令字长度不变而增加指令的数量', '保持指令字长度不变而增加寻址空间'),

(9, '00000000-0000-0000-0000-000000098009', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '一个计算机系统采用32位单字长指令，地址码为12位，若定义了250条二地址指令，则还可以有（ ）条单地址指令。',
 'D',
 '地址码为12位，二地址指令的操作码长度32-12-12=8位，已定义了250条二地址指令，2^8-250=6，即可以设计出单地址指令6×2^12=3×2^13条。',
 '2^12', '2^13', '2^4', '3×2^13'),

(10, '00000000-0000-0000-0000-000000098010', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '假设系统采用16位定长指令字格式，操作码使用扩展编码方式，地址码为4位，三地址、二地址、一地址指令各有15、8、127条，则零地址指令最多有（ ）条。',
 'B',
 '指令长16位，地址码各4位。三地址指令：操作码4位，最多16种，用15种，剩1种（1111）用于扩展，所有非三地址指令的操作码的高4位均为1111，共2^12=4096个编码。二地址指令：8条，每条占2^8=256个编码（因有8位地址），共占8×256=2048个，剩余编码为4096-2048=2048个。一地址指令：127条，每条占2^4=16个编码，共占127×16=2032个，剩余编码2048-2032=16个。这些编码无地址字段，每个可以定义一条零地址指令，故最多16条。',
 '15', '16', '31', '32'),

(11, '00000000-0000-0000-0000-000000098011', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '某指令系统的指令字长为16位，地址码长度为6位。若已定义二地址指令15条、一地址指令48条，则零地址指令最多可定义（ ）条。',
 'D',
 '操作码按从短到长进行扩展编码。指令字长16位，地址码占6位。二地址指令含两个地址码（共12位），操作码为高4位，可编码2^4=16种；15条指令可使用编码0000～1110，剩余1111用作扩展。一地址指令的高4位固定为1111，中间6位用作扩展操作码，共2^6=64种组合；实际使用48条，剩余64-48=16个编码可用作零地址扩展。零地址指令无地址字段，其高10位由1111拼接上述16个空闲扩展码构成，低6位自由取值，故最多可定义16×2^6=16×64=1024条。',
 '255', '256', '1023', '1024'),

(12, '00000000-0000-0000-0000-000000098012', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'MOCK', 2027, '4.1指令格式', 'pp.151-153,155-157',
 '某机器的指令字长为12位，采用扩展操作码技术，支持零地址、一地址和二地址3种指令格式，地址码长度均为4位。若一地址和二地址指令均取最大可能条数，则该机器最多可定义的指令总数为（ ）。',
 'B',
 '二地址指令的操作码占4位，共2^4=16种编码，保留1个用于扩展，最多定义15条。一地址指令利用该保留编码，将第二个4位地址字段作为扩展操作码，得到2^4=16种组合，再保留其中1个用于零地址扩展，最多可定义15条。零地址指令则使用这一保留编码，将剩余的4位全部作为操作码，可定义2^4=16条。因此，指令总数最多15+15+16=46条。',
 '16', '46', '48', '4366'),

(13, '00000000-0000-0000-0000-000000098013', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'PAST_EXAM', 2017, '4.1指令格式', 'pp.151-153,155-157',
 '【2017统考真题】某计算机按字节编址，指令字长固定且只有两种指令格式，其中三地址指令29条、二地址指令107条，每个地址字段为6位，则指令字长至少应该是（ ）。',
 'A',
 '三地址指令有29条，所以其操作码至少5位。以5位进行计算，它剩余32-29=3种操作码给二地址。而二地址额外多了6位给操作码，因此其数量最大达3×64=192。所以指令字长最少为23位，因为计算机按字节编址，需要是8的倍数，所以指令字长至少应该是24位。',
 '24位', '26位', '28位', '32位'),

(14, '00000000-0000-0000-0000-000000098014', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'PAST_EXAM', 2022, '4.1指令格式', 'pp.151-153,155-157',
 '【2022统考真题】下列选项中，属于指令集体系结构（ISA）规定的内容是（ ）。
I. 指令字格式和指令类型
II. CPU的时钟周期
III. 通用寄存器个数和位数
IV. 加法器的进位方式',
 'B',
 '指令集体系结构处于软/硬件的交界面上。指令字和指令格式、通用寄存器个数和位数都与机器指令有关，由ISA规定。两个CPU可以有不同的时钟周期，但指令集可以相同；加法器的进位方式涉及电路设计，这两项都属于计算机的硬件部分，不由ISA规定。',
 '仅I、II', '仅I、III', '仅II、IV', '仅I、II、IV'),

(15, '00000000-0000-0000-0000-000000098015', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'PAST_EXAM', 2022, '4.1指令格式', 'pp.151-153,155-157',
 '【2022统考真题】设计某指令系统时，假设采用16位定长指令字格式，操作码使用扩展编码方式，地址码为6位，包含零地址、一地址和二地址3种格式的指令。若二地址指令有12条，一地址指令有254条，则零地址指令的条数最多为（ ）。',
 'D',
 '地址码为6位，一条二地址指令会占用2^6条一地址指令的空间，一条一地址指令会占用2^6条零地址指令的空间。若全都是零地址指令，则最多有2^16条，减去一地址指令和二地址指令所占用的零地址指令空间，即2^16-254×2^6-12×2^6×2^6=(2^10-254-12×2^6)×2^6=2×2^6=128。另解：二地址指令有12条，则剩余16-12=4种操作码给一地址指令，一地址指令有254条，剩余4×64-254=2种操作码给零地址指令，所以零地址一共有2×2^6=128条。',
 '0', '2', '64', '128'),

(16, '00000000-0000-0000-0000-000000098016', 'CO_INSTRUCTION', 'CO_INSTRUCTION_FORMAT', 'MEDIUM', 'PAST_EXAM', 2025, '4.1指令格式', 'pp.151-153,155-157',
 '【2025统考真题】在下列选项中，由指令集体系结构（ISA）规定的是（ ）。',
 'B',
 '指令集体系结构（ISA）是软件和硬件之间的抽象接口，定义了机器语言程序员可见的处理器行为，包括指令集、数据类型、寄存器、寻址方式及指令编码格式等。指令字是否定长属于编码格式的一部分，直接影响机器代码解析与程序设计，由ISA明确规定。而阵列乘法器、微程序控制器和单总线数据通路均属于微架构实现细节，对程序员不可见，不在ISA范畴内。',
 '是否采用阵列乘法器', '是否采用定长指令字格式', '是否采用微程序控制器', '是否采用单总线数据通路');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 4 章 4.1 指令格式本节试题精选及答案解析；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch4_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000198', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch4_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000198', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch4_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000198', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch4_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000198', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch4_a_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch4_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000098701', 'CO-2027-ORIGINAL-CH4-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000098702', '4.1指令格式')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch4_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH4-A-TEXT-ONLY',
    '第4章指令系统',
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
DROP TABLE co_2027_original_ch4_a_text_import;
