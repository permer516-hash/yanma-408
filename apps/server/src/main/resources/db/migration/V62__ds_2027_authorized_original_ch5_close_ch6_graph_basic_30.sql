-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 5: 5.5.3/5.5.4; Chapter 6: 6.1.2/6.1.3 本节试题精选 / 答案与解析
-- Batch: DS-2027-ORIGINAL-CH5-J-CH6-A

CREATE TABLE ds_2027_original_ch5j_ch6a_import (
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

INSERT INTO ds_2027_original_ch5j_ch6a_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, stem_format, stem_image_url,
    option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000062001', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.186,189', '下列关于并查集的说法中，正确的是（ ）（注，本题涉及图的考点）。', 'D', '依次探测图的各条边，用并查集检查该边依附的两个顶点是否已属于同一个集合。若是，则说明图中存在环路，因此 A 错误。经过路径优化后，并查集在最坏情况下的高度远小于 O(n)，B 错误。Find 操作返回当前根结点作为集合标志，而不是元素个数的相反数，C 错误。Union 操作可根据集合规模将小集合合并到大集合中，D 正确。', 'PLAIN_TEXT', NULL, '并查集不能检测图中是否存在环路的问题', '通过路径优化后的并查集在最坏情况下的高度仍是 O(n)', 'Find 操作返回集合中元素个数的相反数，它用来作为某个集合的标志', 'Union 操作时可根据当前集合的规模，将小集合合并到大集合中'),
(2, '00000000-0000-0000-0000-000000062002', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'MOCK', 2027, '5.5树与二叉树的应用', 'pp.186,189', '下列关于并查集的叙述中，（ ）是错误的（注意，本题涉及图的考点）。', 'D', '并查集是用双亲表示法存储的树，能够用于 Kruskal 算法实现最小生成树，也可用于判断无向图的连通性。在用并查集判断无向图连通性时，遍历无向图的边，将每条边连接的两个顶点合并到同一集合，处理完后互相连通的顶点会合并到同一子集合中。未做路径优化时，并查集最坏情况下查找操作的时间复杂度为 O(n)，因此 D 错误。', 'PLAIN_TEXT', NULL, '并查集是用双亲表示法存储的树', '并查集可用于实现克鲁斯卡尔算法', '并查集可用于判断无向图的连通性', '在长度为 n 的并查集中进行查找操作的时间复杂度为 O(log2n)'),
(3, '00000000-0000-0000-0000-000000062003', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'PAST_EXAM', 2010, '5.5树与二叉树的应用', 'pp.186,189', '【2010 统考真题】n（n≥2）个权值均不相同的字符构成哈夫曼树，关于该树的叙述中，错误的是（ ）。', 'A', '哈夫曼树为带权路径长度最小的二叉树，不一定是完全二叉树。哈夫曼树中没有度为 1 的结点。构造哈夫曼树时最先选取两个权值最小的结点作为左右子树构造一棵新的二叉树，因此两个权值最小的结点一定是兄弟结点。哈夫曼树中任意一个非叶结点的权值为其左右子树根结点权值之和，可知任意一个非叶结点的权值一定不小于下一层任意一个结点的权值。', 'PLAIN_TEXT', NULL, '该树一定是一棵完全二叉树', '树中一定没有度为 1 的结点', '树中两个权值最小的结点一定是兄弟结点', '树中任意一个非叶结点的权值一定不小于下一层任意一个结点的权值'),
(4, '00000000-0000-0000-0000-000000062004', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'PAST_EXAM', 2014, '5.5树与二叉树的应用', 'pp.186,189', '【2014 统考真题】5 个字符有如下 4 种编码方案，不是前缀编码的是（ ）。', 'D', '前缀编码要求在一个字符集中，任何一个字符的编码都不是另一个字符编码的前缀。选项 D 中，编码 110 是编码 1100 的前缀，违反前缀编码规则，所以选 D。', 'PLAIN_TEXT', NULL, '01,0000,0001,0011,1', '011,000,001,010,1', '000,001,010,011,100', '0,100,110,1110,1100'),
(5, '00000000-0000-0000-0000-000000062005', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'HARD', 'PAST_EXAM', 2015, '5.5树与二叉树的应用', 'pp.186,189', '【2015 统考真题】下列选项给出的是从根分别到达两个叶结点路径上的权值序列，能属于同一棵哈夫曼树的是（ ）。', 'D', '在哈夫曼树中，左右孩子权值之和为父结点权值。逐项分析可排除 A、B、C：若两个 10 分别属于两棵不同子树或同棵子树，均不能满足父子权值关系；选项 D 的两条路径可同时出现在同一棵哈夫曼树中。', 'PLAIN_TEXT', NULL, '24,10,5 和 24,10,7', '24,10,5 和 24,12,7', '24,10,10 和 24,14,11', '24,10,5 和 24,14,6'),
(6, '00000000-0000-0000-0000-000000062006', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'PAST_EXAM', 2017, '5.5树与二叉树的应用', 'pp.186,189', '【2017 统考真题】已知字符集 {a,b,c,d,e,f,g,h}，各字符的哈夫曼编码依次是 0100,10,0000,0101,001,011,11,0001，编码序列 0100011001001011110101 的译码结果是（ ）。', 'D', '哈夫曼编码是前缀编码，各编码的前缀不同，因此直接拿编码序列与哈夫曼编码逐一比对即可。序列可分割为 0100 011 001 001 011 11 0101，译码结果是 afeefgd。', 'PLAIN_TEXT', NULL, 'acgabfh', 'adbagbb', 'afbeagd', 'afeefgd'),
(7, '00000000-0000-0000-0000-000000062007', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'HARD', 'PAST_EXAM', 2018, '5.5树与二叉树的应用', 'pp.186,189', '【2018 统考真题】已知字符集 {a,b,c,d,e,f}，若各字符出现的次数分别为 6,3,8,2,10,4，则对应字符集中各字符的哈夫曼编码可能是（ ）。', 'A', '根据各字符出现次数构造哈夫曼树可知，a、c 和 e 的编码长度应该相同；a 和 c 的第 1 个编码应该相同，且与 e 的第 1 个编码不同；b 和 d 的前 3 个编码应该相同。选项 A 满足这些关系。', 'PLAIN_TEXT', NULL, '00,1011,01,1010,11,100', '00,100,110,000,0010,01', '10,1011,11,0011,00,010', '0011,10,11,0010,01,000'),
(8, '00000000-0000-0000-0000-000000062008', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'PAST_EXAM', 2019, '5.5树与二叉树的应用', 'pp.187,189', '【2019 统考真题】对 n 个互不相同的符号进行哈夫曼编码。若生成的哈夫曼树共有 115 个结点，则 n 的值是（ ）。', 'C', 'n 个符号构造成哈夫曼树的过程中，共新建了 n-1 个结点（双分支结点），因此哈夫曼树的结点总数为 2n-1=115，解得 n=58。', 'PLAIN_TEXT', NULL, '56', '57', '58', '60'),
(9, '00000000-0000-0000-0000-000000062009', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'PAST_EXAM', 2021, '5.5树与二叉树的应用', 'pp.187,190', '【2021 统考真题】若某二叉树有 5 个叶结点，其权值分别为 10,12,16,21,30，则其最小的带权路径长度（WPL）是（ ）。', 'B', '对于带权值的结点，构造出哈夫曼树的带权路径长度最小。构造过程可得 WPL=(10+12)*3+(30+16+21)*2=200。', 'PLAIN_TEXT', NULL, '89', '200', '208', '289'),
(10, '00000000-0000-0000-0000-000000062010', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'HARD', 'PAST_EXAM', 2022, '5.5树与二叉树的应用', 'pp.187,190', '【2022 统考真题】对任意给定的含 n（n>2）个字符的有限集 S，用二叉树表示 S 的哈夫曼编码集和定长编码集，分别得到二叉树 T1 和 T2。下列叙述中，正确的是（ ）。', 'D', '可用简单特例说明。满足条件的哈夫曼编码树 T1 与定长编码树 T2 的结点数可能不同，T1 的高度也未必大于 T2，出现频次不同的字符在 T1 中也可能处于相同层。对于定长编码集，所有字符一定在 T2 中处于相同层，而且都是叶结点。', 'PLAIN_TEXT', NULL, 'T1 与 T2 的结点数相同', 'T1 的高度大于 T2 的高度', '出现频次不同的字符在 T1 中处于不同的层', '出现频次不同的字符在 T2 中处于相同的层'),
(11, '00000000-0000-0000-0000-000000062011', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'PAST_EXAM', 2023, '5.5树与二叉树的应用', 'pp.187,190', '【2023 统考真题】在由 6 个字符组成的字符集 S 中，各字符出现的频次分别为 3,4,5,6,8,10，为 S 构造的哈夫曼编码的加权平均长度为（ ）。', 'B', '构建哈夫曼树：合并 3、4 得 7，合并 5、6 得 11，合并 7、8 得 15，合并 10、11 得 21，合并 15、21 得 36。中间结点的哈夫曼编码中共有 4 个长度为 3 的叶结点、2 个长度为 2 的叶结点，因此编码加权平均长度为 [(3+4+5+6)*3+(8+10)*2]/(3+4+5+6+8+10)=2.5。', 'PLAIN_TEXT', NULL, '2.4', '2.5', '2.67', '2.75'),
(12, '00000000-0000-0000-0000-000000062012', 'DS_TREE', 'DS_TREE_HUFFMAN_UNION_FIND', 'MEDIUM', 'PAST_EXAM', 2025, '5.5树与二叉树的应用', 'pp.187,190', '【2025 统考真题】设字符集 S 中包含 7 个字符，各字符出现的频次分别为 2,3,4,6,8,10,11。现为 S 中的各字符构造哈夫曼编码，编码长度不小于 3 的字符数是（ ）。', 'D', '哈夫曼编码的编码长度等于该字符在哈夫曼树中的路径深度。依次合并 2 和 3 得 5，合并 4 和 5 得 9，合并 6 和 8 得 14，合并 9 和 10 得 19，合并 11 和 14 得 25，最后合并 19 和 25 得 44。由树形可知编码长度不小于 3 的字符为 4、2、3、6、8，共 5 个。', 'PLAIN_TEXT', NULL, '2', '3', '4', '5'),
(13, '00000000-0000-0000-0000-000000062013', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', 'MOCK', 2027, '6.1图的基本概念', 'pp.197,199', '一个有 n 个顶点和 n 条边的无向图一定是（ ）。', 'D', '若一个无向图有 n 个顶点和 n-1 条边，可以使它连通但没有环，即生成树；若再加一条边，在不考虑重边的情形下，则必然会构成环。', 'PLAIN_TEXT', NULL, '连通的', '不连通的', '无环的', '有环的'),
(14, '00000000-0000-0000-0000-000000062014', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,199', '若从无向图的任意顶点出发进行一次深度优先搜索即可访问所有顶点，则该图一定是（ ）。', 'B', '对无向连通图做一次深度优先搜索，可以访问到该连通图中的所有顶点。强连通图是有向图概念；有回路的无向图不一定连通；连通图可能是树，也可能存在环。', 'PLAIN_TEXT', NULL, '强连通图', '连通图', '有回路', '一棵树'),
(15, '00000000-0000-0000-0000-000000062015', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,199', '以下关于图的叙述中，正确的是（ ）。', 'C', '图与树的区别是逻辑上的区别，而不是边数的区别；图的边数也可能小于树的边数。若边 E'' 中对应的顶点不是 V'' 的元素，则 V'' 和 E'' 无法构成图。无向图的极大连通子图称为连通分量，C 正确。图的遍历要求每个顶点只能被访问一次，且若图非连通，从某一顶点出发无法访问到其他全部顶点。', 'PLAIN_TEXT', NULL, '图与树的区别在于图的边数大于或等于顶点数', '假设有图 G={V,{E}}，顶点集 V''⊆V，E''⊆E，则 V'' 和 {E''} 构成 G 的子图', '无向图的连通分量是指无向图中的极大连通子图', '图的遍历就是从图中某一顶点出发访遍图中其余顶点'),
(16, '00000000-0000-0000-0000-000000062016', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,199', '以下关于子图的叙述中，正确的是（ ）。', 'C', '强连通有向图中任意顶点到其他所有顶点都有路径，但未必有弧。无向图任意顶点的入度等于出度，但有向图未必满足。有向完全图中任意两个顶点之间都存在方向相反的两条弧，所以一定是强连通有向图。若边集中的某条边对应的某个顶点不在对应的顶点集中，则边集的子集和顶点集的子集无法构成子图。', 'PLAIN_TEXT', NULL, '强连通有向图的任何顶点到其他所有顶点都有弧', '图的任意顶点的入度等于出度', '有向完全图一定是强连通有向图', '有向图的边集的子集和顶点集的子集都构成原有向图的子图'),
(17, '00000000-0000-0000-0000-000000062017', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,199', '一个有 28 条边的非连通无向图至少有（ ）个顶点。', 'C', '考虑该非连通图最极端的情形，即它由一个完全图加一个孤立顶点构成。若完全图有 8 个顶点，则边数为 8*7/2=28；再加上 1 个不连通的顶点，共 9 个顶点。', 'PLAIN_TEXT', NULL, '7', '8', '9', '10'),
(18, '00000000-0000-0000-0000-000000062018', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '对于一个有 n 个顶点的图：若是连通无向图，其边的个数至少为（ ）；若是强连通有向图，则其边的个数至少为（ ）。', 'A', '对于连通无向图，边最少即构成一棵树的情形；对于强连通有向图，边最少即构成一个有向环的情形。', 'PLAIN_TEXT', NULL, 'n-1,n', 'n-1,n(n-1)', 'n,n', 'n,n(n-1)'),
(19, '00000000-0000-0000-0000-000000062019', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '无向图 G 有 23 条边，度为 4 的顶点有 5 个，度为 3 的顶点有 4 个，其余都是度为 2 的顶点，则图 G 有（ ）个顶点。', 'D', '在具有 n 个顶点、e 条边的无向图中，有 ΣTD(vi)=2e。已知总度数为 46，度为 4 的 5 个顶点贡献 20，度为 3 的 4 个顶点贡献 12，剩余度为 2 的顶点贡献 14，因此剩余顶点数为 7，总顶点数为 16。', 'PLAIN_TEXT', NULL, '11', '12', '15', '16'),
(20, '00000000-0000-0000-0000-000000062020', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'BASIC', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '在有 n 个顶点的有向图中，顶点的度最大可达（ ）。', 'D', '在有向图中，顶点的度等于入度与出度之和。n 个顶点的有向图中，任意一个顶点最多还可与其他 n-1 个顶点有一对方向相反的边相连，因此度最大为 2n-2。', 'PLAIN_TEXT', NULL, 'n', 'n-1', '2n', '2n-2'),
(21, '00000000-0000-0000-0000-000000062021', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '具有 6 个顶点的无向图，当有（ ）条边时能确保是一个连通图。', 'D', '5 个顶点构成一个完全无向图需要 5*4/2=10 条边；再加上 1 条边后，能保证第 6 个顶点必然与此完全无向图构成一个连通图，所以共需 11 条边。', 'PLAIN_TEXT', NULL, '8', '9', '10', '11'),
(22, '00000000-0000-0000-0000-000000062022', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '设有无向图 G=(V,E) 和 G''=(V'',E'')，若 G'' 是 G 的生成树，则下列不正确的是（ ）。\nI. G'' 为 G 的连通分量\nII. G'' 为 G 的无环子图\nIII. G'' 为 G 的极小连通子图且 V''=V', 'D', '一个连通图的生成树是极小连通子图，显然它是无环的，因此 II、III 正确。极大连通子图称为连通分量，生成树连通但并非连通分量，所以 I 不正确。', 'PLAIN_TEXT', NULL, 'I、II', '只有 III', 'II、III', '只有 I'),
(23, '00000000-0000-0000-0000-000000062023', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '具有 51 个顶点和 21 条边的无向图的连通分量最多为（ ）。', 'C', '初始考虑只有 51 个顶点的无向图，此时每个顶点都是一个连通分量。要使连通分量数最多，应尽可能把 21 条边加入同一个连通分量并使其接近完全图。含有 7 个顶点的完全图有 21 条边，可用 7 个顶点构成一个含有 21 条边的连通分量，剩下 44 个顶点对应 44 个连通分量，共 45 个连通分量。', 'PLAIN_TEXT', NULL, '33', '34', '45', '32'),
(24, '00000000-0000-0000-0000-000000062024', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '在右图所示的有向图中，共有（ ）个强连通分量。', 'B', '强连通分量是极大强连通子图，任意两个顶点之间有方向相反的两条路径。题图中顶点 B 只有出边，其他所有顶点都不能有到顶点 B 的路径，所以顶点 B 单独构成一个强连通分量。在顶点 A、C、D、E 中，任意两个顶点之间都有方向相反的两条路径，所以可构成一个强连通分量。', 'DIAGRAM', '/question-assets/ds-2027/ch6/q61-q12-directed-graph.png', '1', '2', '3', '4'),
(25, '00000000-0000-0000-0000-000000062025', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '若具有 n 个顶点的图是一个环，则它有（ ）棵生成树。', 'B', 'n 个顶点的生成树具有 n-1 条边的极小连通子图。因为 n 个顶点构成的环共有 n 条边，去掉任意一条边就是一棵生成树，所以共有 n 种情况。', 'PLAIN_TEXT', NULL, 'n²', 'n', 'n-1', '1'),
(26, '00000000-0000-0000-0000-000000062026', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'MOCK', 2027, '6.1图的基本概念', 'pp.198,200', '若一个具有 n 个顶点、e 条边的无向图是一个森林，则该森林中必有（ ）棵树。', 'C', 'n 个顶点的树有 n-1 条边。设森林中有 x 棵树，将每棵树的根连到一个添加的顶点，则成为一棵树，顶点数为 n+1，边数为 e+x，因此 x=n-e。', 'PLAIN_TEXT', NULL, 'n', 'e', 'n-e', '1'),
(27, '00000000-0000-0000-0000-000000062027', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'PAST_EXAM', 2009, '6.1图的基本概念', 'pp.199,200', '【2009 统考真题】下列关于无向连通图特性的叙述中，正确的是（ ）。\nI. 所有顶点的度之和为偶数\nII. 边数大于顶点个数减 1\nIII. 至少有一个顶点的度为 1', 'A', '每条边都连接了两个顶点，在计算顶点的度之和时每条边都被计算了两次，所以所有顶点的度之和为偶数，I 正确。无向连通图对应的生成树也是无向连通图，但此时边数等于顶点数减 1，II 错误。考虑 2 个或以上顶点恰好构成一个环的情况，此时每个顶点的度都为 2，III 错误。', 'PLAIN_TEXT', NULL, '只有 I', '只有 II', 'I 和 II', 'I 和 III'),
(28, '00000000-0000-0000-0000-000000062028', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'MEDIUM', 'PAST_EXAM', 2010, '6.1图的基本概念', 'pp.199,200-201', '【2010 统考真题】若无向图 G=(V,E) 中含有 7 个顶点，要保证图 G 在任何情况下都是连通的，则需要的边数最少是（ ）。', 'C', '题干要求无论如何分配边都能使 7 个顶点连通。最极端情形是某 6 个顶点构成一个完全无向图，此时若再添加一条边，则都会连接第 7 个顶点，使该图变成连通图。因此最少边数为 6*5/2+1=16。', 'PLAIN_TEXT', NULL, '6', '15', '16', '21'),
(29, '00000000-0000-0000-0000-000000062029', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'HARD', 'PAST_EXAM', 2017, '6.1图的基本概念', 'pp.199,201', '【2017 统考真题】已知无向图 G 含有 16 条边，其中度为 4 的顶点个数为 3，度为 3 的顶点个数为 4，其他顶点的度均小于 3。图 G 所含的顶点数至少是（ ）。', 'B', '无向图边数的 2 倍等于各顶点度数的总和。要求至少的顶点数，应使每个顶点的度取最大，而其他顶点的度均小于 3，因此可设它们的度都为 2，并设数量为 x，列方程 4*3+3*4+2x=16*2，解得 x=4。因此至少包含 3+4+4=11 个顶点。', 'PLAIN_TEXT', NULL, '10', '11', '13', '15'),
(30, '00000000-0000-0000-0000-000000062030', 'DS_GRAPH', 'DS_GRAPH_TRAVERSAL', 'HARD', 'PAST_EXAM', 2022, '6.1图的基本概念', 'pp.199,201', '【2022 统考真题】对于无向图 G=(V,E)，下列选项中，正确的是（ ）。', 'D', '这类题分析图的边数、顶点数与连通性时，应寻找临界情况。当 |E|<|V|-1 时，图一定不连通，所以选项 C 错误，选项 D 正确。若增加任意一条边即可从不连通变为连通，则无向图不连通的最大边数为 (|V|-1)(|V|-2)/2；只有当 |E|≥(|V|-1)(|V|-2)/2+1 时才能保证无向图一定连通，因此 A、B 错误。', 'PLAIN_TEXT', NULL, '当 |V|>|E| 时，G 一定是连通的', '当 |V|<|E| 时，G 一定是连通的', '当 |V|=|E|-1 时，G 一定是不连通的', '当 |V|>|E|+1 时，G 一定是不连通的');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 5 章 5.5.3/5.5.4 与第 6 章 6.1.2/6.1.3 本节试题精选及答案解析，参考页：' || q.source_pages || '。',
    q.stem_format,
    q.stem_image_url,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch5j_ch6a_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000162', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch5j_ch6a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000162', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch5j_ch6a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000162', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch5j_ch6a_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000162', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch5j_ch6a_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch5j_ch6a_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000062701', 'DS-2027-ORIGINAL-CH5-J-CH6-A'),
    ('00000000-0000-0000-0000-000000062702', '5.5树与二叉树的应用'),
    ('00000000-0000-0000-0000-000000062703', '第6章图'),
    ('00000000-0000-0000-0000-000000062704', '6.1图的基本概念')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch5j_ch6a_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH5-J-CH6-A',
    q.section_tag,
    '授权原题',
    '本节试题精选',
    '原答案解析',
    '选择题扩容'
) OR (q.chapter_code = 'DS_TREE' AND tag.name = '第5章树与二叉树')
   OR (q.chapter_code = 'DS_GRAPH' AND tag.name = '第6章图')
   OR (q.source_type = 'PAST_EXAM' AND tag.name = '真题')
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations existing
    WHERE existing.question_id = CAST(q.id AS UUID)
      AND existing.tag_id = tag.id
);

DROP TABLE ds_2027_original_ch5j_ch6a_import;
