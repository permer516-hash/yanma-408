-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.3.6/3.3.7 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-G

CREATE TABLE ds_2027_original_ch3_g_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_year INTEGER NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    stem_format VARCHAR(32) NOT NULL DEFAULT 'PLAIN_TEXT',
    stem_image_url TEXT,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch3_g_import (
    num, id, difficulty, source_year, source_pages, stem, answer, explanation,
    stem_format, stem_image_url, option_a, option_b, option_c, option_d
) VALUES
(12, '00000000-0000-0000-0000-000000048012', 'BASIC', 2009, 'pp.107,110', '【2009 统考真题】为解决计算机主机与打印机之间速度不匹配的问题，通常设置一个打印数据缓冲区。主机将要输出的数据依次写入该缓冲区，而打印机则依次从该缓冲区中取出数据。该缓冲区的逻辑结构应该是（ ）。', 'B', '在提取数据时必须保持原来数据的顺序，所以缓冲区的特性是先进先出。', 'PLAIN_TEXT', NULL, '栈', '队列', '树', '图'),
(13, '00000000-0000-0000-0000-000000048013', 'HARD', 2012, 'pp.107,110', '【2012 统考真题】已知操作符包括“+”“-”“*”“/”“(”和“)”。将中缀表达式 a+b-a*((c+d)/e-f)+g 转换为等价的后缀表达式 ab+acd+e/f-*-g+ 时，用栈来存放暂时还不能确定运算次序的操作符。栈初始时为空，转换过程中同时保存在栈中的操作符的最大个数是（ ）。', 'A', '在中缀表达式转后缀表达式的过程中，扫描到操作数时直接输出，扫描到操作符时根据优先级进行相应出入栈操作。逐步模拟可知，栈中操作符的最大个数为 5。', 'PLAIN_TEXT', NULL, '5', '7', '8', '11'),
(14, '00000000-0000-0000-0000-000000048014', 'HARD', 2014, 'pp.107,110-111', '【2014 统考真题】假设栈初始为空，将中缀表达式 a/b+(c*d-e*f)/g 转换为等价的后缀表达式的过程中，当扫描到 f 时，栈中的元素依次是（ ）。', 'B', '中缀表达式转后缀表达式时，操作数直接输出，操作符按优先级入栈或出栈。扫描到 f 时，后缀表达式中 f 后面的运算符还需结合中缀式判断；此时栈中的运算符从栈底到栈顶为 +、(、-、*，因此栈中元素依次是 +(-*。', 'PLAIN_TEXT', NULL, '+(*-', '+(-*', '/+(*-*', '/+-*'),
(15, '00000000-0000-0000-0000-000000048015', 'MEDIUM', 2015, 'pp.107-108,111', '【2015 统考真题】已知程序如下：
int S(int n)
{
    return (n<=0)?0:S(n-1)+n;
}
void main()
{
    cout<<S(1);
}
程序运行时使用栈来保存调用过程的信息，自栈底到栈顶保存的信息依次对应的是（ ）。', 'A', '递归调用函数时，在系统栈中保存的函数信息满足先进后出的特点。程序依次调用 main()、S(1)、S(0)，所以栈底到栈顶的信息依次是 main()、S(1)、S(0)。', 'PLAIN_TEXT', NULL, 'main()->S(1)->S(0)', 'S(0)->S(1)->main()', 'main()->S(0)->S(1)', 'S(1)->S(0)->main()'),
(16, '00000000-0000-0000-0000-000000048016', 'HARD', 2016, 'pp.108,111', '【2016 统考真题】设有如图所示的火车车轨，入口和出口之间有 n 条轨道，列车的行进方向均为从左至右，列车可驶入任意一条轨道。现有编号为 1-9 的 9 列列车，驶入的次序依次是 8,4,2,5,3,9,1,6,7。若期望驶出的次序依次为 1-9，则 n 至少是（ ）。', 'C', '每个轨道可看作一个队列。为保证输出为 1-9，同一轨道中后进入的元素必须大于前面的元素，并且要使用尽可能少的轨道。按驶入序列分配轨道可知至少需要 4 个轨道。', 'DIAGRAM', '/question-assets/ds-2027/ch3/q16-train-tracks.png', '2', '3', '4', '5'),
(17, '00000000-0000-0000-0000-000000048017', 'MEDIUM', 2017, 'pp.108,111', '【2017 统考真题】下列关于栈的叙述中，错误的是（ ）。
I. 采用非递归方式重写递归程序时必须使用栈
II. 函数调用时，系统要用栈保存必要的信息
III. 只要确定了入栈次序，即可确定出栈次序
IV. 栈是一种受限的线性表，允许在其两端进行操作', 'C', '说法 I 错误，例如斐波那契数列可用循环迭代实现。说法 III 错误，同一入栈序列可以通过不同的 Push/Pop 组合得到不同出栈序列。说法 IV 错误，栈只允许在一端进行操作。说法 II 正确。', 'PLAIN_TEXT', NULL, '仅 I', '仅 I、II、III', '仅 I、III、IV', '仅 II、III、IV'),
(18, '00000000-0000-0000-0000-000000048018', 'HARD', 2018, 'pp.108,111', '【2018 统考真题】若栈 S1 中保存整数，栈 S2 中保存运算符，函数 F() 依次执行下述各步操作：
1）从 S1 中依次弹出两个操作数 a 和 b；
2）从 S2 中弹出一个运算符 op；
3）执行相应的运算 b op a；
4）将运算结果压入 S1 中。
假定 S1 中的操作数依次是 5,8,3,2（2 在栈顶），S2 中的运算符依次是 *、-、+（+ 在栈顶）。调用 3 次 F() 后，S1 栈顶保存的值是（ ）。', 'B', '第一次调用弹出 2 和 3，弹出 +，执行 3+2=5 并压入 S1；第二次调用弹出 5 和 8，弹出 -，执行 8-5=3 并压入 S1；第三次调用弹出 3 和 5，弹出 *，执行 5*3=15 并压入 S1。因此栈顶为 15。', 'PLAIN_TEXT', NULL, '-15', '15', '-20', '20'),
(19, '00000000-0000-0000-0000-000000048019', 'MEDIUM', 2024, 'pp.108,111', '【2024 统考真题】与表达式 x+y*(z-u)/v 等价的后缀表达式是（ ）。', 'A', '根据中缀表达式可画出对应二叉树，对该二叉树进行后序遍历，即可得到后缀表达式 xyzu-*v/+。也可采用手算方法转换。', 'PLAIN_TEXT', NULL, 'xyzu-*v/+', 'xyzu-v/*+', '+x/*y-zuv', '+x*y/-zuv'),
(20, '00000000-0000-0000-0000-000000048020', 'HARD', 2025, 'pp.108,111-112', '【2025 统考真题】已知算法 A 用于检查字符串中各类括号是否匹配，A 执行过程中使用初始为空的栈保存遇到的括号。若栈的容量是 3，则下列选项中，A 不能处理的是（ ）。', 'D', '该算法利用栈检查括号匹配，遇到左括号时入栈，遇到右括号时出栈并匹配。栈容量为 3，最多只能容纳 3 个未匹配的左括号。选项 D 的括号序列为 [([()])]，最大嵌套深度达到 4，扫描到第 4 个左括号时栈已满，因此无法被正确处理。', 'PLAIN_TEXT', NULL, '(a+[b+(c+d)/e]+f)+g-h', '[a*((b+c)/(d-e)+f/g)-h]', '[a*(b-(c-d)*e/(f+g))-h]', '[a-(b+[c*(d+e)-f]+g+h)]');

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
    'PAST_EXAM',
    q.source_year,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 3 章 3.3.6/3.3.7 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    q.stem_format,
    q.stem_image_url,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch3_g_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STACK_QUEUE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000148', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_g_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000148', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_g_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000148', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_g_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000148', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_g_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_g_import q
JOIN knowledge_points kp ON kp.code = 'DS_STACK_QUEUE_APPLICATION';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000048701', 'DS-2027-ORIGINAL-CH3-G')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_g_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-G',
    '第3章栈队列和数组',
    '3.3栈和队列的应用',
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

DROP TABLE ds_2027_original_ch3_g_import;
