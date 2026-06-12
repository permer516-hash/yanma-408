-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 1: 1.1.3/1.1.4 and 1.2.3/1.2.4 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH1

INSERT INTO chapters (id, subject_id, code, name, sort_order)
SELECT CAST('00000000-0000-0000-0000-000000036201' AS UUID), s.id, 'DS_INTRO', '绪论', 0
FROM subjects s
WHERE s.code = 'DATA_STRUCTURE'
  AND NOT EXISTS (SELECT 1 FROM chapters c WHERE c.code = 'DS_INTRO');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT CAST(kp.id AS UUID), c.id, kp.code, kp.name, kp.sort_order
FROM chapters c
JOIN (
    VALUES
    ('00000000-0000-0000-0000-000000036301', 'DS_INTRO_BASIC', '数据结构基本概念', 1),
    ('00000000-0000-0000-0000-000000036302', 'DS_ALGORITHM_COMPLEXITY', '算法复杂度分析', 2)
) AS kp(id, code, name, sort_order) ON TRUE
WHERE c.code = 'DS_INTRO'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points existing WHERE existing.code = kp.code);

CREATE TABLE ds_2027_original_ch1_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer VARCHAR(1) NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch1_import (
    num, id, kp_code, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000036001', 'DS_INTRO_BASIC', 'BASIC', 'pp.15-16', '一个完整的数据结构通常应包含以下哪些要素（ ）？', 'C', '一个完整的数据结构由三部分组成：逻辑结构（如线性、树形等）、存储结构（物理表示）以及在其上定义的基本操作（如插入、删除等）。只有选项 C 同时包含这三个核心要素。', '数据元素及其存储方式', '数据的逻辑结构和物理结构', '数据的逻辑结构、存储结构以及在其上定义的基本操作', '数据对象和数据元素之间的关系'),
(2, '00000000-0000-0000-0000-000000036002', 'DS_INTRO_BASIC', 'BASIC', 'pp.15-16', '下列四种数据结构中，（ ）是非线性数据结构。', 'A', '树和图是典型的非线性数据结构，其他选项都属于线性数据结构。', '树', '字符串', '队列', '栈'),
(3, '00000000-0000-0000-0000-000000036003', 'DS_INTRO_BASIC', 'BASIC', 'pp.15-16', '下列选项中，属于逻辑结构的是（ ）。', 'C', '顺序表、哈希表和单链表是三种不同的数据结构，既描述逻辑结构，又描述存储结构和数据运算。而有序表是指关键字有序的线性表，仅描述元素之间的逻辑关系，它既可链式存储，又可顺序存储，所以属于逻辑结构。', '顺序表', '哈希表', '有序表', '单链表'),
(4, '00000000-0000-0000-0000-000000036004', 'DS_INTRO_BASIC', 'BASIC', 'pp.15-16', '下列关于数据结构的说法中，正确的是（ ）。', 'A', '数据的逻辑结构是从面向实际问题的角度出发的，只采用抽象表达方式，独立于存储结构；数据的存储结构是逻辑结构在计算机上的映射，它不能独立于逻辑结构而存在。数据结构包括三个要素，缺一不可。', '数据的逻辑结构独立于其存储结构', '数据的存储结构独立于其逻辑结构', '数据的逻辑结构唯一决定其存储结构', '数据结构仅由其逻辑结构和存储结构决定'),
(5, '00000000-0000-0000-0000-000000036005', 'DS_INTRO_BASIC', 'BASIC', 'pp.15-16', '在存储数据时，通常不仅要存储各数据元素的值，还要存储（ ）。', 'C', '在存储数据时，不仅要存储数据元素的值，而且要存储数据元素之间的关系。', '数据的操作方法', '数据元素的类型', '数据元素之间的关系', '数据的存取方法'),
(6, '00000000-0000-0000-0000-000000036006', 'DS_ALGORITHM_COMPLEXITY', 'BASIC', 'pp.18,20-21', '一个算法应该具有（ ）等重要特性。', 'B', '一个算法应具有五个重要特性：有穷性、确定性、可行性、输入和输出。选项 A、C 和 D 中提到的特性（如可维护性、可读性、可靠性、正确性等）很重要，但它们并不是算法定义的重要特性，更多的是关于软件开发中的附加要求。', '可维护性、可读性和可行性', '可行性、确定性和有穷性', '确定性、有穷性和可靠性', '可读性、正确性和可行性'),
(7, '00000000-0000-0000-0000-000000036007', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.18,20-21', '下列关于算法的说法中，正确的是（ ）。', 'C', '算法的时间效率是指算法的时间复杂度，即执行算法所需的计算工作量，选项 A 错误。算法设计会综合考虑时间效率和空间效率两个方面，选项 B 错误。评价一个算法的优劣不仅要考虑算法的时空效率，还要从正确性、可读性、健壮性等方面综合评价。', '算法的时间效率取决于算法执行所花的 CPU 时间', '在算法设计中不允许用牺牲空间效率的方式来换取好的时间效率', '算法必须具备有穷性、确定性等五个特性', '通常用时间效率和空间效率来衡量算法的优劣'),
(8, '00000000-0000-0000-0000-000000036008', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.18,20-21', '某算法的时间复杂度为 O(n^2)，则表示该算法的（ ）。', 'C', '时间复杂度为 O(n^2)，说明算法的时间复杂度 T(n) 满足 T(n) <= cn^2（其中 c 为比例常数），即 T(n)=O(n^2)。时间复杂度 T(n) 是问题规模 n 的函数，其问题规模仍然是 n 而不是 n^2。', '问题规模是 n^2', '执行时间等于 n^2', '执行时间与 n^2 成正比', '问题规模与 n^2 成正比'),
(9, '00000000-0000-0000-0000-000000036009', 'DS_ALGORITHM_COMPLEXITY', 'BASIC', 'pp.18,20-21', '若某算法的空间复杂度为 O(1)，则表示该算法（ ）。', 'B', '算法的空间复杂度为 O(1)，表示执行该算法所需的辅助空间大小相对输入数据的规模来说是一个常量，而不表示该算法执行时不需要任何空间或辅助空间。', '不需要任何辅助空间', '所需辅助空间大小与问题规模 n 无关', '不需要任何空间', '所需空间大小与问题规模 n 无关'),
(10, '00000000-0000-0000-0000-000000036010', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.18,20-21', '下列关于时间复杂度的函数中，时间复杂度最小的是（ ）。', 'D', '选项 A 的最高阶是 nlog2n，时间复杂度是 O(nlog2n)。选项 B 的最高阶是 n^2，时间复杂度是 O(n^2)。选项 C 的最高阶是 nlog2n，时间复杂度是 O(nlog2n)。选项 D 的最高阶是 log2n，时间复杂度是 O(log2n)。', 'T1(n)=nlog2n+5000n', 'T2(n)=n^2-8000n', 'T3(n)=nlog2n-6000n', 'T4(n)=20000log2n'),
(11, '00000000-0000-0000-0000-000000036011', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.18-19,21', '下列算法的时间复杂度为（ ）。\nvoid fun(int n) {\n    int i = 1;\n    while (i <= n)\n        i = i * 2;\n}', 'D', '找出基本运算 i=i*2，设执行次数为 t，2^t <= n，则 t <= log2n，故时间复杂度 T(n)=O(log2n)。更直观的方法是计算基本运算 i=i*2 的执行次数（每执行一次，i 乘以 2），其中判断条件可以理解为 2^t=n，即 t=log2n，则 T(n)=O(log2n)。', 'O(n)', 'O(n^2)', 'O(nlog2n)', 'O(log2n)'),
(12, '00000000-0000-0000-0000-000000036012', 'DS_ALGORITHM_COMPLEXITY', 'HARD', 'pp.19,21', '下列算法的时间复杂度为（ ）。\nvoid fun(int n) {\n    int i = 0;\n    while (i * i * i <= n)\n        i++;\n}', 'C', '基本运算为 i++，设执行次数为 t，有 t*t*t <= n，即 t^3 <= n。因此有 t <= 三次根号 n，则 T(n)=O(三次根号 n)。', 'O(n)', 'O(nlog2n)', 'O(三次根号 n)', 'O(根号 n)'),
(13, '00000000-0000-0000-0000-000000036013', 'DS_ALGORITHM_COMPLEXITY', 'HARD', 'pp.19,21', '某个程序段如下：\nfor (i=n-1; i>1; i--)\n    for (j=1; j<i; j++)\n        if (A[j] > A[j+1])\n            A[j] 与 A[j+1] 对换;\n其中 n 为正整数，则最后一行语句的频度在最坏情况下是（ ）。', 'D', '这是冒泡排序的算法代码，考查最坏情况下的元素交换次数。当所有相邻元素都为逆序时，则最后一行的语句每次都会执行。此时 T(n)=sum_{i=2}^{n-1} sum_{j=1}^{i-1} 1 = (n-2)(n-1)/2 = O(n^2)，所以在最坏情况下该语句的频度是 O(n^2)。', 'O(n)', 'O(nlog2n)', 'O(n^3)', 'O(n^2)'),
(14, '00000000-0000-0000-0000-000000036014', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.19,21', '下列程序段的时间复杂度为（ ）。\nif (n >= 0) {\n    for (int i=0; i<n; i++)\n        for (int j=0; j<n; j++)\n            printf(\"输入数据大于或等于零\\n\");\n} else {\n    for (int j=0; j<n; j++)\n        printf(\"输入数据小于零\\n\");\n}', 'A', '当程序段中有条件判断语句时，取分支路径上的最大时间复杂度。', 'O(n^2)', 'O(n)', 'O(1)', 'O(nlog2n)'),
(15, '00000000-0000-0000-0000-000000036015', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.19,21', '下列算法中加下划线的语句的执行次数为（ ）。\nint m=0,i,j;\nfor (i=1; i<=n; i++)\n    for (j=1; j<=2*i; j++)\n        m++;', 'A', 'm++ 语句的执行次数为 sum_{i=1}^{n} sum_{j=1}^{2i} 1 = sum_{i=1}^{n} 2i = 2 sum_{i=1}^{n} i = n(n+1)。', 'n(n+1)', 'n', 'n+1', 'n^2'),
(16, '00000000-0000-0000-0000-000000036016', 'DS_ALGORITHM_COMPLEXITY', 'HARD', 'pp.19,21-22', '下列函数代码的时间复杂度是（ ）。\nint Func(int n) {\n    if (n == 1) return 1;\n    else return 2 * Func(n/2) + n;\n}', 'C', '本题求的是递归调用的时间复杂度。递归调用可视为多重循环，每次递归执行的基本语句是 if(n==1) return 1，因此可以认为单层循环的执行次数为 1，设递归次数为 t，2^t <= n，即 t <= log2n，共执行了 log2n 次递归调用，所以时间复杂度为 O(log2n)。', 'O(n)', 'O(nlog2n)', 'O(log2n)', 'O(n^2)'),
(17, '00000000-0000-0000-0000-000000036017', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.19,22', '【2011 统考真题】设 n 是描述问题规模的非负整数，下列程序段的时间复杂度是（ ）。\nx=2;\nwhile (x < n/2)\n    x = 2 * x;', 'A', '基本运算（执行频率最高的语句）为 x=2*x，每执行一次，x 乘以 2，设执行次数为 t，则有 2^(t+1) < n/2，所以 t < log2(n/2)-1 = log2n-2，得 T(n)=O(log2n)。', 'O(log2n)', 'O(n)', 'O(nlog2n)', 'O(n^2)'),
(18, '00000000-0000-0000-0000-000000036018', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.19-20,22', '【2012 统考真题】求整数 n（n>=0）的阶乘的算法如下，其时间复杂度是（ ）。\nint fact(int n) {\n    if (n <= 1) return 1;\n    return n * fact(n-1);\n}', 'B', '本题求的是递归调用的时间复杂度。递归调用可视为多重循环，每次递归执行的基本语句是 if(n<=1) return 1，因此可以认为单层循环的执行次数为 1，共执行了 n 次递归调用，总执行次数 T=1+1+...+1=n，所以时间复杂度为 O(n)。', 'O(log2n)', 'O(n)', 'O(nlog2n)', 'O(n^2)'),
(19, '00000000-0000-0000-0000-000000036019', 'DS_ALGORITHM_COMPLEXITY', 'HARD', 'pp.20,22', '【2014 统考真题】下列程序段的时间复杂度是（ ）。\ncount=0;\nfor (k=1; k<=n; k*=2)\n    for (j=1; j<=n; j++)\n        count++;', 'C', '对于单层循环 for(j=1; j<=n; j++) count++，可以直接数出执行次数为 n，因此可将多层循环转换成多个并列的单层循环。外层循环变量 k 的幂次 t 满足 2^t <= n，所以总执行次数 T=n(t+1)=n(log2n+1)，时间复杂度为 O(nlog2n)。', 'O(log2n)', 'O(n)', 'O(nlog2n)', 'O(n^2)'),
(20, '00000000-0000-0000-0000-000000036020', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.20,22', '【2017 统考真题】下列函数的时间复杂度是（ ）。\nint func(int n) {\n    int i=0, sum=0;\n    while (sum < n) sum += ++i;\n    return i;\n}', 'B', '基本运算为 sum+=++i，等价于“++i; sum=sum+i”，每执行一次，i 都自增 1。当 i=1 时，sum=0+1；当 i=2 时，sum=0+1+2；当 i=3 时，sum=0+1+2+3，以此类推，得出 sum=0+1+2+3+...+i=(1+i)i/2，可知循环次数 t 满足 (1+t)t/2 < n，故时间复杂度为 O(n^(1/2))。', 'O(log2n)', 'O(n^(1/2))', 'O(n)', 'O(nlog2n)'),
(21, '00000000-0000-0000-0000-000000036021', 'DS_ALGORITHM_COMPLEXITY', 'MEDIUM', 'pp.20,22', '【2019 统考真题】设 n 是描述问题规模的非负整数，下列程序段的时间复杂度是（ ）。\nx=0;\nwhile (n >= (x+1)*(x+1))\n    x = x + 1;', 'B', '假设第 k 次循环终止，则第 k 次执行时，(x+1)^2 > n，x 的初始值为 0，第 k 次判断时 x=k-1，即 k^2 > n，k > 根号 n，因此该程序段的时间复杂度为 O(n^(1/2))。', 'O(log2n)', 'O(n^(1/2))', 'O(n)', 'O(n^2)'),
(22, '00000000-0000-0000-0000-000000036022', 'DS_ALGORITHM_COMPLEXITY', 'HARD', 'pp.20,22-23', '【2022 统考真题】下列程序段的时间复杂度是（ ）。\nint sum=0;\nfor (int i=1; i<n; i*=2)\n    for (int j=0; j<i; j++)\n        sum++;', 'B', '对于内层循环 for(j=0; j<i; j++) sum++，每趟的执行次数为 i（j 从 0 到 i）。外层循环条件为 i<n，循环结束时，i 的幂次 t 满足 2^t < n <= 2^(t+1)。总执行次数 T=1+2^1+2^2+...+2^t=2^(t+1)-1，即 n-1 <= T 且 T < 2n-1，所以时间复杂度为 O(n)。', 'O(log2n)', 'O(n)', 'O(nlog2n)', 'O(n^2)'),
(23, '00000000-0000-0000-0000-000000036023', 'DS_ALGORITHM_COMPLEXITY', 'HARD', 'pp.20,23', '【2025 统考真题】下列程序段的时间复杂度是（ ）。\nint count=0,i,j;\nfor (i=1; i*i<=n; i++)\n    for (j=1; j<=i; j++)\n        count++;', 'B', '对于单层循环 for(j=1; j<=i; j++) count++，其每趟的执行次数为 i（j 从 1 到 i）。外层循环的条件为 i^2<=n，即 i<=根号 n。因此，总执行次数 T(n)=1+2+...+floor(根号 n)=n/2+floor(根号 n)/2，时间复杂度为 O(n)。', 'O(log2n)', 'O(n)', 'O(nlog2n)', 'O(n^2)');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 1 章本节试题精选与答案解析，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch1_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_INTRO';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000136', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch1_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000136', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch1_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000136', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch1_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000136', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch1_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch1_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000036701', 'DS-2027-ORIGINAL-CH1'),
    ('00000000-0000-0000-0000-000000036702', '第1章绪论')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch1_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH1',
    '第1章绪论',
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

DROP TABLE ds_2027_original_ch1_import;
