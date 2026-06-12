-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 3: 数据链路层 (3.1 功能 + 3.2 组帧 + 3.3 差错控制 + 3.4 流量控制与可靠传输机制, first batch).
-- Text-only batch: 30 pure-text questions (6 from 3.1, 1 from 3.2, 9 from 3.3, 14 from 3.4).
-- Deferred: None in this batch.
-- Batch: CN-2027-ORIGINAL-CH3-A-TEXT-ONLY

-- ============================================================
-- Ensure chapter exists (CN_DATA_LINK from V18)
-- ============================================================
INSERT INTO chapters (id, subject_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000018214',
    s.id,
    'CN_DATA_LINK',
    '数据链路层',
    23
FROM subjects s
WHERE s.code = 'COMPUTER_NETWORK'
  AND NOT EXISTS (SELECT 1 FROM chapters c WHERE c.code = 'CN_DATA_LINK');

-- ============================================================
-- Ensure knowledge points exist
-- ============================================================
-- CN_DATA_LINK_PROTOCOL (差错控制与介质访问) already exists from V18

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000129301',
    c.id,
    'CN_DATA_LINK_FUNC',
    '数据链路层功能',
    1
FROM chapters c
WHERE c.code = 'CN_DATA_LINK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_DATA_LINK_FUNC');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000129302',
    c.id,
    'CN_FRAMING',
    '组帧',
    2
FROM chapters c
WHERE c.code = 'CN_DATA_LINK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_FRAMING');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000129303',
    c.id,
    'CN_FLOW_CONTROL',
    '流量控制与可靠传输机制',
    4
FROM chapters c
WHERE c.code = 'CN_DATA_LINK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_FLOW_CONTROL');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch3_a_text_import (
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

INSERT INTO cn_2027_original_ch3_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 3.1 数据链路层的功能 Q1-Q6 (6 questions, MOCK 2027)
-- ============================================================

(1, '00000000-0000-0000-0000-000000129001', 'CN_DATA_LINK', 'CN_DATA_LINK_FUNC', 'BASIC', 'MOCK', 2027, '3.1数据链路层的功能', 'pp.64-65',
'下列选项中，不属于数据链路层功能的是（ ）。',
'B',
'数据链路层的主要功能包括：如何将二进制比特流组织成数据链路层的帧；如何控制帧在物理信道上的传输，包括如何处理传输差错；在两个网络实体之间提供数据链路的建立、维护和释放；控制链路上帧的传输速率，以使接收方有足够的缓存来接收每个帧。这些功能对应为帧定界、差错检测、链路管理和流量控制。电路管理功能由物理层提供。',
'帧定界', '电路管理', '差错控制', '流量控制'),

(2, '00000000-0000-0000-0000-000000129002', 'CN_DATA_LINK', 'CN_DATA_LINK_FUNC', 'BASIC', 'MOCK', 2027, '3.1数据链路层的功能', 'pp.64-65',
'下列选项中，不属于数据链路层功能的是（ ）。',
'D',
'拥塞控制是网络层或传输层的功能，用于防止过多的分组注入网络而导致网络性能下降。透明传输、差错检测和可靠传输都是数据链路层的功能。',
'透明传输', '差错检测', '可靠传输', '拥塞控制'),

(3, '00000000-0000-0000-0000-000000129003', 'CN_DATA_LINK', 'CN_DATA_LINK_FUNC', 'BASIC', 'MOCK', 2027, '3.1数据链路层的功能', 'pp.64-65',
'下列选项中，不属于数据链路层协议功能的是（ ）。',
'D',
'数据链路层的主要功能包括组帧，组帧即定义数据格式，选项A正确。数据链路层在物理层提供的不可靠的物理连接上实现节点到节点的可靠性传输，选项B正确。控制对物理传输介质的访问由数据链路层的介质访问控制（MAC）子层完成，选项C正确。为终端节点隐蔽物理传输的细节是物理层的功能，数据链路层不必考虑如何实现无差别的比特传输，选项D错误。',
'定义数据格式', '提供节点之间的可靠传输', '控制对物理传输介质的访问', '为终端节点隐蔽物理传输的细节'),

(4, '00000000-0000-0000-0000-000000129004', 'CN_DATA_LINK', 'CN_DATA_LINK_FUNC', 'BASIC', 'MOCK', 2027, '3.1数据链路层的功能', 'pp.64-65',
'为了避免传输过程中帧的丢失，数据链路层采用的方法是（ ）。',
'D',
'为防止在传输过程中丢失帧，在可靠的数据链路层协议中，发送方为发送的每个数据帧设计一个计时器，当计时器到期而该帧的确认帧仍未到达时，发送方将重发该帧。为保证接收方不会接收到重复帧，需要对每个发送的帧进行编号；海明码和循环冗余检验码都用于差错控制。',
'帧编号机制', '循环冗余检验码', '海明码', '计时器超时重发'),

(5, '00000000-0000-0000-0000-000000129005', 'CN_DATA_LINK', 'CN_DATA_LINK_FUNC', 'BASIC', 'MOCK', 2027, '3.1数据链路层的功能', 'pp.64-65',
'对于信道比较可靠且对实时性要求高的网络，数据链路层采用（ ）比较合适。',
'A',
'无确认的无连接服务是指源主机发送帧时不需要先建立逻辑连接，目的主机收到帧时不需要发回确认。若因线路上有噪声而造成某一帧丢失，则数据链路层并不检测这样的丢失现象，也不回复。当错误率很低时，这类服务非常合适，此时恢复任务可由上面的高层来负责。这类服务对实时通信也非常合适，因为实时通信中数据迟到比数据损坏更不好。',
'无确认的无连接服务', '有确认的无连接服务', '无确认的面向连接服务', '有确认的面向连接服务'),

(6, '00000000-0000-0000-0000-000000129006', 'CN_DATA_LINK', 'CN_DATA_LINK_FUNC', 'BASIC', 'MOCK', 2027, '3.1数据链路层的功能', 'pp.64-65',
'流量控制实际上是对（ ）的控制。',
'A',
'流量控制功能并不是数据链路层独有的，其他层上也有相应的控制策略，只是各层的流量控制对象是在相应层的实体之间进行的。流量控制实际上是对发送方的数据流量的控制，限制发送方的发送速率使其不超过接收方的接收能力。',
'发送方的数据流量', '接收方的数据流量', '发送、接收方的数据流量', '链路上任意两节点间的数据流量'),

-- ============================================================
-- 3.2 组帧 Q1 (1 question, PAST_EXAM 2013)
-- ============================================================

(7, '00000000-0000-0000-0000-000000129007', 'CN_DATA_LINK', 'CN_FRAMING', 'BASIC', 'PAST_EXAM', 2013, '3.2组帧', 'pp.67-68',
'【2013统考真题】HDLC协议对01111100 01111110组帧后，对应的比特串为（ ）。（注：HDLC协议已从最新大纲中删除。）',
'A',
'HDLC协议对比特串组帧时，HDLC数据帧以比特模式01111110标识每个帧的起始和结束，因此在帧数据中只要出现5个连续的位"1"，就在输出的位流中填充一个"0"。原始数据为01111100 01111110，每遇到5个连续的"1"就插入一个"0"，组帧后的比特串为01111100 00111110 10（下划线部分为新增的0）。',
'01111100 00111110 10', '01111100 01111101 01111110', '01111100 01111101 0', '01111100 01111110 01111101'),

-- ============================================================
-- 3.3 差错控制 Q1-Q9 (9 questions)
-- Q1-Q7: 模拟题 (MOCK 2027)
-- Q8-Q9: 统考真题 (PAST_EXAM 2023, 2025)
-- ============================================================

(8, '00000000-0000-0000-0000-000000129008', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'BASIC', 'MOCK', 2027, '3.3差错控制', 'pp.71-72',
'下列有关数据链路层差错控制的叙述中，错误的是（ ）。',
'A',
'链路层的差错控制有两种基本策略：检错编码和纠错编码。常见的纠错编码有海明码，它可以纠正一位差错。CRC检验编码可以检测出所有的单比特错误。因此数据链路层不仅可以提供差错检测，也可以提供对差错的纠正，选项A的说法是错误的。',
'数据链路层只能提供差错检测，而不提供对差错的纠正', '奇偶检验码只能检测出错误而无法对其进行修正，也无法检测出双位错误', 'CRC检验码可以检测出所有的单比特错误', '海明码可以纠正一位差错'),

(9, '00000000-0000-0000-0000-000000129009', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'BASIC', 'MOCK', 2027, '3.3差错控制', 'pp.71-72',
'下列关于奇偶检验码特征的描述中，正确的是（ ）。',
'A',
'奇偶检验的原理是通过增加冗余位来使得码字中"1"的个数保持为奇数或偶数的编码方法，它只能检查出奇数个比特的错误。若发生偶数个比特的错误，则1的个数的奇偶性不变，无法检测。',
'只能检查出奇数个比特的错误', '能检查出任意比特的错误', '比CRC检验更可靠', '只能检查出偶数个比特的错误'),

(10, '00000000-0000-0000-0000-000000129010', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'BASIC', 'MOCK', 2027, '3.3差错控制', 'pp.71-72',
'字符S的ASCII编码从低到高依次为1100101，采用奇检验，在下述收到的传输后字符中，错误（ ）不能检测。',
'D',
'既然采用奇检验，那么传输的数据中1的个数若是偶数则可检测出错误，若1的个数是奇数则检测不出错误。对于选项D，11010011中1的个数为5（奇数），因此无法检测出错误。',
'11000011', '11001010', '11001100', '11010011'),

(11, '00000000-0000-0000-0000-000000129011', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'BASIC', 'MOCK', 2027, '3.3差错控制', 'pp.71-72',
'为纠正2比特错误，编码的码距至少应为（ ）。',
'D',
'要纠正c位错误，编码的码距需满足d≥2c+1。当c=2时，所需码距为2×2+1=5。',
'2', '3', '4', '5'),

(12, '00000000-0000-0000-0000-000000129012', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'BASIC', 'MOCK', 2027, '3.3差错控制', 'pp.71-72',
'对于10位要传输的数据，若采用海明码检验，则需要增加的冗余信息位数是（ ）。',
'B',
'在海明码中，在k比特信息位上附加r比特冗余信息，构成k+r比特的码字，必须满足2^r≥k+r+1。当k=10时，若r=3则2^3=8<10+3+1=14，不满足；若r=4则2^4=16≥10+4+1=15，满足条件。因此需要增加4位冗余信息。',
'3', '4', '5', '6'),

(13, '00000000-0000-0000-0000-000000129013', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'BASIC', 'MOCK', 2027, '3.3差错控制', 'pp.71-73',
'下列关于循环冗余检验的说法中，错误的是（ ）。',
'B',
'在使用多项式编码时，发送方和接收方必须预先商定一个生成多项式。发送方按照模2除法来计算CRC检验码，接收方用相同的生成多项式来验证数据的正确性。选项A是正确结论。CRC检验可以使用硬件来完成，选项C正确。有一些特殊的多项式因为有很好的特性而成了国际标准，选项D正确。',
'带r个检验位的多项式编码可以检测到所有长度小于或等于r的突发性错误', '通信双方可以无须商定就直接使用多项式编码', 'CRC检验可以使用硬件来完成', '有一些特殊的多项式，因为有很好的特性，而成了国际标准'),

(14, '00000000-0000-0000-0000-000000129014', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'MEDIUM', 'MOCK', 2027, '3.3差错控制', 'pp.72-73',
'要发送的数据是1101011011，采用CRC检验，生成多项式对应的比特串为10011，那么最终发送的数据应是（ ）。',
'C',
'假设一个帧有m位，其对应的多项式为G(x)，则计算冗余码的步骤如下：①加0——假设G(x)的阶为r，在帧的低位端加上r个0。这里生成多项式10011的阶r=4，在1101011011后加4个0得11010110110000。②模2除——利用模2除法，用10011除11010110110000，得到的余数为1110。最终发送的数据为原始数据+余数=11010110111110。',
'11010110111010', '11010110110110', '11010110111110', '11110011011100'),

(15, '00000000-0000-0000-0000-000000129015', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'BASIC', 'PAST_EXAM', 2023, '3.3差错控制', 'pp.72-73',
'【2023统考真题】若甲向乙发送数据时采用CRC检验，生成多项式为G(X)=X^4+X+1（G=10011），则乙方接收到比特串（ ）时，可以断定其在传输过程中未发生错误。',
'D',
'除后4位外，前5位都为10111，可知发送方发送的数据部分为10111。列式求得余数部分：对101110000用10011进行模2除法，得余数为1100。因此发送方发送的帧串为10111 1100。乙方收到该比特串时，用10011去除，余数为0，可断定传输未发生错误。',
'10111 0000', '101110100', '10111 1000', '10111 1100'),

(16, '00000000-0000-0000-0000-000000129016', 'CN_DATA_LINK', 'CN_DATA_LINK_PROTOCOL', 'MEDIUM', 'PAST_EXAM', 2025, '3.3差错控制', 'pp.72-73',
'【2025统考真题】某差错编码的编码集为{1001 1010, 0101 1100, 1111 0000, 0000 1111}，该差错编码的检错和纠错能力是（ ）。',
'C',
'首先计算该编码集的码距：对四个码字两两比较，任意两个码字的码距至少为4，故该编码集的码距dmin=4。根据差错控制理论，若编码集的码距为d，则可检测不超过d-1位错误，能纠正不超过⌊(d-1)/2⌋位错误。因此该编码集最多能检测3位错误，纠正1位错误。',
'不超过2位错的100%检错、不超过1位错的纠错', '不超过2位错的100%检错、不超过2位错的纠错', '不超过3位错的100%检错、不超过1位错的纠错', '不超过3位错的100%检错、不超过2位错的纠错'),

-- ============================================================
-- 3.4 流量控制与可靠传输机制 Q1-Q14 (14 questions)
-- Q1-Q14: 模拟题 (MOCK 2027)
-- ============================================================

(17, '00000000-0000-0000-0000-000000129017', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.79,84',
'下列关于停止-等待协议(Stop-and-Wait)的描述中，正确的是（ ）。',
'A',
'停止-等待协议采用1比特给数据帧编号，发送窗口和接收窗口的尺寸都为1，选项A正确。仅在收到当前窗口内的数据帧后，接收窗口才能向后移动，因此一定是按序接收的。停止-等待协议的信道利用率=一个数据帧的发送时延/(一个数据帧的发送时延+RTT+一个确认帧的发送时延)，其中分子一定小于分母，所以信道利用率不可能达到100%，当RTT较大时，会降低信道利用率，因此停止-等待协议适合RTT较小的信道。',
'发送窗口和接收窗口的尺寸都为1', '最大的信道利用率有可能达到100%', '适合于往返时间比较长的信道', '接收方可以不按序接收'),

(18, '00000000-0000-0000-0000-000000129018', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.79,84',
'下列情况中，会使停止-等待协议的效率变得很低的是（ ）。',
'B',
'根据信道利用率的计算公式，当数据传输速率很高时，数据帧的发送时间很短；当源主机和目的主机的距离很远时，往返时延很大，此时的信道利用率很低。因此停止-等待协议在源主机和目的主机距离很远且数据传输速率很高时效率极低。',
'当源主机和目的主机之间的距离很近而且数据传输速率很高时', '当源主机和目的主机之间的距离很远而且数据传输速率很高时', '当源主机和目的主机之间的距离很近而且数据传输速率很低时', '当源主机和目的主机之间的距离很远而且数据传输速率很低时'),

(19, '00000000-0000-0000-0000-000000129019', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.79,84',
'在简单的停止-等待协议中，当帧出现丢失时，发送方会永远等待下去，解决这种死锁现象的办法是（ ）。',
'D',
'在停止-等待协议中，发送方设置了计时器，在发送一个帧后，发送方等待确认，若在计时器计满时仍未收到确认，则再次发送相同的帧，以免陷入永久的等待。这种超时机制解决了帧丢失导致的死锁问题。',
'差错检验', '帧序号', 'NAK机制', '超时机制'),

(20, '00000000-0000-0000-0000-000000129020', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.79,84',
'在停止-等待协议中，为了让接收方能判断所收到的数据帧是否重复，采用（ ）的方法。',
'A',
'在停止-等待协议中，使用1位来编号即可。若连续出现相同序号的数据帧，则表明发送方进行了超时重传；若连续出现相同序号的确认帧，则表明接收方收到了重复帧。帧编号机制解决了重复帧的判断问题。',
'帧编号', '差错检验', '重传计时器', 'NAK帧'),

(21, '00000000-0000-0000-0000-000000129021', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.79,84',
'一个信道的数据传输速率为4kb/s，单向传播时延为30ms，若使停止-等待协议的信道最大利用率达到80%，则要求的数据帧长至少为（ ）。',
'D',
'设C为数据传输速率，L为帧长，R为单程传播时延。停止-等待协议的信道最大利用率为(L/C)/(L/C+2R)=L/(L+2RC)=L/(L+2×30ms×4kb/s)=80%，解得L=960bit。',
'160比特', '320比特', '560比特', '960比特'),

(22, '00000000-0000-0000-0000-000000129022', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,84',
'一个信道的数据传输速率为6kb/s，单向传播时延为100ms，忽略确认帧的发送时延。信道的利用率为40%时，数据帧的长度为（ ）。',
'D',
'本题忽略确认帧的发送时延，所以信道利用率=数据帧的发送时延/(数据帧的发送时延+往返时延)=0.4。设数据帧发送时延为t，则t/(t+200ms)=0.4，解得t≈133.3ms，约为4/30s。所以数据帧的长度=6kb/s×(4/30)s=800bit。',
'240比特', '320比特', '600比特', '800比特'),

(23, '00000000-0000-0000-0000-000000129023', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,84',
'在停止-等待协议中，若发送方发送的数据帧中途丢失，则可能发生的情况是（ ）。',
'B',
'停止-等待协议使用确认和重传机制，发送方每发送一个帧，就要停下来等待接收方发回的确认帧，收到确认帧后才能发送下一帧。经过超时时间后未收到ACK帧则自动重传。数据帧中途丢失后，接收方不会发送任何响应，发送方在超时后自动重发该帧。',
'接收方发送NAK帧，请求重发此帧', '发送方在经过超时时间后未收到ACK帧，自动重发此帧', '接收方在经过超时时间后，向发送方发送ACK帧，请求重发此帧', '发送方继续发送后续帧，直到经过超时时间后未收到ACK帧，重发此帧'),

(24, '00000000-0000-0000-0000-000000129024', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,84',
'下列关于连续ARQ的说法中，错误的是（ ）。',
'D',
'连续ARQ协议分为GBN协议和SR协议。SR的接收窗口大于1，接收方可以先收下失序但序号仍落在接收窗口内的那些数据帧。但GBN的接收窗口等于1，接收方必须按序接收数据帧。因此不能说连续ARQ协议的接收方都可以不按序接收，选项D错误。',
'发送方可以连续发送若干数据帧，而不是发完一个数据帧就停下来等待确认帧', '发送方收到了接收方发来的确认帧，还可以接着发送数据帧', '相比停止-等待协议，连续ARQ因为减少了等待时间，所以提高了信道利用率', '接收方可以不按序接收数据帧'),

(25, '00000000-0000-0000-0000-000000129025', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,84',
'数据链路层采用后退N帧协议进行流量控制，发送方已发送编号为0～6的帧，之后收到5号数据帧的确认，发送方的滑动窗口向后移动后，发送方可发送的数据帧数量为6个，假设整个过程未发生超时，则应采用（ ）位给数据帧编号。',
'A',
'发送方收到5号帧的确认后，表示5号帧及之前的所有帧都被接收方正确接收，因此滑动窗口右移后，新窗口内的第一个帧就是6号帧，又因为此时可发送的数据帧数为6，因此发送窗口的总大小为7。在GBN协议中，若采用n位给帧编号，则发送窗口大小≤2^n-1，因此2^n-1≥7，解得n=3。',
'3', '4', '5', '6'),

(26, '00000000-0000-0000-0000-000000129026', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,84-85',
'数据链路层采用后退N帧协议，发送方已经发送了编号从0到6的帧。当计时器超时的时候，只收到对1、2、4号帧的确认，发送方需要重传的帧的数量是（ ）。',
'B',
'后退N帧协议采用累积确认，确认的最后一个帧是4号帧，表示4号帧及4号帧之前的数据帧都已被正确接收，所以只需重传5号帧和6号帧这两个数据帧。',
'1', '2', '4', '6'),

(27, '00000000-0000-0000-0000-000000129027', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,84-85',
'数据链路层采用了后退N帧协议（GBN），若发送窗口的大小是32，则至少需要（ ）位的序列号才能保证协议不出错。',
'C',
'对于滑动窗口协议，序列号个数要大于或等于窗口数（发送窗口大小+接收窗口大小），所以在后退N帧协议中，序列号个数不小于"发送窗口大小+1"。发送窗口大小是32，那么序列号个数最少应该是33个。2^5=32<33，2^6=64≥33，所以最少需要6位的序列号才能达到要求。',
'4', '5', '6', '7'),

(28, '00000000-0000-0000-0000-000000129028', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,85',
'若采用后退N帧的ARQ协议进行流量控制，帧编号字段为7位，则发送窗口的最大长度为（ ）。',
'C',
'在后退N帧的ARQ协议中，发送窗口W_s≤2^n-1。本题中n=7，因此发送窗口的最大长度是2^7-1=127。若发送窗口等于128，则接收窗口整体向前移动时，新窗口中的序列号和旧窗口的序列号产生重叠，致使接收方无法区别发送方发送的帧是重发帧还是新帧。',
'7', '8', '127', '128'),

(29, '00000000-0000-0000-0000-000000129029', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,85',
'一个使用选择重传协议的数据链路层，若采用5位的帧序列号，则可以选用的最大接收窗口是（ ）。',
'B',
'在选择重传协议中，若用n比特对帧编号，则发送窗口和接收窗口的大小关系为1≤W_r≤W_s，还需满足W_s+W_r≤2^n，所以接收窗口的最大尺寸不超过序号范围的一半，即W_r≤2^(n-1)=2^4=16。',
'15', '16', '31', '32'),

(30, '00000000-0000-0000-0000-000000129030', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,85',
'对于窗口总大小为n的滑动窗口，最多可以有（ ）帧已发送但没有确认。',
'B',
'在连续ARQ协议中，发送窗口大小≤窗口总数-1。例如，窗口总数为8，编号为0～7，假设这8个帧都已发出，下一轮又发出编号0～7的8个帧，接收方将无法判断第二轮发的8个帧到底是重传帧还是新帧，因为它们的序号完全相同。因此对于窗口大小为n的滑动窗口，其发送窗口大小最大为n-1，即最多可以有n-1帧已发送但没有确认。',
'0', 'n-1', 'n', 'n/2');

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
    '原题来自《2027年计算机网络考研复习指导》第3章 数据链路层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共30道纯文本单选题，含3道统考真题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch3_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000129', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch3_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000129', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch3_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000129', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch3_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000129', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch3_a_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch3_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000129901', 'CN-2027-ORIGINAL-CH3-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000129902', '3.1数据链路层的功能'),
    ('00000000-0000-0000-0000-000000129903', '3.2组帧'),
    ('00000000-0000-0000-0000-000000129904', '3.3差错控制'),
    ('00000000-0000-0000-0000-000000129905', '3.4流量控制与可靠传输机制')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.id = CAST(tag.id AS UUID));

-- Section tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_a_text_import q
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH3-A-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id
);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_a_text_import q
JOIN question_tags tag ON tag.name = '3.1数据链路层的功能'
WHERE q.section_tag = '3.1数据链路层的功能'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_a_text_import q
JOIN question_tags tag ON tag.name = '3.2组帧'
WHERE q.section_tag = '3.2组帧'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_a_text_import q
JOIN question_tags tag ON tag.name = '3.3差错控制'
WHERE q.section_tag = '3.3差错控制'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_a_text_import q
JOIN question_tags tag ON tag.name = '3.4流量控制与可靠传输机制'
WHERE q.section_tag = '3.4流量控制与可靠传输机制'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- Standard tags
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000000031', '2027计算机网络'),
    ('00000000-0000-0000-0000-000000000089', '无图片题目'),
    ('00000000-0000-0000-0000-000000000090', '授权原题'),
    ('00000000-0000-0000-0000-000000000091', '本节试题精选'),
    ('00000000-0000-0000-0000-000000000092', '原答案解析'),
    ('00000000-0000-0000-0000-000000000093', '选择题扩容'),
    ('00000000-0000-0000-0000-000000000094', '真题')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_a_text_import q
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容')
WHERE NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- PAST_EXAM questions get 真题 tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_a_text_import q
JOIN question_tags tag ON tag.name = '真题'
WHERE q.source_type = 'PAST_EXAM'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- ============================================================
-- Cleanup
-- ============================================================
DROP TABLE cn_2027_original_ch3_a_text_import;
