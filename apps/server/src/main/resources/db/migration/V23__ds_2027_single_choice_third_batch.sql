-- Third data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Batch: DS-2027-003

CREATE TABLE ds_2027_batch3_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    stem VARCHAR(1000) NOT NULL,
    answer VARCHAR(1) NOT NULL,
    explanation VARCHAR(1000) NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL
);

INSERT INTO ds_2027_batch3_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000023001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', '线性表中第一个元素通常没有哪类邻接元素？', 'A', '线性表中第一个元素没有直接前驱，最后一个元素没有直接后继。', '直接前驱', '直接后继', '存储地址', '元素值'),
(2, '00000000-0000-0000-0000-000000023002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '顺序表在表尾插入元素且容量未满时，时间复杂度通常为？', 'A', '表尾插入不需要移动已有元素，只需写入新元素并更新长度，时间复杂度为 O(1)。', 'O(1)', 'O(log n)', 'O(n)', 'O(n^2)'),
(3, '00000000-0000-0000-0000-000000023003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '单链表设置头结点的主要好处是？', 'C', '头结点能统一空表和非空表、首元结点插入删除等边界处理。', '减少每个结点数据域大小', '让链表支持随机访问', '统一空表和首元结点操作', '保证链表有序'),
(4, '00000000-0000-0000-0000-000000023004', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '在单链表中删除某结点的后继结点，已知该结点指针 p，通常需要修改什么？', 'B', '删除 p 的后继结点时，需要让 p->next 指向原后继的后继。', 'p 的数据域', 'p 的 next 域', '头结点的数据域', '所有结点的地址'),
(5, '00000000-0000-0000-0000-000000023005', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '双链表相比单链表，在已知某结点指针时更便于执行哪类操作？', 'D', '双链表保存前驱和后继指针，已知结点时可直接访问其前驱，删除或前插更方便。', '按下标随机访问', '二分查找', '哈希定位', '访问前驱并进行前插/删除'),
(6, '00000000-0000-0000-0000-000000023006', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'BASIC', '队列的插入操作通常称为？', 'B', '队列一端插入、另一端删除，插入操作通常称为入队。', '出队', '入队', '压栈', '出栈'),
(7, '00000000-0000-0000-0000-000000023007', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '循环队列中若采用计数器 count 区分队空和队满，则队空条件通常是？', 'A', '使用 count 记录元素个数时，count 为 0 表示队空，count 等于容量表示队满。', 'count = 0', 'front = rear + 1', 'rear = 0', 'front = capacity'),
(8, '00000000-0000-0000-0000-000000023008', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', '递归调用过程通常需要系统栈保存哪些信息？', 'C', '递归调用需要保存返回地址、局部变量、参数等活动记录信息，以便返回后恢复现场。', '磁盘块号', '散列函数', '返回地址和局部环境', '所有输入文件'),
(9, '00000000-0000-0000-0000-000000023009', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '后缀表达式求值扫描到运算符时，通常应如何处理？', 'D', '后缀表达式求值遇到运算符时，从栈中弹出所需操作数计算，再把结果压回栈。', '直接输出运算符', '把运算符压入队列', '丢弃栈顶元素', '弹出操作数计算并压回结果'),
(10, '00000000-0000-0000-0000-000000023010', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'BASIC', '数组适合随机访问的根本原因通常是？', 'B', '数组元素类型相同且连续存储，可由基地址、下标和元素大小直接计算地址。', '元素值天然有序', '可通过地址公式直接定位', '每个元素都有指针域', '只能顺序扫描'),
(11, '00000000-0000-0000-0000-000000023011', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'MEDIUM', '下三角矩阵压缩存储时，位于上三角区域的相同常数元素通常如何处理？', 'C', '三角矩阵压缩存储时，非主要三角区域的常数元素通常只额外保存一次。', '全部逐个保存', '全部丢弃且不可恢复', '只保存一个常数值', '转为链表保存'),
(12, '00000000-0000-0000-0000-000000023012', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'HARD', '稀疏矩阵十字链表存储中，每个非零结点通常同时属于哪两条链？', 'A', '十字链表中的非零结点既在所在行链中，也在所在列链中，便于按行或按列访问。', '行链和列链', '前序链和后序链', '栈链和队列链', '父链和孩子链'),
(13, '00000000-0000-0000-0000-000000023013', 'DS_STRING', 'DS_STRING_KMP', 'BASIC', '空串的长度为多少？', 'A', '空串是不含任何字符的串，其长度为 0。', '0', '1', '-1', '不确定'),
(14, '00000000-0000-0000-0000-000000023014', 'DS_STRING', 'DS_STRING_KMP', 'MEDIUM', '串的定长顺序存储方式最明显的局限是？', 'D', '定长顺序存储预先限定最大串长，超出上限时会发生截断或溢出问题。', '不能按下标访问', '不能保存字符', '必须使用链表', '最大长度固定'),
(15, '00000000-0000-0000-0000-000000023015', 'DS_STRING', 'DS_STRING_KMP', 'HARD', 'KMP 改进 nextval 数组的主要目的是什么？', 'B', 'nextval 用于避免模式串中某些相同字符导致的无效重复比较。', '扩大主串长度', '减少失配后的无效比较', '把时间复杂度降为 O(1)', '取消模式串预处理'),
(16, '00000000-0000-0000-0000-000000023016', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'BASIC', '树中某结点拥有的子树个数称为什么？', 'C', '结点拥有的子树个数称为该结点的度。', '高度', '层次', '度', '路径长度'),
(17, '00000000-0000-0000-0000-000000023017', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '具有 n 个结点的树中边数为多少？', 'B', '树中除根结点外，每个结点都有且仅有一条来自双亲的边，因此边数为 n-1。', 'n', 'n - 1', 'n + 1', '2n'),
(18, '00000000-0000-0000-0000-000000023018', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '完全二叉树中编号为 i 的结点，若 i > 1，其双亲结点编号通常为？', 'A', '顺序存储完全二叉树时，编号 i 的结点双亲编号为 floor(i/2)。', 'floor(i/2)', '2i', '2i + 1', 'i - 1'),
(19, '00000000-0000-0000-0000-000000023019', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', '一棵满二叉树高度为 h，根为第 1 层，则结点总数为？', 'D', '高度为 h 的满二叉树各层结点数为 1,2,...,2^(h-1)，总数为 2^h-1。', '2h', '2^(h-1)', '2^h', '2^h - 1'),
(20, '00000000-0000-0000-0000-000000023020', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', '哈夫曼编码通常具有什么性质？', 'C', '哈夫曼编码是前缀编码，任一字符编码都不是另一个字符编码的前缀。', '所有编码等长', '必须含有数字 2', '任一码字都不是另一码字前缀', '编码越长权值越大'),
(21, '00000000-0000-0000-0000-000000023021', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', '有向图中某顶点的入度表示什么？', 'A', '入度是以该顶点为终点的有向边条数。', '以该顶点为终点的边数', '以该顶点为起点的边数', '与该顶点无关的边数', '该顶点的权值'),
(22, '00000000-0000-0000-0000-000000023022', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', '邻接表存储无向图时，若图有 e 条边，则边结点个数通常为？', 'B', '无向图每条边会在两个顶点的邻接表中各出现一次，因此边结点个数为 2e。', 'e', '2e', 'e - 1', 'e + n'),
(23, '00000000-0000-0000-0000-000000023023', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', '深度优先搜索 DFS 通常借助哪种思想或结构实现？', 'C', 'DFS 沿一条路径尽可能深入，常用递归或栈实现。', '队列先进先出', '散列开放定址', '递归或栈', '顺序表二分'),
(24, '00000000-0000-0000-0000-000000023024', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'Floyd 算法主要用于求解哪类最短路径问题？', 'D', 'Floyd 算法通过动态规划求解图中任意两个顶点之间的最短路径。', '无权图单源最短路径', '最小生成树', '拓扑排序', '各顶点对之间最短路径'),
(25, '00000000-0000-0000-0000-000000023025', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '关键路径问题中，活动的最早开始时间和最迟开始时间相等通常说明什么？', 'A', '若某活动最早开始时间等于最迟开始时间，说明该活动没有时间余量，是关键活动。', '该活动是关键活动', '该活动一定不可执行', '该活动不在图中', '该活动权值为 0'),
(26, '00000000-0000-0000-0000-000000023026', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', '顺序查找的主要优点是？', 'C', '顺序查找对表的存储结构和关键字有序性要求低，顺序表和链表都可使用。', '一定最快', '只适用于有序表', '对存储结构要求低', '必须随机访问'),
(27, '00000000-0000-0000-0000-000000023027', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'MEDIUM', '带哨兵的顺序查找通常可以减少哪类操作？', 'A', '哨兵可避免每次循环都判断是否越界，从而减少边界判断。', '边界判断', '关键字比较', '数据存储', '散列冲突'),
(28, '00000000-0000-0000-0000-000000023028', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '二叉排序树查找效率主要取决于什么？', 'B', 'BST 查找沿树高方向进行，因此效率主要取决于树的高度。', '结点数据域长度', '树的高度', '叶结点颜色', '边权之和'),
(29, '00000000-0000-0000-0000-000000023029', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '红黑树从根到叶结点的任一路径上，黑结点数目满足什么性质？', 'D', '红黑树要求从任一结点到其所有后代叶结点的简单路径上黑结点数相同。', '可以任意变化', '必须为 1', '必须等于红结点数', '相同'),
(30, '00000000-0000-0000-0000-000000023030', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'B+ 树相比 B 树，一个典型特点是？', 'C', 'B+ 树通常所有记录指针都在叶结点，叶结点之间可按关键字顺序链接。', '所有关键字只在根结点', '不支持范围查询', '叶结点按序链接', '每个结点最多两个孩子'),
(31, '00000000-0000-0000-0000-000000023031', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '散列查找中装填因子通常定义为？', 'A', '装填因子通常是表中已有记录数与散列表长度之比。', '记录数/散列表长度', '散列表长度/记录数', '冲突次数/关键字位数', '关键字最大值/最小值'),
(32, '00000000-0000-0000-0000-000000023032', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', '直接插入排序在最好情况下的时间复杂度通常为？', 'B', '当序列已有序时，直接插入排序每趟只需比较一次，时间复杂度为 O(n)。', 'O(1)', 'O(n)', 'O(n log n)', 'O(n^2)'),
(33, '00000000-0000-0000-0000-000000023033', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '折半插入排序相比直接插入排序，主要减少的是哪类次数？', 'C', '折半插入排序用二分定位插入位置，减少关键字比较次数，但元素移动次数并不减少。', '元素移动次数', '辅助空间大小', '关键字比较次数', '递归调用次数'),
(34, '00000000-0000-0000-0000-000000023034', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '简单选择排序的稳定性通常如何？', 'D', '简单选择排序交换最小元素到前面时，可能改变相等关键字的相对次序，通常不稳定。', '一定稳定', '只对链表稳定', '只对完全有序表稳定', '通常不稳定'),
(35, '00000000-0000-0000-0000-000000023035', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '堆排序中建立大根堆后，堆顶元素通常是什么？', 'A', '大根堆要求每个结点关键字不小于其孩子，堆顶为当前最大关键字。', '当前最大关键字', '当前最小关键字', '随机关键字', '最后插入的关键字'),
(36, '00000000-0000-0000-0000-000000023036', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '二路归并排序一趟归并后，归并段长度通常如何变化？', 'B', '二路归并每趟把相邻两个有序段合并，因此归并段长度通常加倍。', '减半', '约加倍', '变为 1', '保持不变'),
(37, '00000000-0000-0000-0000-000000023037', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '基数排序的趟数主要取决于什么？', 'C', '基数排序按关键字各位进行分配和收集，趟数主要由关键字位数决定。', '记录个数', '比较次数', '关键字位数', '树的高度'),
(38, '00000000-0000-0000-0000-000000023038', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '外部排序生成初始归并段后，总归并趟数主要受哪些因素影响？', 'D', '归并趟数与初始归并段个数和归并路数有关，路数越大通常趟数越少。', 'CPU 字长和补码范围', '栈顶和队尾位置', '图的顶点度数', '初始归并段个数和归并路数'),
(39, '00000000-0000-0000-0000-000000023039', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'Prim 算法每一步通常选择哪类边加入生成树？', 'A', 'Prim 从已选顶点集合出发，每次选择连接该集合与外部顶点的最小权边。', '连接已选集合和未选顶点的最小权边', '任意一条最大权边', '形成回路的最小边', '最后输入的边'),
(40, '00000000-0000-0000-0000-000000023040', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '线性探测法处理冲突时，容易产生的典型问题是什么？', 'B', '线性探测会使连续地址区形成聚集，增加后续探测长度。', '无法插入任何元素', '一次聚集', '关键字自动排序', '树高必定为 1');

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
    '基于 /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf 的第三批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_batch3_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000123', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_batch3_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000123', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_batch3_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000123', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_batch3_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000123', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_batch3_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_batch3_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000023701', 'DS-2027-003')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_batch3_import q
JOIN question_tags tag ON tag.name IN ('2027数据结构', 'DS-2027-003', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_batch3_import;
