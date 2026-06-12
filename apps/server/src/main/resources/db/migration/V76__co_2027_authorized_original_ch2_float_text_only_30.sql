-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 2: 2.3 floating point representation and operation.
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Batch: CO-2027-ORIGINAL-CH2-C-TEXT-ONLY

CREATE TABLE co_2027_original_ch2_c_text_import (
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

INSERT INTO co_2027_original_ch2_c_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000076001', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,67', '在 C 语言的不同类型的数据混合运算中，要先转换为同一类型后进行运算。设一表达式中包含有 int 型、long 型、char 型和 double 型的变量与数据，则表达式最后的运算结果是（ ），这 4 种类型数据的转换规律是（ ）。', 'C', '不同类型数据混合运算时，遵循"类型提升"原则，较低类型转换为较高类型，最终结果为 double 型。4 种类型数据的转换规律为 char→int→long→double。', 'long，int→char→double→long', 'long，char→int→long→double', 'double，char→int→long→double', 'double，char→int→double→long'),
(2, '00000000-0000-0000-0000-000000076002', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,67', '长度相同但格式不同的两种浮点数，假设前者阶码长、尾数短，后者阶码短、尾数长，其他规定均相同，则它们可表示的数的范围和精度为（ ）。', 'B', '在浮点数总位数不变的情况下，阶码位数越多，尾数位数越少；即表示的数的范围越大但精度越差（数变稀疏）。', '两者可表示的数的范围和精度相同', '前者可表示的数的范围大但精度低', '后者可表示的数的范围大且精度高', '前者可表示的数的范围大且精度高'),
(3, '00000000-0000-0000-0000-000000076003', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,67', '浮点数的 IEEE 754 标准对尾数编码采用的是（ ）。', 'A', 'IEEE 754 标准中尾数采用原码表示，阶码部分用移码表示。', '原码', '反码', '补码', '移码'),
(4, '00000000-0000-0000-0000-000000076004', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,67', 'IEEE 754 标准规定的 64 位浮点数格式中，符号位为 1 位，阶码为 11 位，尾数为 52 位，则它所能表示的最小规格化负数为（ ）。', 'B', '长浮点数阶码为 11 位，尾数为 52 位，采取隐藏位策略，因此其最小规格化负数为阶码取最大值 2^11-3=1023，尾数取最大值 2-2^(-52)（注意其有隐藏位要加 1），符号位为负。即 -(2-2^(-52))×2^1023。', '-(2-2^54)×2^1023', '-(2-2^(-52))×2^1023', '-1×2^(-1024)', '-(1-2^(-52))×2^1024'),
(5, '00000000-0000-0000-0000-000000076005', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,67-68', 'IEEE 754 标准规定的 32 位单精度浮点数 41A4C000H 对应的十进制数是（ ）。', 'D', '41A4C000H 写成二进制为 0100 0001 1010 0100 1100 0000 0000 0000。第一位符号位为 0，表示正数。之后 8 位 1000 0011 表示阶码，真值为 (100)b，即 4。剩下的是隐藏了最高位 1 的尾数，所以为 1.0100 1001 1000 0000 0000 0000，数值左移四位后整数部分 10100 表示为 20，小数部分 0.1001100... 表示为 0.59375，合计 20.59375。', '4.59375', '-20.59375', '-4.59375', '20.59375'),
(6, '00000000-0000-0000-0000-000000076006', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,68', '在浮点数编码表示中，（ ）在机器数中不出现，是隐含的。', 'D', '在浮点数编码表示中，基数的值是约定好的，因此将其隐含。', '阶码', '符号', '尾数', '基数'),
(7, '00000000-0000-0000-0000-000000076007', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,68', '若某单精度浮点数、某原码、某补码、某移码的 32 位机器数均为 0xF0000000，则这些数从大到小的顺序是（ ）。', 'D', '这个机器数的最高位为 1，对于原码、补码、单精度浮点数而言为负数，对于移码而言为正数，所以移码最大，而补码为 -2^28，原码为 -(2^29+2^28+2^27)，单精度浮点数为 -1.0×2^112，大小依次递减。因此顺序为：移码 > 补码 > 原码 > 浮点数。', '浮 移 原 补', '移 浮 补 原', '移 原 补 浮', '移 补 原 浮'),
(8, '00000000-0000-0000-0000-000000076008', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,68', '采用规格化的浮点数最主要的是为了（ ）。', 'D', '与非规格化浮点数相比，采用规格化浮点数的目的主要是为了增加数据的表示精度。', '增加数据的表示范围', '方便浮点运算', '防止运算时数据溢出', '增加数据的表示精度'),
(9, '00000000-0000-0000-0000-000000076009', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,68', '设 x 是采用 IEEE 754 标准表示的 32 位单精度浮点数，下列说法中正确的是（ ）。
I. 当 |x|<1.0×2^(-126) 时，x 将被置为机器零
II. 当 |x|>1.0×2^127 时，将发生溢出
III. x 所能表示的最小非规格化正数与最大非规格化负数的绝对值相等
IV. x 可表示的最大正数与最小负数的绝对值相等', 'D', 'IEEE 754 单精度浮点数的阶码偏置为 127，规格化数的阶码范围为 1~254（对应真值指数 -126~+127），非规格化数用于表示接近零的数值。1.0×2^(-126) 是最小规格化正数，最小非规格化正数为 1.0×2^(-149)，仅当 |x| 小于此值时才舍入为机器零，说法 I 错误。最大可表示正数为 (2-2^(-23))×2^127，仅当 |x| 超过该值时才溢出，说法 II 错误。IEEE 754 浮点数的表示范围在正负区间完全对称，故说法 III 和 IV 正确。', 'I, II, III, IV', 'I, II', 'II, III, IV', 'III, IV'),
(10, '00000000-0000-0000-0000-000000076010', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,68', '在浮点运算中，下溢指的是（ ）。', 'A', '运算结果在 0 至规格化最小正数之间时称为正下溢，运算结果在 0 至规格化最大负数之间时称为负下溢，正下溢和负下溢统称下溢。即运算结果的绝对值小于机器所能表示的最小绝对值。', '运算结果的绝对值小于机器所能表示的最小绝对值', '运算的结果小于机器所能表示的最小负数', '运算的结果小于机器所能表示的最小正数', '运算结果的最低有效位产生的错误'),
(11, '00000000-0000-0000-0000-000000076011', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,68', '判断浮点数运算是否溢出，取决于（ ）。', 'C', '判断浮点数运算是否溢出，取决于阶码是否上溢。阶码下溢可以通过非规格化数来表示。尾数上溢或下溢，可以通过左移或右移进行调整。', '尾数是否上溢', '尾数是否下溢', '阶码是否上溢', '阶码是否下溢'),
(12, '00000000-0000-0000-0000-000000076012', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.61,68', '假定采用 IEEE 754 标准中的单精度浮点数格式表示一个数为 45100000H，则该数的值是（ ）。', 'B', '写成二进制表示为 0100 0101 0001 0000 0000 0000 0000 0000。第一位符号位 0 表示正数，随后 8 位 1000 1010 是用移码表示的阶码，减去 01111111 后得十进制数 11。尾数为 (1.0010)B=(1.125)D，因此该数值为 (+1.125)×2^11。', '(+1.125)×2^10', '(+1.125)×2^11', '(+0.125)×2^11', '(+0.125)×2^10'),
(13, '00000000-0000-0000-0000-000000076013', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,68', '已知 float 型用 IEEE 754 单精度浮点数格式，若 x,y 为 float 型变量，且 x=-126，y=15.75，则执行语句 z=x+y 时，在浮点运算单元中进行对阶操作后的结果是（ ）。', 'A', '规格化 IEEE 754 浮点数尾数部分的数值范围为 [1, 2)。x=-1111110B=-1.111110B×2^6，y=1111.11B=1.11111B×2^3，所以浮点数 x、y 的阶数分别为 6 和 3。对阶操作是小阶码向大阶码看齐，即 y 的阶数变为 6，移码表示为 6+127=133，即 10000101B，y 的尾数右移 3 位，变为 0.00111111B。x 不变。', 'x 不变，y 为 010000101,0.001111110…0', 'x 不变，y 为 010000110,0.001111110…0', 'y 不变，x 为 110000101,0.001111110…0', 'y 不变，x 为 110000110,0.001111110…0'),
(14, '00000000-0000-0000-0000-000000076014', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,68', '假设 x 和 y 均是 float 型变量，x 的真值为 1，y 的真值为 0.1。已知 0.1 的二进制表示为无限循环小数 0.00011[0011]…（重复因子为 0011），若计算机采用 IEEE 754 单精度格式及就近舍入方式，则计算 x+y 的结果用十六进制机器数表示为（ ）。', 'B', 'x=1.0=(1.0)×2^0，尾数为 1.00…0。y=0.1=(1.10011…)×2^(-4)，尾数为 1.100 1100 1100 1100 1100 1101（最低有效位之后的 3 位为 110，故末位加 1）。执行 x+y 时对阶：将 y 的尾数右移 4 位使其与 x 同阶 (2^0)，得 0.000 1100 1100 1100 1100 1100 1101。将其与 x 的尾数 1.00…0 相加，得 1.000 1100 1100 1100 1100 1100 1101。根据 1101 进行就近舍入，末位加 1，得 1.000 1100 1100 1100 1100 1101。最终编码为：符号位 0，阶码 127=01111111，尾数为 000 1100 1100 1100 1100 1101，组合并转换成十六进制数为 3F8CCCCD。', '3F800000', '3F8CCCCD', '3F8CCCCC', '3F80000C'),
(15, '00000000-0000-0000-0000-000000076015', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,68', '在 IEEE 754 标准浮点格式中，非规格化浮点数表示为（ ）。', 'A', '在 IEEE 754 标准浮点格式中，阶码全为 0，尾数不全为 0 表示非规格化数，非规格化数可用于处理阶码下溢，使得出现比最小规格化数还小的数时程序也能继续进行下去。', '阶码为 0，尾数为任意非 0 的二进制数', '阶码为 255，尾数全为 0', '阶码为 255，尾数为任意非 0 的二进制数', '阶码为 0，尾数全为 0'),
(16, '00000000-0000-0000-0000-000000076016', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,68', '在 IEEE 754 单精度浮点数加减运算的对阶阶段，若需将某操作数的尾数右移以对齐阶码，则关于其隐含的前导"1"，以下说法正确的是（ ）。', 'C', 'IEEE 754 单精度规格化数的有效数字为 24 位 (1.XX…X)，其中前导"1"是隐含的，未实际存储。对阶时，必须先恢复该隐含位，与 23 位尾数拼接成 24 位，再整体右移（高位补 0）以对齐阶码。因此，前导"1"会随尾数一同参与移位，可能被移出。右移是逻辑右移，高位补 0；若补 1 将导致数值错误。非规格化数无隐藏位。', '前导"1"不参与移位，始终保持隐含状态', '前导"1"参与移位，但为保持规格化形式，移位后仍重置为 1', '对阶移位前需先将隐含的"1"恢复到尾数高位，再整体右移', '非规格化数也包含隐含的"1"，因此同样需要恢复后再移位'),
(17, '00000000-0000-0000-0000-000000076017', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,68', '在 IEEE 754 单精度浮点数加减运算中，若两个操作数阶码之差的绝对值为 ΔE，当其大于或等于（ ）时，阶码较小的操作数对结果无影响，结果直接取阶码较大的操作数（假设采用就近舍入的方式）。', 'B', 'IEEE 754 单精度浮点数的有效数字为 24 位（含隐含前导 1）。对阶时，若阶差 ΔE≥25，则小阶操作数的隐含 1 将右移至舍入位或更低位，导致保护位为 0。根据就近舍入规则，此时无论舍入位和粘滞位为何值，均直接截断，不会进位；因此结果直接取大阶操作数。', '24', '25', '126', '128'),
(18, '00000000-0000-0000-0000-000000076018', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,68-69', '下列关于机器字长的叙述中，错误的是（ ）。', 'D', '机器字长是 CPU 一次能处理的定点整数位数，通常等于通用寄存器位数和定点运算数据通路宽度。机器字长越长，定点数的表示范围越大，可精确表示的整数位数越多。机器字长直接影响寄存器、ALU、总线等硬件的位宽，字长越长，电路规模越大，硬件成本显著增加。', '机器字长是指 CPU 中定点运算数据通路的宽度', '机器字长通常与 CPU 通用寄存器的位数一致', '机器字长决定了定点数的表示范围和精度', '机器字长对计算机硬件造价没有影响'),
(19, '00000000-0000-0000-0000-000000076019', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,69', '计算机中的信息按边界对齐方式存储的含义是（ ）。', 'D', '信息在存储器中按边界对齐方式存储的含义是信息单元的存储地址是其字节长度的整数倍。这样可以保证对一个字长数据的读/写只需要一次存储器访问，提高了访存效率，但有时会导致存储空间的浪费。因此，这是一种以空间换时间的办法。', '信息的字节长度必须是整数', '信息单元的字节长度必须是整数', '信息单元的存储地址必须是整数', '信息单元的存储地址是其字节长度的整数倍'),
(20, '00000000-0000-0000-0000-000000076020', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.62,69', '假设已定义三个 int 型变量 x、y 和 z，sizeof(int)=4，double 型采用 IEEE 754 双精度浮点数格式，变量 dx、dy 和 dz 的声明和初始化如下：
double dx = (double)x;
double dy = (double)y;
double dz = (double)z;
则下列关系表达式中永远为真的是（ ）。
I. dx + dy == (double)(x+y)
II. (dx + dy) + dz == dx + (dy + dz)', 'B', '说法 I 非永真，因为 x+y 可能溢出，而 dx+dy 不会溢出，两者结果可能不同。说法 II 永真，由于 dx、dy 和 dz 均由 32 位 int 转换而来，double 可精确地表示 int，且对阶时尾数移动位数不会超过 52 位，因此尾数不会舍入，不会发生大数吃小数的情况。', 'I 和 II', '仅 II', '仅 I', '无正确项'),
(21, '00000000-0000-0000-0000-000000076021', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.63,69', '在按字节编址的计算机中，采用小端方式存储数据，某静态二维数组 b 的声明如下：
static short b[2][4] = {{2,9,-1,5},{3,1,-6,2}};
若 b 的首地址为 0x8049820，采用按行优先存储，地址 0x804982c 中的内容是（ ）。', 'A', '二维数组 b 的元素是 short 型，占 2 字节，采用按行优先存储。b[0][0] 的地址为 0x8049820，b[0][1] 的地址为 0x8049822，以此类推，b[1][2] 的地址为 0x804982c。b[1][2] 的值为 -6，补码表示为 11111111 11111010，采用小端方式存储，因此地址 0x804982c 存放的是低位字节 FAH。', 'FAH', 'FFH', '00H', '05H'),
(22, '00000000-0000-0000-0000-000000076022', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.63,69', '在按字节编址的计算机中，数据在存储器中以小端方式存放。假定 int 型变量 i 的地址为 08000000H，i 的机器数为 01234567H，地址 08000000H 单元的内容是（ ）。', 'D', '小端方式是将最低有效字节存储在最小位置。在数 01234567H 中，最低有效字节为 67H。', '01H', '23H', '45H', '67H'),
(23, '00000000-0000-0000-0000-000000076023', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.63,69', '在按字节编址的 32 位计算机中，按边界对齐方式为以下结构型变量 x 分配存储空间：
struct cont_info {
    char id;
    unsigned post;
    char phone;
} x;
若 x 的首地址为 0x8049820，则成员变量 phone 的起始地址为（ ）。', 'A', '结构体按边界对齐存放的要求：数据成员的起始地址是其数据类型大小的整数倍。char 型占 1 字节，起始地址必须是 1 字节的整数倍；unsigned 型占 4 字节，起始地址必须是 4 字节的整数倍。据此分析，id 的起始地址为 0x8049820，post 的起始地址为 0x8049824，phone 的起始地址为 0x8049828。', '0x8049828', '0x8049826', '0x8049825', '0x8049822'),
(24, '00000000-0000-0000-0000-000000076024', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.63,69-70', '假定变量 i、f 的数据类型分别是 int、float。已知 i=12345，f=1.2345×2^3，则在一个 32 位机器中执行下列表达式时，结果为"假"的是（ ）。', 'D', '对于选项 A 和 B，int 型的有效位数不会超过 31 位，float 型的有效位数比 double 型的小得多，因此都能精确转换为具有 53 位有效位的 double 型。对于选项 C，12345<1024×16=2^14，因此 12345 对应的二进制的位数一定小于 14，因此可精确转换为具有 24 位有效位的 float 型。对于选项 D，f=1.2345×8=9.876，转换为 int 型后，小数点后面的数字丢失，因此与原来的 f 不相等。', 'i==(int)(double)i', 'f==(float)(double)f', 'i==(int)(float)i', 'f==(float)(int)f'),
(25, '00000000-0000-0000-0000-000000076025', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'BASIC', 'MOCK', 2027, '2.3浮点数的表示与运算', 'pp.63,70', '有以下 C 语言代码段：
int m=13;
float a=12.6,x;
x=m/2+a/2;
printf("%f\n",x);
执行上述代码后，输出的 x 值为（ ）。', 'B', '整数与整数运算，结果为整数，所以 m/2 的结果为 6。实数与整数运算，结果为实数，所以 a/2 的结果为 6.3，相加为 12.3。C 语言的输出格式可使输出值保留小数点后 6 位，输出为 12.300000。', '12.000000', '12.300000', '12.800000', '12'),
(26, '00000000-0000-0000-0000-000000076026', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'HARD', 'PAST_EXAM', 2009, '2.3浮点数的表示与运算', 'pp.63,70', '【2009 统考真题】浮点数加、减运算过程一般包括对阶、尾数运算、规格化、舍入和判断溢出等步骤。设浮点数的阶码和尾数均采用补码表示，且位数分别为 5 和 7（均含 2 位符号位）。若有两个数 X=2^7×29/32 和 Y=2^5×5/8，则用浮点加法计算 X+Y 的最终结果是（ ）。', 'D', 'X 的浮点数格式为 00,111;00,11101（分号前为阶码，分号后为尾数），Y 的浮点数格式为 00,101;00,10100。
① 对阶：X 的阶码比 Y 的阶码大 2，根据小阶码向大阶码看齐的原则，将 Y 的阶码加 2，尾数右移 2 位，将 Y 变为 00,111;00,00101。
② 尾数相加：00.11101+00.00101=01.00010，尾数相加结果符号位为 01，因此需要右规。
③ 规格化：将尾数右移 1 位，阶码加 1，得 X+Y 为 01,000;00,10001。
④ 判断溢出：阶码符号位为 01，说明发生溢出。', '001111100010', '001110100010', '010000010001', '发生溢出'),
(27, '00000000-0000-0000-0000-000000076027', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2010, '2.3浮点数的表示与运算', 'pp.63,70', '【2010 统考真题】假定变量 i、f 和 d 的数据类型分别为 int、float 和 double（int 型用补码表示，float 型和 double 型分别用 IEEE 754 单精度和双精度浮点数格式表示），已知 i=785、f=1.5678E3、d=1.5E100，若在 32 位机器中执行下列关系表达式，则结果为"真"的是（ ）。
I. i==(int)(float)i
II. f==(float)(int)f
III. f==(float)(double)f
IV. (d+f)-d==f', 'B', '三种数据类型强制类型转换的顺序为 int→float→double。i=785 转换为二进制真值为 1.100010001×2^9，小数点后只有 9 位，不会发生精度损失，说法 I 正确。对于说法 II，将 float 型的 f 转换为 int 型，小数点后的数位丢失，结果非真。double 型的精度和范围都比 float 型大，float 型转换为 double 型不会有损失，说法 III 正确。对于说法 IV，浮点运算 d+f 时需要对阶，对阶后 f 的尾数有效位被舍去而变为 0，因此 d+f 仍然为 d，再减去 d 后结果为 0，结果非真。', '仅 I 和 II', '仅 I 和 III', '仅 II 和 III', '仅 II 和 IV'),
(28, '00000000-0000-0000-0000-000000076028', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2011, '2.3浮点数的表示与运算', 'pp.63,70-71', '【2011 统考真题】float 型数据通常用 IEEE 754 单精度格式表示。若编译器将 float 型变量 x 分配在一个 32 位浮点寄存器 FR1 中，且 x=-8.25，则 FR1 的内容是（ ）。', 'A', '首先将 x 转换为二进制数，即 -1000.01=-1.00001×2^3。然后计算阶码 E，根据 IEEE 754 单精度浮点数格式，有 E-127=3，因此 E=130，转换为二进制数即 10000010。根据 IEEE 754 标准，最高位的 1 是被隐藏的。
IEEE 754 单精度浮点数格式：符号（1 位）+阶码（8 位）+尾数（23 位）。
因此 FR1 的内容为：1;10000010;00001000000000000000000
即 1100 0001 0000 0100 0000 0000 0000 0000=C1040000H。', 'C1040000H', 'C2420000H', 'C1840000H', 'C1C20000H'),
(29, '00000000-0000-0000-0000-000000076029', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2012, '2.3浮点数的表示与运算', 'pp.63,71', '【2012 统考真题】float 型（IEEE 754 单精度浮点数格式）能表示的最大正整数是（ ）。', 'D', 'IEEE 754 单精度浮点数是尾数用采取隐藏位策略的原码表示，且阶码用移码（偏置值为 127）表示的浮点数。规格化短浮点数的真值为 (-1)^S×1.m×2^(E-127)，其中 S 为符号位，阶码 E 的取值为 1~254（8 位表示），尾数 m 为 23 位。表示最大正整数时：符号取 0；阶码取最大值 127；尾数部分隐藏了整数部分的"1"，23 位尾数全取 1 时尾数最大，为 2-2^(-23)，此时浮点数的大小为 (2-2^(-23))×2^127=2^128-2^104。', '2^126-2^103', '2^127-2^104', '2^127-2^103', '2^128-2^104'),
(30, '00000000-0000-0000-0000-000000076030', 'CO_NUMBER', 'CO_NUMBER_REPRESENTATION', 'MEDIUM', 'PAST_EXAM', 2012, '2.3浮点数的表示与运算', 'pp.63-64,71', '【2012 统考真题】某计算机存储器按字节编址，采用小端方式存放数据。假定编译器规定 int 型和 short 型长度分别为 32 位和 16 位，并且数据按边界对齐存储。某 C 语言代码段如下：
struct {
    int a;
    char b;
    short c;
} record;
record.a = 273;
若 record 变量的首地址为 0xC008，则地址 0xC008 中的内容及 record.c 的地址分别为（ ）。', 'D', '尽管 record 大小为 7B（成员 a 有 4B，成员 b 有 1B，成员 c 有 2B），因为数据按边界对齐方式存储，所以 record 共占用 8B。record.a 的十六进制表示为 0x00000111，因为采用小端方式存放数据，所以地址 0xC008 中的内容应为低字节 0x11；record.b 只占 1B，后面的 1B 留空；record.c 占 2B，因此其地址为 0xC00E。', '0x00，0xC00D', '0x00，0xC00E', '0x11，0xC00D', '0x11，0xC00E');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 2 章 2.3.5/2.3.6 本节试题精选及答案解析；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch2_c_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000176', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch2_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000176', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch2_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000176', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch2_c_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000176', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch2_c_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch2_c_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000076701', 'CO-2027-ORIGINAL-CH2-C-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000076702', '2.3浮点数的表示与运算')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch2_c_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH2-C-TEXT-ONLY',
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

DROP TABLE co_2027_original_ch2_c_text_import;
