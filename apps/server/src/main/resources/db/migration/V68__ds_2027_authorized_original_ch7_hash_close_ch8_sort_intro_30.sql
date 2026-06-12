-- Authorized original data-structure single-choice import based on:
-- /Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf
-- Chapter 7 hash close and chapter 8 sort intro, text-only batch.
-- Batch: DS-2027-ORIGINAL-CH7-D-CH8-A-TEXT-ONLY

CREATE TABLE ds_2027_original_ch7_d_ch8_a_text_import (
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
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO ds_2027_original_ch7_d_ch8_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000068001', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2020, '7.4B树和B+树', 'pp.311,314', '【2020 统考真题】依次将关键字 5,6,9,13,8,2,12,15 插入初始为空的 4 阶 B 树后，根结点中包含的关键字是（ ）。', 'B', '4 阶 B 树任意非叶结点至多含有 3 个关键字，插入过程中结点不断分裂。按顺序插入后，根结点包含的关键字为 6、9。', '8', '6,9', '8,13', '9,12'),
(2, '00000000-0000-0000-0000-000000068002', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2021, '7.4B树和B+树', 'pp.311,315', '【2021 统考真题】在一棵高度为 3 的 3 阶 B 树中，根为第 1 层，若第 2 层中有 4 个关键字，则该树的结点数最多是（ ）。', 'A', '3 阶 B 树每个结点至多含 2 个关键字。第 2 层 4 个关键字要让结点数最多，应分布在 3 个结点中，此时整棵树最多有 11 个结点。', '11', '10', '9', '8'),
(3, '00000000-0000-0000-0000-000000068003', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2023, '7.4B树和B+树', 'pp.311,315', '【2023 统考真题】下列关于非空 B 树的叙述中，正确的是（ ）。\nI. 插入操作可能增加树的高度\nII. 删除操作一定会导致叶结点的变化\nIII. 查找某关键字总是要查找到叶结点\nIV. 插入的新关键字最终位于叶结点中', 'B', 'B 树插入可能因根分裂而增高，I 正确。删除会最终转化为删除叶层关键字，II 正确。B 树查找可能在非叶结点成功，III 错误；插入初始位置在底层叶结点，但可能因分裂上移，IV 错误。', '仅 I', '仅 I、II', '仅 III、IV', '仅 I、II、IV'),
(4, '00000000-0000-0000-0000-000000068004', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2025, '7.4B树和B+树', 'pp.311,315', '【2025 统考真题】给定 7 个不同的关键字，能构造的不同 4 阶 B 树的个数最多是（ ）。', 'C', '对 4 阶 B 树按树高分类计数：树高为 2 时可得 8 种，树高为 3 时可得 1 种，合计最多 9 种不同的 4 阶 B 树。', '7', '8', '9', '10'),
(5, '00000000-0000-0000-0000-000000068005', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'BASIC', 'MOCK', 2027, '7.5散列表', 'pp.321,324', '只能在顺序存储结构上进行的查找方法是（ ）。', 'B', '折半查找要求表中关键字有序且支持随机访问，因此只能用于顺序存储结构；顺序查找、树形查找和散列查找不具备这一限制。', '顺序查找法', '折半查找法', '树形查找法', '散列查找法'),
(6, '00000000-0000-0000-0000-000000068006', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'BASIC', 'MOCK', 2027, '7.5散列表', 'pp.321,324', '散列查找一般适用于（ ）的情况下的查找。', 'D', '散列查找通过散列函数表示关键字集合与地址集合之间的对应关系，查找时以计算散列地址为主。', '查找表为链表', '查找表为有序表', '关键字集合比地址集合大得多', '关键字集合与地址集合之间存在对应关系'),
(7, '00000000-0000-0000-0000-000000068007', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,324', '下列关于散列表的说法中，正确的是（ ）。\nI. 若散列表的填装因子 α<1，则可避免碰撞的产生\nII. 散列查找中不需要任何关键字的比较\nIII. 散列表在查找成功时平均查找长度仅与表长有关\nIV. 若在散列表中删除一个元素，不能简单地将该元素删除', 'D', '冲突不可避免，与装填因子无直接必然关系；散列查找仍需比较关键字确认是否查找成功；平均查找长度与装填因子等因素有关。开放定址法下删除元素不能直接物理删除，IV 正确。', 'I 和 IV', 'II 和 III', 'III', 'IV'),
(8, '00000000-0000-0000-0000-000000068008', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,324', '在开放定址法中散列到同一个地址而引起的“堆积”问题是由（ ）引起的。', 'C', '开放定址法中，同义词和非同义词的探查序列可能交织在一起，导致关键字需要经过较长探测距离，即产生堆积。', '同义词之间发生冲突', '非同义词之间发生冲突', '同义词之间或非同义词之间发生冲突', '散列表“溢出”'),
(9, '00000000-0000-0000-0000-000000068009', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,324', '下列关于散列冲突处理方法的说法中，正确的有（ ）。\nI. 采用平方探测法处理冲突时不易产生聚集\nII. 采用线性探测法处理冲突时，所有同义词在散列表中一定相邻\nIII. 采用链地址法处理冲突时，若限定在链首插入，则插入任意一个元素的时间相同\nIV. 采用链地址法处理冲突易引起聚集现象', 'A', '平方探测法采用非线性增量，可减少聚集；链地址法在链首插入时时间相同。线性探测法并不能保证所有同义词相邻；链地址法不会引起开放定址法中的聚集。', 'I 和 III', 'I、II 和 III', 'III 和 IV', 'I 和 IV'),
(10, '00000000-0000-0000-0000-000000068010', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,324', '设有一个含有 200 个元素的散列表，用线性探测法解决冲突，按关键字查询时找到一个表项的平均探测次数不超过 1.5，则散列表应至少能够容纳（ ）个元素。（设查找成功的平均查找长度为 ASL=[1+1/(1-α)]/2，其中 α 为装填因子）', 'A', '由 ASL<=1.5 可得 [1+1/(1-α)]/2<=1.5，即 α<=1/2。α=200/m，因此 m>=400。', '400', '526', '624', '676'),
(11, '00000000-0000-0000-0000-000000068011', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,325', '假定有 K 个关键字互为同义词，若用线性探测法把这 K 个关键字填入散列表，至少要进行（ ）次探测。', 'D', 'K 个互为同义词的关键字依次填入时，只有第一个不发生冲突，探测次数至少为 1+2+...+K=K(K+1)/2。', 'K-1', 'K', 'K+1', 'K(K+1)/2'),
(12, '00000000-0000-0000-0000-000000068012', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,325', '对包含 n 个元素的散列表进行查找，平均查找长度（ ）。', 'C', '散列表的平均查找长度与装填因子直接相关，查找效率不直接依赖于 n 或表长 m；若表中元素都是某个地址的同义词，平均查找长度也可能达到 O(n)。', '为 O(log2n)', '为 O(1)', '不直接依赖于 n', '直接依赖于表长 m'),
(13, '00000000-0000-0000-0000-000000068013', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,325', '采用开放定址法解决冲突的散列查找中，发生聚集的原因主要是（ ）。', 'D', '聚集是因为选取不当的处理冲突方法，导致不同关键字的元素对同一散列地址进行争夺。线性探查法容易引发聚集现象。', '数据元素过多', '负载因子过大', '散列函数选择不当', '解决冲突的方法选择不当'),
(14, '00000000-0000-0000-0000-000000068014', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.321,325', '当用线性探测再散列法解决冲突时，计算出的一系列“下一个空位”的要求是（ ）。', 'C', '线性探测得到的下一个空位可以大于或小于原散列地址，但等于原散列地址没有意义。', '必须大于或等于原散列地址', '必须小于或等于原散列地址', '可以大于或小于但不等于原散列地址', '对地址在何处没有限制'),
(15, '00000000-0000-0000-0000-000000068015', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.322,325', '一组记录的关键字为 {19,14,23,1,68,20,84,27,55,11,10,79}，用链地址法构造散列表，散列函数为 H(key)=key mod 13，散列地址为 1 的链中有（ ）个记录。', 'D', '14、1、27、79 散列后的地址均为 1，因此地址 1 的链中共有 4 个记录。', '1', '2', '3', '4'),
(16, '00000000-0000-0000-0000-000000068016', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.322,325', '在采用链地址法处理冲突所构成的散列表上查找某一关键字，则在查找成功的情况下，所探测的这些位置上的关键字值（ ）；若采用线性探测法，则（ ）。', 'A', '链地址法中映射到同一地址的关键字都在对应链表上，因此探测位置上的关键字均为同义词；线性探测中，同义关键字可能占用后续地址，因此不一定都是同义词。本题原题为两空，已改为组合选项。', '链地址法：一定都是同义词；线性探测法：不一定都是同义词', '链地址法：不一定都是同义词；线性探测法：一定都是同义词', '链地址法：都相同；线性探测法：一定都是同义词', '链地址法：一定都不是同义词；线性探测法：一定都不是同义词'),
(17, '00000000-0000-0000-0000-000000068017', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.322,325', '若采用链地址法构造散列表，散列函数为 H(key)=key mod 17，则需（①）个链表。这些链的链首指针构成一个指针数组，数组的下标范围为（②）。', 'A', 'H(key)=key mod 17 的取值共有 17 种，对应 17 个链表；散列地址范围为 0 到 16。本题原题为两空，已改为组合选项。', '17；0~16', '17；1~17', '13；0~16', '任意；1~16'),
(18, '00000000-0000-0000-0000-000000068018', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.322,325', '设散列表长 m=14，散列函数为 H(key)=key%11，表中仅有 4 个结点，H(15)=4，H(38)=5，H(61)=6，H(84)=7。若采用线性探测法处理冲突，则关键字为 49 的结点地址是（ ）。', 'A', 'H(49)=49%11=5，地址 5、6、7 已有结点，继续线性探测到地址 8 时无冲突，因此关键字 49 的结点地址为 8。', '8', '3', '5', '9'),
(19, '00000000-0000-0000-0000-000000068019', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.322,325', '现有长度为 17、初始为空的散列表 HT，散列函数 H(key)=key%17，用线性探查法解决冲突。将关键字序列 26,25,72,38,8,18,59 依次插入 HT 后，查找 59 需探查（ ）次。', 'C', '依次插入后，59 的初始地址为 8，发生冲突后继续探测，最终存放在地址 11；查找时需依次探查 8、9、10、11，共 4 次。', '2', '3', '4', '5'),
(20, '00000000-0000-0000-0000-000000068020', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'MOCK', 2027, '7.5散列表', 'pp.322,325', '现有长度为 17、初始为空的散列表 HT，散列函数 H(key)=key%17，用平方探测法解决冲突：Hi(key)=(H(key)±i^2)%17。将关键字序列 6,22,7,26,9,23 依次插入 HT 后，则关键字 23 存放在散列表中的位置是（ ）。', 'B', '23%17=6，按平方探测序列依次探测 7、5、10、2，最终关键字 23 存放在地址 2。', '0', '2', '6', '15'),
(21, '00000000-0000-0000-0000-000000068021', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'BASIC', 'MOCK', 2027, '7.5散列表', 'pp.322,325', '将 10 个元素散列到 100000 个单元的散列表中，则（ ）产生冲突。', 'C', '散列函数的选择仍可能把不同关键字映射到同一地址，因此冲突不能绝对避免，仍然有可能产生冲突。', '一定会', '一定不会', '仍可能会', '不确定'),
(22, '00000000-0000-0000-0000-000000068022', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2011, '7.5散列表', 'pp.322,325-326', '【2011 统考真题】为提高散列表的查找效率，可以采取的正确措施是（ ）。\nI. 增大装填（载）因子\nII. 设计冲突（碰撞）少的散列函数\nIII. 处理冲突（碰撞）时避免产生聚集（堆积）现象', 'D', '散列表的查找效率取决于散列函数、处理冲突的方法和装填因子。增大装填因子会降低效率，设计冲突少的散列函数并避免聚集可提高效率。', '仅 I', '仅 II', '仅 I、II', '仅 II、III'),
(23, '00000000-0000-0000-0000-000000068023', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2014, '7.5散列表', 'pp.322,326', '【2014 统考真题】用哈希（散列）方法处理冲突（碰撞）时可能出现堆积（聚集）现象，下列选项中，会受堆积现象直接影响的是（ ）。', 'D', '堆积现象因冲突而产生，会使平均查找长度随堆积增加而增大；它对存储效率、散列函数和装填因子本身没有直接影响。', '存储效率', '散列函数', '装填（装载）因子', '平均查找长度'),
(24, '00000000-0000-0000-0000-000000068024', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2018, '7.5散列表', 'pp.322,326', '【2018 统考真题】现有长度为 7、初始为空的散列表 HT，散列函数 H(k)=k%7，用线性探测再散列法解决冲突。将关键字 22,43,15 依次插入 HT 后，查找成功的平均查找长度是（ ）。', 'C', '22、43、15 依次插入后分别需要 1、2、3 次比较才能查找成功，因此 ASL=(1+2+3)/3=2。', '1.5', '1.6', '2', '3'),
(25, '00000000-0000-0000-0000-000000068025', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2019, '7.5散列表', 'pp.322,326', '【2019 统考真题】现有长度为 11 且初始为空的散列表 HT，散列函数是 H(key)=key%7，采用线性探查（线性探测再散列）法解决冲突。将关键字序列 87,40,30,6,11,22,98,20 依次插入 HT 后，HT 查找失败的平均查找长度是（ ）。', 'C', '按线性探查插入后，查找失败时需对散列函数可产生的地址 0 到 6 分别计算失败比较次数，平均值为 6。', '4', '5.25', '6', '6.29'),
(26, '00000000-0000-0000-0000-000000068026', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2022, '7.5散列表', 'pp.322-323,326', '【2022 统考真题】下列因素中，影响散列（哈希）方法平均查找长度的是（ ）。\nI. 装填因子\nII. 散列函数\nIII. 冲突解决策略', 'D', '装填因子越大冲突概率通常越高；散列函数和冲突解决策略也会影响冲突分布，因此三者都会影响平均查找长度。', '仅 I、II', '仅 I、III', '仅 II、III', 'I、II、III'),
(27, '00000000-0000-0000-0000-000000068027', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2023, '7.5散列表', 'pp.323,326', '【2023 统考真题】现有长度为 5、初始为空的散列表 HT，散列函数 H(k)=(k+4)%5，用线性探查再散列法解决冲突。若将关键字序列 2022,12,25 依次插入 HT，然后删除关键字 25，则 HT 中查找失败的平均查找长度为（ ）。', 'C', '开放定址法删除元素时应做删除标记。依次插入并删除 25 后，查找失败的比较次数为 1、3、2、1、2，平均为 1.8。', '1', '1.6', '1.8', '2.2'),
(28, '00000000-0000-0000-0000-000000068028', 'DS_SEARCH', 'DS_SEARCH_TREE_HASH', 'MEDIUM', 'PAST_EXAM', 2025, '7.5散列表', 'pp.323,326-327', '【2025 统考真题】下列关于散列方法处理冲突的叙述中，正确的是（ ）。', 'A', '线性探查法按顺序依次探查下一个地址，只要散列表未满，总能找到一个空闲位置。二次探查法即使表未满，也可能无法遍历所有位置。', '只要散列表不满，线性探查再散列一定能找到一个空闲位置', '只要散列表不满，二次探查再散列一定能找到一个空闲位置', '线性探查再散列处理的冲突，一定是发生在同义词之间的冲突', '二次探查再散列处理的冲突，一定发生在非同义词之间的冲突'),
(29, '00000000-0000-0000-0000-000000068029', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', 'MOCK', 2027, '8.1排序的基本概念', 'pp.332', '下述排序算法中，不属于内部排序算法的是（ ）。', 'C', '拓扑排序是将有向图中的所有结点排成一个线性序列，虽然在内存中进行，但不属于本章讨论的内部排序算法范畴。', '插入排序', '选择排序', '拓扑排序', '冒泡排序'),
(30, '00000000-0000-0000-0000-000000068030', 'DS_SORT', 'DS_SORT_INTERNAL_EXTERNAL', 'BASIC', 'MOCK', 2027, '8.1排序的基本概念', 'pp.332-333', '排序算法的稳定性是指（ ）。', 'A', '稳定性是指排序前关键字相同的元素，排序后仍保持原序列中的相对位置不变。注意这里强调相对位置，而不是绝对位置。', '经过排序后，能使关键字相同的元素保持原顺序中的相对位置不变', '经过排序后，能使关键字相同的元素保持原顺序中的绝对位置不变', '排序算法的性能与被排序元素个数关系不大', '排序算法的性能与被排序元素的个数关系密切');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027数据结构_高清带书签版.pdf，第 7 章 7.4.3/7.4.4、7.5.5/7.5.6 与第 8 章 8.1.2/8.1.3 本节试题精选及答案解析；本批按用户要求跳过需要题图/选项图的题目，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM ds_2027_original_ch7_d_ch8_a_text_import q
JOIN subjects s ON s.code = 'DATA_STRUCTURE'
JOIN chapters c ON c.code = q.chapter_code;

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000168', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM ds_2027_original_ch7_d_ch8_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000168', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM ds_2027_original_ch7_d_ch8_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000168', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM ds_2027_original_ch7_d_ch8_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000168', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM ds_2027_original_ch7_d_ch8_a_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM ds_2027_original_ch7_d_ch8_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000068701', 'DS-2027-ORIGINAL-CH7-D-CH8-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000068702', '7.5散列表'),
    ('00000000-0000-0000-0000-000000068703', '第8章排序'),
    ('00000000-0000-0000-0000-000000068704', '8.1排序的基本概念')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM ds_2027_original_ch7_d_ch8_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027数据结构',
    'DS-2027-ORIGINAL-CH7-D-CH8-A-TEXT-ONLY',
    '第7章查找',
    '第8章排序',
    q.section_tag,
    '无图片题目',
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

DROP TABLE ds_2027_original_ch7_d_ch8_a_text_import;
