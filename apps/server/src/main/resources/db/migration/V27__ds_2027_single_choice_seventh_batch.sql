-- Seventh data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Batch: DS-2027-007

CREATE TABLE ds_2027_batch7_import (
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

INSERT INTO ds_2027_batch7_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000027001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', '数据结构研究的核心通常不包括下列哪一项？', 'D', '数据结构关注逻辑结构、存储结构及其运算，不关注具体显示器刷新率。', '逻辑结构', '存储结构', '数据运算', '显示器刷新率'),
(2, '00000000-0000-0000-0000-000000027002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '若算法的执行时间与输入规模 n 成正比，通常记为哪种时间复杂度？', 'B', '与 n 成正比的增长记为线性时间复杂度 O(n)。', 'O(1)', 'O(n)', 'O(n^2)', 'O(2^n)'),
(3, '00000000-0000-0000-0000-000000027003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '顺序表在任意位置插入时，平均移动元素个数约为多少？', 'C', '若各插入位置等概率，平均移动元素个数约为 n/2。', '0', '1', 'n/2', 'n^2'),
(4, '00000000-0000-0000-0000-000000027004', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '带头结点单链表中，头指针指向的是？', 'A', '带头结点链表的头指针指向头结点，而不是首元结点。', '头结点', '最后一个结点', '任意中间结点', '空地址'),
(5, '00000000-0000-0000-0000-000000027005', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '尾插法建立单链表时，额外维护尾指针的主要目的是什么？', 'D', '尾指针可直接定位当前链表尾部，使每次插入不用从头遍历。', '实现二分查找', '删除所有结点', '保存链表长度平方', '避免每次查找尾结点'),
(6, '00000000-0000-0000-0000-000000027006', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'BASIC', '共享栈栈满的典型条件是两个栈顶指针满足什么关系？', 'B', '两个栈从数组两端向中间增长，栈满时两个栈顶相邻。', 'top1 = top2', 'top1 + 1 = top2', 'top1 = 0', 'top2 = maxSize'),
(7, '00000000-0000-0000-0000-000000027007', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '链式队列为空时，带头结点实现中 front 和 rear 通常满足什么关系？', 'A', '带头结点链队为空时，front 与 rear 都指向头结点。', 'front = rear', 'front = NULL 且 rear 非空', 'rear->next = front->next', 'front 指向尾结点'),
(8, '00000000-0000-0000-0000-000000027008', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', '递归算法转为非递归算法时，常用哪种结构显式保存调用状态？', 'C', '递归本质依赖调用栈，转非递归时常用显式栈保存状态。', '队列', '散列表', '栈', '邻接矩阵'),
(9, '00000000-0000-0000-0000-000000027009', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '中缀表达式 a+b*c 的后缀表达式通常为？', 'D', '乘法优先级高于加法，因此后缀形式为 abc*+。', 'ab+c*', 'abc+*', 'a+bc*', 'abc*+'),
(10, '00000000-0000-0000-0000-000000027010', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'BASIC', '矩阵压缩存储的直接目的是什么？', 'A', '压缩存储通过只保存必要元素减少存储空间。', '节省存储空间', '增加矩阵阶数', '降低 CPU 主频', '改变逻辑结构'),
(11, '00000000-0000-0000-0000-000000027011', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'MEDIUM', '三对角矩阵中，非零元素主要分布在哪些位置？', 'C', '三对角矩阵非零元素位于主对角线及其上下相邻两条对角线。', '仅第一行', '仅最后一列', '主对角线及相邻两条对角线', '任意位置'),
(12, '00000000-0000-0000-0000-000000027012', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'HARD', '稀疏矩阵三元组表不适合高效执行哪类操作？', 'B', '三元组表压缩保存非零元素，但按行列随机定位某元素通常不如数组直接。', '顺序遍历非零元素', '按下标随机访问任意元素', '统计非零元素个数', '保存行列和值'),
(13, '00000000-0000-0000-0000-000000027013', 'DS_STRING', 'DS_STRING_KMP', 'BASIC', '串长是指串中什么的个数？', 'A', '串长是串中字符的个数。', '字符', '指针', '子树', '边'),
(14, '00000000-0000-0000-0000-000000027014', 'DS_STRING', 'DS_STRING_KMP', 'MEDIUM', '模式匹配问题中，被查找的较短串通常称为什么？', 'D', '模式匹配中较短的待匹配串通常称为模式串。', '主串', '矩阵', '哈希表', '模式串'),
(15, '00000000-0000-0000-0000-000000027015', 'DS_STRING', 'DS_STRING_KMP', 'HARD', 'KMP 算法整体匹配阶段的时间复杂度通常为？', 'B', 'KMP 主串指针不回退，匹配阶段对主串线性扫描，复杂度为 O(n)。', 'O(1)', 'O(n)', 'O(nm)', 'O(n^2)'),
(16, '00000000-0000-0000-0000-000000027016', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'BASIC', '树中结点的层次从根开始通常如何编号？', 'A', '通常规定根结点为第 1 层。', '根为第 1 层', '根为第 n 层', '叶为第 1 层', '从 0 到负数'),
(17, '00000000-0000-0000-0000-000000027017', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '二叉树顺序存储更适合哪类二叉树？', 'C', '顺序存储按完全二叉树编号保存，适合完全二叉树，普通稀疏二叉树会浪费空间。', '任意稀疏二叉树', '只有一个结点的树以外都不适合', '完全二叉树', '所有森林'),
(18, '00000000-0000-0000-0000-000000027018', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', '由先序和中序序列构造二叉树时，先序序列的第一个结点用于确定什么？', 'B', '先序遍历先访问根结点，因此先序第一个结点用于确定根。', '左子树最后结点', '根结点', '右子树最后结点', '叶结点个数'),
(19, '00000000-0000-0000-0000-000000027019', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', '哈夫曼编码适合用于哪类场景？', 'D', '哈夫曼编码根据字符频率构造最优前缀编码，适合无损压缩。', '进程调度', '分页管理', '图遍历', '无损压缩编码'),
(20, '00000000-0000-0000-0000-000000027020', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'HARD', '并查集 find 操作的返回值通常表示什么？', 'A', 'find 返回元素所在集合的代表元或根。', '集合代表元', '队头元素', '矩阵阶数', '排序趟数'),
(21, '00000000-0000-0000-0000-000000027021', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', '简单图中任意两个顶点之间最多有多少条边？', 'A', '简单图不允许重边，任意两个顶点之间最多一条边。', '1 条', '2 条', 'n 条', '无限多条'),
(22, '00000000-0000-0000-0000-000000027022', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', '有向完全图含 n 个顶点时，弧数为多少？', 'C', '有向完全图任意两个不同顶点间有方向相反的两条弧，共 n(n-1) 条。', 'n', 'n(n-1)/2', 'n(n-1)', '2n'),
(23, '00000000-0000-0000-0000-000000027023', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'HARD', '邻接表存储图时，判断两个指定顶点之间是否有边通常需要怎样做？', 'B', '邻接表需在其中一个顶点的边表中查找另一个顶点。', '直接 O(1) 读取矩阵元素', '扫描相关顶点的边表', '计算 KMP next 数组', '执行堆调整'),
(24, '00000000-0000-0000-0000-000000027024', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', '生成树与原连通图相比，边数特点是什么？', 'D', '生成树包含全部顶点且无回路，边数固定为 n-1，通常少于或等于原图。', '一定更多', '一定等于 n^2', '没有边', '固定为 n-1'),
(25, '00000000-0000-0000-0000-000000027025', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'Floyd 算法能否处理带负权边但无负权回路的图？', 'A', 'Floyd 可处理负权边，但不能处理存在负权回路的情况。', '可以', '绝对不可以', '只能处理无权图', '只能处理树'),
(26, '00000000-0000-0000-0000-000000027026', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', '查找表中关键字的作用通常是什么？', 'B', '关键字用于标识或区分数据元素，是查找的依据。', '保存图的边权', '标识数据元素', '表示矩阵行数', '表示栈容量'),
(27, '00000000-0000-0000-0000-000000027027', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'MEDIUM', '折半查找中，若查找区间 low > high，通常表示什么？', 'C', '当 low 超过 high，说明查找区间为空，查找失败。', '查找成功', '需要扩容', '查找失败', '树高增加'),
(28, '00000000-0000-0000-0000-000000027028', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '二叉排序树中最小关键字结点通常位于哪里？', 'A', 'BST 中不断沿左孩子走可到达最小关键字结点。', '最左下结点', '根的右孩子', '任意叶子', '红色结点'),
(29, '00000000-0000-0000-0000-000000027029', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'B 树适合外存查找的主要原因之一是？', 'D', 'B 树分支多、高度低，可减少磁盘 I/O 次数。', '每个结点只有一个关键字', '高度一定等于记录数', '不支持插入删除', '多路分支降低树高'),
(30, '00000000-0000-0000-0000-000000027030', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'B+ 树中非叶结点通常主要起什么作用？', 'B', 'B+ 树非叶结点主要作为索引，实际记录通常在叶结点。', '保存所有完整记录', '索引作用', '执行排序交换', '保存图的边'),
(31, '00000000-0000-0000-0000-000000027031', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '直接定址法构造散列函数的优点是？', 'A', '直接定址法计算简单且通常不会产生冲突，但适用范围受关键字集合限制。', '计算简单且冲突少', '适合任意大范围关键字', '必须使用链表', '只能用于字符串'),
(32, '00000000-0000-0000-0000-000000027032', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '散列查找性能分析中，装填因子越大通常意味着什么？', 'C', '装填因子越大，表越满，冲突概率通常越高。', '冲突必为 0', '表越空', '冲突概率通常越高', '关键字自动有序'),
(33, '00000000-0000-0000-0000-000000027033', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', '排序的直接目标通常是按什么重新排列记录？', 'B', '排序通常按关键字大小或指定次序重新排列记录。', '存储地址随机性', '关键字', '进程编号', '矩阵行数'),
(34, '00000000-0000-0000-0000-000000027034', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '直接插入排序每趟把待插入记录插入到哪里？', 'D', '直接插入排序把待插入记录插入到前面已经有序的子序列中。', '无序区末尾', '散列表溢出区', '图的邻接表', '前面有序子序列'),
(35, '00000000-0000-0000-0000-000000027035', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '快速排序不稳定的主要原因是划分时可能发生什么？', 'A', '快速排序划分和交换可能使相等关键字跨越彼此，改变相对次序。', '相等关键字相对次序改变', '无法比较关键字', '只能处理一个元素', '必须使用外存'),
(36, '00000000-0000-0000-0000-000000027036', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '堆排序初始建堆后，若按升序排序，通常建立哪种堆？', 'C', '升序堆排序通常建立大根堆，每次把最大元素放到当前无序区末尾。', '小根堆且删除最小', '二叉搜索树', '大根堆', '哈夫曼树'),
(37, '00000000-0000-0000-0000-000000027037', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '归并排序中“归并”的含义是？', 'B', '归并是将两个或多个有序子序列合并为一个有序序列。', '随机打乱序列', '合并有序子序列', '删除重复关键字', '构造散列表'),
(38, '00000000-0000-0000-0000-000000027038', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '外部排序中初始归并段越长，通常会带来什么效果？', 'D', '初始归并段越长，段数越少，后续归并趟数通常越少。', '归并趟数一定增加', '无法归并', '内存容量变小', '归并趟数通常减少'),
(39, '00000000-0000-0000-0000-000000027039', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '关键路径上的关键活动时间增加，会直接影响什么？', 'A', '关键活动没有时间余量，其持续时间增加会直接延长工程总工期。', '工程总工期', '散列表长度', '二叉树结点度', 'KMP next 数组'),
(40, '00000000-0000-0000-0000-000000027040', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '平方取中法构造散列函数适合利用关键字平方值的哪一部分？', 'B', '平方取中法取关键字平方后的中间若干位作为散列地址。', '最高一位', '中间若干位', '最低一位之前全部删除', '符号位');

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
    '基于 /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf 的第七批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_batch7_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000127', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_batch7_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000127', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_batch7_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000127', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_batch7_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000127', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_batch7_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_batch7_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000027701', 'DS-2027-007')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_batch7_import q
JOIN question_tags tag ON tag.name IN ('2027数据结构', 'DS-2027-007', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_batch7_import;
