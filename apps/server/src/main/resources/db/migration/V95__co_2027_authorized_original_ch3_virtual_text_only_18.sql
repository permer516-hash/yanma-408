-- Authorized original computer-organization single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf
-- Chapter 3: 3.6 虚拟存储器 (Q1-Q20, pure text only).
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Deferred in this section: Q13 (TLB content table), Q17 (page table content).
-- Batch: CO-2027-ORIGINAL-CH3-F-TEXT-ONLY

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000095301',
    c.id,
    'CO_CACHE_VIRTUAL',
    '虚拟存储器',
    6
FROM chapters c
WHERE c.code = 'CO_CACHE'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CO_CACHE_VIRTUAL');

CREATE TABLE co_2027_original_ch3_f_text_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    kp_code VARCHAR(96) NOT NULL,
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

INSERT INTO co_2027_original_ch3_f_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 3.6 虚拟存储器 Q1-Q12 (模拟题), Q14-Q16 (真题), Q18-Q20 (真题)
-- Q13 (TLB表) 和 Q17 (页表) 因依赖表格暂不导入
-- ============================================================
(1, '00000000-0000-0000-0000-000000095001', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.135,142',
 '为使虚拟存储系统有效地发挥其预期的作用，所运行程序应具有的特性是（ ）。',
 'C',
 '虚拟存储系统利用的是局部性原理，程序应当具有较好的局部性，选项C正确。而含有输入、输出操作产生中断，与虚拟存储器无关，选项A错误。大小较小但可以多个程序并发执行，也可以发挥虚拟存储器的作用，选项B错误。顺序执行的指令应当占较大比重为宜，这样可增强程序的局部性，选项D错误。',
 '不应含有过多的I/O操作', '大小不应小于实际的内存容量', '应具有较好的局部性', '顺序执行的指令不应过多'),

(2, '00000000-0000-0000-0000-000000095002', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.135,142',
 '虚拟存储管理系统的基础是程序访问的局部性原理，此理论的基本含义是（ ）。',
 'A',
 '局部性原理的含义是在一个程序的执行过程中，其大部分情况下是顺序执行的，某条指令或数据使用后，在最近一段时间内有较大的可能再次被访问（时间局部性）；某条指令或数据使用后，其邻近的指令或数据可能在近期被使用（空间局部性）。在虚拟存储管理系统中，程序只能访问主存获得指令和数据，选项A正确。选项B、C、D均是局部性原理的一个方面而已。',
 '在程序的执行过程中，程序对主存的访问是不均匀的', '空间局部性', '时间局部性', '代码的顺序执行'),

(3, '00000000-0000-0000-0000-000000095003', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.135,142',
 '虚拟存储器的常用管理方式有段式、页式和段页式，关于它们在与主存交换信息时的单位，以下表述正确的是（ ）。',
 'D',
 '页式虚拟存储方式对程序分页，采用页进行交互；段页式则先按照逻辑分段，然后分页，以页为单位和主存交互，选项D正确。',
 '段式采用"页"', '页式采用"块"', '段页式采用"段"和"页"', '页式和段页式均仅采用"页"'),

(4, '00000000-0000-0000-0000-000000095004', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.135,142',
 '下列关于虚拟存储器的叙述中，正确的是（ ）。',
 'A',
 '虚拟存储器需要通过操作系统实现地址映射，因此对操作系统的设计者即系统程序员是不透明的。而应用程序员写的程序所使用的是逻辑地址（虚地址），因此对其是透明的。',
 '对应用程序员透明，对系统程序员不透明', '对应用程序员不透明，对系统程序员透明', '对应用程序员、系统程序员都不透明', '对应用程序员、系统程序员都透明'),

(5, '00000000-0000-0000-0000-000000095005', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.135,142',
 '在虚拟存储器中，当程序正在执行时，由（ ）完成地址映射。',
 'D',
 '虚拟存储器中，地址映射由操作系统来完成，但需要一部分硬件基础的支持，如快表、地址映射系统等。',
 '程序员', '编译器', '装入程序', '操作系统'),

(6, '00000000-0000-0000-0000-000000095006', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.135,142',
 '采用虚拟存储器的主要目的是（ ）。',
 'B',
 '引入虚拟存储器的目的是解决内存容量不够大的问题。',
 '提高主存储器的存取速度', '扩大主存储器的存储空间', '提高外存储器的存取速度', '扩大外存储器的存储空间'),

(7, '00000000-0000-0000-0000-000000095007', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.135,142',
 '下列有关虚拟存储管理机制中地址转换的叙述，错误的是（ ）。',
 'B',
 '虚拟存储管理的目的是让程序员可以在一个比主存地址空间大得多的虚拟地址空间中编程，显然逻辑地址空间比主存空间大，因此逻辑地址的位数比物理地址的位数多，选项B错误。在执行程序时，由CPU中的MMU进行逻辑地址到物理地址的转换。在转换过程中，MMU需要查找对应的页表项，根据页表项中的装入（有效）位是否为1来确定是否发生缺页。',
 '地址转换是指把逻辑地址转换为物理地址', '通常逻辑地址的位数比物理地址的位数少', '地址转换过程中会发现是否"缺页"', '内存管理单元（MMU）在地址转换过程中要访问页表项'),

(8, '00000000-0000-0000-0000-000000095008', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.136,142',
 '下列有关虚拟存储管理机制的页表的叙述中，错误的是（ ）。',
 'D',
 '选项A、B和C都正确。页表中的每个表项反映的是对应虚拟页面的位置和使用等信息，通常只能由操作系统和硬件进行访问，虚拟存储管理机制对用户进程来说是透明的，选项D错误。',
 '系统中每个进程有一个页表', '页表中每个表项与一个虚页对应', '每个页表项中都包含装入位（有效位）', '所有进程都可以访问页表'),

(9, '00000000-0000-0000-0000-000000095009', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.136,142',
 '下列有关缺页处理的叙述中，错误的是（ ）。',
 'B',
 '缺页是CPU在执行指令过程中进行取指令或读/写数据时发生的一种故障，属于内部异常。',
 '若对应页表项中的有效位为0，则发生缺页', '缺页是一种外部中断，需要调用操作系统提供的中断服务程序来处理', '缺页处理过程中需根据页表中给出的磁盘地址去读磁盘数据', '缺页处理完后要重新执行发生缺页的指令'),

(10, '00000000-0000-0000-0000-000000095010', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.136,142',
 '下列关于段式虚拟存储管理的叙述中，错误的是（ ）。',
 'D',
 '选项A、B和C都正确。分段方式对低级语言程序员和编译器来说是不透明的，因为低级语言程序员需要使用段号来编程，编译器需要使用段号来链接，选项D错误。',
 '段是逻辑结构上相对独立的程序块，因此段是可变长的', '按程序中实际的段来分配主存，所以分配后的存储块是可变长的', '每个段表项必须记录对应段在主存的起始位置和段的长度', '分段方式对低级语言程序员和编译器来说是透明的'),

(11, '00000000-0000-0000-0000-000000095011', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'BASIC', 'MOCK', 2027, '3.6虚拟存储器', 'pp.136,142',
 '虚拟存储器中的页表有快表和慢表之分，下面关于页表的叙述中正确的是（ ）。',
 'D',
 '快表采用高速相联存储器，它的速度快来源于硬件本身，而不是依赖搜索算法来查找的；慢表存储在内存中，通常是依赖于查找算法，所以选项A和B错误。快表与慢表的命中率没有必然联系，快表仅是慢表的一个部分拷贝，不能够得到比慢表更多的结果，选项C错误。',
 '快表与慢表都存储在主存中，但快表比慢表容量小', '快表采用了优化的搜索算法，因此查找速度快', '快表比慢表的命中率高，因此快表可以得到更多的搜索结果', '快表采用相联存储器件组成了按照查找内容访问，因此比慢表查找速度快'),

(12, '00000000-0000-0000-0000-000000095012', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'MEDIUM', 'PAST_EXAM', 2010, '3.6虚拟存储器', 'pp.136,142',
 '【2010统考真题】下列命令组合的一次访存过程中，不可能发生的是（ ）。',
 'D',
 'Cache的内容是主存的一部分副本，TLB的内容是Page（页表）的一部分副本。在同时具有TLB和Cache的虚拟存储系统中，CPU发出访存命令，先查找对应的Cache块。1）若Cache命中，则说明所需内容在Cache内，其所在页面必然已调入主存，因此Page必然命中，但TLB不一定命中。2）若Cache未命中，则并不能说明所需内容未调入主存，和TLB、Page命中与否没有联系。但若TLB命中，Page也必然命中；而当Page命中，TLB则未必命中，因此D不可能发生。',
 'TLB未命中，Cache未命中，Page未命中', 'TLB未命中，Cache命中，Page命中', 'TLB命中，Cache未命中，Page命中', 'TLB命中，Cache命中，Page未命中'),

(14, '00000000-0000-0000-0000-000000095014', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'MEDIUM', 'PAST_EXAM', 2015, '3.6虚拟存储器', 'pp.136,142',
 '【2015统考真题】假定编译器将赋值语句"x=x+3;"转换为指令"add xaddr, 3"，其中xaddr是x对应的存储单元地址。若执行该指令的计算机采用页式虚拟存储管理方式，并配有相应的TLB，且Cache使用直写方式，则完成该指令功能需要访问主存的次数至少是（ ）。',
 'B',
 '上述指令的执行过程可划分为取数、运算和写回过程，取数时读取xaddr可能不需要访问主存而直接访问Cache，而直写方式需要把数据同时写入Cache和主存，因此至少访问1次。',
 '0', '1', '2', '3'),

(15, '00000000-0000-0000-0000-000000095015', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'MEDIUM', 'PAST_EXAM', 2019, '3.6虚拟存储器', 'pp.136,142',
 '【2019统考真题】下列关于缺页处理的叙述中，错误的是（ ）。',
 'D',
 '在请求分页系统中，每当要访问的页面不在内存中时，CPU检测到异常，便会产生缺页中断，请求操作系统将所缺的页调入内存。缺页处理由缺页中断处理程序完成，根据发生缺页故障的地址从外存读入所缺失的页，缺页处理完成后回到发生缺页的指令继续执行。选项D中描述回到发生缺页的指令的下一条指令执行，明显错误。',
 '缺页是在地址转换时CPU检测到的一种异常', '缺页处理由操作系统提供的缺页处理程序来完成', '缺页处理程序根据页故障地址从外存读入所缺失的页', '缺页处理完成后回到发生缺页的指令的下一条指令执行'),

(16, '00000000-0000-0000-0000-000000095016', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'MEDIUM', 'PAST_EXAM', 2020, '3.6虚拟存储器', 'pp.137,143',
 '【2020统考真题】下列关于TLB和Cache的叙述中，错误的是（ ）。',
 'D',
 'Cache由SRAM组成；TLB也由SRAM组成。DRAM需要不断刷新，性能偏低，不适合组成TLB和Cache。选项A、B和C都是TLB和Cache的特点。',
 '命中率都与程序局部性有关', '缺失后都需要去访问主存', '缺失处理都可以由硬件实现', '都由DRAM存储器组成'),

(18, '00000000-0000-0000-0000-000000095018', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'MEDIUM', 'PAST_EXAM', 2024, '3.6虚拟存储器', 'pp.137,143',
 '【2024统考真题】对于页式虚拟存储管理系统，下列关于存储器层次结构的叙述中，错误的是（ ）。',
 'D',
 'Cache与主存之间交换的是主存块，主存与外存之间交换的是页。Cache-主存层次和主存-外存层次的区别在于前者主要解决速度不匹配问题，用软件实现会影响速度，因此Cache-主存层次替换算法由硬件实现；而主存-外存层次替换算法由软件实现。Cache-主存层次可采用回写法或全写法；主存-外存层次通常采用回写法。访问外存的代价很大，提高命中率是关键，因此主存-外存层次通常采用全相联映射；而Cache-主存层次可采用直接映射、组相联或全相联，选项D错误。',
 'Cache-主存层次的交换单位为主存块，主存-外存层次的交换单位为页', 'Cache-主存层次替换算法由硬件实现，主存-外存层次替换算法由软件实现', 'Cache-主存层次可采用回写法，主存-外存层次通常采用回写法', 'Cache-主存层次可采用直接映射方式，主存-外存层次通常采用直接映射方式'),

(19, '00000000-0000-0000-0000-000000095019', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'MEDIUM', 'PAST_EXAM', 2024, '3.6虚拟存储器', 'pp.137,143',
 '【2024统考真题】某计算机按字节编址，采用页式虚拟存储管理方式，虚拟地址为32位，主存地址为30位，页大小为1KB。若TLB共有32个表项，采用4路组相联映射方式，则TLB表项中标记字段的位数至少是（ ）。',
 'C',
 '按字节编址，页大小为2^10B，因此页内地址占10位；TLB有32个表项，采用4路组相联映射，被分为2^3=8组，因此TLB组号占3位；于是，标记字段的位数至少是32-3-10=19。',
 '17', '18', '19', '20'),

(20, '00000000-0000-0000-0000-000000095020', 'CO_CACHE', 'CO_CACHE_VIRTUAL', 'MEDIUM', 'PAST_EXAM', 2024, '3.6虚拟存储器', 'pp.137,144',
 '【2024统考真题】下列事件中，不是在MMU地址转换过程中检测的是（ ）。',
 'B',
 '在地址转换的过程中，MMU会检查页表项的访问权限，以确保进程有权访问某个页面，否则就会访问越权。为了获得对应的页表项，先查找TLB，若找不到，则TLB缺失，然后查找页表，若找不到，则页面缺失。访问Cache是在获得物理地址后使用物理地址存取数据的过程中才执行的操作，而MMU地址转换过程是在获得物理地址之前进行的，选项B错误。',
 '访问越权', 'Cache缺失', '页面缺失', 'TLB缺失');

-- ============================================================
-- Insert into questions
-- ============================================================
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
    '授权原题导入：/Users/permer/Documents/408资料/2027计算机组成原理_高清带书签版.pdf，第 3 章 3.6 虚拟存储器本节试题精选及答案解析；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM co_2027_original_ch3_f_text_import q
JOIN subjects s ON s.code = 'COMPUTER_ORGANIZATION'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000195', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM co_2027_original_ch3_f_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000195', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM co_2027_original_ch3_f_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000195', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM co_2027_original_ch3_f_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000195', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM co_2027_original_ch3_f_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM co_2027_original_ch3_f_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new section tag exists
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000095701', 'CO-2027-ORIGINAL-CH3-F-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000095702', '3.6虚拟存储器')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM co_2027_original_ch3_f_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机组成原理',
    'CO-2027-ORIGINAL-CH3-F-TEXT-ONLY',
    '第3章存储系统',
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

-- ============================================================
-- Cleanup
-- ============================================================
DROP TABLE co_2027_original_ch3_f_text_import;
