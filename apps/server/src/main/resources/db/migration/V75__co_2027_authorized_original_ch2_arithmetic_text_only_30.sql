-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 2: finish 2.1 and start 2.2 arithmetic methods and circuits.
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Batch: CO-2027-ORIGINAL-CH2-B-TEXT-ONLY

CREATE TABLE co_2027_original_ch2_b_text_import (
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

INSERT INTO co_2027_original_ch2_b_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000075001', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'PAST_EXAM', 2018, '2.1数制与编码', 'pp.29,32', '【2018 统考真题】冯·诺依曼结构计算机中的数据采用二进制编码表示，其主要原因是（ ）。
I. 二进制的运算规则简单
II. 制造两个稳态的物理器件较容易
III. 便于用逻辑门电路实现算术运算', 'D', '二进制运算规则简单，物理上只需两个稳定状态即可表示 0 和 1，并且二进制与逻辑量相吻合，便于用逻辑门电路实现运算。三项均正确。', '仅 I、II', '仅 I、III', '仅 II、III', 'I、II 和 III'),
(2, '00000000-0000-0000-0000-000000075002', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'PAST_EXAM', 2019, '2.1数制与编码', 'pp.29,32', '【2019 统考真题】考虑以下 C 语言代码：
unsigned short usi = 65535;
short si = usi;
执行上述程序段后，si 的值是（ ）。', 'A', 'unsigned short 的 65535 对应 16 位机器码 1111111111111111。按 short 补码解释时，该机器码表示 -1。', '-1', '-32767', '-32768', '-65535'),
(3, '00000000-0000-0000-0000-000000075003', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2021, '2.1数制与编码', 'pp.29,32', '【2021 统考真题】已知有符号整数用补码表示，变量 x,y,z 的机器数分别为 FFFDH, FFDFH, 7FFCH，下列结论中，正确的是（ ）。', 'D', '若按无符号数解释，x 和 y 均大于 z，且 x>y；若按有符号补码解释，z 为正数，x=-3，y=-33，因此 y<x<z。', '若 x,y 和 z 为无符号整数，则 z<x<y', '若 x,y 和 z 为无符号整数，则 x<y<z', '若 x,y 和 z 为有符号整数，则 x<y<z', '若 x,y 和 z 为有符号整数，则 y<x<z'),
(4, '00000000-0000-0000-0000-000000075004', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'PAST_EXAM', 2022, '2.1数制与编码', 'pp.29,32', '【2022 统考真题】32 位补码所能表示的整数范围是（ ）。', 'B', 'n 位补码整数的表示范围是 -2^(n-1)～2^(n-1)-1，因此 32 位补码整数范围是 -2^31～2^31-1。', '-2^32～2^31-1', '-2^31～2^31-1', '-2^32～2^32-1', '-2^31～2^32-1'),
(5, '00000000-0000-0000-0000-000000075005', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2025, '2.1数制与编码', 'pp.29,32', '【2025 统考真题】在 32 位计算机上执行下列 C 语言代码段后，ui 的值是（ ）。
short si = -32767;
unsigned int ui = si;', 'D', '-32767 的 16 位补码为 1000000000000001。赋给 32 位 unsigned int 时先符号扩展为 32 位，再按无符号数解释，结果为 2^32-2^15+1。', '2^15-1', '2^15+1', '2^32-2^15-1', '2^32-2^15+1'),
(6, '00000000-0000-0000-0000-000000075006', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,48', '算术逻辑单元（ALU）的核心部件是（ ）。', 'C', 'ALU 的核心功能是算术与逻辑运算，其中加法是最基础的操作；减法可用补码加法实现，乘除可由加法和移位组合而成，因此加法器是 ALU 最核心的部件。', '多路选择器', '移位器', '加法器', '寄存器'),
(7, '00000000-0000-0000-0000-000000075007', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,48', '算术逻辑单元（ALU）的功能通常包括（ ）。', 'C', 'ALU 既能进行算术运算，又能进行逻辑运算。', '算术运算', '逻辑运算', '算术运算和逻辑运算', '加法运算'),
(8, '00000000-0000-0000-0000-000000075008', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,48-49', '补码定点整数 0101 0101 算术左移两位后的值为（ ）。', 'B', '该数为正数，按补码算术左移规则左移两位，移出最高位 01、低位补 0，结果为 0101 0100。虽然符号位仍为 0，但移出了有效位 1，因此发生溢出。', '0100 0111', '0101 0100', '0100 0110', '0101 0101'),
(9, '00000000-0000-0000-0000-000000075009', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '下列四个补码整数存放于 8 位寄存器中，算术左移不会发生溢出的是（ ）。', 'D', '80H、90H、B0H 左移后符号位都由 1 变为 0，发生溢出；C0H 左移后为 10000000，左移前后符号位均为 1，未溢出。', '80H', '90H', 'B0H', 'C0H'),
(10, '00000000-0000-0000-0000-000000075010', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '补码定点整数 1001 0101 右移一位后的值为（ ）。', 'D', '该数为负数，补码算术右移时高位补 1，因此 10010101 右移一位后为 11001010。', '0100 1010', '01001010 1', '1000 1010', '1100 1010'),
(11, '00000000-0000-0000-0000-000000075011', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '两个机器数 7E5H 和 4D3H 相加，得（ ）。', 'C', '十六进制加法中，逢十六进一，因此 7E5H + 4D3H = CB8H。', 'BD8H', 'CD8H', 'CB8H', 'CC8H'),
(12, '00000000-0000-0000-0000-000000075012', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '设机器数字长为 8 位（含 1 位符号位），若机器数 BAH 为补码，算术左移 1 位和算术右移 1 位分别得（ ）。', 'C', 'BAH=(10111010)2。算术左移 1 位低位补 0，得 01110100=74H；算术右移 1 位高位补符号位 1，得 11011101=DDH。', 'F4H，EDH', 'B4H，6DH', '74H，DDH', 'B5H，EDH'),
(13, '00000000-0000-0000-0000-000000075013', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '在定点运算器中，无论是采用双符号位还是采用单符号位，必须有（ ）。', 'C', '双符号位或单符号位判溢都需要溢出判断电路，常用异或门实现。', '译码电路，它一般用“与非”门来实现', '编码电路，它一般用“或非”门来实现', '溢出判断电路，它一般用“异或”门来实现', '移位电路，它一般用“与或非”门来实现'),
(14, '00000000-0000-0000-0000-000000075014', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '机器运算发生溢出的根本原因是（ ）。', 'A', '机器字长有限，只能表示一定范围内的数据，运算结果超出可表示范围时就会发生溢出。', '寄存器的位数有限', '运算中将符号位的进位丢弃', '运算中将符号位的借位丢弃', '数据运算中发生错误'),
(15, '00000000-0000-0000-0000-000000075015', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '假定有两个整数用 8 位补码分别表示为 r1=F5H，r2=EEH。若将运算结果存放在一个 8 位寄存器中，则下列运算会发生溢出的是（ ）。', 'C', 'F5H 表示 -11，EEH 表示 -18，8 位补码范围为 [-128,127]。r1×r2=198，超过 8 位补码可表示范围，因此发生溢出。', 'r1+r2', 'r1-r2', 'r1×r2', 'r1/r2'),
(16, '00000000-0000-0000-0000-000000075016', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44,49', '关于模 4 补码，下列说法正确的是（ ）。', 'B', '存储模 4 补码只需一个符号位，因为任一正确数值的两个符号位总相同；只有送入 ALU 判断溢出时，才需要把符号位同时送入双符号位。', '模 4 补码和模 2 补码不同，它不容易检查乘除运算中的溢出问题', '每个模 4 补码存储时只需要一个符号位', '存储每个模 4 补码需要两个符号位', '模 4 补码，在算术与逻辑单元中为一个符号位'),
(17, '00000000-0000-0000-0000-000000075017', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44-45,49', '若采用双符号位，则两个正数相加产生溢出的特征时，双符号位为（ ）。', 'B', '双符号位中，第一符号位表示最终结果符号，第二符号位表示是否溢出。两个正数相加发生正溢出时，双符号位为 01。', '00', '01', '10', '11'),
(18, '00000000-0000-0000-0000-000000075018', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.44-45,49', '判断加减法溢出时，可采用判断进位的方式，若符号位的进位为 C0，最高位的进位为 C1，则产生溢出的条件是（ ）。
I. C0 产生进位
II. C1 产生进位
III. C0、C1 都产生进位
IV. C0、C1 都不产生进位
V. C0 产生进位，C1 不产生进位
VI. C0 不产生进位，C1 产生进位', 'D', '采用进位位判断溢出时，最高有效位进位和符号位进位不同才会溢出，即 C0C1 取 10 或 01，对应 V 和 VI。', 'I 和 II', 'III', 'IV', 'V 和 VI'),
(19, '00000000-0000-0000-0000-000000075019', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,49', '在补码的加减法中，用两位符号位判断溢出，两位符号位 S1S2=10 时，表示（ ）。', 'C', '用两位符号位判断溢出时，两位符号位不同表示溢出；01 表示正溢出，10 表示负溢出。', '结果为正数，无溢出', '结果正溢出', '结果负溢出', '结果为负数，无溢出'),
(20, '00000000-0000-0000-0000-000000075020', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '若 [X]补=X0.X1X2…Xn，其中 X0 为符号位，X1 为最高数位。若（ ），则当补码算术左移时，将会发生溢出。', 'B', '补码左移时，若移出的高位不同于移位后的符号位，即左移前后的符号位不同，就会发生溢出。因此 X0≠X1 表示发生溢出。', 'X0=X1', 'X0≠X1', 'X1=0', 'X1=1'),
(21, '00000000-0000-0000-0000-000000075021', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '假设一次 ALU 运算和一次移位操作各需 1 个时钟周期，则 32 位无符号整数乘法电路完成一次乘法运算所需的时钟周期数约为（ ）。', 'B', '32 位无符号乘法通常采用“移位-相加”算法，共进行 32 轮迭代；每轮至少包含一次加法或空操作和一次移位，每轮约 2 个时钟周期，因此约需 64 个时钟周期。', '16', '64', '96', '100'),
(22, '00000000-0000-0000-0000-000000075022', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '下列关于移位运算的说法中，正确的是（ ）。
I. 补码算术左移时，高位移出，低位补 0，若左移前后的符号位不同，则发生溢出
II. 无符号数逻辑左移时，若最高位移出的是 1，则发生溢出
III. 逻辑左移和补码算术左移的结果都一样，都是移出最高位，并在低位补 0', 'D', '逻辑左移和算术左移在操作结果上都是高位移出、低位补 0；无符号逻辑左移若最高位移出 1 表示溢出；补码算术左移若移出位不同于移位后的符号位表示溢出。三项均正确。', 'I、III', '仅 II', '只有 III', 'I、II、III'),
(23, '00000000-0000-0000-0000-000000075023', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '某计算机字长为 8 位，CPU 中有一个 8 位加法器。已知无符号数 x=69，y=38，若在该加法器中计算 x-y，则加法器的两个输入端信息和输入的低位进位信息分别为（ ）。', 'B', '减法 y 的负数补码为按位取反后末位加 1，因此在加法器的 Y 输入端送入 y 各位取反后的 11011001，同时低位进位输入为 1；x 的机器数为 01000101。', '0100 0101，0010 0110，0', '0100 0101，1101 1001，1', '0100 0101，1101 1010，0', '0100 0101，1101 1010，1'),
(24, '00000000-0000-0000-0000-000000075024', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '某计算机中有一个 8 位加法器，有符号整数 x 和 y 的机器数用补码表示，[x]补=F5H，[y]补=7EH，若在该加法器中计算 x-y，则加法器的低位进位输入信号和运算后的溢出标志 OF 分别是（ ）。', 'A', '补码减法中控制端 Sub 为 1，因此低位进位输入为 1。F5H 表示 -11，7EH 表示 126，计算 -11-126 超出 8 位补码范围，结果符号异常，OF=1。', '1，1', '1，0', '0，1', '0，0'),
(25, '00000000-0000-0000-0000-000000075025', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '某 8 位计算机中，x 和 y 是两个有符号整数，用补码表示，[x]补=44H，[y]补=DCH，则 x/2+2y 的机器数及相应的溢出标志 OF 分别是（ ）。', 'C', '[x/2+2y]补 = [x]补>>1 + [y]补<<1 = 00100010 + 10111000 = 11011010 = DAH。x 右移移出 0，y 左移后符号位仍为 1，最终一个正数和一个负数相加不会溢出，因此 OF=0。', 'CAH，0', 'CAH，1', 'DAH，0', 'DAH，1'),
(26, '00000000-0000-0000-0000-000000075026', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '某 8 位计算机中，x 和 y 是两个有符号整数，用补码表示，[x]补=44H，[y]补=DCH，则 x-2y 的机器数及相应的溢出标志 OF 分别是（ ）。', 'A', '计算 x-2y 时，先将 y 算术左移一位得 10111000，未溢出；再各位取反并与 x 相加，同时 Sub=1，得 10001100=8CH。两个加数符号均为 0 而结果符号为 1，发生溢出，OF=1。', '8CH，1', '8CH，0', '68H，1', '68H，0'),
(27, '00000000-0000-0000-0000-000000075027', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.2运算方法和运算电路', 'pp.45,50', '某 C 语言代码段如下：
int si=65536;
short i=si;
unsigned j=0;
if(i<=j-1) printf("王道");
else printf("计算机教育");
当上述代码段执行到 if 分支条件的判断时，会根据标志寄存器中的（ ）决定执行顺序。最终的输出结果是（ ）。', 'A', '无符号数与有符号数一起参与运算时，计算机按无符号数解释最终结果，因此 j-1 被解释为最大的无符号数；si 强制转换为 short 后保留低 16 位为 0。比较时根据 CF 位可知 i 小于 j-1，因此输出“王道”。', 'CF，王道', 'CF，计算机教育', 'OF，王道', 'OF，计算机教育'),
(28, '00000000-0000-0000-0000-000000075028', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2009, '2.2运算方法和运算电路', 'pp.46,51', '【2009 统考真题】一个 C 语言程序在一台 32 位机器上运行。程序中定义了三个变量 x、y、z，其中 x 和 z 为 int 型，y 为 short 型。当 x=127，y=-9 时，执行赋值语句 z=x+y 后，x,y,z 的值分别是（ ）。', 'D', 'int 为 32 位，short 为 16 位。x 的机器数为 0000007FH，y=-9 的 16 位补码为 FFF7H。执行 x+y 时需将 y 符号扩展为 32 位 FFFFFFF7H，再与 x 相加得 00000076H。', 'x=0000007FH，y=FFF9H，z=00000076H', 'x=0000007FH，y=FFF9H，z=FFFF0076H', 'x=0000007FH，y=FFF7H，z=FFFF0076H', 'x=0000007FH，y=FFF7H，z=00000076H'),
(29, '00000000-0000-0000-0000-000000075029', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2010, '2.2运算方法和运算电路', 'pp.46,51', '【2010 统考真题】假定有四个整数用 8 位补码分别表示：r1=FEH，r2=F2H，r3=90H，r4=F8H。若将运算结果存放在一个 8 位寄存器中，则下列运算会发生溢出的是（ ）。', 'B', '8 位补码范围为 -128～+127。四个数转换为十进制分别为 r1=-2，r2=-14，r3=-112，r4=-8，其中 r2×r3=1568，远超出表示范围，发生溢出。', 'r1×r2', 'r2×r3', 'r1×r4', 'r2×r4'),
(30, '00000000-0000-0000-0000-000000075030', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2013, '2.2运算方法和运算电路', 'pp.46,51', '【2013 统考真题】某字长为 8 位的计算机中，已知整型变量 x、y 的机器数分别为 [x]补=11110100，[y]补=10110000，若整型变量 z=2x+y/2，则 z 的机器数为（ ）。', 'A', 'x×2 可将 x 算术左移一位得 11101000；y/2 可将 y 算术右移一位得 11011000。二者相加得 11000000，运算过程无溢出。', '11000000', '00100100', '10101010', '溢出');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 2 章 2.1.5/2.1.6 收尾与 2.2.5/2.2.6 本节试题精选及答案解析；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch2_b_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000175', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch2_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000175', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch2_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000175', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch2_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000175', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch2_b_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch2_b_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000075701', 'CO-2027-ORIGINAL-CH2-B-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000075702', '2.2运算方法和运算电路')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch2_b_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH2-B-TEXT-ONLY',
    '第2章数据的表示和运算',
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

DROP TABLE co_2027_original_ch2_b_text_import;
