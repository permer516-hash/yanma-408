-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 3: 3.3.6/3.3.7 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH3-F

CREATE TABLE ds_2027_original_ch3_f_import (
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

INSERT INTO ds_2027_original_ch3_f_import (
    num, id, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000047001', 'BASIC', 'pp.106,108', '栈的应用不包括（ ）。', 'D', '缓冲区是用队列实现的，选项 A、B、C 都是栈的典型应用。', '递归', '表达式求值', '括号匹配', '缓冲区'),
(2, '00000000-0000-0000-0000-000000047002', 'MEDIUM', 'pp.106,108', '表达式 a*(b+c)-d 的后缀表达式是（ ）。', 'B', '后缀表达式中，每个运算符均直接位于其两个操作数的后面。将括号内的 b+c 转为 bc+，再与 a 做乘法得到 abc+*，最后减 d，得到 abc+*d-。', 'abc@*+-', 'abc+*d-', 'abc*+d-', '-+*abcd'),
(3, '00000000-0000-0000-0000-000000047003', 'BASIC', 'pp.106,108', '下面（ ）用到了队列。', 'D', 'FIFO 页面替换算法用到了队列，其余选项只用到了栈。', '括号匹配', '表达式求值', '递归', 'FIFO 页面替换算法'),
(4, '00000000-0000-0000-0000-000000047004', 'HARD', 'pp.106,108', '利用栈求表达式的值时，设立运算数栈 OPEN。假设 OPEN 只有两个存储单元，则在下列表达式中，不会发生溢出的是（ ）。', 'B', '利用栈求表达式的值时，可以分别设立运算符栈和运算数栈。选项 B 中 A 入栈、B 入栈后计算得 R1，C 入栈后计算得 R2，D 入栈后计算得 R3，运算数栈深为 2。选项 A、C、D 的计算栈深分别为 4、3、3。', 'A-B*(C-D)', '(A-B)*C-D', '(A-B*C)-D', '(A-B)*(C-D)'),
(5, '00000000-0000-0000-0000-000000047005', 'MEDIUM', 'pp.106,108', '执行下列语句后，i 的值为（ ）。
int f(int x) {
    return ((x>0)? x*f(x-1):2);
}
int i;
i=f(f(1));', 'B', '递归出口为 x<=0 时返回 2。由题意有 f(0)=2，f(1)=1*f(0)=2，i=f(f(1))=f(2)=2*f(1)=4。', '2', '4', '8', '无限递归'),
(6, '00000000-0000-0000-0000-000000047006', 'HARD', 'pp.107,108', '设有如下递归函数，则计算 F(8) 需要调用该递归函数的次数为（ ）。
int F(int n) {
    if(n<=3) return 1;
    else return F(n-2)+F(n-4)+1;
}', 'C', '计算 F(8) 的递归调用树可知，递归函数 F() 调用的次数为 9。', '7', '8', '9', '10'),
(7, '00000000-0000-0000-0000-000000047007', 'MEDIUM', 'pp.107,108', '设有如下递归函数，在 func(func(5)) 的执行过程中，第 4 个被执行的 func 函数是（ ）。
int func(int x) {
    if(x<=3) return 2;
    else return func(x-2)+func(x-4);
}', 'C', '先执行内层参数 func(5)=func(3)+func(1)=4，共执行 3 次 func 函数。然后执行 func(func(5))=func(4)=func(2)+func(0)=4，因此第 4 个被执行的 func 函数是 func(4)。也可画出递归调用树，按先序遍历顺序判断。', 'func(2)', 'func(3)', 'func(4)', 'func(5)'),
(8, '00000000-0000-0000-0000-000000047008', 'BASIC', 'pp.107,108', '对于一个问题的递归算法求解和其相对应的非递归算法求解，（ ）。', 'B', '通常情况下，递归算法在计算机实际执行过程中包含很多重复计算，所以效率会低。', '递归算法通常效率高一些', '非递归算法通常效率高一些', '两者相同', '无法比较'),
(9, '00000000-0000-0000-0000-000000047009', 'BASIC', 'pp.107,108', '执行函数时，其局部变量一般采用（ ）进行存储。', 'C', '调用函数时，系统会为调用者构造一个由参数表和返回地址组成的活动记录，并将记录压入系统提供的栈中。若被调用函数有局部变量，也要压入栈中。', '树形结构', '静态链表', '栈结构', '队列结构'),
(10, '00000000-0000-0000-0000-000000047010', 'BASIC', 'pp.107,108', '执行（ ）操作时，需要使用队列作为辅助存储空间。', 'B', '图的广度优先搜索类似于树的层序遍历，都要借助队列。', '查找散列（哈希）表', '广度优先搜索图', '前序（根）遍历二叉树', '深度优先搜索图'),
(11, '00000000-0000-0000-0000-000000047011', 'MEDIUM', 'pp.107-108', '下列说法中，正确的是（ ）。', 'A', '使用栈可以模拟递归过程，进而消除递归。对于单向递归和尾递归而言，也可以用迭代方式消除递归。不同的入栈和出栈组合操作会产生许多不同的输出序列。通常使用栈处理函数或过程调用。队列和栈都是操作受限的线性表，但队列只允许在表的两端进行运算，而栈只允许在栈顶方向进行操作。', '消除递归不一定需要使用栈', '对同一输入序列进行两组不同的合法入栈和出栈组合操作，所得的输出序列也一定相同', '通常使用队列来处理函数或过程调用', '队列和栈都是运算受限的线性表，只允许在表的两端进行运算');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 3 章 3.3.6/3.3.7 本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch3_f_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_STACK_QUEUE';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000147', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch3_f_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000147', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch3_f_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000147', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch3_f_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000147', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch3_f_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch3_f_import q
JOIN knowledge_points kp ON kp.code = 'DS_STACK_QUEUE_APPLICATION';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000047701', 'DS-2027-ORIGINAL-CH3-F'),
    ('00000000-0000-0000-0000-000000047702', '3.3栈和队列的应用')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch3_f_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH3-F',
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

DROP TABLE ds_2027_original_ch3_f_import;
