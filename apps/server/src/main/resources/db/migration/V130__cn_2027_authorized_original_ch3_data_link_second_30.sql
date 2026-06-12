-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 3: 数据链路层 (3.4 continuation Q15-Q30 + 3.5 介质访问控制 Q1-Q14).
-- Text-only batch: 30 pure-text questions (16 from 3.4, 14 from 3.5).
-- Deferred: 3.4 Q31 (2024 exam with SR frame exchange figure).
-- Batch: CN-2027-ORIGINAL-CH3-B-TEXT-ONLY

-- ============================================================
-- Ensure knowledge points exist
-- ============================================================
-- CN_DATA_LINK_PROTOCOL already exists from V18 (used by 3.3)
-- CN_FLOW_CONTROL already exists from V129 (used by 3.4)

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000130301',
    c.id,
    'CN_MEDIA_ACCESS',
    '介质访问控制',
    5
FROM chapters c
WHERE c.code = 'CN_DATA_LINK'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_MEDIA_ACCESS');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch3_b_text_import (
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

INSERT INTO cn_2027_original_ch3_b_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 3.4 流量控制与可靠传输机制 Q15-Q30 (16 questions, continuation from V129)
-- Q15-Q21: 模拟题 (MOCK 2027)
-- Q22-Q30: 统考真题 (PAST_EXAM 2009-2023)
-- NOTE: 3.4 Q31 (2024 SR with figure) deferred
-- ============================================================

(1, '00000000-0000-0000-0000-000000130001', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,85',
'数据链路层采用选择重传协议（SR）传输数据，若帧序号采用4比特编号，接收窗口大小为7，则发送窗口最大是（ ）。',
'C',
'在选择重传协议中，若用n比特对帧编号，则发送窗口和接收窗口的大小关系为1≤W_r≤W_s，此外还需要满足W_s+W_r≤2^n，因此发送窗口的最大尺寸为2^n-W_r=16-7=9。',
'17', '8', '9', '10'),

(2, '00000000-0000-0000-0000-000000130002', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80,85',
'对无序接收的滑动窗口协议，若序号位数为n，则接收窗口最大尺寸为（ ）。',
'D',
'本题未直接告知使用的是选择重传协议，而是通过间接方式给出的。题目称无序接收的滑动窗口协议，表示接收窗口大于1，所以使用的是选择重传协议，接收窗口最大尺寸为2^(n-1)。',
'2^n-1', '2n', '2n-1', '2^(n-1)'),

(3, '00000000-0000-0000-0000-000000130003', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.80-81,85',
'节点A和B之间进行流量控制，A和B之间的数据传输速率为20kb/s，数据帧和确认帧的长度都为2000B，往返传播时延为1400ms，A用3比特给数据帧编号，测得在A和B的通信过程中信道利用率大于80%，则（ ）。（注：在SR协议中，默认发送窗口大小等于接收窗口大小。）',
'D',
'无论采用哪种滑动窗口协议，信道利用率的计算方法都是：发送窗口内所有数据帧的发送时延/(一个数据帧的发送时延+RTT+一个确认帧的发送时延)。其中数据帧或确认帧的发送时延=2000B/(20kb/s)=800ms，RTT=1400ms，即T=800+800+1400=3000ms。假设发送窗口大小为x，则800x/3000>0.8，即发送窗口大小x要大于3。GBN协议的发送窗口为2^3-1=7，满足要求；SR协议的发送窗口为2^(3-1)=4，也满足要求。因此A和B之间可以采用GBN协议或SR协议。',
'节点A、B之间只能采用停止等待协议', '节点A、B之间只能采用GBN协议', '节点A、B之间只能采用SR协议', '节点A、B之间可以采用GBN协议或SR协议'),

(4, '00000000-0000-0000-0000-000000130004', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.81,85',
'流量控制是实现发送方和接收方速度一致的机制，实现这种机制所采取的措施是（ ）。',
'C',
'实现流量控制的常用方法是滑动窗口协议，它让接收方把自己的接收窗口大小反馈给发送方，以调节发送方的发送窗口大小，避免发送方因发送速度过快而导致接收方来不及接收。流量控制实质上是通过接收方向发送方反馈信息来限制发送方的发送速率。',
'增大接收方接收速度', '减小发送方发送速度', '接收方向发送方反馈信息', '增加双方的缓冲区'),

(5, '00000000-0000-0000-0000-000000130005', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.81,85',
'假设两台主机之间采用后退N帧协议传输数据，数据传输速率为16kb/s，单向传播时延为250ms，数据帧的长度是128B，确认帧的长度也是128B，为使信道利用率达到最高，则帧序号的比特数至少为（ ）。',
'C',
'为使信道利用率最高（100%），要让发送方在一个发送周期内持续发送帧，不能出现发送窗口内的帧发完但还未收到第一个帧的确认帧的情况。发送周期=发送一个数据帧的时间+往返时延+发送一个确认帧的时间，发送一个数据帧或确认帧的时间均为128B÷16kb/s=64ms，发送周期=64ms+250ms×2+64ms=628ms。为保证发送方持续发送帧，在一个发送周期内至少要发送的帧数为628ms/64ms≈10，即发送窗口大小至少为10，所以帧序号至少采用4比特。',
'2', '3', '4', '5'),

(6, '00000000-0000-0000-0000-000000130006', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'BASIC', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.81,85',
'在下列滑动窗口机制中，理论上可以达到100%信道利用率的是（ ）。
I.停止-等待协议
II.后退N帧协议
III.选择重传协议',
'D',
'信道利用率=发送周期内用于发送数据帧的时间/发送周期，其中发送周期=发送一个数据帧的时间+往返时延+发送一个确认帧的时间。停止-等待协议的发送窗口为1，不可能达到100%的信道利用率；只要发送窗口够大，后退N帧协议和选择重传协议都有可能达到100%的信道利用率。',
'I', 'II', 'III', 'II和III'),

(7, '00000000-0000-0000-0000-000000130007', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'MOCK', 2027, '3.4流量控制与可靠传输机制', 'pp.81,85-86',
'数据链路层采用选择重传协议进行流量控制，发送方在收到0～3号帧的确认后，又收到了5号帧的确认，发送窗口内还有其他帧未发送，且未发生超时，则发送方将（ ）。',
'C',
'在选择重传协议中，接收方对正确收到的每个数据帧单独进行确认，不要求收到的数据帧是有序的。依题意，接收方已正确收到0～3号和5号数据帧，但不确定4号数据帧是否收到。因为没有发生超时，发送方不进行重传，所以接收该确认帧并继续发送剩下的数据帧。',
'重传4号帧', '重传5号帧', '接收该确认帧并继续发送剩下的帧', '停止发送并等待超时'),

(8, '00000000-0000-0000-0000-000000130008', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2009, '3.4流量控制与可靠传输机制', 'pp.81,86',
'【2009统考真题】数据链路层采用了后退N帧（GBN）协议，发送方已经发送了编号为0～7的帧。当计时器超时的时候，若发送方只收到0、2、3号帧的确认，则发送方需要重发的帧数是（ ）。',
'C',
'在GBN协议中，当接收方检测到某帧出错时，会简单地丢弃该帧及所有的后续帧，发送方超时后需重传该数据帧及所有的后续帧。注意，在GBN协议中，接收方一般采用累积确认的方式，即接收方对按序到达的最后一个分组发送确认，因此本题中收到3号帧的确认就表示编号为0、1、2、3的帧已接收，而此时发送方未收到1号帧的确认只能代表确认帧在返回的过程中丢失，而不代表1号帧未到达接收方。因此需要重传的帧为编号是4、5、6、7的帧，共4帧。',
'2', '3', '4', '5'),

(9, '00000000-0000-0000-0000-000000130009', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2011, '3.4流量控制与可靠传输机制', 'pp.81,86',
'【2011统考真题】数据链路层采用选择重传协议（SR）传输数据，发送方已发送0～3号数据帧，现已收到1号帧的确认，而0、2号帧依次超时，则此时需要重传的帧数是（ ）。',
'B',
'在选择重传协议中，接收方逐个确认正确接收的分组，不管接收到的分组是否有序，只要正确接收就发送选择ACK分组进行确认，因此ACK分组不再具有累积确认的作用。对于这一点，要特别注意与GBN协议的区别。此题中只收到1号帧的确认，0、2号帧超时，因为对1号帧的确认不具有累积确认的作用，所以发送方认为接收方未收到0、2号帧，于是重传这两帧。',
'1', '2', '3', '4'),

(10, '00000000-0000-0000-0000-000000130010', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2012, '3.4流量控制与可靠传输机制', 'pp.81,86',
'【2012统考真题】两台主机之间的数据链路层采用后退N帧协议（GBN）传输数据，数据传输速率为16kb/s，单向传播时延为270ms，数据帧长范围是128～512B，接收方总是以与数据帧等长的帧进行确认。为使信道利用率达到最高，帧序号的比特数至少为（ ）。',
'B',
'数据帧长是不确定的，范围为128～512B，在计算最小窗口数时，为了保证无论数据帧长如何变化，信道利用率都能达到100%，应以128B的帧长计算。首先计算出：发送一个帧的时间=128×8/(16×10^3)=64ms；发送一个帧到收到确认帧为止的总时间=64+270×2+64=668ms；这段时间总共可发送668/64≈10.4帧，即发送窗口≥11，而接收窗口=1，所以至少需要用4位比特进行编号。',
'5', '4', '3', '2'),

(11, '00000000-0000-0000-0000-000000130011', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2014, '3.4流量控制与可靠传输机制', 'pp.81,86',
'【2014统考真题】主机甲与主机乙之间使用后退N帧协议（GBN）传输数据，主机甲的发送窗口尺寸为1000，数据帧长为1000B，信道带宽为100Mb/s，主机乙每收到一个数据帧，就立即利用一个短帧（忽略其传输延迟）进行确认，若主机甲和主机乙之间的单向传播时延是50ms，则主机甲可以达到的最大平均数据传输速率约为（ ）。',
'C',
'考虑制约甲方数据传输速率的因素。首先，信道带宽能直接制约数据的传输速率，传输速率一定是小于或等于信道带宽的。其次，因为甲方和乙方之间采用后退N帧协议传输数据，要考虑发送一个数据到接收到它的确认之前，最多能发送多少数据。甲方的发送窗口尺寸为1000，即收到第一个数据的确认前，最多能发送1000个数据帧，即1000×1000B=1MB的内容，而从发送第一个帧到接收到它的确认的时间是一个帧的发送时间加上往返时间，即1000B÷100Mb/s+50ms+50ms=0.10008s，此时的最大传输速率为1MB/0.10008s≈10MB/s=80Mb/s。信道带宽为100Mb/s，因此答案为min(80Mb/s, 100Mb/s)=80Mb/s。',
'10Mb/s', '20Mb/s', '80Mb/s', '100Mb/s'),

(12, '00000000-0000-0000-0000-000000130012', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2015, '3.4流量控制与可靠传输机制', 'pp.81,86',
'【2015统考真题】主机甲通过128kb/s卫星链路，采用滑动窗口协议向主机乙发送数据，链路单向传播时延为250ms，帧长为1000B。不考虑确认帧的开销，为使链路利用率不小于80%，帧序号的比特数至少是（ ）。',
'B',
'按发送周期思考，从开始发送帧到收到第一个确认帧为止，用时为T=第一个帧的发送时延+第一个帧的传播时延+确认帧的发送时延+确认帧的传播时延，这里忽略确认帧的发送时延。因此T=1000B÷128kb/s+RTT=0.0625s+0.5s=0.5625s。接着计算在T内需要发送多少数据才能满足利用率不小于80%。设数据大小为L字节，则(L÷128kb/s)/T≥0.8，得到L≥7200B，即在一个发送周期内至少要发7.2个帧才能满足要求。设需要编号的比特数为n，则2^n-1≥7.2，n至少为4。',
'3', '4', '5', '8'),

(13, '00000000-0000-0000-0000-000000130013', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2018, '3.4流量控制与可靠传输机制', 'pp.81,87',
'【2018统考真题】主机甲采用停止-等待协议向主机乙发送数据，数据传输速率是3kb/s，单向传播时延是200ms，忽略确认帧的传输时延。当信道利用率等于40%时，数据帧的长度为（ ）。',
'D',
'信道利用率=传输帧的有效时间/传输帧的周期。假设帧的长度为x比特。帧的传输周期由三部分组成：首先是帧在发送方的发送时延x÷3kb/s，其次是帧从发送方到接收方的单程传播时延200ms，最后是确认帧从接收方到发送方的单程传播时延200ms。三者相加得周期为x÷3kb/s+400ms。代入信道利用率的公式：x/(3kb/s)÷(x/(3kb/s)+400ms)=40%，解得x=800bit。',
'240比特', '400比特', '480比特', '800比特'),

(14, '00000000-0000-0000-0000-000000130014', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2019, '3.4流量控制与可靠传输机制', 'pp.82,87',
'【2019统考真题】对于滑动窗口协议，若分组序号采用3比特编号，发送窗口大小为5，则接收窗口最大是（ ）。',
'B',
'从滑动窗口的概念来看，停止-等待协议：发送窗口大小=1，接收窗口大小=1；后退N帧协议：发送窗口大小>1，接收窗口大小=1；选择重传协议：发送窗口大小>1，接收窗口大小>1。在选择重传协议中，还需满足：接收窗口大小≤发送窗口大小；发送窗口大小+接收窗口大小≤2^n。根据以上规则，采用3比特编号，发送窗口大小为5，接收窗口大小≤3。',
'2', '3', '4', '5'),

(15, '00000000-0000-0000-0000-000000130015', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2020, '3.4流量控制与可靠传输机制', 'pp.82,87',
'【2020统考真题】假设主机甲采用停止-等待协议向主机乙发送数据帧，数据帧长与确认帧长均为1000B，数据传输速率是10kb/s，单向传播时延是200ms。则主机甲的最大信道利用率为（ ）。',
'D',
'发送数据帧和确认帧的时间均为t=1000×8b÷10kb/s=800ms。发送周期为T=800ms+200ms+800ms+200ms=2000ms。信道利用率为t/T×100%=800/2000=40%。',
'80%', '66.7%', '44.4%', '40%'),

(16, '00000000-0000-0000-0000-000000130016', 'CN_DATA_LINK', 'CN_FLOW_CONTROL', 'MEDIUM', 'PAST_EXAM', 2023, '3.4流量控制与可靠传输机制', 'pp.82,87',
'【2023统考真题】假设通过同一条信道，数据链路层分别采用停止-等待协议、GBN协议和SR协议（发送窗口和接收窗口相等）传输数据，三个协议的数据帧长相同，忽略确认帧长，帧序号位数为3比特。若对应三个协议的发送方最大信道利用率分别是U1、U2和U3，则U1、U2和U3满足的关系是（ ）。',
'B',
'信道利用率U=n×T_f/T，其中n是发送窗口的大小，T_f是发送一个数据帧的时间，T是一个数据帧的发送周期。在T_f和T确定的情况下，n越大，信道利用率就越大。设帧序号的比特数为k，则停止-等待协议的发送窗口W_1=1；GBN协议的发送窗口W_2=2^k-1；SR协议的发送窗口W_3≤2^(k-1)，通常取2^(k-1)。因此W_1≤W_3≤W_2，即U1≤U3≤U2。',
'U1≤U2≤U3', 'U1≤U3≤U2', 'U2≤U1≤U3', 'U3≤U1≤U2'),

-- ============================================================
-- 3.5 介质访问控制 Q1-Q14 (14 questions)
-- Q1-Q8,Q9-Q18: 模拟题 (MOCK 2027)
-- NOTE: Q13 original had slightly garbled OCR on token ring statements
-- ============================================================

(17, '00000000-0000-0000-0000-000000130017', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95,97',
'信道划分介质访问控制的核心思想是（ ）。',
'A',
'选项B是随机访问介质访问控制的特点，如CSMA/CD协议。选项C是集中式介质访问控制的特点，如主从式协议，它由一个主站控制所有从站的发送顺序，从站只能在主站允许时才能发送数据。选项D是轮询访问介质访问控制的特点，如令牌传递协议。信道划分介质访问控制通过分时、分频、分码等方法，将广播信道变为若干点对点信道。',
'通过分时、分频、分码等方法，将广播信道变为若干点对点信道', '胜利者通过争用获得信道，从而获得信息的发送权', '通过集中控制方式解决发送信息的次序问题', '通过轮询方式依次询问每个站点是否有数据要发送'),

(18, '00000000-0000-0000-0000-000000130018', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95,97',
'介质访问控制（MAC）子层的主要功能是（ ）。',
'B',
'介质访问控制（MAC）子层的主要功能是控制和协调所有站点对共享介质的访问。能否实现带确认的可靠传输服务与介质访问控制子层无关，这属于上层协议的功能。',
'提供可靠的数据传输', '控制和协调所有站点对共享介质的访问', '实现数据链路层和物理层之间的接口', '为上层协议提供服务'),

(19, '00000000-0000-0000-0000-000000130019', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95,97',
'将物理信道的总频带宽分割成若干子信道，每个子信道传输一路信号，这种信道复用技术是（ ）。',
'B',
'在物理信道的可用带宽超过单个原始信号所需带宽的情况下，可将该物理信道的总带宽分割成若干与传输单个信号带宽相同（或略宽）的子信道，每个子信道传输一种信号，这就是频分复用（FDM）。',
'码分复用', '频分复用', '时分复用', '空分复用'),

(20, '00000000-0000-0000-0000-000000130020', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95,97',
'TDM所用传输介质的性质是（ ）。（注：本题选项中的带宽是指信号的频率范围。）',
'D',
'本题的关键是理解TDM（时分复用）的原理和特点。TDM在发送端将不同用户的信号相互交织在不同的时间片内，沿同一个信道传输，在接收端再将各个时间片内的信号提取出来，还原成原始信号。为了实现TDM，必须满足如下条件：①介质的位速率（每秒传输的二进制位数）大于单个信号的位速率；②介质的带宽（所能传输信号的最高频率与最低频率之差）大于结合信号的带宽（所有信号经过调制后形成的复合信号的带宽）。',
'介质的带宽大于结合信号的位速率', '介质的带宽小于单个信号的带宽', '介质的位速率小于最小信号的带宽', '介质的位速率大于单个信号的位速率'),

(21, '00000000-0000-0000-0000-000000130021', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95,97',
'从表面上看，FDM比TDM能更好地利用信道的传输能力，但现在计算机网络更多地使用TDM而非FDM，其原因是（ ）。',
'B',
'TDM与FDM相比，抗干扰能力强，可以逐级再生整形，能避免干扰的积累，而且数字信号比较容易实现自动转换，所以根据FDM和TDM的工作原理，FDM适合传输模拟信号，TDM适合传输数字信号。计算机网络上传输的是数字信号，因此更适合使用TDM。',
'FDM实际能力更差', 'TDM可用于数字传输而FDM不行', 'FDM技术不成熟', 'TDM能更充分地利用带宽'),

(22, '00000000-0000-0000-0000-000000130022', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95,97',
'在下列复用技术中，（ ）具有动态分配时隙的功能。',
'B',
'时分复用（TDM）分为同步时分复用和异步时分复用（也称统计时分复用）。同步时分复用是一种静态时分复用技术，它预先分配时间片（时隙），而异步时分复用则是一种动态时分复用技术，它动态地分配时间片（时隙）。',
'同步时分复用', '统计时分复用', '频分复用', '码分复用'),

(23, '00000000-0000-0000-0000-000000130023', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95,97',
'在下列协议中，不会发生冲突的是（ ）。',
'A',
'TDM属于静态划分信道的方法，各节点分时使用信道，不发生冲突。而ALOHA协议、CSMA协议和CSMA/CD协议都属于动态分配信道的方法，都采用检测冲突的策略来应对冲突，因此都可能发生冲突。注意，随机访问介质访问控制和轮询访问介质访问控制，都属于动态分配信道的方法，但是随机访问介质访问控制可能发生冲突，而轮询访问介质访问控制不发生冲突。',
'TDM', 'ALOHA', 'CSMA', 'CSMA/CD'),

(24, '00000000-0000-0000-0000-000000130024', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.95-96,98',
'在纯ALOHA协议中，一个站点想要发送数据时（ ）。',
'C',
'在纯ALOHA协议中，一个站点想要发送数据时可以立即发送，而不需要等待信道空闲或下一个时间槽开始，也不需要先发送RTS帧。纯ALOHA协议的思想非常简单：想发就发。',
'必须等待信道空闲', '必须等待下一个时间槽开始', '可以立即发送', '必须先发送RTS帧'),

(25, '00000000-0000-0000-0000-000000130025', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'下列几种CSMA协议中，（ ）协议在监听到信道空闲时仍可能不发送。',
'C',
'p-坚持CSMA协议是1-坚持CSMA协议和非坚持CSMA协议的折中。p-坚持CSMA协议检测到信道空闲后，以概率p发送数据，以概率1-p推迟到下一个时隙，目的是降低1-坚持CSMA协议中多个节点检测到信道空闲后同时发送数据的冲突概率；采用"坚持"监听的目的，是克服非坚持CSMA协议中因随机等待造成延迟时间较长的缺点。',
'1-坚持CSMA', '非坚持CSMA', 'p-坚持CSMA', '以上都不是'),

(26, '00000000-0000-0000-0000-000000130026', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'在CSMA的非坚持协议中，当信号忙时，则（ ）直到介质空闲。',
'C',
'非坚持CSMA协议：站点在发送数据前先监听信道，若信道忙则放弃监听，等待一个随机时间后再监听，若信道空闲，则发送数据。因此当信号忙时，会延迟一个随机的时间单位再监听。',
'延迟一个固定的时间单位再监听', '继续监听', '延迟一个随机的时间单位再监听', '放弃监听'),

(27, '00000000-0000-0000-0000-000000130027', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'在CSMA的非坚持协议中，当站点监听到总线信道空闲时，它（ ）。',
'B',
'非坚持CSMA协议中，站点在发送数据前先监听信道，若信道空闲，则马上发送数据。若信道忙，则等待一个随机时间后再监听。',
'以概率p传送', '马上传送', '以概率1-p传送', '以概率p延迟一个时间单位后传送'),

(28, '00000000-0000-0000-0000-000000130028', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'与采用CSMA/CD协议的网络相比，令牌环网络更适合的环境是（ ）。',
'B',
'CSMA/CD协议网络中各站随机发送数据，有冲突产生。当负载很多时，冲突加剧。而令牌环网络各站轮流使用令牌发送数据，无论网络负载如何，都无冲突产生，这是它的突出优点。因此令牌环网络更适合负载重的环境。',
'负载轻', '负载重', '距离远', '距离近'),

(29, '00000000-0000-0000-0000-000000130029', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'下列关于令牌环网络的描述中，错误的是（ ）。',
'A',
'令牌环网络的拓扑结构为环状，有一个令牌不停地在环中流动，只有获得了令牌的节点才能发送数据，因此不存在冲突，选项A错误。令牌环网络是一种半双工通信方式，同一时刻只能有一个节点发送数据，其他节点只能接收或转发数据，选项B正确。令牌环网络中的所有节点都连接到同一个信道上，共享整个信道的带宽，选项C正确。在令牌环网络中，数据从一个节点到另一节点的时间可根据环上经过的节点数、传输速率和数据帧长来计算，选项D正确。',
'令牌环网络存在冲突的可能', '同一时刻，环上只有一个节点的数据在传输', '网上所有节点共享网络带宽', '数据从一个节点到另一节点的时间可以计算'),

(30, '00000000-0000-0000-0000-000000130030', 'CN_DATA_LINK', 'CN_MEDIA_ACCESS', 'BASIC', 'MOCK', 2027, '3.5介质访问控制', 'pp.96,98',
'下列关于令牌环网络的说法中，错误的是（ ）。
I.信道的利用率比较公平
II.重负载下信道利用率高
III.节点可以一直持有令牌，直至所要发送的数据传输完毕
IV.节点只能持有令牌一段固定的时间；对于没有数据要发送的节点也是如此',
'C',
'令牌环网络使用令牌在各个节点之间传递来分配信道的使用权，每个节点都可在一定的时间内（令牌持有时间）获得发送数据的权限，而非无限制地持有令牌。在令牌传递过程中，没有数据要发送的节点收到令牌后将立刻传递下去而不能持有。因此说法III错误。选项C（仅III处错误）。',
'I、II和III', 'III', 'III和IV', 'IV');

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
    '原题来自《2027年计算机网络考研复习指导》第3章 数据链路层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共30道纯文本单选题，含9道统考真题（2009/2011/2012/2014/2015/2018/2019/2020/2023）。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch3_b_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000130', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch3_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000130', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch3_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000130', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch3_b_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000130', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch3_b_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch3_b_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Ensure tags exist and bind
-- ============================================================
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (VALUES
    ('00000000-0000-0000-0000-000000130901', 'CN-2027-ORIGINAL-CH3-B-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000130902', '3.4流量控制与可靠传输机制'),
    ('00000000-0000-0000-0000-000000130903', '3.5介质访问控制')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags t WHERE t.name = tag.name);

-- Batch tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_b_text_import q
JOIN question_tags tag ON tag.name = 'CN-2027-ORIGINAL-CH3-B-TEXT-ONLY'
WHERE NOT EXISTS (
    SELECT 1 FROM question_tag_relations r
    WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id
);

-- Section tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_b_text_import q
JOIN question_tags tag ON tag.name = '3.4流量控制与可靠传输机制'
WHERE q.section_tag = '3.4流量控制与可靠传输机制'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_b_text_import q
JOIN question_tags tag ON tag.name = '3.5介质访问控制'
WHERE q.section_tag = '3.5介质访问控制'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- Standard tags (ensure they exist first)
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
FROM cn_2027_original_ch3_b_text_import q
JOIN question_tags tag ON tag.name IN ('2027计算机网络', '无图片题目', '授权原题', '本节试题精选', '原答案解析', '选择题扩容')
WHERE NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- PAST_EXAM questions get 真题 tag
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch3_b_text_import q
JOIN question_tags tag ON tag.name = '真题'
WHERE q.source_type = 'PAST_EXAM'
  AND NOT EXISTS (SELECT 1 FROM question_tag_relations r WHERE r.question_id = CAST(q.id AS UUID) AND r.tag_id = tag.id);

-- ============================================================
-- Cleanup
-- ============================================================
DROP TABLE cn_2027_original_ch3_b_text_import;
