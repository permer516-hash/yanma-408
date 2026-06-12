-- Ninth data-structure single-choice import based on section exercise areas:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Batch: DS-2027-009
-- Note: questions are rewritten from the same section-selected exercise patterns,
-- with page-level source areas tracked in review_note for later licensed review.

CREATE TABLE ds_2027_batch9_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem VARCHAR(1000) NOT NULL,
    answer VARCHAR(1) NOT NULL,
    explanation VARCHAR(1000) NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL
);

INSERT INTO ds_2027_batch9_import (
    num, id, chapter_code, kp_code, difficulty, source_pages, stem, answer, explanation,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000033001', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.30-31', '对长度为 n 的顺序表在第 i 个元素之前插入一个新元素，若 1 <= i <= n+1，则平均需要移动的元素个数为多少？', 'C', '第 i 个元素之前插入时需移动第 i 至第 n 个元素，共 n-i+1 个；等概率插入时平均为 n/2。', 'n-i', 'i-1', 'n/2', '(n+1)/2'),
(2, '00000000-0000-0000-0000-000000033002', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.30-31', '长度为 n 的顺序表删除第 i 个元素，若 1 <= i <= n，则需要移动的元素个数是？', 'B', '删除第 i 个元素后，第 i+1 到第 n 个元素依次前移，共 n-i 个。', 'i-1', 'n-i', 'n-i+1', 'n+1-i'),
(3, '00000000-0000-0000-0000-000000033003', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', 'pp.30-31', '顺序表中第一个元素地址为 LOC(a1)，每个元素占 l 个存储单元，则第 i 个元素地址应为？', 'A', '顺序存储中元素按逻辑次序连续存放，第 i 个元素偏移为 (i-1)l。', 'LOC(a1)+(i-1)l', 'LOC(a1)+il', 'LOC(a1)+(n-i)l', 'LOC(a1)+n/l'),
(4, '00000000-0000-0000-0000-000000033004', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.30-31', '顺序表支持按位序随机访问，其根本原因是？', 'D', '顺序表中逻辑相邻元素物理上连续，可由首地址和元素大小直接计算任意位序地址。', '元素关键字有序', '每个元素带指针域', '删除操作无需移动元素', '可按首地址和位序计算地址'),
(5, '00000000-0000-0000-0000-000000033005', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', 'pp.30-33', '若顺序表长度为 n，查找每个元素的概率相同且查找成功，则平均比较次数为？', 'C', '成功查找第 i 个元素需比较 i 次，平均为 (1+2+...+n)/n=(n+1)/2。', 'n/2', 'log2 n', '(n+1)/2', 'n+1'),
(6, '00000000-0000-0000-0000-000000033006', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', 'pp.30-33', '静态分配顺序表和动态分配顺序表的共同限制是？', 'A', '两者都要求元素存放在连续存储空间中，动态分配只是容量可在运行时重新申请和复制。', '都必须占用连续存储空间', '都不能随机访问', '都不保存表长', '都必须用链式结点实现'),
(7, '00000000-0000-0000-0000-000000033007', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.51-54', '若线性表规模变化频繁，且经常在已知结点之后插入或删除元素，通常更适合采用哪种存储结构？', 'B', '已知操作位置时，链式存储只需修改指针，避免顺序表大规模移动元素。', '静态顺序表', '链式存储', '压缩矩阵', '开放定址散列表'),
(8, '00000000-0000-0000-0000-000000033008', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.51-54', '单链表中已知结点 p，若要在 p 之后插入结点 s，正确的指针修改顺序是？', 'D', '应先让 s 指向 p 原来的后继，再令 p 指向 s，避免丢失后继链。', 'p->next=s; s->next=p->next', 's=p->next; p->next=s', 'p=s->next; s->next=p', 's->next=p->next; p->next=s'),
(9, '00000000-0000-0000-0000-000000033009', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', 'pp.51-57', '在单链表中删除结点 p 的后继结点 q，若 q 存在，关键指针操作是？', 'A', '删除 p 的后继时，需要让 p->next 跳过 q 指向 q->next。', 'p->next=q->next', 'q->next=p', 'p=q->next', 'q=p->next->next'),
(10, '00000000-0000-0000-0000-000000033010', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.51-57', '使用头插法依次插入 a1,a2,...,an 建立单链表，最终链表中元素的逻辑次序通常为？', 'C', '头插法每次把新结点插到表头，因此最终次序与输入次序相反。', 'a1,a2,...,an', 'a2,a1,a3,...,an', 'an,...,a2,a1', '只包含 an'),
(11, '00000000-0000-0000-0000-000000033011', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'MEDIUM', 'pp.51-57', '带头结点的循环单链表为空时，通常满足的条件是？', 'B', '空循环单链表中头结点的 next 指向自身。', 'head == NULL', 'head->next == head', 'head->next == NULL', 'head->next->next == NULL'),
(12, '00000000-0000-0000-0000-000000033012', 'DS_LINEAR_LIST', 'DS_LINEAR_LIST_BASIC', 'HARD', 'pp.51-57', '双链表在结点 p 之后插入结点 s 时，若 p 有后继，通常需要修改几个指针域？', 'D', '需修改 s 的 prior/next、p 后继的 prior、p 的 next，共 4 个指针域。', '1 个', '2 个', '3 个', '4 个'),
(13, '00000000-0000-0000-0000-000000033013', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', 'pp.79-81', '元素 1,2,3,4 依次入栈，允许入栈和出栈交替进行，下列哪个出栈序列不可能出现？', 'C', '3,1,2,4 不可能，因为 3 先出栈后，2 位于 1 的上方，1 不可能先于 2 出栈。', '2,1,4,3', '3,2,1,4', '3,1,2,4', '4,3,2,1'),
(14, '00000000-0000-0000-0000-000000033014', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', 'pp.79-81', '两个栈共享一个数组空间，栈 1 从低地址增长、栈 2 从高地址增长，则栈满条件通常是？', 'A', '两个栈顶相邻时，数组中已无可用单元，条件为 top1+1 == top2。', 'top1 + 1 == top2', 'top1 == top2 + 1', 'top1 == -1 && top2 == maxSize', 'top1 == top2 == 0'),
(15, '00000000-0000-0000-0000-000000033015', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', 'pp.94-96', '循环队列采用少用一个存储单元区分队空和队满，队列容量为 m，队满条件是？', 'B', '少用一个单元时，rear 的下一个位置为 front 表示队满。', 'front == rear', '(rear + 1) % m == front', '(front + 1) % m == rear', 'rear == m'),
(16, '00000000-0000-0000-0000-000000033016', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', 'pp.94-96', '循环队列容量为 m，队头为 front，队尾后一个位置为 rear，则队列当前长度为？', 'C', '循环队列长度需处理回绕，公式为 (rear-front+m)%m。', 'rear-front', 'front-rear', '(rear-front+m)%m', '(front-rear+m)%m'),
(17, '00000000-0000-0000-0000-000000033017', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'HARD', 'pp.106-108', '表达式 ((a+b)*c-d)/e 的后缀表达式是？', 'D', '先 a b +，再与 c 相乘，再减 d，最后除以 e。', 'ab+c*d-e/', 'ab+cd-*e/', 'abc+*d-e/', 'ab+c*d-e/'),
(18, '00000000-0000-0000-0000-000000033018', 'DS_STACK_QUEUE', 'DS_STACK_QUEUE_APPLICATION', 'MEDIUM', 'pp.106-108', '递归算法执行过程中，系统栈帧通常不保存下列哪一项？', 'C', '递归栈帧通常保存参数、局部变量和返回地址，不保存所有未访问图边。', '返回地址', '局部变量', '所有未访问图边', '实参或形参值'),
(19, '00000000-0000-0000-0000-000000033019', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'MEDIUM', 'pp.116-117', 'n 阶对称矩阵只存储主对角线及下三角元素，所需存储单元数为？', 'A', '对称矩阵可只保存一个三角和主对角线，共 n(n+1)/2 个元素。', 'n(n+1)/2', 'n(n-1)/2', '2n-1', '3n-2'),
(20, '00000000-0000-0000-0000-000000033020', 'DS_ARRAY_MATRIX', 'DS_ARRAY_MATRIX_COMPRESS', 'HARD', 'pp.116-117', 'n 阶三对角矩阵按行压缩存储时，非零元素个数最多为？', 'B', '除首行和末行各 2 个外，中间 n-2 行各 3 个，共 3n-2 个。', '2n+1', '3n-2', 'n(n+1)/2', 'n^2'),
(21, '00000000-0000-0000-0000-000000033021', 'DS_STRING', 'DS_STRING_KMP', 'MEDIUM', 'pp.130-131', '朴素模式匹配在最坏情况下的时间复杂度通常为？', 'C', '主串长度为 n、模式串长度为 m 时，朴素匹配最坏情况下每个起点都比较多次，为 O(nm)。', 'O(n+m)', 'O(log n)', 'O(nm)', 'O(m log n)'),
(22, '00000000-0000-0000-0000-000000033022', 'DS_STRING', 'DS_STRING_KMP', 'HARD', 'pp.130-131', 'KMP 算法相对朴素匹配的关键改进是？', 'D', 'KMP 利用模式串自身的前后缀信息，主串指针不回退。', '每次失配后主串指针回到起点', '先对主串排序', '把串存入二叉树', '利用 next 信息避免主串指针回退'),
(23, '00000000-0000-0000-0000-000000033023', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', 'pp.145-147', '任意非空二叉树中，度为 0 的结点数 n0 与度为 2 的结点数 n2 的关系是？', 'A', '二叉树边数为 n-1，按出度计边可推出 n0=n2+1。', 'n0 = n2 + 1', 'n0 = n2 - 1', 'n0 = 2n2', 'n0 + n2 = 1'),
(24, '00000000-0000-0000-0000-000000033024', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MEDIUM', 'pp.145-147', '含 n 个结点的完全二叉树按层序从 1 编号，编号为 i 的结点若有双亲，其双亲编号是？', 'B', '完全二叉树顺序存储中，编号 i 的结点双亲为 floor(i/2)。', '2i', 'floor(i/2)', '2i+1', 'i-1'),
(25, '00000000-0000-0000-0000-000000033025', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', 'pp.158-164', '已知一棵二叉树的先序序列和中序序列且结点互异，通常可以唯一确定什么？', 'C', '先序确定根，中序划分左右子树，递归可唯一确定二叉树。', '只能确定叶结点数', '只能确定树高', '整棵二叉树', '只能确定后序第一个结点'),
(26, '00000000-0000-0000-0000-000000033026', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'HARD', 'pp.158-164', '线索二叉树利用空指针域保存线索，主要目的是？', 'D', '线索指向遍历序列中的前驱或后继，可加快遍历时寻找前驱/后继。', '减少所有结点的数据域', '让二叉树变成完全二叉树', '取消根结点', '方便寻找遍历前驱或后继'),
(27, '00000000-0000-0000-0000-000000033027', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'pp.210-212', '含 n 个顶点的无向完全图共有多少条边？', 'A', '无向完全图任意两个不同顶点之间都有一条边，共 C(n,2)=n(n-1)/2。', 'n(n-1)/2', 'n(n-1)', 'n^2', '2n'),
(28, '00000000-0000-0000-0000-000000033028', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'HARD', 'pp.210-212', '含 n 个顶点的有向完全图不考虑自环时，弧数为？', 'B', '每对不同顶点之间有两条方向相反的弧，共 n(n-1) 条。', 'n(n-1)/2', 'n(n-1)', 'n^2', '2n-1'),
(29, '00000000-0000-0000-0000-000000033029', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'pp.219-223', '邻接矩阵存储图时，空间复杂度主要为？', 'C', '邻接矩阵需要 n*n 个矩阵单元，空间复杂度为 O(n^2)。', 'O(n)', 'O(e)', 'O(n^2)', 'O(n+e)'),
(30, '00000000-0000-0000-0000-000000033030', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'pp.219-223', '有向图采用邻接表存储时，某顶点单链表中的结点个数通常表示该顶点的什么？', 'A', '邻接表中某顶点边表记录从该顶点出发的弧，因此结点数为出度。', '出度', '入度', '总度数', '连通分量数'),
(31, '00000000-0000-0000-0000-000000033031', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'pp.231-234', '广度优先遍历图时，为保证按访问层次扩展顶点，通常使用哪种辅助结构？', 'B', 'BFS 先访问的顶点先扩展，符合队列先进先出特性。', '栈', '队列', '小根堆', '十字链表'),
(32, '00000000-0000-0000-0000-000000033032', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'pp.250-259', '对有向无环图进行拓扑排序时，通常优先选择哪类顶点输出？', 'D', '拓扑排序反复选择入度为 0 的顶点输出，并删除其出边。', '出度为 0 的顶点', '权值最大的边', '任意成环顶点', '入度为 0 的顶点'),
(33, '00000000-0000-0000-0000-000000033033', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'pp.250-259', 'AOE 网中某活动的最早开始时间和最迟开始时间相等，通常说明该活动是？', 'C', '最早开始与最迟开始相等表示时间余量为 0，该活动在关键路径上。', '孤立活动', '可任意延迟的活动', '关键活动', '入度为 0 的活动'),
(34, '00000000-0000-0000-0000-000000033034', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'MEDIUM', 'pp.282-285', '对长度为 n 的有序顺序表进行折半查找，查找成功的最多比较次数通常为？', 'B', '折半查找判定树高度约为 floor(log2 n)+1。', 'n', 'floor(log2 n)+1', 'n/2', 'n-1'),
(35, '00000000-0000-0000-0000-000000033035', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'pp.304-308', '二叉排序树的中序遍历序列具有怎样的特点？', 'A', '二叉排序树左小右大，中序遍历得到按关键字递增的序列。', '关键字递增有序', '关键字递减有序', '与插入顺序完全相同', '一定是层序序列'),
(36, '00000000-0000-0000-0000-000000033036', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'HARD', 'pp.322-325', 'm 阶 B 树中，除根结点外的非叶结点至少应有多少棵子树？', 'D', 'm 阶 B 树非根结点的子树数至少为 ceil(m/2)。', '1', 'm-1', 'floor(m/2)-1', 'ceil(m/2)'),
(37, '00000000-0000-0000-0000-000000033037', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'pp.335-338', '散列表采用线性探测处理冲突时，最容易出现的现象是？', 'C', '线性探测会把连续冲突元素聚集成块，产生一次聚集。', '完全没有冲突', '树高增加', '一次聚集', '图不连通'),
(38, '00000000-0000-0000-0000-000000033038', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'MEDIUM', 'pp.351-353', '直接插入排序在最好情况下的时间复杂度为？', 'A', '序列已基本有序且完全有序时，每趟只比较一次，最好为 O(n)。', 'O(n)', 'O(n log n)', 'O(n^2)', 'O(1)'),
(39, '00000000-0000-0000-0000-000000033039', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', 'pp.359-361', '快速排序在什么情况下最容易退化到 O(n^2)？', 'B', '每次划分都极不均衡时，递归深度接近 n，总比较次数退化为 O(n^2)。', '每次划分都接近均分', '每次划分都极不均衡', '所有元素随机分布且枢轴合理', '采用三数取中'),
(40, '00000000-0000-0000-0000-000000033040', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'HARD', 'pp.400-401', '外部排序中增加归并路数 k 可以减少归并趟数，但通常会带来什么额外要求？', 'D', '多路归并需要在内存中维护更多输入缓冲区和选择最小关键字的数据结构。', '初始归并段必须变长为 1', '完全不需要内存缓冲', '取消置换选择', '需要更多缓冲区和选择开销');

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
    '基于 /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf 的“本节试题精选”题区改写导入；参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_batch9_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000133', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_batch9_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000133', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_batch9_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000133', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_batch9_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000133', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_batch9_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_batch9_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000033701', 'DS-2027-009')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_batch9_import q
JOIN question_tags tag ON tag.name IN ('2027数据结构', 'DS-2027-009', '资料文档改写', '选择题扩容')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_batch9_import;
