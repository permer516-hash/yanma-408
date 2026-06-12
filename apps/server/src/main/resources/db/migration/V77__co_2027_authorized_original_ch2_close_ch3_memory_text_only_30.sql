-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 2: 2.3 floating point (Q31-Q45, close) and Chapter 3: 3.2 main memory (Q1-Q15, start).
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Batch: CO-2027-ORIGINAL-CH2-D-CH3-A-TEXT-ONLY

CREATE TABLE co_2027_original_ch2_d_ch3_a_text_import (
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

INSERT INTO co_2027_original_ch2_d_ch3_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000077001', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2013, '2.3浮点数的表示与运算', 'pp.64-65,70-72', '【2013 统考真题】某数采用 IEEE 754 单精度浮点数格式表示为 C640 0000H，则该数的值是（ ）。', 'A', 'IEEE 754 单精度浮点数格式为 C640 0000H，二进制格式为 1100 0110 0100 0000 0000 0000 0000 0000。符号为 1 表示负数；阶码为 1000 1100 - 0111 1111 = 0000 1101 = 13；尾数为 1.5（注意其有隐藏位，要加 1）。因此，浮点数的值为 -1.5×2^13。', '-1.5×2^13', '-1.5×2^12', '-0.5×2^13', '-0.5×2^12'),
(2, '00000000-0000-0000-0000-000000077002', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2014, '2.3浮点数的表示与运算', 'pp.64-65,70-72', '【2014 统考真题】float 型数据常用 IEEE 754 单精度浮点格式表示。假设两个 float 型变量 x 和 y 分别存放在 32 位寄存器 f1 和 f2 中，若 (f1) = CC90 0000H, (f2) = B0C0 0000H，则 x 和 y 之间的关系为（ ）。', 'A', '(f1) 和 (f2) 对应的二进制分别是 (1100 1100 1001...) 和 (1011 0000 1100...)，根据 IEEE 754 浮点数标准，可知 (f1) 的符号为 1，阶码为 10011001，尾数为 1.001，而 (f2) 的符号为 1，阶码为 01100001，尾数为 1.1，可知两数均为负数，符号相同，B、D 排除；(f1) 的绝对值为 1.001×2^26，(f2) 的绝对值为 1.1×2^(-30)，(f1) 的绝对值比 (f2) 的绝对值大，而符号为负，真值大小相反，即 (f1) 的真值比 (f2) 的真值小，即 x<y。', 'x<y 且符号相同', 'x<y 且符号不同', 'x>y 且符号相同', 'x>y 且符号不同'),
(3, '00000000-0000-0000-0000-000000077003', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2015, '2.3浮点数的表示与运算', 'pp.64-65,70-72', '【2015 统考真题】下列有关浮点数加减运算的叙述中，正确的是（ ）。
I. 对阶操作不会引起阶码上溢或下溢
II. 右规和尾数舍入都可能引起阶码上溢
III. 左规时可能引起阶码下溢
IV. 尾数溢出时结果不一定溢出', 'D', '对阶是较小的阶码向较大的阶码对齐，所以对阶后的阶码是当前那个较大的阶码而不会导致阶码溢出，说法 I 正确。右规和尾数舍入过程，阶码加 1 而可能上溢，说法 II 正确，同理说法 III 也正确。尾数溢出时可能仅产生误差，结果不一定溢出，说法 IV 正确。', '仅 II、III', '仅 I、II、IV', '仅 I、III、IV', 'I、II、III、IV'),
(4, '00000000-0000-0000-0000-000000077004', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2016, '2.3浮点数的表示与运算', 'pp.64-65,70-72', '【2016 统考真题】某计算机字长为 32 位，按字节编址，采用小端方式存放数据。假定有一个 double 型变量，其机器数表示为 1122 3344 5566 7788H，存放在以 0000 8040H 开始的连续存储单元中，则存储单元 0000 8046H 中存放的是（ ）。', 'A', '大端方式：一个字中的高位字节存放在内存中这个字区域的低地址处。小端方式：一个字中的低位字节存放在内存中这个字区域的低地址处。在 double 型变量的 8 个字节 11 22 33 44 55 66 77 88H 中，88H 是最低字节，存放于 0000 8040H；77H 存放于 0000 8041H；66H 存放于 0000 8042H；55H 存放于 0000 8043H；44H 存放于 0000 8044H；33H 存放于 0000 8045H；22H 存放于 0000 8046H；11H 存放于 0000 8047H。从而存储单元 0000 8046H 中存放的是 22H。', '22H', '33H', '77H', '66H'),
(5, '00000000-0000-0000-0000-000000077005', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'PAST_EXAM', 2018, '2.3浮点数的表示与运算', 'pp.64-66,70-73', '【2018 统考真题】IEEE 754 单精度浮点格式表示的数中，最小的规格化正数是（ ）。', 'A', 'IEEE 754 单精度浮点数的符号位、阶码位、尾数位（省去正数位 1）所占的位数分别是 1、8、23。最小正数，符号位取 0，移码的取值范围是 1~254，取 1，得阶码 1-127 = -126（127 为我们规定的偏置值），尾数取全 0，最终推出最小规格化正数为 1.0×2^(-126)。', '1.0×2^(-126)', '1.0×2^(-127)', '1.0×2^(-128)', '1.0×2^(-149)'),
(6, '00000000-0000-0000-0000-000000077006', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2018, '2.3浮点数的表示与运算', 'pp.64-66,70-73', '【2018 统考真题】某 32 位计算机按字节编址，采用小端方式。若语句 "int i = 0;" 对应指令的机器代码为 "C7 45 FC 00 00 00 00"，则语句 "int i = -64;" 对应指令的机器代码是（ ）。', 'A', '按字节编址，采用小端方式，低位的数据存储在低地址位、高位的数据存储在高地址位，并且按照一字节相对不变的顺序存储。由题意，存储 0 的位数是后 32 位，则我们只需要把 -64 的补码按字节存储在其中即可，而 -64 表示成 32 位的十六进制是 FFFFFF C0，根据小端方式的特点，低位字节存储在低地址位，就是 C0 FF FF FF。', 'C7 45 FC C0 FF FF FF', 'C7 45 FC 0C FF FF FF', 'C7 45 FC FF FF FF C0', 'C7 45 FC FF FF FF 0C'),
(7, '00000000-0000-0000-0000-000000077007', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2019, '2.3浮点数的表示与运算', 'pp.65-66,71-73', '【2019 统考真题】在按字节编址、采用小端方式的 32 位计算机中，按边界对齐方式为以下 C 语言结构型变量 a 分配存储空间：
struct record {
    short x1;
    int x2;
} a;
若 a 的首地址为 2020 FE00H，a 的成员变量 x2 的机器数为 1234 0000H，则 34H 所在存储单元的地址是（ ）。', 'D', '在 32 位计算机中，按字节编址，根据小端方式和按边界对齐的定义，变量 a 的存放方式：short x1 占 2 字节（2020 FE00H~2020 FE01H），空 2 字节（2020 FE02H~2020 FE03H），int x2 占 4 字节。x2 的机器数 1234 0000H 在小端方式下：地址 2020 FE04H 为 00H，2020 FE05H 为 00H，2020 FE06H 为 34H，2020 FE07H 为 12H。于是，34H 所在存储单元的地址为 2020 FE06H。', '2020 FE03H', '2020 FE04H', '2020 FE05H', '2020 FE06H'),
(8, '00000000-0000-0000-0000-000000077008', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2020, '2.3浮点数的表示与运算', 'pp.65-66,71-73', '【2020 统考真题】已知有符号整数用补码表示，float 型数据用 IEEE 754 标准表示，假定变量 x 的类型只可能是 int 或 float，当 x 的机器数为 C800 0000H 时，x 的值可能是（ ）。', 'A', 'C800 0000H = 1100 1000 0000 0000 0000 0000 0000 0000。若为 float 型：符号为 1 表示负数，阶码 1001 0000 = 2^7+2^4 = 128+16，再减去偏置值 127 得到 17，算出 x 值为 -2^17。若为 int 型，则有符号补码，为负数，数值部分取反加 1，得 011 1000 0000 0000 0000 0000 0000 0000，算出 x 值为 -7×2^27。', '-7×2^27', '-2^16', '2^17', '25×2^27'),
(9, '00000000-0000-0000-0000-000000077009', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'PAST_EXAM', 2021, '2.3浮点数的表示与运算', 'pp.66,72-73', '【2021 统考真题】下列数值中，不能用 IEEE 754 浮点格式精确表示的是（ ）。', 'A', '使用排除法。选项 B: 1.25 = 1.01B×2^0；选项 C: 2.0 = 1.0B×2^1；选项 D: 2.5 = 1.01B×2^1。因此，选项 B、C 和 D 均可以用 IEEE 754 浮点格式精确表示。选项 A 的十进制小数 1.2 转换为二进制的结果是无限循环小数 1.001100110011...，无法用精度有限的 IEEE 754 浮点格式精确表示。', '1.2', '1.25', '2.0', '2.5'),
(10, '00000000-0000-0000-0000-000000077010', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2022, '2.3浮点数的表示与运算', 'pp.66,72-73', '【2022 统考真题】-0.4375 的 IEEE 754 单精度浮点数表示为（ ）。', 'A', 'IEEE 754 单精度浮点数格式中依次为符号 1 位、阶码 8 位（偏置值 127）、尾数 23 位（隐藏 1 位）。-0.4375 = -1.75 × 2^(-2)，保证小数点前是 1。根据单精度浮点数格式，符号为 1；阶码为移码表示，-2 + 127 = 125，写成 8 位二进制数为 0111 1101；尾数隐藏小数点前的 1，剩下的 0.75 写成二进制数为 0.11，所以尾数部分是 1100...0。该浮点数的二进制格式为 1011 1110 1110 0000 0000 0000 0000 0000，对应的十六进制格式为 BEE0 0000H。', 'BEE0 0000H', 'BF60 0000H', 'BF70 0000H', 'C0E0 0000H'),
(11, '00000000-0000-0000-0000-000000077011', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'PAST_EXAM', 2023, '2.3浮点数的表示与运算', 'pp.66,72-73', '【2023 统考真题】已知 short 型变量 x = -8190，则 x 的机器数是（ ）。', 'A', 'short 型变量是补码表示的 16 位有符号整数。x 是负数，可先求出 8190 的机器数，8190 = 8192 - 2 = 2^13 - 2^1，8190 的机器数为 0010 0000 0000 0000B - 0000 0000 0000 0010B = 0001 1111 1111 1110B，因此 -8190 的机器数为 1110 0000 0000 0010B = E002H（按位取反，末位加 1）。', 'E002H', 'E001H', '9FFFH', '9FFEH'),
(12, '00000000-0000-0000-0000-000000077012', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2023, '2.3浮点数的表示与运算', 'pp.66,72-73', '【2023 统考真题】已知 float 型变量用 IEEE 754 单精度浮点数格式表示。若 float 型变量 x 的机器数为 8020 0000H，则 x 的值是（ ）。', 'A', '把 x 的机器数按二进制展开，8020 0000H = 1000 0000 0010 0000 0000 0000 0000 0000B，符号为负，阶码全为 0，尾数不全为 0，可知这是非规格化数。对于 32 位非规格化负数，若尾数的二进制为 f，则真值为 -2^(-126)×0.f = -2^(-126)×0.01 = -2^(-128)。', '-2^(-128)', '-1.01×2^(-127)', '-1.01×2^(-126)', '非数（NaN）'),
(13, '00000000-0000-0000-0000-000000077013', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2024, '2.3浮点数的表示与运算', 'pp.66,73', '【2024 统考真题】某科学实验中，需要使用大量的整型参数，为了在保证表数精度的基础上提高运算速度，需要选择合理的数据表示方法。若整型参数 α、β 的取值范围分别为 -2^31~2^31-1、-2^40~2^40，则在下列选项中，α、β 最适合采用的数据表示方法分别是（ ）。', 'C', '表示整数时，相同位数的浮点型的精度不如整型，因此在能满足 α、β 的取值范围的前提下，应优先选择整型；否则，才选择浮点型。32 位补码整数的表示范围为 -2^31~2^31-1，满足 α 的取值范围，因此 α 应采用 32 位整数。双精度浮点数的精度比单精度浮点数的更高，-2^40~2^40 超出了单精度浮点数可以表示的精度（由尾数位数+隐含位决定），因此 β 应采用双精度浮点数。', '32 位整数、32 位整数', '单精度浮点数、单精度浮点数', '32 位整数、双精度浮点数', '单精度浮点数、双精度浮点数'),
(14, '00000000-0000-0000-0000-000000077014', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2025, '2.3浮点数的表示与运算', 'pp.66-67,73-74', '【2025 统考真题】已知 float 型变量用 IEEE 754 单精度浮点数格式表示。若 float 型变量 x 的机器数为 4730 0000H，则 x 的值是（ ）。', 'D', '根据 IEEE 754 单精度浮点数格式，机器数 4730 0000H 展开为二进制 0 1000 1110 011 0000 0000 0000 0000 0000。符号位为 0，表示正数；8 位阶码 1000 1110 的十进制值为 142，减去偏置 127，得到实际指数为 15；23 位尾数为 011 0000 0000 0000 0000 0000，规格化形式隐含了前导 1，故有效数字为 1.011（二进制），即十进制数 1.375，因此 x 的值为 1.375×2^15。', '0.375×2^14', '1.375×2^14', '0.375×2^15', '1.375×2^15'),
(15, '00000000-0000-0000-0000-000000077015', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2025, '2.3浮点数的表示与运算', 'pp.67,74', '【2025 统考真题】某 32 位计算机按字节编址，采用小端方式存放数据，编译器按边界对齐方式为下列 C 语言结构类型 employee 分配存储空间：
struct record {
    int id;
    char name[10];
    int salary;
} employee[200];
若 employee 的首地址为 0000 A0B0H，employee[1].id 的机器数为 1234 5678H，则该机器数中的 56H 所在存储单元的地址是（ ）。', 'C', '首先分析结构体 record 的内存布局：int id 占 4 字节；char name[10] 占 10 字节，为使后续 int salary 对齐到 4 字节边界，需要在 name 后填充 2 字节，使 salary 从 4 的整数倍偏移处开始。因此结构体总大小为 4 + 10 + 2 + 4 = 20 字节。employee[1] 的首地址为 0000 A0B0H + 20 = 0000 A0C4H，id 为其第一个成员，起始地址即为 0000 A0C4H。已知 id 的值为 1234 5678H，在小端方式下，字节按 78H、56H、34H、12H 的顺序存放，故 56H 位于 0000 A0C5H。', '0000 A0C3H', '0000 A0C4H', '0000 A0C5H', '0000 A0C6H'),
(16, '00000000-0000-0000-0000-000000077016', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', '某一 SRAM 芯片，容量为 1024×8 位，该芯片的地址引脚和数据引脚总数至少是（ ）。', 'C', '芯片容量为 1024×8 位，8 位说明数据线要 8 根，地址线要 10 根（1024 = 2^10）。因此，该芯片的地址引脚和数据引脚总数至少需要 18 根。', '8', '10', '18', '13'),
(17, '00000000-0000-0000-0000-000000077017', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', '某芯片容量为 32K×16 位，则（ ）。', 'C', '该芯片为 16 位，所以数据线为 16 根，寻址空间 32K = 2^15，所以地址线为 15 根。', '地址线为 16 根，数据线为 32 根', '地址线为 32 根，数据线为 16 根', '地址线为 15 根，数据线为 16 根', '地址线为 15 根，数据线为 32 根'),
(18, '00000000-0000-0000-0000-000000077018', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', 'DRAM 的刷新是以（ ）为单位的。', 'B', 'DRAM 的刷新按行进行。', '存储单元', '行', '列', '存储字'),
(19, '00000000-0000-0000-0000-000000077019', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', '下面是有关 DRAM 和 SRAM 存储芯片的叙述：
I. DRAM 芯片的集成度比 SRAM 芯片的高
II. DRAM 芯片的成本比 SRAM 芯片的高
III. DRAM 芯片的速度比 SRAM 芯片的快
IV. DRAM 芯片工作时需要刷新，SRAM 芯片工作时不需要刷新
通常情况下，错误的是（ ）。', 'B', 'DRAM 芯片的集成度高于 SRAM，说法 I 正确；SRAM 芯片的速度高于 DRAM，说法 II 错误；可以推出 DRAM 芯片的成本低于 SRAM，说法 III 错误；SRAM 芯片工作时不需要刷新，DRAM 芯片工作时需要刷新，说法 IV 正确。本题要求选择描述错误的表述，所以选择说法 II 和 III。', 'I 和 II', 'II 和 III', 'II 和 IV', 'I 和 IV'),
(20, '00000000-0000-0000-0000-000000077020', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', '下列关于随机存储器的说法中，正确的是（ ）。', 'C', 'RAM 属于易失性半导体。SRAM 和 DRAM 的区别在于是否需要动态刷新。半导体 RAM 是易失性存储器，但只要电源不断电，所存信息是不丢失的。', '半导体 RAM 中的信息可读可写，且断电后仍能保持记忆', 'DRAM 是易失性 RAM，而 SRAM 中的存储信息是不易失的', '半导体 RAM 是易失性 RAM，但只要电源不断电，所存信息是不丢失的', '半导体 RAM 是非易失性 RAM'),
(21, '00000000-0000-0000-0000-000000077021', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', '下列关于存储器的说法中，不正确的是（ ）。', 'A', '主存由 RAM 和 ROM 构成，两者统一编址，选项 A 错误。选项 B 描述的是随机访问特性，正确。RAM 芯片具有随机访问特性和易失性，选项 C 正确。ROM 芯片具有随机访问特性和非易失性，选项 D 正确。', '随机存储器和只读存储器不可以统一编址', '在访问随机存储器时，访问时间与存储单元的物理位置无关', '随机存储器（RAM）芯片可随机存取信息，掉电后信息会丢失', '只读存储器（ROM）芯片可随机存取信息，掉电后信息不会丢失'),
(22, '00000000-0000-0000-0000-000000077022', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', '关于半导体存储器的组织，下列选项中（ ）是不正确的。', 'A', '同一个存储器中，每个存储单元的宽度必须相同，即每个存储单元存储的比特位数必须相同。', '在同一个存储器中，每个存储单元的宽度可以不同', '所谓"编址"，是指给每个存储单元一个编号', '存储器的核心部分是存储阵列，由若干存储单元构成', '每个存储元件可以存储 1 个比特位'),
(23, '00000000-0000-0000-0000-000000077023', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,92-93', '关于 SRAM 和 DRAM，下列叙述中正确的是（ ）。', 'D', 'SRAM 依靠双稳态电路的两个稳定状态来分别存储 0 和 1，SRAM 速度较快，不需要动态刷新，但集成度稍低，功耗大，单位价格高。DRAM 依靠电容暂存电荷来存储信息，电容上有电荷为 1，无电荷为 0；DRAM 集成度高，功耗小，单位价格较低，需定时刷新，速度慢。', '通常 SRAM 依靠电容暂存电荷来存储信息，电容上有电荷为 1，无电荷为 0', 'DRAM 依靠双稳态电路的两个稳定状态来分别存储 0 和 1', 'SRAM 速度较慢，但集成度稍高；DRAM 速度稍快，但集成度低', 'SRAM 速度较快，但集成度稍低；DRAM 速度稍慢，但集成度高'),
(24, '00000000-0000-0000-0000-000000077024', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,93', '某一 DRAM 芯片，采用地址复用技术，容量为 1024×8 位，该芯片的地址引脚和数据引脚总数至少是（ ）。', 'B', '1024×8 位，寻址范围是 1024 = 2^10。采用地址复用技术时，分两次传送行、列地址，地址引脚减半为 5 根，数据引脚仍为 8 根，因此地址引脚和数据引脚总数至少为 13 根。注意 SRAM 和 DRAM 的区别，DRAM 采用地址复用技术，而 SRAM 不采用。', '18', '13', '8', '17'),
(25, '00000000-0000-0000-0000-000000077025', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,93', '下列几种存储器中，（ ）是易失性存储器。', 'A', 'Cache 由 SRAM 组成，掉电后信息即消失，属于易失性存储器。', 'Cache', 'EPROM', 'Flash 存储器', 'CD-ROM'),
(26, '00000000-0000-0000-0000-000000077026', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,93', 'U 盘属于（ ）类型的存储器。', 'C', 'U 盘采用 Flash 存储技术，它是在 EPROM 的基础上发展起来的，属于 ROM 的一种。擦写速度和性价比均很可观，因此常用作辅存。值得注意的是，随机存取与随机存储器是两个不同的概念，只读存储器也是随机存取的。因此，支持随机存取的存储器并不一定是随机存储器。', '高速缓存', '主存', '只读存储器', '随机存储器'),
(27, '00000000-0000-0000-0000-000000077027', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-89,93', '下面有关 ROM 和 RAM 的叙述中，错误的是（ ）。', 'D', '系统主存主要由 DRAM 构成，但通常也包含用于存放 BIOS 或固件的 ROM（如 Flash），因此并非全部由 DRAM 实现，D 选项的说法错误。', 'RAM 是可读可写存储器，ROM 是只读存储器', 'ROM 和 RAM 都采用随机访问方式进行读/写', '系统的主存由 RAM 和 ROM 组成', '系统的主存都用 DRAM 芯片实现'),
(28, '00000000-0000-0000-0000-000000077028', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-90,93', '下列说法正确的是（ ）。', 'B', 'EPROM 可多次改写，但改写较为烦琐，写入时间过长，且改写的次数有限，速度较慢，因此不能作为需要频繁读/写的 RAM 使用。', 'EPROM 是可改写的，因此可以作为随机存储器', 'EPROM 是可改写的，但不能作为随机存储器', 'EPROM 是不可改写的，因此不能作为随机存储器', 'EPROM 只能改写一次，因此不能作为随机存储器'),
(29, '00000000-0000-0000-0000-000000077029', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-90,93-94', '下列（ ）是动态半导体存储器的特点。
I. 在工作中存储器内容会产生变化
II. 每隔一定时间，需要根据原存内容重新写入一遍
III. 一次完整的刷新过程需要占用两个存取周期
IV. 一次完整的刷新过程只需要占用一个存取周期', 'C', '动态半导体存储器利用电容存储电荷的特性记录信息，电容会放电，因此必须在电荷流失前对电容充电，即刷新。方法不是每隔一定的时间根据原存内容重新写入一遍，因此说法 I 错误。说法 II 正确。这里的读并不是把信息读入 CPU，也不是从 CPU 向主存存入信息，它只是把信息读出，通过一个刷新放大器后又重新存回存储单元，而刷新放大器是集成在 RAM 上的。因此，这里只进行了一次访存，也就是占用一个存取周期，说法 II、IV 正确，说法 III 错误。', 'I、III', 'II、III', 'II、IV', '只有 II'),
(30, '00000000-0000-0000-0000-000000077030', 'CO_CACHE', 'CO_CACHE_MAPPING', 'BASIC', 'MOCK', 2027, '3.2主存储器', 'pp.87-90,94', '下列关于存储器层次结构的说法中，错误的是（ ）。', 'C', 'Flash 存储器的读速接近 RAM，但写/擦除速度慢，类似 ROM，读写性能显著不对称。存储器层次结构以局部性原理为设计基础，通过缓冲机制有效缓解各级存储器间的速率差异。Cache 虽位于 CPU 与主存之间且访问速度快，但其容量远小于主存，并非"大于主存"，选项 C 错误。辅存（如机械硬盘）因速度慢，不参与 CPU 实时访存，仅用于主存扩展或持久性存储。', 'Flash 存储器读/写速度差异显著，读速接近 RAM，写速接近 ROM', '存储器层次结构基于程序局部性原理，通常采用缓冲技术缓解层级间速率差异', 'Cache 位于 CPU 与主存之间，容量通常大于主存，旨在提升平均访问速率', '辅存（如机械硬盘）容量大、成本低但速度慢，仅作为主存的补充与备份');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 2 章 2.3.5/2.3.6 本节试题精选及答案解析（Q31-Q45），以及第 3 章 3.2.4/3.2.5 本节试题精选及答案解析（Q1-Q15）；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch2_d_ch3_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000177', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch2_d_ch3_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000177', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch2_d_ch3_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000177', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch2_d_ch3_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000177', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch2_d_ch3_a_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch2_d_ch3_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000077701', 'CO-2027-ORIGINAL-CH2-D-CH3-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000077702', '2.3浮点数的表示与运算'),
    ('00000000-0000-0000-0000-000000077703', '3.2主存储器')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch2_d_ch3_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH2-D-CH3-A-TEXT-ONLY',
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

DROP TABLE co_2027_original_ch2_d_ch3_a_text_import;
