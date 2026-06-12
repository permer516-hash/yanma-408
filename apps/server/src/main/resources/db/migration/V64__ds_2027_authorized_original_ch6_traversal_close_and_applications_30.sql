-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 6: 6.3.4/6.3.5 and 6.4.6/6.4.7 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH6-C

CREATE TABLE ds_2027_original_ch6_c_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
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

INSERT INTO ds_2027_original_ch6_c_import (
    num, id, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, stem_format, stem_image_url,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000064001', 'MEDIUM', 'MOCK', 2027, '6.3图的遍历', 'pp.219,222', '无向图 G=(V,E)，其中 V={a,b,c,d,e,f}，E={(a,b),(a,e),(a,c),(b,e),(c,f),(f,d),(e,d)}。对该图进行深度优先遍历，不能得到的序列是（ ）。', 'D', 'DFS 遍历序列随邻接点访问顺序不同而不同。根据边集可画出该无向图并逐项模拟，acfdeb、aebdfc、aedfcb 都可由某种邻接访问顺序得到，abecdf 中从 e 转到 c 不符合深度优先回溯过程。', 'PLAIN_TEXT', NULL, 'acfdeb', 'aebdfc', 'aedfcb', 'abecdf'),
(2, '00000000-0000-0000-0000-000000064002', 'BASIC', 'MOCK', 2027, '6.3图的遍历', 'pp.219,222', '判断有向图中是否存在回路，除拓扑排序外，还可利用（ ）。（注：涉及下节内容）', 'C', '深度优先遍历可用于判断图中是否存在回路。对有向图进行 DFS 时，若发现某条边从顶点 u 指向顶点 v，且 u 是 v 在 DFS 树中的子孙，则图中存在有向回路。', 'PLAIN_TEXT', NULL, '求关键路径的方法', '求最短路径的 Dijkstra 算法', '深度优先遍历算法', '广度优先遍历算法'),
(3, '00000000-0000-0000-0000-000000064003', 'BASIC', 'MOCK', 2027, '6.3图的遍历', 'pp.219,222', '设无向图 G=(V,E) 和 G''=(V'',E'')，若 G'' 是 G 的生成树，则下列说法错误的是（ ）。', 'B', '生成树是连通图包含全部顶点的极小连通子图，必然是 G 的子图，也是无环子图。连通分量是无向图的极大连通子图，可含回路，概念上不同于生成树。', 'PLAIN_TEXT', NULL, 'G'' 为 G 的子图', 'G'' 为 G 的连通分量', 'G'' 为 G 的极小连通子图且 V=V''', 'G'' 是 G 的一个无环子图'),
(4, '00000000-0000-0000-0000-000000064004', 'BASIC', 'MOCK', 2027, '6.3图的遍历', 'pp.219,222', '图的广度优先生成树的树高比深度优先生成树的树高（ ）。', 'A', 'BFS 从根顶点逐层扩展，生成树中从根到各顶点的路径长度是按层次得到的最短边数路径，因此广度优先生成树的高度小于或等于深度优先生成树。', 'PLAIN_TEXT', NULL, '小或相等', '小', '大或相等', '大'),
(5, '00000000-0000-0000-0000-000000064005', 'MEDIUM', 'PAST_EXAM', 2012, '6.3图的遍历', 'pp.219,223', '【2012 统考真题】对有 n 个顶点、e 条边且使用邻接表存储的有向图进行广度优先遍历，其算法的时间复杂度为（ ）。', 'C', '采用邻接表存储时，BFS 需要访问每个顶点一次，并扫描与各顶点相连的全部边表结点一次，因此时间复杂度为 O(n+e)。', 'PLAIN_TEXT', NULL, 'O(n)', 'O(e)', 'O(n+e)', 'O(ne)'),
(6, '00000000-0000-0000-0000-000000064006', 'MEDIUM', 'PAST_EXAM', 2013, '6.3图的遍历', 'pp.219,223', '【2013 统考真题】下列选项中，不是右图所示无向图的广度优先遍历序列的是（ ）。', 'D', '逐项按 BFS 队列过程模拟。A、B、C 都能通过不同邻接点访问次序得到；D 序列从 a 出发后继续深入访问 d，更符合深度优先过程，而不是按层扩展的广度优先过程。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q64-q08-bfs-graph.png', 'h,c,a,b,d,e,g,f', 'e,a,f,g,b,h,c,d', 'd,b,c,a,h,e,f,g', 'a,b,c,d,h,e,f,g'),
(7, '00000000-0000-0000-0000-000000064007', 'HARD', 'PAST_EXAM', 2015, '6.3图的遍历', 'pp.219,223', '【2015 统考真题】设有向图 G=(V,E)，顶点集 V={V0,V1,V2,V3}，边集 E={<V0,V1>,<V0,V2>,<V0,V3>,<V1,V3>}。若从顶点 V0 开始对图进行深度优先遍历，则可能得到的不同遍历序列个数是（ ）。', 'D', '从 V0 出发时可按不同邻接点次序递归。可能序列包括 <V0,V1,V3,V2>、<V0,V2,V3,V1>、<V0,V2,V1,V3>、<V0,V3,V2,V1>、<V0,V3,V1,V2>，共 5 个。', 'PLAIN_TEXT', NULL, '2', '3', '4', '5'),
(8, '00000000-0000-0000-0000-000000064008', 'MEDIUM', 'PAST_EXAM', 2016, '6.3图的遍历', 'pp.219,223', '【2016 统考真题】下列选项中，不是右图所示深度优先搜索序列的是（ ）。', 'D', '根据题图从 V1 出发逐项模拟 DFS。A、B、C 均可由不同邻接点访问顺序得到；D 中访问 V2 后先转到 V3，再到 V4、V5，与图中深度优先可达关系不符。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q64-q10-dfs-directed.png', 'V1,V5,V4,V3,V2', 'V1,V3,V2,V5,V4', 'V1,V2,V5,V4,V3', 'V1,V2,V3,V4,V5'),
(9, '00000000-0000-0000-0000-000000064009', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.237,246', '任何一个无向连通图的最小生成树（ ）。', 'A', '当无向连通图中存在权值相同的多条边时，最小生成树可能不唯一；无向连通图一定存在最小生成树，因此应选“有一棵或多棵”。', 'PLAIN_TEXT', NULL, '有一棵或多棵', '只有一棵', '一定有多棵', '可能不存在'),
(10, '00000000-0000-0000-0000-000000064010', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.237,246', '用 Prim 算法和 Kruskal 算法构造图的最小生成树，所得到的最小生成树（ ）。', 'C', '无向连通图的最小生成树不一定唯一，所以用不同算法生成的最小生成树可能不同；若最小生成树唯一，则两种算法得到的最小生成树必定相同。', 'PLAIN_TEXT', NULL, '相同', '不相同', '可能相同，可能不同', '无法比较'),
(11, '00000000-0000-0000-0000-000000064011', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.237,246', '下列关于图的生成树和最小生成树的叙述中，正确的是（ ）。', 'A', '最小生成树算法基于贪心策略。若各边权值不同，则每次选择的满足条件的最小边唯一，从而最小生成树唯一。权值相同不必然导致不唯一；直接取 n-1 条最小边可能成环；含 n 个顶点、n-1 条边的子图也可能不连通。', 'PLAIN_TEXT', NULL, '只要无向连通图中没有权值相同的边，则其最小生成树唯一', '只要无向图中有权值相同的边，则其最小生成树一定不唯一', '从 n 个顶点的连通图中选取 n-1 条权值最小的边，即可构成最小生成树', '设连通图 G 含有 n 个顶点，则含有 n 个顶点、n-1 条边的子图一定是 G 的生成树'),
(12, '00000000-0000-0000-0000-000000064012', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.237,246', '设有 n 个顶点的无向连通图的最小生成树不唯一，则下列说法中正确的是（ ）。', 'A', '若边数小于 n-1，则图不连通；若边数等于 n-1，则连通图本身就是唯一生成树。因此最小生成树不唯一时，图的边数一定大于 n-1。最小生成树不唯一时总代价仍相同。', 'PLAIN_TEXT', NULL, '图的边数一定大于 n-1', '图的权值最小的边一定有多条', '图的最小生成树的代价不一定相等', '图的各条边的权值不相等'),
(13, '00000000-0000-0000-0000-000000064013', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.237,246', '用 Prim 算法求一个带权连通图的最小生成树，在算法执行的某个时刻，已选取的顶点集合 U={1,2,3}，已选取的边集合 TE={(1,2),(2,3)}，要选取下一条权值最小的边，应当从（ ）组中选取。', 'A', 'Prim 算法每一步从 U 和 V-U 两个顶点集合之间的候选边中选取权值最小者。当前 U={1,2,3}，V-U={4,5,...}，候选边只能跨越这两个集合，只有 A 符合题意。', 'PLAIN_TEXT', NULL, '{(1,4),(3,4),(3,5),(2,5)}', '{(3,4),(3,5),(4,5),(1,4)}', '{(1,2),(2,3),(3,5)}', '{(4,5),(1,3),(3,5)}'),
(14, '00000000-0000-0000-0000-000000064014', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.237,246', '用 Kruskal 算法求一个带权连通图的最小生成树，在算法执行的某个时刻，已选取的边集合 TE={(1,2),(2,3),(3,5)}，要选取下一条权值最小的边，不可能选取的边是（ ）。', 'C', 'Kruskal 算法每次从未选边中选择不会形成回路的最小权边。已选边使 1、2、3、5 属于同一连通分量，再选 (1,3) 会形成回路，因此不可能选取。', 'PLAIN_TEXT', NULL, '(3,6)', '(2,4)', '(1,3)', '(1,4)'),
(15, '00000000-0000-0000-0000-000000064015', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.237-238,246', '下列关于图的最短路径的相关叙述中，正确的是（ ）。', 'A', '最短路径一定是简单路径。Dijkstra 算法适合求有回路的带权图最短路径，也可用于求任意两个顶点之间的最短路径，但不能正确处理含负权边的情形。', 'PLAIN_TEXT', NULL, '最短路径一定是简单路径', 'Dijkstra 算法不适合求有回路的带权图的最短路径', 'Dijkstra 算法不适合求任意两个顶点的最短路径', 'Dijkstra 算法可以正确处理含有负权边的图'),
(16, '00000000-0000-0000-0000-000000064016', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.238,246', '下列关于图的最短路径的相关叙述中，正确的是（ ）。\nI. Dijkstra 算法求单源最短路径不允许边的权为负\nII. Dijkstra 算法求每对顶点间的最短路径的时间复杂度为 O(n^2)\nIII. Floyd 算法求每对顶点间的最短路径允许边的权为负，但不允许含有负权的回路', 'C', 'Dijkstra 算法不允许边权为负，I 正确。若用 Dijkstra 求每对顶点间最短路径，需要对每个源点调用一次，时间复杂度为 O(n^3)，II 错误。Floyd 算法可处理负权边，但不能含负权回路，III 正确。', 'PLAIN_TEXT', NULL, 'I、II 和 III', '仅 I', 'I 和 III', 'II 和 III'),
(17, '00000000-0000-0000-0000-000000064017', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.238,246', '已知带权连通无向图 G=(V,E)，其中 V={v1,v2,v3,v4,v5,v6,v7}，E={(v1,v2)10,(v1,v3)2,(v3,v4)2,(v3,v6)11,(v2,v5)1,(v4,v5)4,(v4,v6)6,(v5,v7)7,(v6,v7)3}（注：顶点偶对括号外的数据表示边上的权值），从源点 v1 到顶点 v7 的最短路径上经过的顶点序列是（ ）。', 'B', '各选项对应的路径长度分别为 18、13、15、24。由 Dijkstra 算法可得最短路径为 v1->v3->v4->v6->v7。', 'PLAIN_TEXT', NULL, 'v1,v2,v5,v7', 'v1,v3,v4,v6,v7', 'v1,v3,v4,v5,v7', 'v1,v2,v5,v4,v6,v7'),
(18, '00000000-0000-0000-0000-000000064018', 'HARD', 'MOCK', 2027, '6.4图的应用', 'pp.238,247', '用 Dijkstra 算法求一个带权有向图的从顶点 0 出发的最短路径，在算法执行的某个时刻，已求得的最短路径的顶点集合 S={0,2,3,4}，下一个选取的目标顶点是顶点 1，则可能修改的最短路径是（ ）。', 'D', '下一个选入 S 的顶点为 1，说明从源点 0 到顶点 1 的当前最短路径已确定。因此本轮可能被确定或修改的是从顶点 0 到顶点 1 的最短路径。', 'PLAIN_TEXT', NULL, '从顶点 0 到顶点 3 的最短路径', '从顶点 0 到顶点 2 的最短路径', '从顶点 2 到顶点 4 的最短路径', '从顶点 0 到顶点 1 的最短路径'),
(19, '00000000-0000-0000-0000-000000064019', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.238,247', '下面的（ ）方法可以判断出一个有向图是否有环（回路）。\nI. 深度优先遍历\nII. 拓扑排序\nIII. 求最短路径\nIV. 广度优先遍历', 'A', '深度优先遍历可通过回边判断有向环；拓扑排序中若不能输出全部顶点则存在回路；广度优先遍历也可结合入度或访问状态判断回路。求最短路径不是判断有向图是否有环的通用方法。', 'PLAIN_TEXT', NULL, 'I、II、IV', 'I、III、IV', 'I、II、III', '全部可以'),
(20, '00000000-0000-0000-0000-000000064020', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.238,247', '在有向图 G 的拓扑序列中，若顶点 vi 在顶点 vj 之前，则不可能出现的情形是（ ）。', 'D', '若存在从 vj 到 vi 的路径，则拓扑序列中 vj 必须出现在 vi 之前，这与题设 vi 在 vj 之前矛盾。因此不可能出现的是从 vj 到 vi 的路径。', 'PLAIN_TEXT', NULL, 'G 中有弧<vi,vj>', 'G 中有一条从 vi 到 vj 的路径', 'G 中没有弧<vi,vj>', 'G 中有一条从 vj 到 vi 的路径'),
(21, '00000000-0000-0000-0000-000000064021', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.238,247', '下列关于拓扑排序的说法中，错误的是（ ）。\nI. 若某有向图存在环，则该有向图一定不存在拓扑排序\nII. 在拓扑排序算法中为暂存入度为零的顶点，可以使用栈，也可以使用队列\nIII. 若有向图的拓扑有序序列唯一，则图中每个顶点的入度和出度最多为 1\nIV. 若有向图的拓扑有序序列唯一，则图中入度为 0 和出度为 0 的顶点都仅有 1 个', 'D', 'I 正确；II 中暂存入度为 0 的顶点可使用栈或队列。若拓扑序列唯一，并不要求每个顶点入度和出度最多为 1，III 错误。若入度为 0 的顶点或出度为 0 的顶点不唯一，则序列首尾可交换，拓扑序列不唯一，IV 正确。', 'PLAIN_TEXT', NULL, 'I、III、IV', 'III、IV', 'II、IV', 'III'),
(22, '00000000-0000-0000-0000-000000064022', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.238,247', '下列关于拓扑排序的说法中，正确的是（ ）。\nI. 顶点数大于 1 的强连通图不能进行拓扑排序\nII. 在一个有向图的拓扑序列中，若顶点 a 在顶点 b 之前，则图中必有一条弧<a,b>\nIII. 若有向无环图的拓扑序列唯一，则可以唯一确定该图', 'C', '顶点数大于 1 的强连通图中存在回路，不能进行拓扑排序，I 正确。拓扑序列中 a 在 b 前，只能说明不存在从 b 到 a 的路径，并不必然存在弧<a,b>，II 错误。拓扑序列唯一也不能唯一确定原图，III 错误。', 'PLAIN_TEXT', NULL, 'I 和 II', 'I、II 和 III', '仅 I', 'I 和 III'),
(23, '00000000-0000-0000-0000-000000064023', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.238,247', '若一个有向图的顶点不能排成一个拓扑序列，则判定该有向图（ ）。', 'D', '有向图不能排成拓扑序列，说明图中存在有向回路。存在回路时，该有向图至少有一个顶点数大于 1 的强连通分量。', 'PLAIN_TEXT', NULL, '含有多个出度为 0 的顶点', '是个强连通图', '含有多个入度为 0 的顶点', '含有顶点数大于 1 的强连通分量'),
(24, '00000000-0000-0000-0000-000000064024', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.238,247', '右图所示有向图的所有拓扑序列共有（ ）个。', 'C', '从图中入度为 0 的顶点开始逐步删除顶点并更新入度。按所有可选入度为 0 的顶点分支枚举，可得到 5 个不同拓扑序列。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q64-q24-topo-dag.png', '4', '6', '5', '7'),
(25, '00000000-0000-0000-0000-000000064025', 'HARD', 'MOCK', 2027, '6.4图的应用', 'pp.238-239,247', '已知有向图 G=(V,E)，其中 V={v1,v2,v3,v4,v5,v6,v7}，E={<v1,v2>,<v1,v3>,<v1,v4>,<v2,v5>,<v3,v5>,<v3,v6>,<v5,v7>,<v6,v7>,<v4,v6>}，G 的拓扑序列是（ ）。', 'A', '顶点 v1 入度为 0，应首先输出。输出 v1 后，v2、v3、v4 的入度变为 0。逐项检查选项，只有 A 中每个顶点都出现在其所有后继之前，满足全部弧的拓扑约束。', 'PLAIN_TEXT', NULL, '{v1,v3,v4,v6,v2,v5,v7}', '{v1,v3,v2,v6,v4,v5,v7}', '{v1,v3,v4,v5,v2,v6,v7}', '{v1,v2,v5,v3,v4,v6,v7}'),
(26, '00000000-0000-0000-0000-000000064026', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.239,248', '下列哪种图的邻接矩阵必为对称矩阵？', 'B', '无向图中边 (vi,vj) 与 (vj,vi) 表示同一条边，因此邻接矩阵关于主对角线对称。有向图、AOV 网和 AOE 网本质上都是有向图，邻接矩阵不一定对称。', 'PLAIN_TEXT', NULL, '有向图', '无向图', 'AOV 网', 'AOE 网'),
(27, '00000000-0000-0000-0000-000000064027', 'BASIC', 'MOCK', 2027, '6.4图的应用', 'pp.239,248', '若一个有向图具有有序的拓扑排序序列，则它的邻接矩阵必定为（ ）。', 'C', '按拓扑序列重新排列有向无环图顶点后，所有弧都从序列前面的顶点指向后面的顶点，因此邻接矩阵可表现为三角矩阵。', 'PLAIN_TEXT', NULL, '对称', '稀疏', '三角', '一般'),
(28, '00000000-0000-0000-0000-000000064028', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.239,248', '用 DFS 算法遍历一个无环有向图，并在 DFS 算法退栈返回时输出相应的顶点，则输出的顶点序列是（ ）。', 'A', '对有向无环图进行 DFS 时，若在递归退栈返回时输出顶点，输出序列中每个顶点会在其所有后继之后出现，因此得到的是逆拓扑有序序列。', 'PLAIN_TEXT', NULL, '逆拓扑有序', '拓扑有序', '无序的', '无法确定'),
(29, '00000000-0000-0000-0000-000000064029', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.239,248', '下列关于图的说法中，正确的是（ ）。\nI. 有向图中顶点 V 的度等于其邻接矩阵中第 V 行中 1 的个数\nII. 无向图的邻接矩阵一定是对称矩阵，有向图的邻接矩阵一定是非对称矩阵\nIII. 在带权图 G 的最小生成树 G'' 中，某条边的权值可能会超过未选边的权值\nIV. 若有向无环图的拓扑序列唯一，则可以唯一确定该图', 'C', 'I 错在有向图顶点的度为入度加出度，不能只看一行。II 错在有向图邻接矩阵也可能对称。III 正确，最小生成树中某条已选边的权值可能大于未选边。IV 错在拓扑序列唯一仍不能唯一确定原图。', 'PLAIN_TEXT', NULL, 'I、II 和 III', 'III 和 IV', 'III', 'IV'),
(30, '00000000-0000-0000-0000-000000064030', 'MEDIUM', 'MOCK', 2027, '6.4图的应用', 'pp.239,248', '下图所示的 AOE 网中，关键路径长度为（ ）。', 'C', '按 AOE 网计算事件最早发生时间。最长路径为 v0->v1->v4->v6->v8，其长度为 6+1+9+2=18，因此关键路径长度为 18。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q64-q30-aoe-network.png', '16', '17', '18', '19');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 6 章 6.3.4/6.3.5 与 6.4.6/6.4.7 本节试题精选及答案解析，参考页：' || q.source_pages || '。',
    q.stem_format,
    q.stem_image_url,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch6_c_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = 'DS_GRAPH';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000164', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch6_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000164', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch6_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000164', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch6_c_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000164', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch6_c_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch6_c_import q
JOIN knowledge_points kp ON kp.code = 'DS_GRAPH_TRAVERSAL';

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000064701', 'DS-2027-ORIGINAL-CH6-C'),
    ('00000000-0000-0000-0000-000000064702', '6.4图的应用')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch6_c_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH6-C',
    '第6章图',
    q.section_tag,
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容'
) OR (q.source_type = 'PAST_EXAM' AND tag.name = '真题')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_original_ch6_c_import;
