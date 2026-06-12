-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 6: 6.4.6/6.4.7 close; Chapter 7: 7.2.4/7.2.5 first questions
-- Batch: DS-2027-ORIGINAL-CH6-D-CH7-A

CREATE TABLE ds_2027_original_ch6_d_ch7_a_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    kp_code VARCHAR(64) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    section_tag VARCHAR(64) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    stem_format VARCHAR(32) NOT NULL DEFAULT 'PLAIN_TEXT',
    stem_image_url VARCHAR(512),
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch6_d_ch7_a_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, stem_format, stem_image_url,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000065001', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.239,248', '若某带权图为 G=(V,E)，其中 V={v1,v2,v3,v4,v5,v6,v7,v8,v9,v10}，E={<v1,v2>5,<v1,v3>6,<v2,v3>3,<v3,v5>6,<v3,v4>3,<v4,v3>3,<v4,v7>1,<v4,v8>4,<v5,v6>4,<v5,v7>2,<v6,v10>4,<v7,v9>5,<v8,v9>2,<v9,v10>2}（注：边括号外的数据表示边上的权值），则 G 的关键路径的长度为（ ）。', 'C', '根据题目给出的 AOE 网可得关键路径长度为 21，图中画出的两条路径都是关键路径。', 'PLAIN_TEXT', NULL, '19', '20', '21', '22'),
(2, '00000000-0000-0000-0000-000000065002', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.239,249', '下面关于求关键路径的说法中，不正确的是（ ）。', 'C', '事件的最迟发生时间可由以该事件为尾的弧的最迟开始时间求得，或由其所指事件的最迟发生时间与活动持续时间的差求得，C 的表述不正确。改变任一活动持续时间都可能影响关键路径。', 'PLAIN_TEXT', NULL, '求关键路径是以拓扑排序为基础的', '一个事件的最早发生时间与以该事件为始的弧的活动的最早开始时间相同', '一个事件的最迟发生时间是以该事件为尾的弧的活动最迟开始时间与该活动持续时间的差', '任何一个活动的持续时间的改变可能会影响关键路径的改变'),
(3, '00000000-0000-0000-0000-000000065003', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.239-240,249', '下列关于 AOE 网的关键路径的说法中，正确的是（ ）。\nI. 改变网上某一关键路径上的任意一个关键活动后，必将产生不同的关键路径\nII. 关键路径上活动的时间延长多少，整个工期也就随之延长多少\nIII. 缩短关键路径上任意一个关键活动的持续时间可缩短关键路径长度\nIV. 缩短所有关键路径上共有的任意一个关键活动的持续时间可缩短关键路径长度\nV. 缩短多条关键路径上共有的任意一个关键活动的持续时间可缩短关键路径长度', 'C', '关键路径是源点到汇点的最长路径，关键路径活动时间延长会使工期等量延长，II 正确。只有所有关键路径长度都缩短时，整个图的关键路径长度才可能缩短，IV 正确。I、III、V 均过于绝对。', 'PLAIN_TEXT', NULL, 'II 和 V', 'I、II 和 IV', 'II 和 IV', 'I 和 IV'),
(4, '00000000-0000-0000-0000-000000065004', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.240,249', '在求 AOE 网的关键路径时，若该有向图用邻接矩阵表示且第 i 列值全为 ∞，则（ ）。', 'A', '邻接矩阵第 i 列全为 ∞，说明顶点 i 没有入边，是整个工程的开始。若关键路径存在，则该顶点一定是起点，但不能据此判定关键路径是否存在。', 'PLAIN_TEXT', NULL, '若关键路径存在，第 i 个顶点一定是起点', '若关键路径存在，第 i 个顶点一定是终点', '关键路径不存在', '该有向图对应的无向图存在多个连通分量'),
(5, '00000000-0000-0000-0000-000000065005', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2010, '6.4图的应用', 'pp.240,249', '【2010 统考真题】对右图进行拓扑排序，可得不同拓扑序列的个数是（ ）。', 'B', '按入度为 0 的顶点逐步输出并删除相关边进行枚举，可得到 abced、abecd、abced 等不同分支，最终共有 3 种不同拓扑序列。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q05-topo-graph.png', '4', '3', '2', '1'),
(6, '00000000-0000-0000-0000-000000065006', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2012, '6.4图的应用', 'pp.240,249', '【2012 统考真题】下列关于最小生成树的叙述中，正确的是（ ）。\nI. 最小生成树的代价唯一\nII. 所有权值最小的边一定会出现在所有的最小生成树中\nIII. 使用 Prim 算法从不同顶点开始得到的最小生成树一定相同\nIV. 使用 Prim 算法和 Kruskal 算法得到的最小生成树总不相同', 'A', '最小生成树可能不唯一，但总代价一定唯一，I 正确。权值最小的边若构成环，则并非都会出现在某棵最小生成树中；Prim 从不同顶点开始和 Kruskal 得到的树都可能相同或不同，III、IV 错误。', 'PLAIN_TEXT', NULL, '仅 I', '仅 II', '仅 I、III', '仅 II、IV'),
(7, '00000000-0000-0000-0000-000000065007', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'PAST_EXAM', 2012, '6.4图的应用', 'pp.240,249-250', '【2012 统考真题】对右图所示的有向带权图，若采用 Dijkstra 算法求从源点 a 到其他各顶点的最短路径，则得到的第一条最短路径的目标顶点是 b，第二条最短路径的目标顶点是 c，后续得到的其余各最短路径的目标顶点依次是（ ）。', 'C', '按 Dijkstra 算法依次更新 dist。第一条和第二条目标顶点为 b、c 后，后续目标顶点依次为 f、d、e。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q07-dijkstra-graph.png', 'd,e,f', 'e,d,f', 'f,d,e', 'f,e,d'),
(8, '00000000-0000-0000-0000-000000065008', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2012, '6.4图的应用', 'pp.240,250', '【2012 统考真题】若用邻接矩阵存储有向图，矩阵中主对角线以下的元素均为零，则关于该图拓扑序列的结论是（ ）。', 'C', '主对角线以下均为 0，说明只有从编号小的顶点到编号大的顶点可能有边，因此图中不存在环，一定存在拓扑序列；但拓扑序列可能不唯一。', 'PLAIN_TEXT', NULL, '存在，且唯一', '存在，且不唯一', '存在，可能不唯一', '无法确定是否存在'),
(9, '00000000-0000-0000-0000-000000065009', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'PAST_EXAM', 2013, '6.4图的应用', 'pp.240,250', '【2013 统考真题】下列 AOE 网表示一项包含 8 个活动的工程，通过同时加快若干活动的进度，可缩短整个工程的工期。在下列选项中，加快其进度就可缩短工程工期的是（ ）。', 'C', '该 AOE 网的全部关键路径为 bdcg、bdeh 和 bfh。只有同时加快 f 和 d，才能覆盖全部关键路径并缩短工期。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q09-aoe-8-activities.png', 'c 和 e', 'd 和 c', 'f 和 d', 'f 和 h'),
(10, '00000000-0000-0000-0000-000000065010', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2014, '6.4图的应用', 'pp.240,250', '【2014 统考真题】对右图所示的有向图进行拓扑排序，得到的拓扑序列可能是（ ）。', 'D', '按拓扑排序规则，每次只能输出入度为 0 的顶点。图中开始只有顶点 3 的入度为 0，删除后只有顶点 1 的入度为 0，随后顶点 4、2 的入度均为 0，因此可能序列为 3,1,4,2,6,5。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q10-topo-graph.png', '3,1,2,4,5,6', '3,1,2,4,6,5', '3,1,4,2,5,6', '3,1,4,2,6,5'),
(11, '00000000-0000-0000-0000-000000065011', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'PAST_EXAM', 2015, '6.4图的应用', 'pp.241,250', '【2015 统考真题】求右图所示带权图的最小（代价）生成树时，可能是 Kruskal 算法第 2 次选中但不是 Prim 算法（从 V4 开始）第 2 次选中的边是（ ）。', 'C', '从 V4 开始执行 Prim，第一条边为 (V1,V4)。Kruskal 的第 2 次选择可能落在权值次小且不成环的边上，结合题图可知符合条件的是 (V2,V3)。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q11-mst-graph.png', '(V1,V3)', '(V1,V4)', '(V2,V3)', '(V3,V4)'),
(12, '00000000-0000-0000-0000-000000065012', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2011, '6.4图的应用', 'pp.241,250', '【2011 统考真题】下列关于图的叙述中，正确的是（ ）。\nI. 回路是简单路径\nII. 存储稀疏图，用邻接矩阵比邻接表更省空间\nIII. 若有向图中存在拓扑序列，则该图不存在回路', 'C', '回路首尾顶点相同，不是简单路径，I 错误。稀疏图更适合邻接表存储，II 错误。有向图存在拓扑序列等价于无有向回路，III 正确。', 'PLAIN_TEXT', NULL, '仅 II', '仅 I、II', '仅 III', '仅 I、III'),
(13, '00000000-0000-0000-0000-000000065013', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'PAST_EXAM', 2016, '6.4图的应用', 'pp.241,250-251', '【2016 统考真题】使用 Dijkstra 算法求下图中从顶点 1 到其他各顶点的最短路径，依次得到的各最短路径的目标顶点是（ ）。', 'B', '按 Dijkstra 算法从顶点 1 出发逐轮选择当前 dist 最小的顶点，得到目标顶点次序为 5、2、3、6、4。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q13-dijkstra-graph.png', '5,2,3,4,6', '5,2,3,6,4', '5,2,4,3,6', '5,2,6,3,4'),
(14, '00000000-0000-0000-0000-000000065014', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2016, '6.4图的应用', 'pp.241,251', '【2016 统考真题】若对 n 个顶点、e 条弧的有向图采用邻接表存储，则拓扑排序算法的时间复杂度为（ ）。', 'B', '采用邻接表进行拓扑排序时，需要对 n 个顶点入栈、出栈并输出各一次，同时检查 e 条弧对应的边表结点，总时间复杂度为 O(n+e)。', 'PLAIN_TEXT', NULL, 'O(n)', 'O(n+e)', 'O(n^2)', 'O(ne)'),
(15, '00000000-0000-0000-0000-000000065015', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2018, '6.4图的应用', 'pp.241,251', '【2018 统考真题】下列选项中，不是右侧有向图的拓扑序列的是（ ）。', 'D', '拓扑排序每次选取入度为 0 的顶点输出。观察图可知拓扑序列前两位只能是 1、5 或 5、1，其余顶点也必须满足前驱约束，D 不满足。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q15-topo-graph.png', '1,5,2,3,6,4', '5,1,2,6,3,4', '5,1,2,3,6,4', '5,2,1,6,3,4'),
(16, '00000000-0000-0000-0000-000000065016', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'PAST_EXAM', 2019, '6.4图的应用', 'pp.241,251', '【2019 统考真题】下图所示的 AOE 网表示一项包含 8 个活动的工程。活动 d 的最早开始时间和最迟开始时间分别是（ ）。', 'C', '活动 d 的最早开始时间为事件 2 的最早发生时间 max{a,b+c}=12；求得关键路径长度为 27，事件 4 的最迟发生时间为 21，因此 d 的最迟开始时间为 21-7=14。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q16-aoe-2019.png', '3 和 7', '12 和 12', '12 和 14', '15 和 15'),
(17, '00000000-0000-0000-0000-000000065017', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2019, '6.4图的应用', 'pp.241,252', '【2019 统考真题】用有向无环图描述表达式 (x+y)((x+y)/x)，需要的顶点个数至少是（ ）。', 'A', '将表达式转换为有向二叉树后，公共子表达式 x+y 可共享结点，从而得到有向无环图。去除重复顶点后，至少需要 5 个顶点。', 'PLAIN_TEXT', NULL, '5', '6', '8', '9'),
(18, '00000000-0000-0000-0000-000000065018', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2020, '6.4图的应用', 'pp.241-242,252', '【2020 统考真题】已知无向图 G 如右所示，使用 Kruskal 算法求 G 的最小生成树，加入到最小生成树中的边依次是（ ）。', 'A', 'Kruskal 算法按权值递增选边且避免成环。依次选择 (b,f)、(b,d)，跳过会成环的边后，继续选择 (a,e)、(c,e)、(b,e)。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q18-kruskal-graph.png', '(b,f),(b,d),(a,e),(c,e),(b,e)', '(b,f),(b,d),(b,e),(a,e),(c,e)', '(a,e),(b,e),(c,e),(b,d),(b,f)', '(a,e),(c,e),(b,e),(b,f),(b,d)'),
(19, '00000000-0000-0000-0000-000000065019', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2020, '6.4图的应用', 'pp.242,252', '【2020 统考真题】修改递归方式实现的图的深度优先搜索（DFS）算法，将输出访问顶点信息的语句移到退出递归前（执行输出语句后立刻退出递归）。采用修改后的算法遍历有向无环图 G，若输出结果中包含 G 中的全部顶点，则输出的顶点序列是 G 的（ ）。', 'B', 'DFS 中顶点在其所有后继顶点处理完之后才输出，输出序列与拓扑有序序列相反，因此为逆拓扑有序序列。', 'PLAIN_TEXT', NULL, '拓扑有序序列', '逆拓扑有序序列', '广度优先搜索序列', '深度优先搜索序列'),
(20, '00000000-0000-0000-0000-000000065020', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2020, '6.4图的应用', 'pp.242,253', '【2020 统考真题】若使用 AOE 网估算工程进度，则下列叙述中正确的是（ ）。', 'B', '关键路径是从源点到汇点路径长度最长的路径。它不是边数最多的路径；增加关键活动时间会延长工期；缩短任一关键活动不一定缩短总工期。', 'PLAIN_TEXT', NULL, '关键路径是从源点到汇点边数最多的一条路径', '关键路径是从源点到汇点路径长度最长的路径', '增加任意一个关键活动的时间不会延长工程的工期', '缩短任意一个关键活动的时间将会缩短工程的工期'),
(21, '00000000-0000-0000-0000-000000065021', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2021, '6.4图的应用', 'pp.242,253', '【2021 统考真题】给定右图所示有向图，该图的拓扑有序序列的个数是（ ）。', 'A', '从图中选择无入边顶点，输出并删除其所有出边，重复该过程。每一步都只有一个顶点无入边，因此拓扑序列唯一，为 ABCDEF。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q21-topo-count.png', '1', '2', '3', '4'),
(22, '00000000-0000-0000-0000-000000065022', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'HARD', 'PAST_EXAM', 2021, '6.4图的应用', 'pp.242,253', '【2021 统考真题】使用 Dijkstra 算法求下图中从顶点 1 到其余各顶点的最短路径，将当前找到的从顶点 1 到顶点 2、3、4、5 的最短路径长度保存在数组 dist 中，求出第二条最短路径后，dist 中的内容更新为（ ）。', 'C', '初始化后先选入距离最近的顶点 3，再选入顶点 5。通过顶点 5 松弛后，dist 数组更新为 21、3、14、6。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q22-dijkstra-dist.png', '26,3,14,6', '25,3,14,6', '21,3,14,6', '15,3,14,6'),
(23, '00000000-0000-0000-0000-000000065023', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2022, '6.4图的应用', 'pp.242,253', '【2022 统考真题】下图是一个有 10 个活动的 AOE 网，时间余量最大的活动是（ ）。', 'B', '按关键路径算法计算各活动的时间余量，可得 c 的余量为 2，g 的余量为 6，h 的余量为 2，j 的余量为 2，因此时间余量最大的是 g。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q65-q23-aoe-slack.png', 'c', 'g', 'h', 'j'),
(24, '00000000-0000-0000-0000-000000065024', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'BASIC', 'PAST_EXAM', 2023, '6.4图的应用', 'pp.242,253', '【2023 统考真题】已知无向连通图 G 中各边的权值均为 1。在下列算法中，一定能够求出图 G 中从某顶点到其余各顶点最短路径的是（ ）。\nI. Prim 算法\nII. Kruskal 算法\nIII. 图的广度优先搜索算法', 'B', 'Prim 和 Kruskal 用于求最小生成树，生成树中两点路径不一定是原图最短路径。无权图或各边权值相同的图可用 BFS 求单源最短路径。', 'PLAIN_TEXT', NULL, '仅 I', '仅 III', '仅 I、II', 'I、II、III'),
(25, '00000000-0000-0000-0000-000000065025', 'DS_GRAPH', 'DS_GRAPH_APPLICATION', 'MEDIUM', 'PAST_EXAM', 2025, '6.4图的应用', 'pp.242-243,253', '【2025 统考真题】下列关于图的叙述中，正确的是（ ）。', 'C', '若一个有向图构成环，则每个顶点入度均不为 0。各顶点度均大于或等于 2 的无向图，从任一顶点出发至少还有另一条边可走，因顶点有限，最终会形成回路。BFS 只适用于无权图或等权图的单源最短路径。', 'PLAIN_TEXT', NULL, '有向图必存在入度为 0 的顶点', '有向无环图的拓扑有序序列存在且唯一', '各顶点的度均大于或等于 2 的无向图必有回路', '可用 BFS 算法求出带权图中每对顶点间的最短路径'),
(26, '00000000-0000-0000-0000-000000065026', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', 'MOCK', 2027, '7.2顺序查找和折半查找', 'pp.269,272', '顺序查找适合于存储结构为（ ）的线性表。', 'A', '顺序查找是从表的一端开始逐个比较，不要求随机存取，顺序存储结构和链式存储结构均可使用。', 'PLAIN_TEXT', NULL, '顺序存储结构或链式存储结构', '散列存储结构', '索引存储结构', '压缩存储结构'),
(27, '00000000-0000-0000-0000-000000065027', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', 'MOCK', 2027, '7.2顺序查找和折半查找', 'pp.269,273', '由 n 个数据元素组成的两个表：一个递增有序，一个无序。采用顺序查找算法，对有序表从头开始查找，发现当前元素已不小于待查元素时，停止查找，确定查找不成功。已知查找任意一个元素的概率是相同的，则在两种表中成功查找（ ）。', 'B', '顺序查找成功时，每个元素的比较次数只与它在表中的位置有关，与表是否有序无关，因此成功查找的平均时间两者相同。', 'PLAIN_TEXT', NULL, '平均时间后者小', '平均时间两者相同', '平均时间前者小', '无法确定'),
(28, '00000000-0000-0000-0000-000000065028', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', 'MOCK', 2027, '7.2顺序查找和折半查找', 'pp.269,273', '对长度为 n 的有序单链表，若查找每个元素的概率相等，则顺序查找表中任意一个元素的查找成功的平均查找长度为（ ）。', 'B', '在有序单链表上进行顺序查找，查找成功的平均查找长度与在顺序表上顺序查找相同，均为 (n+1)/2。', 'PLAIN_TEXT', NULL, 'n/2', '(n+1)/2', '(n-1)/2', 'n/4'),
(29, '00000000-0000-0000-0000-000000065029', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', 'MOCK', 2027, '7.2顺序查找和折半查找', 'pp.269,273', '对长度为 3 的顺序表进行查找，若查找第一个元素的概率为 1/2，查找第二个元素的概率为 1/3，查找第三个元素的概率为 1/6，则查找任意一个元素的平均查找长度为（ ）。', 'A', '三个元素的查找长度分别为 1、2、3，按给定概率加权可得 ASL=1/2×1+1/3×2+1/6×3=5/3。', 'PLAIN_TEXT', NULL, '5/3', '2', '7/3', '4/3'),
(30, '00000000-0000-0000-0000-000000065030', 'DS_SEARCH', 'DS_SEARCH_LINEAR_BINARY', 'BASIC', 'MOCK', 2027, '7.2顺序查找和折半查找', 'pp.269,273', '下列关于二分查找的叙述中，正确的是（ ）。', 'D', '二分查找通过下标定位中间元素，要求查找表有序并采用顺序存储。查找表可以递增也可以递减，但不能是链式存储。', 'PLAIN_TEXT', NULL, '表必须有序，表可以顺序方式存储，也可以链表方式存储', '表必须有序且表中数据必须是整型、实型或字符型', '表必须有序，而且只能从小到大排列', '表必须有序，且表只能以顺序方式存储');

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
    q.source_type,
    q.source_year,
    2.00,
    'PUBLISHED',
    'APPROVED',
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 6 章 6.4.6/6.4.7 与第 7 章 7.2.4/7.2.5 本节试题精选及答案解析，参考页：' || q.source_pages || '。',
    q.stem_format,
    q.stem_image_url,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch6_d_ch7_a_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000165', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch6_d_ch7_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000165', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch6_d_ch7_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000165', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch6_d_ch7_a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000165', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch6_d_ch7_a_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch6_d_ch7_a_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000065701', 'DS-2027-ORIGINAL-CH6-D-CH7-A'),
    ('00000000-0000-0000-0000-000000065702', '第7章查找'),
    ('00000000-0000-0000-0000-000000065703', '7.2顺序查找和折半查找')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch6_d_ch7_a_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH6-D-CH7-A',
    q.section_tag,
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容'
) OR (q.chapter_code = 'DS_GRAPH' AND tag.name = '第6章图')
   OR (q.chapter_code = 'DS_SEARCH' AND tag.name = '第7章查找')
   OR (q.source_type = 'PAST_EXAM' AND tag.name = '真题')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_original_ch6_d_ch7_a_import;
