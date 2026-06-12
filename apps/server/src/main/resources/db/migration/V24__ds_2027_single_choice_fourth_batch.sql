-- Fourth data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Batch: DS-2027-004

CREATE TABLE ds_2027_batch4_import (
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

INSERT INTO ds_2027_batch4_import (
    num, id, chapter_code, kp_code, difficulty, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000024001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'BASIC', '线性表的逻辑顺序与物理存储位置一定一致吗？', 'B', '线性表描述的是逻辑上的一对一关系，链式存储时逻辑相邻元素物理位置可以不相邻。', '一定一致', '不一定一致', '必须完全相反', '只能在树中一致'),
(2, '00000000-0000-0000-0000-000000024002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', '在带头结点的单链表 L 中，判断空表的常见条件是？', 'A', '带头结点单链表为空时，头结点的 next 域为空。', 'L->next == NULL', 'L == NULL', 'L->data == 0', 'L->next == L'),
(3, '00000000-0000-0000-0000-000000024003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', '循环单链表设置尾指针 rear 时，访问首元结点通常可通过什么实现？', 'C', '循环单链表尾结点的 next 指向头结点或首元结点，带头结点时 rear->next->next 通常为首元结点。', 'rear 本身', 'rear->prior', 'rear->next->next', 'rear->data'),
(4, '00000000-0000-0000-0000-000000024004', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', '链式队列中同时设置 front 和 rear 指针的主要原因是？', 'D', 'front 便于出队，rear 便于在队尾入队，二者配合可使基本操作保持高效。', '支持二分查找', '让队列元素有序', '避免使用指针', '分别便于队头删除和队尾插入'),
(5, '00000000-0000-0000-0000-000000024005', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', '若循环队列不牺牲存储单元，也不使用计数器，则通常还需要什么信息区分队空和队满？', 'B', 'front 与 rear 相等时可能表示空也可能表示满，需要额外标志位等信息区分。', '关键字大小', '额外标志位', '栈顶指针', '散列函数'),
(6, '00000000-0000-0000-0000-000000024006', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'MEDIUM', '按列优先存储二维数组时，地址计算中变化最快的下标通常是哪一个？', 'A', '按列优先时同一列元素连续存放，行下标变化对应相邻元素，变化最快。', '行下标', '列下标', '数组维数', '元素字长'),
(7, '00000000-0000-0000-0000-000000024007', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'HARD', '对称矩阵压缩到一维数组时，访问上三角元素 a[i][j] 通常需要先做什么？', 'C', '若只存下三角，访问上三角元素时可利用对称性转为访问 a[j][i]。', '直接报错', '删除该元素', '利用 a[i][j]=a[j][i] 转换下标', '把矩阵转为图'),
(8, '00000000-0000-0000-0000-000000024008', 'DS_STRING', 'DS_STRING_KMP', 'MEDIUM', '串的堆分配存储表示相比定长顺序存储，主要优势是？', 'D', '堆分配可按需要动态申请空间，相比固定长度更灵活。', '不能修改串长', '只能保存一个字符', '必须连续保存在栈中', '可动态分配存储空间'),
(9, '00000000-0000-0000-0000-000000024009', 'DS_STRING', 'DS_STRING_KMP', 'HARD', 'KMP 匹配中若模式串在位置 j 失配，next[j] 的作用通常是？', 'A', 'next[j] 指示模式串下一步应回退到的位置，从而避免主串指针回退。', '指示模式串回退位置', '计算主串长度', '删除主串前缀', '确定散列地址'),
(10, '00000000-0000-0000-0000-000000024010', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'BASIC', '树的高度通常指什么？', 'B', '树的高度通常指树中结点的最大层数。', '结点总数', '最大层数', '叶结点个数', '边权总和'),
(11, '00000000-0000-0000-0000-000000024011', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', '具有 n0 个叶结点、n2 个度为 2 的结点的二叉树，二者关系通常为？', 'C', '二叉树中叶结点数 n0 与度为 2 的结点数 n2 满足 n0 = n2 + 1。', 'n0 = n2', 'n0 = 2n2', 'n0 = n2 + 1', 'n2 = n0 + 1'),
(12, '00000000-0000-0000-0000-000000024012', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', '中序线索二叉树中，ltag 为 1 通常表示 left 指针域存放什么？', 'A', '线索标志为 1 时，对应指针域不指向孩子，而是保存遍历序列中的前驱或后继线索。', '中序前驱线索', '左孩子地址', '双亲地址', '根结点地址'),
(13, '00000000-0000-0000-0000-000000024013', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', '构造哈夫曼树时，每一步通常选择哪两个结点合并？', 'D', '哈夫曼树构造时，每次选择当前权值最小的两个根结点合并。', '权值最大的两个', '高度最高的两个', '最早输入的两个', '权值最小的两个'),
(14, '00000000-0000-0000-0000-000000024014', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'HARD', '并查集路径压缩的主要效果是？', 'B', '路径压缩会让查找路径上的结点直接接近根，降低后续查找成本。', '增加树高度', '降低后续查找路径长度', '保持所有结点为叶子', '按关键字排序'),
(15, '00000000-0000-0000-0000-000000024015', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', '无向完全图含 n 个顶点时，边数为多少？', 'C', '无向完全图任意两个不同顶点之间都有一条边，边数为 n(n-1)/2。', 'n', 'n - 1', 'n(n-1)/2', 'n(n+1)'),
(16, '00000000-0000-0000-0000-000000024016', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', '有向图用邻接矩阵存储时，第 i 行非零元素个数通常表示顶点 i 的什么？', 'A', '邻接矩阵第 i 行表示从顶点 i 发出的边，因此非零元素个数对应出度。', '出度', '入度', '连通分量数', '生成树边数'),
(17, '00000000-0000-0000-0000-000000024017', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'BFS 求无权图单源最短路径时，路径长度按什么计量？', 'D', '无权图中每条边可视为等权，BFS 按经过的边数逐层扩展。', '顶点权值和', '关键字大小', '存储地址差', '经过的边数'),
(18, '00000000-0000-0000-0000-000000024018', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'Dijkstra 算法每一轮确定的顶点通常具有什么性质？', 'B', 'Dijkstra 每轮选择当前距离最小的未确定顶点，其最短路径长度随后被确定。', '入度最大', '当前最短距离已确定', '一定是终点', '边权为负'),
(19, '00000000-0000-0000-0000-000000024019', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', '拓扑排序中，若每一步可选择的入度为 0 的顶点不唯一，说明什么？', 'C', '可选入度为 0 的顶点不唯一时，拓扑序列通常也不唯一。', '图一定有环', '图不是有向图', '拓扑序列可能不唯一', '必须改用 Prim'),
(20, '00000000-0000-0000-0000-000000024020', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'AOE 网中，事件最早发生时间 ve 的计算通常沿什么方向进行？', 'A', '事件最早发生时间通常按拓扑序从源点向汇点正向递推。', '拓扑序正向', '逆拓扑序反向', '随机顺序', '按顶点编号降序'),
(21, '00000000-0000-0000-0000-000000024021', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'AOE 网中，事件最迟发生时间 vl 的计算通常沿什么方向进行？', 'D', '事件最迟发生时间通常按逆拓扑序从汇点向源点反向递推。', '从源点正向', '按边权从小到大', '广度优先顺序', '逆拓扑序反向'),
(22, '00000000-0000-0000-0000-000000024022', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'MEDIUM', '分块查找中索引表通常要求怎样组织？', 'A', '分块查找要求块间有序，索引表记录各块最大关键字等信息并按关键字有序。', '按块最大关键字有序', '完全无序', '必须使用链表且不可排序', '只保存最小地址'),
(23, '00000000-0000-0000-0000-000000024023', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'HARD', '折半查找判定树中，查找失败结点通常对应什么？', 'B', '折半查找判定树的外部结点可表示查找失败的区间。', '每个根结点', '外部结点或失败区间', '所有叶子关键字', '散列表装填因子'),
(24, '00000000-0000-0000-0000-000000024024', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '删除二叉排序树中有两个孩子的结点时，常用替代结点是？', 'C', '通常可用该结点中序前驱或中序后继替代，再删除对应位置的结点。', '根结点', '任意叶子', '中序前驱或中序后继', '高度最高的结点'),
(25, '00000000-0000-0000-0000-000000024025', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'AVL 树插入后出现 LL 型失衡，通常采用什么旋转？', 'A', 'LL 型失衡通过一次右旋即可恢复平衡。', '右单旋', '左单旋', '先左后右双旋', '先右后左双旋'),
(26, '00000000-0000-0000-0000-000000024026', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'AVL 树插入后出现 RL 型失衡，通常采用什么旋转？', 'D', 'RL 型失衡需要先对右孩子右旋，再对失衡结点左旋。', '右单旋', '左单旋', '先左后右双旋', '先右后左双旋'),
(27, '00000000-0000-0000-0000-000000024027', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'B 树中结点分裂通常发生在什么情况下？', 'B', '插入导致某结点关键字个数超过上限时，需要分裂并向父结点提升中间关键字。', '结点为空时', '关键字数超过上限时', '树高为 1 时必定', '查询失败时必定'),
(28, '00000000-0000-0000-0000-000000024028', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'B+ 树叶结点之间通常通过指针链接，其主要好处是？', 'C', '叶结点有序链接后，范围查询和顺序扫描更高效。', '减少关键字总数为 0', '禁止插入操作', '便于范围查询和顺序访问', '让树退化为栈'),
(29, '00000000-0000-0000-0000-000000024029', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '除留余数法构造散列函数时，模数 p 通常应如何选择？', 'A', '通常选择不大于表长且接近表长的质数，以减少关键字分布规律造成的冲突。', '接近表长的质数', '固定为 1', '必须大于所有关键字', '必须为偶数'),
(30, '00000000-0000-0000-0000-000000024030', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', '二次探测法相比线性探测法，主要缓解哪种现象？', 'B', '二次探测跳跃式探测，主要缓解线性探测的一次聚集。', '二叉树失衡', '一次聚集', '排序不稳定', '外存读写'),
(31, '00000000-0000-0000-0000-000000024031', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', '冒泡排序每一趟通常能确定什么？', 'D', '冒泡排序每趟通过相邻比较交换，把当前最大或最小元素放到最终位置。', '所有元素最终位置', '中间元素位置', '随机两个元素位置', '一个极值元素最终位置'),
(32, '00000000-0000-0000-0000-000000024032', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '快速排序平均性能较好，但最坏情况下时间复杂度为？', 'C', '当划分极不均衡时，快速排序递归深度可达 n，最坏复杂度为 O(n^2)。', 'O(1)', 'O(n)', 'O(n^2)', 'O(log n)'),
(33, '00000000-0000-0000-0000-000000024033', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '堆排序和快速排序通常都属于哪类排序？', 'A', '堆排序和快速排序主要通过关键字比较决定次序，属于比较类排序。', '比较类排序', '非比较类排序', '外部排序', '基数分配排序'),
(34, '00000000-0000-0000-0000-000000024034', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '归并排序稳定的主要原因是合并时如何处理相等关键字？', 'B', '合并两个有序段时，若相等关键字优先取前一段元素，可保持原相对次序。', '直接删除其中一个', '优先取前一段元素', '随机交换二者', '全部移到末尾'),
(35, '00000000-0000-0000-0000-000000024035', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', '计数排序适合的关键字通常具有什么特点？', 'C', '计数排序适合关键字范围较小且可直接计数的情况。', '必须是浮点数且无范围', '只能是字符串', '范围较小且可计数', '必须形成二叉树'),
(36, '00000000-0000-0000-0000-000000024036', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '外部排序中败者树的主要作用是？', 'D', '败者树可高效选择多个归并段中的最小记录，提高多路归并效率。', '压缩所有记录', '判断图是否有环', '实现递归调用', '高效选择多路归并最小记录'),
(37, '00000000-0000-0000-0000-000000024037', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '最佳归并树用于外部排序时，通常希望优化什么？', 'A', '最佳归并树通过类似哈夫曼思想安排归并，减少总读写代价。', '总归并代价', 'CPU 寄存器个数', '散列表长度', '栈的容量'),
(38, '00000000-0000-0000-0000-000000024038', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', '置换-选择排序生成的初始归并段平均长度通常约为内存工作区可容纳记录数的多少倍？', 'B', '在随机输入情况下，置换-选择生成的初始归并段平均长度约为内存容量的 2 倍。', '1/2 倍', '2 倍', '10 倍', 'n 倍'),
(39, '00000000-0000-0000-0000-000000024039', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'Kruskal 算法中判断加入一条边是否形成回路，常用哪种结构辅助？', 'C', 'Kruskal 按边权选择边，常用并查集判断两个端点是否已在同一连通分量。', '顺序栈', '循环队列', '并查集', 'KMP next 数组'),
(40, '00000000-0000-0000-0000-000000024040', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', '散列表查找成功的平均查找长度主要受什么影响？', 'D', '散列表平均查找长度与散列函数、冲突处理方法和装填因子等因素密切相关。', '二叉树先序序列', '图的边权和', '排序稳定性', '散列函数、冲突处理和装填因子');

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
    '基于 /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf 的第四批书本单选题考点改写导入。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_batch4_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000124', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_batch4_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000124', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_batch4_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000124', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_batch4_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000124', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_batch4_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_batch4_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000024701', 'DS-2027-004')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_batch4_import q
JOIN question_tags tag ON tag.name IN ('2027数据结构', 'DS-2027-004', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_batch4_import;
