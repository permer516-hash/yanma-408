-- Sixth data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Batch: DS-2027-006

CREATE TABLE ds_2027_batch6_import (
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

INSERT INTO ds_2027_batch6_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000026001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', '数据对象是具有相同性质的数据元素的什么？', 'A', '数据对象是性质相同的数据元素的集合，是数据的一个子集。', '集合', '算法', '存储地址', '操作系统进程'),
(2, '00000000-0000-0000-0000-000000026002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '链式存储结构中，表示元素逻辑关系通常依靠什么？', 'C', '链式存储通过指针或链接域表示元素之间的逻辑关系。', '元素下标公式', '连续物理地址', '指针或链接域', '关键字排序'),
(3, '00000000-0000-0000-0000-000000026003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '若算法基本操作执行次数为 3n^2 + 10n + 7，其时间复杂度应记为？', 'D', '时间复杂度保留最高阶项并忽略常数系数，因此为 O(n^2)。', 'O(1)', 'O(n)', 'O(n log n)', 'O(n^2)'),
(4, '00000000-0000-0000-0000-000000026004', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '顺序表删除最后一个元素时，在不考虑缩容的情况下通常需要移动多少个元素？', 'A', '删除表尾元素不需要移动其他元素，只需修改表长。', '0', '1', 'n - 1', 'n'),
(5, '00000000-0000-0000-0000-000000026005', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '在双链表中删除结点 p 时，通常需要修改哪些相邻指针？', 'B', '删除双链表结点 p 需要让前驱的 next 指向后继，并让后继的 prior 指向前驱。', '只修改 p 的数据域', '修改前驱 next 和后继 prior', '只修改头指针', '重建整个链表'),
(6, '00000000-0000-0000-0000-000000026006', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'BASIC', '栈空时执行出栈操作通常属于什么情况？', 'C', '栈空时无元素可出，执行出栈属于下溢。', '上溢', '正常入栈', '下溢', '散列冲突'),
(7, '00000000-0000-0000-0000-000000026007', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '链栈通常不需要预先限定最大容量，主要因为它使用什么分配方式？', 'D', '链栈结点按需动态分配，容量主要受可用内存限制。', '连续静态数组', '磁盘顺序分配', '哈希分配', '动态链式分配'),
(8, '00000000-0000-0000-0000-000000026008', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', '双端队列与普通队列的主要区别是？', 'A', '双端队列允许在两端进行插入和删除，而普通队列通常一端入队另一端出队。', '两端都可插入和删除', '只能从中间删除', '必须使用递归', '只能存放一个元素'),
(9, '00000000-0000-0000-0000-000000026009', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '在表达式求值中，后缀表达式相比中缀表达式的一个优点是？', 'B', '后缀表达式不需要括号即可由操作数和运算符顺序唯一确定计算过程。', '必须更多括号', '不需要括号即可求值', '不能用栈处理', '只能表示加法'),
(10, '00000000-0000-0000-0000-000000026010', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'BASIC', '数组一旦定义后，维数和每维界限通常具有什么特点？', 'A', '数组通常是定长结构，维数和界限在定义后固定。', '固定', '每次访问都改变', '必须为 0', '由散列函数决定'),
(11, '00000000-0000-0000-0000-000000026011', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'MEDIUM', '对角矩阵压缩存储主要保存哪些元素？', 'C', '对角矩阵只有主对角线附近元素非零，压缩存储主要保存非零带状区域。', '所有零元素', '所有上三角元素', '非零带状区域元素', '所有列指针'),
(12, '00000000-0000-0000-0000-000000026012', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'HARD', '稀疏矩阵快速转置算法通常通过统计每列非零元素个数来确定什么？', 'D', '快速转置需先统计原矩阵每列非零元素数，从而确定转置后三元组的起始位置。', '矩阵是否有序', '每行最大值', '栈顶位置', '转置后各列起始位置'),
(13, '00000000-0000-0000-0000-000000026013', 'DS_STRING', 'DS_STRING_KMP', 'BASIC', '子串是指主串中什么样的字符序列？', 'B', '子串是主串中任意个连续字符组成的子序列。', '任意不连续字符', '连续字符序列', '排序后的字符集合', '去重后的字符集合'),
(14, '00000000-0000-0000-0000-000000026014', 'DS_STRING', 'DS_STRING_KMP', 'MEDIUM', '朴素模式匹配中主串指针回溯的主要后果是？', 'A', '主串指针回溯会造成重复比较，导致最坏复杂度较高。', '产生重复比较', '减少模式串长度', '自动建立 B 树', '避免所有失配'),
(15, '00000000-0000-0000-0000-000000026015', 'DS_STRING', 'DS_STRING_KMP', 'HARD', '模式串为 aaaaab 时，KMP 相比朴素匹配更能体现优势的原因是？', 'C', '这类模式串有大量相同前缀，KMP 可利用前后缀信息跳过重复比较。', '模式串没有前缀', '主串一定为空', '能利用重复前缀避免回退', '只能比较一次'),
(16, '00000000-0000-0000-0000-000000026016', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'BASIC', '树中没有孩子的结点称为什么？', 'D', '没有孩子的结点称为叶结点或终端结点。', '根结点', '分支结点', '双亲结点', '叶结点'),
(17, '00000000-0000-0000-0000-000000026017', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '完全二叉树中编号为 i 的结点，若 2i <= n，则其左孩子编号为？', 'B', '顺序编号的完全二叉树中，编号 i 结点的左孩子编号为 2i。', 'i/2', '2i', '2i + 1', 'i + 1'),
(18, '00000000-0000-0000-0000-000000026018', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', '先序线索二叉树中寻找某结点的先序后继，在哪种情况下较直接？', 'A', '若结点有左孩子，则先序后继通常就是其左孩子；否则需结合右孩子或线索判断。', '有左孩子时', '没有任何孩子时一定为根', '该结点是根时一定为空', '所有情况下都无法确定'),
(19, '00000000-0000-0000-0000-000000026019', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'HARD', '并查集按秩合并的主要思想是？', 'C', '按秩合并通常把较矮的树并到较高的树下，以控制树高增长。', '总是编号小的做根', '随机删除一个集合', '矮树并到高树', '按字符串长度排序'),
(20, '00000000-0000-0000-0000-000000026020', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', '路径长度在无权图中通常指什么？', 'A', '无权图中路径长度通常指路径上边的条数。', '边的条数', '顶点权值和', '矩阵阶数', '关键字个数'),
(21, '00000000-0000-0000-0000-000000026021', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', '邻接多重表主要用于存储哪类图？', 'B', '邻接多重表主要用于无向图，使每条边只用一个边结点并链接到两个顶点。', '有向图', '无向图', '二叉树', '散列表'),
(22, '00000000-0000-0000-0000-000000026022', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'HARD', 'DFS 生成森林中，树的棵数通常反映无向图的什么？', 'D', '对无向图进行 DFS，生成森林的树数对应连通分量数。', '边数', '顶点度数和', '最短路径条数', '连通分量数'),
(23, '00000000-0000-0000-0000-000000026023', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', '最小生成树一定包含连通带权无向图的多少个顶点？', 'C', '最小生成树是连通图的生成树，包含原图全部顶点。', '1 个', '一半顶点', '全部顶点', '度为 0 的顶点'),
(24, '00000000-0000-0000-0000-000000026024', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '若一个连通带权无向图的边权互不相同，则其最小生成树通常如何？', 'A', '边权互不相同时，最小生成树唯一。', '唯一', '一定不存在', '至少有两棵', '包含所有边'),
(25, '00000000-0000-0000-0000-000000026025', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '拓扑排序可以用来检测有向图中是否存在什么？', 'B', '若拓扑排序无法输出所有顶点，说明有向图存在环。', '最小生成树', '环', '无向边', '哈夫曼编码'),
(26, '00000000-0000-0000-0000-000000026026', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', '平均查找长度 ASL 表示什么？', 'D', 'ASL 是查找过程中关键字比较次数的期望或平均值。', '表的物理长度', '散列地址', '树的结点数', '关键字比较次数平均值'),
(27, '00000000-0000-0000-0000-000000026027', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'MEDIUM', '有序表顺序查找失败时，平均比较次数相比无序表可能怎样？', 'A', '有序表顺序查找可在遇到大于目标的关键字时提前失败，失败查找可能减少比较。', '可能提前停止', '一定扫描全表', '一定 O(1)', '不能查找失败'),
(28, '00000000-0000-0000-0000-000000026028', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '二叉排序树插入新关键字时，新结点最终通常成为？', 'C', 'BST 插入沿查找路径到失败位置，新结点作为叶结点插入。', '根结点的双亲', '中间任意结点', '叶结点', '所有结点的祖先'),
(29, '00000000-0000-0000-0000-000000026029', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '红黑树根结点必须满足什么颜色约束？', 'B', '红黑树性质要求根结点为黑色。', '红色', '黑色', '任意颜色且可为空', '必须双色'),
(30, '00000000-0000-0000-0000-000000026030', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'B 树所有叶结点通常位于什么位置？', 'A', 'B 树是平衡的多路查找树，所有叶结点处于同一层。', '同一层', '根的左侧', '不同随机层', '只在根结点'),
(31, '00000000-0000-0000-0000-000000026031', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '散列函数的好坏主要体现在关键字映射地址是否怎样？', 'D', '好的散列函数应使关键字尽量均匀分布到地址空间，减少冲突。', '全部相同', '按输入顺序递减', '只映射到奇数地址', '尽量均匀'),
(32, '00000000-0000-0000-0000-000000026032', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '开放定址法中查找失败时，通常何时停止探测？', 'C', '开放定址查找失败通常在探测到空单元或探测序列循环完仍未找到时停止。', '遇到第一个同义词', '比较一次后立即停止', '遇到空单元或探测完', '表长变为 0 时'),
(33, '00000000-0000-0000-0000-000000026033', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', '内部排序与外部排序的主要区别是排序过程中数据是否全部能放在哪里？', 'A', '内部排序要求待排序数据可全部放入内存，外部排序需要外存参与。', '内存', '寄存器编号表', '散列表冲突链', '图的邻接表'),
(34, '00000000-0000-0000-0000-000000026034', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '冒泡排序设置 exchange 标志的主要目的是什么？', 'B', '若某趟未发生交换，说明序列已有序，可提前结束。', '记录最大值', '判断是否已有序并提前结束', '计算散列地址', '建立哈夫曼树'),
(35, '00000000-0000-0000-0000-000000026035', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '快速排序递归深度最理想时通常为多少数量级？', 'C', '划分均衡时递归树高度为 O(log n)。', 'O(1)', 'O(n)', 'O(log n)', 'O(n^2)'),
(36, '00000000-0000-0000-0000-000000026036', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '简单选择排序的关键字比较次数与初始序列状态通常有什么关系？', 'D', '简单选择排序每趟都要在无序区选择最小元素，比较次数基本与初始状态无关。', '完全由逆序度决定', '已有序时为 0', '只与最大值有关', '基本无关'),
(37, '00000000-0000-0000-0000-000000026037', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '堆排序适合求前 k 大元素的原因之一是？', 'A', '堆能高效维护当前极值，反复取堆顶可得到前 k 个极值。', '堆顶可高效提供极值', '不需要比较关键字', '只能处理字符串', '自动生成最短路径'),
(38, '00000000-0000-0000-0000-000000026038', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '多路平衡归并中，若初始归并段个数为 r、归并路数为 k，归并趟数大致与什么有关？', 'B', '多路归并趟数大致为 log_k r 的向上取整。', 'k + r', 'log_k r', 'k*r^2', 'r!'),
(39, '00000000-0000-0000-0000-000000026039', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'DAG 表达式中一个顶点可代表什么？', 'C', 'DAG 表达式中顶点可表示操作数或运算符，边表示依赖关系。', '只能代表边权', '只能代表队列头', '操作数或运算符', '散列冲突次数'),
(40, '00000000-0000-0000-0000-000000026040', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '树转换为二叉树时，某结点的第一个孩子通常作为它在二叉树中的什么？', 'A', '树转二叉树采用左孩子右兄弟表示，第一个孩子作为左孩子。', '左孩子', '右孩子', '双亲', '中序前驱');

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
    '基于 /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf 的第六批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_batch6_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000126', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_batch6_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000126', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_batch6_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000126', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_batch6_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000126', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_batch6_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_batch6_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000026701', 'DS-2027-006')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_batch6_import q
JOIN question_tags tag ON tag.name IN ('2027数据结构', 'DS-2027-006', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_batch6_import;
