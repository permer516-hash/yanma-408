-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 4: 4.3 程序的机器级代码表示 (Q1-Q11, pure text only).
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Deferred in this section: Q12 (circled-number options ①②③④⑤⑥ for procedure-call step order,
--   OCR cannot reliably transcribe the exact option strings).
-- Batch: CO-2027-ORIGINAL-CH4-C-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000102301',
    c.id,
    'CO_MACHINE_LEVEL_CODE',
    '程序的机器级代码表示',
    4
FROM chapters c
WHERE c.code = 'CO_INSTRUCTION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_MACHINE_LEVEL_CODE');

CREATE TABLE co_2027_original_ch4_c_text_import (
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

INSERT INTO co_2027_original_ch4_c_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 4.3 程序的机器级代码表示 Q1-Q11 (全为模拟题)
-- 共11道纯文本单选题；Q12为过程调用步骤排序题（选项含带圈数字），暂缓入库
-- ============================================================

(1, '00000000-0000-0000-0000-000000102001', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'BASIC', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.181,187',
 '假设 R[ax]=FFE8H, R[bx]=7FE6H, 执行指令 "add ax, bx" 后, 寄存器的内容和各标志的变化为（ ）。',
 'C',
 '该指令是 Intel 格式, add 指令的目的寄存器为 ax。add 指令的补码加法过程为 1111 1111 1110 1000 + 0111 1111 1110 0110 = (0)0111 1111 1100 1110 (7FCEH), 两个操作数的符号不同, 必然不会溢出, OF=0; 结果的符号位为 0, SF=0; 有进位, CF=Cout⊕Sub=1⊕0=1; 非 0, ZF=0。无论是无符号数还是有符号数, 都以二进制代码形式无差别地存放在计算机内。即便两个有符号数相加, 也会导致 CF 的变动, 只是 CF 值对有符号数运算是没有意义的。同理, 两个无符号数相加, 也会导致 OF 和 SF 的变动, 只是 OF 值和 SF 值仅对有符号数运算有意义。',
 'R[ax]=7FCEH, OF=1, SF=0, CF=0, ZF=0', 'R[bx]=7FCEH, OF=1, SF=0, CF=0, ZF=0', 'R[ax]=7FCEH, OF=0, SF=0, CF=1, ZF=0', 'R[bx]=7FCEH, OF=0, SF=0, CF=1, ZF=0'),

(2, '00000000-0000-0000-0000-000000102002', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'BASIC', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.181,187',
 '假设 R[ax]=7FE6H, R[bx]=FFE8H, 执行指令 "sub bx, ax" 后, 寄存器的内容和各标志的变化为（ ）。',
 'B',
 '该指令是 Intel 格式, sub 指令的目的寄存器为 bx。sub 减法运算用补码加法实现, 被减数 + 减数逐位取反 + 1 = 1111 1111 1110 1000 + 1000 0000 0001 1001 + 1 = (1)1000 0000 0000 0010 (8002H), 两个操作数的符号位都是 1, 结果的符号位也是 1, 无溢出, OF=0; 结果为负数, SF=1; 进位输出 Cout=1, 低位进位 Sub=1, CF=Cout⊕Sub=1⊕1=0; 非 0, ZF=0。',
 'R[ax]=8002H, OF=0, SF=1, CF=1, ZF=0', 'R[bx]=8002H, OF=0, SF=1, CF=0, ZF=0', 'R[ax]=8002H, OF=1, SF=1, CF=0, ZF=0', 'R[bx]=8002H, OF=1, SF=1, CF=0, ZF=0'),

(3, '00000000-0000-0000-0000-000000102003', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'MEDIUM', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.181-182,187',
 '若计算机的数据采用小端方式存储, 减法指令 "sub ax, imm" 的功能为 (ax)-imm→ax, imm 表示立即数, 该指令对应的十六进制机器码为 2dxxxx（从左到右以字节为单位由低地址到高地址）, 其中 xxxx 对应 imm 的机器码, 若 imm=-3, (ax)=7, 则该指令对应的机器码和执行后 OF 标志位的值分别为（ ）。',
 'C',
 'imm 的值为 -3, 转换成二进制为 1111111111111101B, 即 FFFDH, 因为该计算机采用小端存储, 先存储低位字节, 所以该指令对应的机器码为 2DFDFFH。OF 是有符号数运算的溢出标志位, 7-(-3) 显然没有溢出, 因此 OF 标志位为 0。',
 '2DFFFDH, 0', '2DFFFDH, 1', '2DFDFFH, 0', '2DFDFFH, 1'),

(4, '00000000-0000-0000-0000-000000102004', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'MEDIUM', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.182,187',
 '若 C 语言程序中对数组变量 b 的声明为 "int b[10][5];", 有一条 for 语句如下：
for (i=0; i<10; i++)
  for (j=0; j<5; j++)
    sum += b[i][j];
假设执行到 "sum+=b[i][j];" 时, sum 的值在 eax 中, b[i][0] 所在的地址在 edx 中, j 在 esi 中, 则 "sum+=b[i][j];" 所对应的指令（Intel 格式）可以是（ ）。',
 'A',
 'b[i][0] 所在的地址在 edx 中, j 在 esi 中, 一个数组元素占 4 字节, 所以 b[i][j] 的地址为 R[edx]+R[esi]*4, 指令格式为 Intel 格式, 第一个为目的操作数, 第二个为源操作数, 于是选项 A 正确。',
 'add dword ptr eax, [edx+esi*4]', 'add dword ptr eax, [esi+edx*4]', 'add dword ptr eax, [edx+esi*2]', 'add dword ptr eax, [esi+edx*2]'),

(5, '00000000-0000-0000-0000-000000102005', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'MEDIUM', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.182,187',
 '假设 R[eax]=080480B4H, R[ebx]=00000011H, M[080480F8H]=000000B0H, 执行指令 "imul eax, [eax+ebx*4], -16" 后, 寄存器或存储单元的内容变为（ ）。',
 'C',
 '指令的一个源操作数在内存单元中, 地址为 R[eax]+R[ebx]*4 = 080480B4H+00000011H*4 = 080480F8H。指令的功能是 R[eax]←M[080480F8H]*(-16) = (-000000B0H)<<4 = FFFFFF50H<<4 = FFFFF500H。目的操作数保存在 eax 中, 所以主存单元 080480F8H 中的内容不会改变。',
 'R[eax]=00000B00H', 'M[080480F8H]=00000B00H', 'R[eax]=FFFFF500H', 'M[080480F8H]=FFFFF500H'),

(6, '00000000-0000-0000-0000-000000102006', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'MEDIUM', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.182,187',
 '程序 P 中有两个变量 i 和 j, 被分别分配在寄存器 eax 和 edx 中, P 中语句 "if(i<j) {...}" 对应的指令序列如下（左边为指令地址, 中间为机器代码, 右边为汇编指令）, 其中 jle 指令的偏移量为 0d：
804846a 39 c2    cmp dword ptr edx, eax
804846c 7e 0d    jle ...
若执行到 804846aH 处的 cmp 指令时, i=105, j=100, 则 jle 指令执行后将转到（ ）处的指令执行。',
 'D',
 'i=105, j=100, 即 edx 的内容为 100, eax 的内容为 105, cmp 指令就是对这两个数做减法, 显然 100<105, 满足 jle 指令小于或等于的条件, jle 指令长度为 2 字节, 所以 jle 指令执行后将转移到当前 PC 值+偏移量 = 804846cH+2+0dH = 804847bH 处执行。',
 '8048461H', '804846eH', '8048479H', '804847bH'),

(7, '00000000-0000-0000-0000-000000102007', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'MEDIUM', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.182,188',
 '假定全局数组 a 的声明为 double a[8], a 的首地址为 80498c0H, 变量 i 被分配在寄存器 ecx 中, 现要将 a[i] 取到 EAX 相应宽度的寄存器中, 则所用的汇编指令是（ ）。',
 'C',
 '每个 double 型的数组元素占 8 字节, 数组 a 的首地址为 80498c0H, i 存储在 ecx 中, 所以 a[i] 在主存中的地址可表示为 [ecx*8+80498c0H], 因此汇编指令可以是 mov eax, [ecx*8+80498c0H]。',
 'mov eax, [ecx*4+80498c0H]', 'mov eax, ecx*4+80498c0H', 'mov eax, [ecx*8+80498c0H]', 'mov eax, ecx*8+80498c0H'),

(8, '00000000-0000-0000-0000-000000102008', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'BASIC', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.182,188',
 '子程序调用指令执行时, 必须完成的操作是（ ）。',
 'B',
 '子程序调用指令属于控制转移类指令, 其执行时必须完成两个关键操作：一是保存返回地址（调用指令的下一条指令地址）, 通常压入主存中的栈；二是将子程序的入口地址送入 PC, 以实现转移。选项 A 仅完成转移, 缺失返回地址保存, 无法正确返回。选项 C 和 D 的描述不准确或不完整。因此, 选项 B 正确且完整地描述了子程序调用的本质功能。',
 '仅将子程序入口地址送入程序计数器（PC）', '将返回地址存入主存, 并将子程序入口地址送入程序计数器（PC）', '将程序计数器（PC）当前值存入通用寄存器', '修改数据通路中的控制信号以实现转移'),

(9, '00000000-0000-0000-0000-000000102009', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'BASIC', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.183,188',
 '下列关于选择结构语句 "if(comp_A) then statement_B; else statement_C" 对应的机器级代码表示的叙述中, 错误的是（ ）。',
 'D',
 '在 if 语句的机器级代码中, comp_A 后面紧接有一个条件转移指令, 条件成立则转移到 statement_B, statement_B 中有一个无条件转移指令, 会转移到 if-else 的下一条语句, 选项 A、B 和 C 正确。statement_B 不一定在 statement_C 之前, 这取决于条件转移指令的类型和方向, 选项 D 错误。',
 '一定包含一条无条件转移指令', '一定包含一条条件转移指令（分支指令）', '计算 comp_A 的代码段一定在条件转移指令之前', '对应 statement_B 的代码一定在对应 statement_C 的代码之前'),

(10, '00000000-0000-0000-0000-000000102010', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'BASIC', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.183,188',
 '下列关于循环结构语句的机器级代码表示的叙述中, 错误的是（ ）。',
 'D',
 '循环结构循环体内最后会有一条条件转移指令, 判断是否跳出循环, 可以用比较指令（CMP）来实现, 选项 A 和 C 正确, 选项 D 错误。循环结构不一定包含无条件转移指令, 选项 B 正确。',
 '一定至少包含一条条件转移指令', '不一定包含无条件转移指令', '循环结束条件可以用一条比较指令 CMP 来实现', '循环体内执行的指令不包含条件转移指令'),

(11, '00000000-0000-0000-0000-000000102011', 'CO_INSTRUCTION', 'CO_MACHINE_LEVEL_CODE', 'BASIC', 'MOCK', 2027, '4.3程序的机器级代码表示', 'pp.183,188',
 '下列有关调用指令（转子指令）的叙述中, 错误的是（ ）。',
 'D',
 '为了能保证从被调用过程返回到调用过程继续执行, 必须确定并保存返回地址, 这个地址是调用指令随后的指令的地址, 返回地址只能由调用指令来计算并保存, 因为执行调用指令后就转移到了被调用过程, 因此无法获取返回地址。为了保证嵌套调用时能够返回到调用过程, 必须将返回地址压栈, 若不压栈而保存在特定寄存器中, 则后面执行的调用指令会将前面调用指令保存的返回地址覆盖掉。调用指令执行时将无条件转移到目标地址处, 这个目标地址就是被调用过程第一条指令的地址, 它一定在调用指令中明显给出, 因此选项 D 错误。',
 '与高级语言源程序中的过程调用相对应, 一次过程调用对应一条调用指令', '指令执行时必须保留返回地址, 调用指令随后一条指令的地址是返回地址', '嵌套调用时返回地址通常保存在栈中, 非嵌套调用时可保存在特定寄存器中', '指令执行时将无条件转移到目标地址处, 转移目标地址无须在指令中明显给出');

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
    '原题来自《2027年计算机组成原理考研复习指导》第4章 4.3 程序的机器级代码表示 本节试题精选。原始页码：' || q.source_pages || '。本批共11道纯文本单选题，Q12（过程调用步骤排序题，选项含带圈数字①②③④⑤⑥）因OCR无法可靠转录选项原文，暂缓入库。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch4_c_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000202', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch4_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000202', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch4_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000202', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch4_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000202', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch4_c_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch4_c_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000102101', 'CO-2027-ORIGINAL-CH4-C-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000102102', '4.3程序的机器级代码表示')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch4_c_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH4-C-TEXT-ONLY',
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
DROP TABLE co_2027_original_ch4_c_text_import;
