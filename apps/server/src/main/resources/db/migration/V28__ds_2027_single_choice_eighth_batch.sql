-- Eighth data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Batch: DS-2027-008

CREATE TABLE ds_2027_batch8_import (
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

INSERT INTO ds_2027_batch8_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000028001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', '线性表的逻辑特征通常是每个元素最多有几个直接前驱和直接后继？', 'B', '线性结构中除首尾结点外，每个元素有一个直接前驱和一个直接后继。', '两个前驱和两个后继', '一个前驱和一个后继', '任意多个前驱', '没有相邻关系'),
(2, '00000000-0000-0000-0000-000000028002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '长度为 n 的顺序表删除第 i 个元素时，通常需要移动多少个后继元素？', 'C', '删除第 i 个元素后，第 i+1 到第 n 个元素要依次前移，共 n-i 个。', 'i 个', 'i-1 个', 'n-i 个', 'n+i 个'),
(3, '00000000-0000-0000-0000-000000028003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '若单链表只给出待删除结点 p 且 p 不是尾结点，常用的 O(1) 删除技巧是？', 'A', '可把 p 后继结点的数据复制到 p，再删除 p 的后继结点。', '复制后继数据并删除后继', '从头结点重新排序', '把 p 变为头结点', '执行二分查找'),
(4, '00000000-0000-0000-0000-000000028004', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '循环单链表判断是否遍历一周时，常用的停止条件是当前指针再次等于什么？', 'D', '循环链表没有空指针作为末尾标记，常以再次回到起始结点作为遍历结束条件。', 'NULL', '尾结点数据域', '链表长度平方', '起始结点'),
(5, '00000000-0000-0000-0000-000000028005', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '两个递增有序单链表归并为一个递增链表时，若复用原结点，主要操作是什么？', 'B', '复用原结点时只需调整指针链接，把较小结点依次接到结果链表尾部。', '重新申请全部数组空间', '调整结点指针链接', '对每个结点执行哈希', '先转成完全二叉树'),
(6, '00000000-0000-0000-0000-000000028006', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'BASIC', '栈的删除操作通常发生在哪一端？', 'C', '栈只允许在栈顶进行插入和删除。', '队头', '表中任意位置', '栈顶', '栈底之前'),
(7, '00000000-0000-0000-0000-000000028007', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '若循环队列用 front 指向队头元素、rear 指向队尾后一个位置，则入队时通常先写入哪个位置？', 'B', '该约定下 rear 指向下一个可插入位置，入队先写入 rear，再令 rear 后移。', 'front 前一个位置', 'rear 所指位置', 'front 所指位置', '数组最后一个位置固定不变'),
(8, '00000000-0000-0000-0000-000000028008', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', '用栈模拟递归时，栈帧中通常不需要保存下列哪项？', 'D', '递归栈帧通常保存参数、局部变量和返回位置，不需要保存整张散列表。', '参数', '局部变量', '返回位置', '完整散列表全部元素'),
(9, '00000000-0000-0000-0000-000000028009', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '后缀表达式 ab+c* 表示的中缀表达式是？', 'A', 'ab+ 先表示 a+b，再与 c 相乘，因此为 (a+b)*c。', '(a+b)*c', 'a+b*c', 'a*(b+c)', 'a*b+c'),
(10, '00000000-0000-0000-0000-000000028010', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', '判断括号序列是否合法时，扫描到右括号通常应执行什么操作？', 'C', '右括号需要与最近的未匹配左括号配对，因此应从栈中弹出并检查类型。', '直接入队', '忽略该字符', '弹出栈顶左括号并匹配', '清空整个数组'),
(11, '00000000-0000-0000-0000-000000028011', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'BASIC', '二维数组按列优先存储时，同一列中相邻元素的地址关系通常是？', 'A', '按列优先会先连续存放同一列元素，因此同一列相邻元素物理地址连续。', '连续', '一定相差 n^2 个单元', '完全随机', '必须经过链表指针访问'),
(12, '00000000-0000-0000-0000-000000028012', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'MEDIUM', 'n 阶下三角矩阵压缩到一维数组时，需要保存的主要元素个数是？', 'B', '下三角含主对角线共有 n(n+1)/2 个位置。', 'n', 'n(n+1)/2', 'n(n-1)', '2n+1'),
(13, '00000000-0000-0000-0000-000000028013', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'HARD', '稀疏矩阵十字链表相比三元组表的优势通常体现在？', 'D', '十字链表同时维护行链和列链，更便于按行或按列插入、删除和遍历非零元素。', '完全不需要存储行号', '能让所有元素连续存储', '只能按行顺序输出', '便于按行和按列组织非零元素'),
(14, '00000000-0000-0000-0000-000000028014', 'DS_STRING', 'DS_STRING_KMP', 'BASIC', '空串和空格串的关系通常如何？', 'C', '空串长度为 0，空格串包含空格字符，二者不是同一个串。', '完全相同', '空格串长度为 0', '不是同一个串', '空串一定含一个空格'),
(15, '00000000-0000-0000-0000-000000028015', 'DS_STRING', 'DS_STRING_KMP', 'MEDIUM', '朴素模式匹配在某次失配后，主串起始比较位置通常如何变化？', 'B', '朴素匹配失配后通常把模式串右移一位，从主串下一起点重新比较。', '永不变化', '向后移动一位重新比较', '直接跳到末尾', '按堆序调整'),
(16, '00000000-0000-0000-0000-000000028016', 'DS_STRING', 'DS_STRING_KMP', 'HARD', 'KMP 中若 next[j] = k，通常表示模式串当前位置失配后应把 j 调整到哪里？', 'A', 'next 值给出失配后模式串指针应回退的位置。', 'k', 'j+1', '主串起点', '散列表地址'),
(17, '00000000-0000-0000-0000-000000028017', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'BASIC', '森林转换为二叉树时，常采用的规则可概括为？', 'D', '森林和树转二叉树常用左孩子右兄弟表示法。', '所有边都删除', '只保留叶结点', '按关键字排序', '左孩子右兄弟'),
(18, '00000000-0000-0000-0000-000000028018', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '一棵二叉树第 i 层最多有多少个结点？根为第 1 层。', 'C', '二叉树第 i 层最多有 2^(i-1) 个结点。', 'i', '2i', '2^(i-1)', '2^i-1'),
(19, '00000000-0000-0000-0000-000000028019', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', '含 n 个结点的完全二叉树中，编号大于 floor(n/2) 的结点通常是什么结点？', 'A', '完全二叉树顺序编号中，大于 floor(n/2) 的结点没有孩子，均为叶结点。', '叶结点', '根结点', '一定有两个孩子', '全部是左孩子'),
(20, '00000000-0000-0000-0000-000000028020', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', '哈夫曼树的带权路径长度主要由哪两项共同决定？', 'C', 'WPL 是叶结点权值与其路径长度乘积之和。', '结点编号和颜色', '边数和图密度', '叶权值和路径长度', '栈顶和队尾'),
(21, '00000000-0000-0000-0000-000000028021', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'HARD', '并查集采用路径压缩的主要效果是什么？', 'B', '路径压缩在 find 过程中让路径上的结点直接或近似直接指向根，降低后续查找代价。', '增加树高', '降低后续查找路径长度', '删除所有集合', '把集合改成队列'),
(22, '00000000-0000-0000-0000-000000028022', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', '无向连通图至少需要多少条边才能连通 n 个顶点？', 'B', 'n 个顶点的连通无向图至少是一棵树，边数为 n-1。', 'n', 'n-1', 'n(n-1)', '0'),
(23, '00000000-0000-0000-0000-000000028023', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', '邻接矩阵存储无向图时，矩阵通常具有什么性质？', 'A', '无向图中边没有方向，邻接矩阵关于主对角线对称。', '关于主对角线对称', '一定全为 1', '只在上三角有值', '每行必须递增'),
(24, '00000000-0000-0000-0000-000000028024', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'HARD', 'DFS 遍历无向连通图时，访问到的边可用于形成什么结构？', 'D', 'DFS 从一个连通图出发访问全部顶点时，首次发现顶点的边构成深度优先生成树。', '散列表', '哈夫曼编码', '顺序查找表', '深度优先生成树'),
(25, '00000000-0000-0000-0000-000000028025', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'Kruskal 算法选择边时，通常按什么顺序考虑边？', 'C', 'Kruskal 将边按权值从小到大考虑，若不形成回路则加入生成树。', '输入的逆序', '顶点编号从大到小', '权值从小到大', '边权从大到小且必须成环'),
(26, '00000000-0000-0000-0000-000000028026', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'Dijkstra 算法的经典形式通常要求边权满足什么条件？', 'A', '经典 Dijkstra 算法要求边权非负，否则贪心确定最短距离的过程可能失效。', '非负权', '全部为负权', '必须相等', '只能为 0'),
(27, '00000000-0000-0000-0000-000000028027', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'AOE 网中事件的最早发生时间通常可按哪种顺序求得？', 'B', 'AOE 网是有向无环图，事件最早发生时间常按拓扑序向前递推。', '散列地址顺序', '拓扑序', '完全随机顺序', '后序线索顺序'),
(28, '00000000-0000-0000-0000-000000028028', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', '顺序查找失败时，最坏情况下通常需要比较多少个表中元素？', 'C', '未设置哨兵时，查找失败可能需要检查全部 n 个元素。', '0 个', '1 个', 'n 个', 'log n 个'),
(29, '00000000-0000-0000-0000-000000028029', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'MEDIUM', '折半查找判定树中，查找成功的比较次数对应什么？', 'D', '判定树中目标结点所在层数即查找成功所需比较次数。', '结点关键字大小', '叶结点总数', '散列函数值', '目标结点所在层数'),
(30, '00000000-0000-0000-0000-000000028030', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '二叉排序树插入新关键字时，通常插入到哪里？', 'B', 'BST 插入沿查找路径找到失败位置，将新结点作为叶结点插入。', '固定作为根结点', '查找失败位置的叶结点处', '任意中间结点之前', '散列表溢出区'),
(31, '00000000-0000-0000-0000-000000028031', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'm 阶 B 树中，一个结点至多拥有多少棵子树？', 'A', 'm 阶 B 树中每个结点最多有 m 棵子树。', 'm', 'm-1', '2m', 'ceil(m/2)-1'),
(32, '00000000-0000-0000-0000-000000028032', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '开放定址散列表删除元素时，直接清空单元可能造成什么问题？', 'C', '直接置空会截断后续探测路径，导致本应可查到的同义词查找失败。', '表长自动翻倍', '所有关键字变有序', '破坏后续探测路径', '装填因子恒为 0'),
(33, '00000000-0000-0000-0000-000000028033', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '拉链法处理散列冲突时，装填因子是否可以大于 1？', 'D', '拉链法每个地址可挂链表，记录数可以超过地址数，因此装填因子可以大于 1。', '绝对不可以', '只能等于 0', '只能小于 0.5', '可以'),
(34, '00000000-0000-0000-0000-000000028034', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', '冒泡排序每一趟通常把当前无序区的哪类元素逐步交换到边界位置？', 'A', '升序冒泡排序每趟通过相邻比较交换，把当前最大元素移到无序区末端。', '最大元素', '最小下标', '随机元素', '所有相等元素'),
(35, '00000000-0000-0000-0000-000000028035', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '简单选择排序每一趟主要做什么？', 'C', '简单选择排序每趟从无序区选出最小或最大记录，与无序区边界记录交换。', '合并两个有序段', '构造 KMP next 数组', '选择极值并放到边界', '执行拓扑排序'),
(36, '00000000-0000-0000-0000-000000028036', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '希尔排序是否稳定？', 'B', '希尔排序按不同增量分组移动元素，可能改变相等关键字的相对次序，通常不稳定。', '一定稳定', '通常不稳定', '只要 n 为偶数就稳定', '只适合外部排序'),
(37, '00000000-0000-0000-0000-000000028037', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '快速排序平均时间复杂度通常为？', 'D', '快速排序在划分较均衡时平均复杂度为 O(n log n)。', 'O(1)', 'O(n)', 'O(n^2)', 'O(n log n)'),
(38, '00000000-0000-0000-0000-000000028038', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '堆排序的辅助空间复杂度通常为多少？', 'A', '就地堆排序只需常数级额外空间。', 'O(1)', 'O(n)', 'O(n log n)', 'O(n^2)'),
(39, '00000000-0000-0000-0000-000000028039', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '稳定的内部排序算法通常包括下列哪一种？', 'C', '直接插入排序在标准实现下稳定，快速排序、希尔排序和简单选择排序通常不稳定。', '快速排序', '希尔排序', '直接插入排序', '简单选择排序'),
(40, '00000000-0000-0000-0000-000000028040', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '外部排序中多路平衡归并提高归并路数的直接目的通常是？', 'B', '提高归并路数可以减少归并趟数，从而减少外存读写次数。', '增加初始归并段个数', '减少归并趟数', '取消内部排序', '让关键字无需比较');

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
    '基于 /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf 的第八批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_batch8_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000128', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_batch8_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000128', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_batch8_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000128', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_batch8_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000128', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_batch8_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_batch8_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000028701', 'DS-2027-008')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_batch8_import q
JOIN question_tags tag ON tag.name IN ('2027数据结构', 'DS-2027-008', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_batch8_import;
