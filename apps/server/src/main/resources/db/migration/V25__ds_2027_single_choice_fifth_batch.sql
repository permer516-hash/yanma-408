-- Fifth data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Batch: DS-2027-005

CREATE TABLE ds_2027_batch5_import (
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

INSERT INTO ds_2027_batch5_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000025001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', '算法的确定性要求每条指令具有什么特点？', 'A', '确定性要求算法中每条指令含义明确，没有二义性。', '含义明确且无二义性', '必须用机器语言书写', '必须含有循环', '必须没有输出'),
(2, '00000000-0000-0000-0000-000000025002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '若算法中有两层嵌套循环，外层执行 n 次，内层每次执行 n 次，则基本操作次数数量级通常为？', 'C', '两层循环均与 n 成正比，总次数为 n*n，数量级为 O(n^2)。', 'O(1)', 'O(n)', 'O(n^2)', 'O(log n)'),
(3, '00000000-0000-0000-0000-000000025003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '若循环变量每次减半直到 1，循环次数通常是什么数量级？', 'B', '每次减半会使规模按 2 的指数下降，循环次数为对数数量级。', 'O(n)', 'O(log n)', 'O(n log n)', 'O(n^2)'),
(4, '00000000-0000-0000-0000-000000025004', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '顺序表扩容时若重新申请更大连续空间，原有元素通常需要怎样处理？', 'D', '顺序表要求连续存储，扩容到新空间时通常要复制原有元素。', '全部删除', '只移动首元素', '改为散列表', '复制到新连续空间'),
(5, '00000000-0000-0000-0000-000000025005', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '在单链表中按序号查找第 i 个结点时，无法像顺序表一样 O(1) 定位的原因是？', 'A', '单链表结点不连续，不能由序号直接计算地址，只能沿指针逐个访问。', '结点地址不能由序号直接计算', '链表一定无序', '链表不能保存数据', '链表没有长度'),
(6, '00000000-0000-0000-0000-000000025006', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'BASIC', '栈和队列共同的逻辑特点是？', 'C', '栈和队列都是操作受限的线性表，只是限制方式不同。', '都是非线性结构', '都支持随机访问', '都是操作受限的线性表', '都只能链式存储'),
(7, '00000000-0000-0000-0000-000000025007', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '若入栈序列为 1,2,3，则下列哪一个不可能是出栈序列？', 'D', '序列 3,1,2 不可能，因为 3 先出栈时 1 和 2 均在栈内，2 必须先于 1 出栈。', '1,2,3', '2,1,3', '3,2,1', '3,1,2'),
(8, '00000000-0000-0000-0000-000000025008', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', '用两个队列实现栈时，为了完成出栈操作，常见做法是？', 'B', '可将非空队列中除最后一个元素外全部转移到另一个队列，最后一个元素即栈顶出栈。', '直接删除队头作为栈顶', '转移除最后一个外的元素再删除最后一个', '把两个队列都清空', '按关键字排序后删除'),
(9, '00000000-0000-0000-0000-000000025009', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '层次遍历二叉树时通常使用队列，是因为需要满足什么顺序？', 'A', '层次遍历要求先访问的结点先扩展其孩子，符合队列先进先出。', '先进先出', '后进先出', '关键字递增', '随机访问'),
(10, '00000000-0000-0000-0000-000000025010', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'MEDIUM', '二维数组 A[0..m-1][0..n-1] 按行优先存储，A[i][j] 前面通常有多少个元素？', 'C', '前面有 i 整行共 i*n 个元素，再加本行前 j 个元素，总数为 i*n+j。', 'i+j', 'm*i+j', 'i*n+j', 'j*m+i'),
(11, '00000000-0000-0000-0000-000000025011', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'HARD', 'n 阶上三角矩阵按行压缩存储非零区域时，第 i 行非零元素个数通常为？', 'D', '上三角矩阵第 i 行从第 i 列到第 n 列为非零区域，若从 1 开始编号，则有 n-i+1 个。', 'i', 'n', 'i - 1', 'n - i + 1'),
(12, '00000000-0000-0000-0000-000000025012', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'BASIC', '稀疏矩阵压缩存储的主要依据是矩阵中哪类元素较多？', 'A', '稀疏矩阵中零元素很多，只保存非零元素可节省空间。', '零元素', '主对角线元素', '负数元素', '最大元素'),
(13, '00000000-0000-0000-0000-000000025013', 'DS_STRING', 'DS_STRING_KMP', 'BASIC', '两个串相等通常要求什么？', 'B', '串相等要求长度相同且对应位置字符完全相同。', '仅长度相同', '长度相同且对应字符相同', '字符集合相同即可', '首字符相同即可'),
(14, '00000000-0000-0000-0000-000000025014', 'DS_STRING', 'DS_STRING_KMP', 'MEDIUM', '串的块链存储适合哪类场景？', 'C', '块链存储把多个字符放在一个块中并用链连接，适合串较长且需要链式扩展的场景。', '只保存一个字符', '必须频繁随机访问任意字符', '串较长且需链式扩展', '只能用于数字数组'),
(15, '00000000-0000-0000-0000-000000025015', 'DS_STRING', 'DS_STRING_KMP', 'HARD', 'KMP 算法预处理模式串得到 next 数组的时间复杂度通常为？', 'A', 'next 数组可在线性扫描模式串时求得，时间复杂度为 O(m)。', 'O(m)', 'O(nm)', 'O(n^2)', 'O(1)'),
(16, '00000000-0000-0000-0000-000000025016', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'BASIC', '森林转换为二叉树时，各树的根结点之间通常形成什么关系？', 'D', '森林转换为二叉树时，各棵树的根结点通常通过右孩子链连接为兄弟关系。', '全部成为左孩子', '全部删除', '形成父子链', '通过右孩子链相连'),
(17, '00000000-0000-0000-0000-000000025017', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '树的孩子兄弟表示法本质上可将树转换成哪类结构？', 'A', '孩子兄弟表示法用左孩子右兄弟组织结点，本质上对应二叉链表结构。', '二叉链表', '散列表', '循环队列', '三对角矩阵'),
(18, '00000000-0000-0000-0000-000000025018', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', '已知二叉树中序和后序序列且结点互不相同，通常能否唯一确定二叉树？', 'C', '后序最后一个结点为根，中序可划分左右子树，因此可唯一确定。', '不能', '只有满二叉树能', '能', '只有完全二叉树不能'),
(19, '00000000-0000-0000-0000-000000025019', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', '哈夫曼树的带权路径长度 WPL 是什么的总和？', 'B', 'WPL 是所有叶结点权值乘以其路径长度后的总和。', '所有结点层次之和', '叶结点权值与路径长度乘积之和', '边权最大值', '根结点权值平方'),
(20, '00000000-0000-0000-0000-000000025020', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', '连通无向图从任一顶点开始 BFS，最终能访问多少顶点？', 'D', '连通无向图任意两个顶点之间有路径，因此从任一顶点开始遍历可访问所有顶点。', '只能访问一个', '只能访问度为 0 的顶点', '最多访问一半', '全部顶点'),
(21, '00000000-0000-0000-0000-000000025021', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', '邻接矩阵存储图的空间复杂度主要取决于什么？', 'A', '邻接矩阵需要为任意两个顶点的关系分配单元，空间为 O(n^2)。', '顶点数平方', '边数对数', '路径长度', '连通分量数'),
(22, '00000000-0000-0000-0000-000000025022', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'HARD', '有向图的十字链表中，每条弧结点通常同时链接在哪两类表中？', 'C', '十字链表使每条弧既在弧尾顶点的出边表中，也在弧头顶点的入边表中。', '两个栈', '两个队列', '出边表和入边表', '父表和孩子表'),
(23, '00000000-0000-0000-0000-000000025023', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'Prim 算法更适合哪类图的最小生成树求解？', 'B', 'Prim 以顶点集合扩展为主，常更适合边较多的稠密图。', '只有一个顶点的图', '稠密图', '无边图', '有向无环图'),
(24, '00000000-0000-0000-0000-000000025024', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '若图中存在负权边，Dijkstra 算法为什么通常不适用？', 'A', 'Dijkstra 依赖当前最小距离一旦确定就不会再变小，负权边会破坏这一贪心前提。', '负权边破坏贪心确定性', '不能存储顶点', '必须使用递归', '只能处理无向图'),
(25, '00000000-0000-0000-0000-000000025025', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '关键路径中活动的时间余量通常等于什么？', 'D', '活动时间余量通常为最迟开始时间与最早开始时间之差。', '入度减出度', '边数减顶点数', '最早事件时间之和', '最迟开始时间减最早开始时间'),
(26, '00000000-0000-0000-0000-000000025026', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', '静态查找表和动态查找表的主要区别在于是否频繁执行哪类操作？', 'C', '动态查找表不仅查找，还经常插入和删除；静态查找表主要查找。', '输出', '排序', '插入和删除', '矩阵转置'),
(27, '00000000-0000-0000-0000-000000025027', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'MEDIUM', '折半查找成功时，最大比较次数与判定树的什么有关？', 'B', '折半查找最大比较次数对应判定树高度。', '结点颜色', '高度', '边权', '叶子权值'),
(28, '00000000-0000-0000-0000-000000025028', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '若二叉排序树高度接近 n，则查找最坏时间复杂度会退化为？', 'A', 'BST 高度接近 n 时，查找路径长度最坏为 n 级别。', 'O(n)', 'O(log n)', 'O(1)', 'O(n log n)'),
(29, '00000000-0000-0000-0000-000000025029', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '红黑树要求红结点的孩子通常是什么颜色？', 'C', '红黑树不允许两个红结点相邻，因此红结点的孩子必须为黑色。', '红色', '任意颜色', '黑色', '不存在孩子'),
(30, '00000000-0000-0000-0000-000000025030', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'B 树查找一个关键字时，在结点内查找后通常根据什么继续向下？', 'D', '在结点内确定关键字所在区间后，沿对应孩子指针继续查找。', '栈顶元素', '队头元素', '主串指针', '关键字所在区间对应的孩子指针'),
(31, '00000000-0000-0000-0000-000000025031', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '开放定址法删除元素时，为什么常需要设置删除标记而不是简单置空？', 'B', '简单置空可能截断后续同义词的探测路径，导致查找失败。', '为了增加装填因子', '避免截断探测路径', '为了让表有序', '为了减少表长'),
(32, '00000000-0000-0000-0000-000000025032', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '拉链法中装填因子可以大于 1 的原因是？', 'A', '拉链法每个地址可挂接链表，记录数可以超过散列表地址数。', '每个地址可挂接多个同义词', '散列表没有地址', '关键字必须唯一', '链表不能增长'),
(33, '00000000-0000-0000-0000-000000025033', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', '排序算法的稳定性主要关注哪类记录的相对次序？', 'C', '稳定性关注关键字相等记录排序前后的相对次序。', '关键字最大记录', '关键字最小记录', '关键字相等记录', '所有奇数记录'),
(34, '00000000-0000-0000-0000-000000025034', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '希尔排序通常不稳定的原因是？', 'D', '希尔排序会进行跨间隔移动，可能改变相等关键字的相对次序。', '只能处理一个元素', '不比较关键字', '必须使用队列', '跨间隔移动可能改变相等关键字次序'),
(35, '00000000-0000-0000-0000-000000025035', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '快速排序一趟划分的主要目标是？', 'A', '一趟划分使枢轴左侧元素不大于枢轴、右侧不小于枢轴，并确定枢轴最终位置。', '确定枢轴最终位置', '生成哈夫曼编码', '构造 B 树', '求最短路径'),
(36, '00000000-0000-0000-0000-000000025036', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '堆排序适合在辅助空间受限时使用，原因是其额外空间通常为？', 'B', '堆排序可在原数组上调整堆，额外空间通常为 O(1)。', 'O(n)', 'O(1)', 'O(n^2)', 'O(log n) 且必须递归'),
(37, '00000000-0000-0000-0000-000000025037', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '二路归并排序的时间复杂度在最好、平均、最坏情况下通常如何？', 'C', '归并排序每层归并代价 O(n)，层数 O(log n)，三种情况通常都是 O(n log n)。', '最好 O(n)，最坏 O(n^2)', '全部 O(n)', '全部 O(n log n)', '全部 O(n^2)'),
(38, '00000000-0000-0000-0000-000000025038', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '基数排序通常属于哪类排序？', 'D', '基数排序按关键字位进行分配收集，不依赖关键字两两比较，属于非比较类排序。', '比较类插入排序', '比较类交换排序', '比较类选择排序', '非比较类排序'),
(39, '00000000-0000-0000-0000-000000025039', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '外部排序中增加归并路数通常会减少归并趟数，但可能增加什么成本？', 'A', '归并路数增加会使选择最小记录和缓冲管理更复杂，需要更多缓冲区或选择开销。', '内部选择和缓冲管理成本', '关键字范围', '树的高度必为 1', '散列表装填因子'),
(40, '00000000-0000-0000-0000-000000025040', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '用有向无环图表示表达式时，共同子表达式通常可以如何处理？', 'B', 'DAG 可让相同子表达式共享同一子图，避免重复存储和计算。', '必须重复存储两次', '共享同一子图', '全部变为叶结点', '无法表示运算符');

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
    '基于 /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf 的第五批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_batch5_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000125', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_batch5_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000125', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_batch5_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000125', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_batch5_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000125', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_batch5_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_batch5_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000025701', 'DS-2027-005')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_batch5_import q
JOIN question_tags tag ON tag.name IN ('2027数据结构', 'DS-2027-005', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_batch5_import;
