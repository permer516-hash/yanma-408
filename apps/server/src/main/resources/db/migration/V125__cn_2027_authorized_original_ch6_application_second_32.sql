-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 6: 应用层 (6.3 FTP收尾 + 6.4 电子邮件 + 6.5 WWW与HTTP).
-- Text-only batch: 32 questions with no image/table/code dependencies.
-- Deferred: 6.4 Q8 (2012统考真题, mail-flow diagram), 6.5 Q15 (NAT table).
-- Batch: CN-2027-ORIGINAL-CH6-B-TEXT-ONLY

-- ============================================================
-- Ensure knowledge points exist for 6.4 and 6.5
-- ============================================================
INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000125301',
    c.id,
    'CN_EMAIL',
    '电子邮件',
    4
FROM chapters c
WHERE c.code = 'CN_APPLICATION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_EMAIL');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000125302',
    c.id,
    'CN_WWW_HTTP',
    '万维网WWW与HTTP',
    5
FROM chapters c
WHERE c.code = 'CN_APPLICATION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_WWW_HTTP');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch6_b_text_import (
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

INSERT INTO cn_2027_original_ch6_b_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 6.3 文件传输协议FTP: Q12-Q14 (3 questions, continuing from V123 Q1-Q11)
-- Q13: 2009统考真题; Q14: 2017统考真题
-- ============================================================

(1, '00000000-0000-0000-0000-000000125001', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'直接封装FTP、DNS、DHCP报文的协议分别是（ ）。',
'A',
'FTP需要保证数据传输的可靠性，因此采用TCP作为传输层协议。在DHCP的应用中，客户在分配到IP地址前无法使用TCP建立连接，因此只能利用UDP进行无连接的交互。UDP具有简化通信、更高效、低延迟的特性，能满足DNS查询对快速响应和高并发的需求。',
'TCP、UDP、UDP', 'UDP、TCP、TCP', 'TCP、UDP、IP', 'UDP、UDP、UDP'),

(2, '00000000-0000-0000-0000-000000125002', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'PAST_EXAM', 2009, '6.3文件传输协议FTP', 'pp.291-293',
'【2009统考真题】FTP客户和服务器间传递FTP命令时，使用的连接是（ ）。',
'A',
'对于FTP文件传输，为了保证可靠性，选择TCP，排除C和D。FTP的控制信息是带外传送的，即FTP使用了一个分离的控制连接来传送命令，因此答案为选项A。',
'建立在TCP之上的控制连接', '建立在TCP之上的数据连接', '建立在UDP之上的控制连接', '建立在UDP之上的数据连接'),

(3, '00000000-0000-0000-0000-000000125003', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'PAST_EXAM', 2017, '6.3文件传输协议FTP', 'pp.291-293',
'【2017统考真题】下列关于FTP的叙述中，错误的是（ ）。',
'C',
'FTP使用控制连接和数据连接，控制连接存在于整个FTP会话过程中，数据连接在每次数据传输完毕后就关闭。控制连接在整个会话期间保持打开状态。客户端与服务器的TCP 21端口建立控制连接。错误的是选项C：数据连接是由服务器端使用20端口与客户端提供的端口建立，而非"服务器与客户端的TCP 20端口建立数据连接"。',
'数据连接在每次数据传输完毕后就关闭', '控制连接在整个会话期间保持打开状态', '服务器与客户端的TCP 20端口建立数据连接', '客户端与服务器的TCP 21端口建立控制连接'),

-- ============================================================
-- 6.4 电子邮件: Q1-Q7, Q9-Q12 (11 questions)
-- Q8 deferred (2012统考真题, mail-flow diagram)
-- Q9: 2013统考真题; Q10: 2015统考真题; Q11: 2018统考真题; Q12: 2025统考真题
-- ============================================================

(4, '00000000-0000-0000-0000-000000125004', 'CN_APPLICATION', 'CN_EMAIL', 'BASIC', 'MOCK', 2027, '6.4电子邮件', 'pp.298-300',
'互联网用户的电子邮件地址格式必须是（ ）。',
'D',
'电子邮件是互联网最基本、最常用的服务功能。要使用电子邮件服务，首先要拥有自己的电子邮箱地址，其格式为：用户名@邮箱所在主机的域名。',
'用户名@单位网络名', '单位网络名@用户名', '邮箱所在主机的域名@用户名', '用户名@邮箱所在主机的域名'),

(5, '00000000-0000-0000-0000-000000125005', 'CN_APPLICATION', 'CN_EMAIL', 'BASIC', 'MOCK', 2027, '6.4电子邮件', 'pp.298-300',
'SMTP基于传输层的（ ）协议，POP3基于传输层的（ ）协议。',
'A',
'SMTP和POP3都是基于TCP的协议，提供可靠的邮件通信。',
'TCP，TCP', 'TCP，UDP', 'UDP，TCP', 'UDP，UDP'),

(6, '00000000-0000-0000-0000-000000125006', 'CN_APPLICATION', 'CN_EMAIL', 'BASIC', 'MOCK', 2027, '6.4电子邮件', 'pp.298-300',
'SMTP服务器使用的端口号是（ ）。',
'B',
'SMTP服务器使用的熟知端口号是25。',
'21', '25', '80', '110'),

(7, '00000000-0000-0000-0000-000000125007', 'CN_APPLICATION', 'CN_EMAIL', 'MEDIUM', 'MOCK', 2027, '6.4电子邮件', 'pp.298-300',
'用Firefox（浏览器）在Gmail中向邮件服务器发送邮件时，使用的是（ ）协议。',
'A',
'在基于万维网的电子邮件中，用户浏览器与Hotmail或Gmail的邮件服务器之间的邮件发送或接收使用的是HTTP，而仅在不同邮件服务器之间传送邮件时才使用SMTP。',
'HTTP', 'POP3', 'P2P', 'SMTP'),

(8, '00000000-0000-0000-0000-000000125008', 'CN_APPLICATION', 'CN_EMAIL', 'BASIC', 'MOCK', 2027, '6.4电子邮件', 'pp.298-300',
'用户代理只能发送而不能接收电子邮件时，可能是（ ）地址错误。',
'A',
'用户代理使用POP3协议接收邮件。通常用户在配置电子邮件用户代理时需要设置邮件服务器的POP3地址（如pop3.gmail.com），若这个地址设置错误，则会导致用户无法接收邮件。用户代理中的SMTP地址错误时会导致无法发送邮件。',
'POP3', 'SMTP', 'HTTP', 'Mail'),

(9, '00000000-0000-0000-0000-000000125009', 'CN_APPLICATION', 'CN_EMAIL', 'MEDIUM', 'MOCK', 2027, '6.4电子邮件', 'pp.299-301',
'不能用于用户从邮件服务器接收电子邮件的协议是（ ）。',
'C',
'SMTP是一种"推"协议，用于发送端用户代理与发送端服务器之间及发送端服务器与接收端服务器之间，不能用于接收端用户从服务器上读取邮件。常用的邮件读取协议有POP3、HTTP和IMAP。',
'HTTP', 'POP3', 'SMTP', 'IMAP'),

(10, '00000000-0000-0000-0000-000000125010', 'CN_APPLICATION', 'CN_EMAIL', 'MEDIUM', 'MOCK', 2027, '6.4电子邮件', 'pp.299-301',
'下列关于电子邮件格式的说法中，错误的是（ ）。',
'B',
'邮件头是由多项内容构成的，其中一部分是由系统自动生成的，如发信人地址（From:）、发送时间；另一部分是由发件人输入的，如收信人地址（To:）、邮件主题（Subject:）等。',
'电子邮件内容包括邮件头与邮件体两部分', '邮件头中发信人地址（From:）、发送时间、收信人地址（To:）及邮件主题（Subject:）是由系统自动生成的', '邮件体是实际要传送的信函内容', 'MIME允许电子邮件系统传输文字、图像、语音与视频等多种信息'),

(11, '00000000-0000-0000-0000-000000125011', 'CN_APPLICATION', 'CN_EMAIL', 'MEDIUM', 'PAST_EXAM', 2013, '6.4电子邮件', 'pp.299-301',
'【2013统考真题】下列关于SMTP的叙述中，正确的是（ ）。' || CHR(10) ||
'I. 只支持传输7比特ASCII码内容' || CHR(10) ||
'II. 支持在邮件服务器之间发送邮件' || CHR(10) ||
'III. 支持从用户代理向邮件服务器发送邮件' || CHR(10) ||
'IV. 支持从邮件服务器向用户代理发送邮件',
'A',
'SMTP只支持传输7比特的ASCII码内容。SMTP用于用户代理向邮件服务器发送邮件，或邮件服务器之间发送邮件。而从邮件服务器向用户代理发送邮件使用的是POP3或IMAP协议。因此说法I、II、III正确，IV错误。',
'仅I、II和III', '仅I、II和IV', '仅I、III和IV', '仅II、III和IV'),

(12, '00000000-0000-0000-0000-000000125012', 'CN_APPLICATION', 'CN_EMAIL', 'BASIC', 'PAST_EXAM', 2015, '6.4电子邮件', 'pp.299-301',
'【2015统考真题】通过POP3协议接收邮件时，使用的传输层服务类型是（ ）。',
'D',
'POP3建立在TCP连接上，使用的是有连接可靠的数据传输服务。',
'无连接不可靠的数据传输服务', '无连接可靠的数据传输服务', '有连接不可靠的数据传输服务', '有连接可靠的数据传输服务'),

(13, '00000000-0000-0000-0000-000000125013', 'CN_APPLICATION', 'CN_EMAIL', 'BASIC', 'PAST_EXAM', 2018, '6.4电子邮件', 'pp.299-301',
'【2018统考真题】无须转换即可由SMTP直接传输的内容是（ ）。',
'D',
'SMTP限制所有邮件报文的体部分只能采用7位ASCII码来表示。因此在传输非文本文件时，往往需要将这些多媒体文件重新编码为ASCII码再传输。无须转换即可传输的是ASCII文本。',
'JPEG图像', 'MPEG视频', 'EXE文件', 'ASCII文本'),

(14, '00000000-0000-0000-0000-000000125014', 'CN_APPLICATION', 'CN_EMAIL', 'MEDIUM', 'PAST_EXAM', 2025, '6.4电子邮件', 'pp.299-301',
'【2025统考真题】下列关于POP3协议的叙述中，正确的是（ ）。' || CHR(10) ||
'I. 支持用户代理从邮件服务器读取邮件' || CHR(10) ||
'II. 支持用户代理向邮件服务器发送邮件' || CHR(10) ||
'III. 支持邮件服务器之间发送与接收邮件' || CHR(10) ||
'IV. 支持通过一条TCP连接收取多封邮件',
'A',
'POP3用于用户代理从邮件服务器读取邮件，说法I正确。用户代理向邮件服务器发送邮件使用的是SMTP，而非POP3。邮件服务器之间的邮件传输也由SMTP实现，与POP3无关。POP3支持在一条TCP连接中收取多封邮件，无须为每封邮件单独建立连接，说法IV正确。',
'仅I、IV', '仅I、III', '仅I、II、III', '仅I、III、IV'),

-- ============================================================
-- 6.5 万维网WWW与HTTP: Q1-Q14, Q16-Q19 (18 questions)
-- Q15 deferred (NAT table question)
-- Q4 is a dual-blank question (both blanks answer C)
-- Q16: 2014统考真题; Q17: 2015统考真题; Q18: 2022统考真题; Q19: 2024统考真题
-- ============================================================

(15, '00000000-0000-0000-0000-000000125015', 'CN_APPLICATION', 'CN_WWW_HTTP', 'BASIC', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'下面的（ ）协议中，客户与服务器之间采用面向无连接的协议进行通信。',
'C',
'DNS采用UDP来传送数据，UDP是一种面向无连接的协议。FTP、SMTP、HTTP均使用TCP进行通信。',
'FTP', 'SMTP', 'DNS', 'HTTP'),

(16, '00000000-0000-0000-0000-000000125016', 'CN_APPLICATION', 'CN_WWW_HTTP', 'BASIC', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'从协议分析的角度，WWW服务的第一步操作是浏览器对服务器的（ ）。',
'C',
'建立浏览器与服务器之间的连接需要知道服务器的IP地址和端口号（80端口是熟知端口），而访问站点时浏览器从用户那里得到的是WWW站点的域名，所以浏览器必须首先向DNS请求域名解析，获得服务器的IP地址后，才能请求建立TCP连接。',
'请求地址解析', '传输连接建立', '请求域名解析', '会话连接建立'),

(17, '00000000-0000-0000-0000-000000125017', 'CN_APPLICATION', 'CN_WWW_HTTP', 'BASIC', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'TCP和UDP的一些端口保留给一些特定的应用使用。为HTTP保留的端口号为（ ）。',
'A',
'HTTP在传输层使用TCP，端口号为80。TCP的25号端口是为SMTP保留的。',
'TCP的80端口', 'UDP的80端口', 'TCP的25端口', 'UDP的25端口'),

(18, '00000000-0000-0000-0000-000000125018', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'从某个已知的URL获得一个万维网文档时，若该万维网服务器的IP地址开始时并不知道，则需要用到的应用层协议有（ ），需要用到的传输层协议有（ ）。' || CHR(10) ||
'① A.FTP、HTTP   B.DNS、FTP   C.DNS、HTTP   D.TELNET、HTTP' || CHR(10) ||
'② A.UDP   B.TCP   C.UDP、TCP   D.TCP、IP',
'C',
'因为不知道服务器的IP地址，所以先要用DNS进行域名解析，然后使用HTTP进行客户和服务器之间的交互。需要用到的传输层协议是UDP（DNS使用）和TCP（HTTP使用）。因此两空均选C。',
'① FTP、HTTP  ② UDP', '① DNS、FTP  ② TCP', '① DNS、HTTP  ② UDP、TCP', '① TELNET、HTTP  ② TCP、IP'),

(19, '00000000-0000-0000-0000-000000125019', 'CN_APPLICATION', 'CN_WWW_HTTP', 'BASIC', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'万维网上的每个页面都有唯一的地址，这些地址统称（ ）。',
'C',
'统一资源定位符负责标识万维网上的各种文档，并使每个文档在整个万维网的范围内具有唯一的标识符URL。',
'IP地址', '域名地址', '统一资源定位符', 'WWW地址'),

(20, '00000000-0000-0000-0000-000000125020', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'使用鼠标单击一个万维网文档时，若该文档除有文本外，还有三幅gif图像，则在HTTP/1.0中需要建立（ ）次TCP连接。',
'A',
'HTTP在传输层用的是TCP。HTTP/1.0只支持非持续连接，所以每请求一个对象需要建立一次TCP连接，传输1个基本html对象和3个gif对象，共需建立4次TCP连接。',
'4', '3', '2', '1'),

(21, '00000000-0000-0000-0000-000000125021', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'仅需Web服务器对HTTP报文进行响应，但不需要返回请求对象时，HTTP请求报文应该使用的方法是（ ）。',
'D',
'使用HEAD方法时服务器可对HTTP报文进行响应，但不会返回请求对象，其主要作用是调试。',
'GET', 'PUT', 'POST', 'HEAD'),

(22, '00000000-0000-0000-0000-000000125022', 'CN_APPLICATION', 'CN_WWW_HTTP', 'BASIC', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'HTTP是一个无状态协议，然而Web站点经常希望能够识别用户，这时需要用到（ ）。',
'B',
'可以在HTTP中使用Cookie保存HTTP服务器和客户之间传递的状态信息。',
'Web缓存', 'Cookie', '条件GET', '持续连接'),

(23, '00000000-0000-0000-0000-000000125023', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,310-311',
'下列关于Cookie的说法中，错误的是（ ）。',
'A',
'Cookie是一个存储在用户主机中的文本文件，它由服务器产生，作为识别用户的手段。服务器的后端数据库记录了用户在Web站点上的活动，因此这些信息（如用户的个人信息及购物的偏好等）有可能被出卖给第三方从而威胁到用户的隐私。',
'Cookie仅存储在服务器端', 'Cookie是服务器产生的', 'Cookie会威胁客户的隐私', 'Cookie的作用是跟踪用户的访问和状态'),

(24, '00000000-0000-0000-0000-000000125024', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,311',
'以下关于非持续连接HTTP特点的描述中，错误的是（ ）。',
'D',
'非持续连接对每次请求/响应都建立一次TCP连接。在浏览器请求一个包含100个图片对象的Web页面时，服务器需要传输1个基本HTML文件和100个图片对象，因此共有101个对象，需要打开和关闭TCP连接101次，而非100次。',
'HTTP支持非持续连接与持续连接', 'HTTP/1.0使用非持续连接，而HTTP/1.1默认使用持续连接', '非持续连接中对每次请求/响应都要建立一次TCP连接', '非持续连接中读取一个包含100个图片对象的Web页面，需要打开和关闭100次TCP连接'),

(25, '00000000-0000-0000-0000-000000125025', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307,311',
'若浏览器支持并行TCP连接，使用非持久的HTTP/1.0协议请求浏览1个Web页，该页中引用同一网站上的7个小图像文件，则从浏览器为传输Web页请求建立TCP连接开始，到接收完所有内容为止，所需的往返时间RTT数至少是（ ）。',
'B',
'建立第一个TCP连接需要1RTT，请求并接收Web页需要1RTT。浏览器支持并行TCP连接，因此在收到Web页后可同时建立7个并行的TCP连接，以请求和接收7个小图像文件。因此，总往返时间RTT数=1RTT（建立第一个TCP连接）+1RTT（请求Web页）+1RTT（建立7个并行的TCP连接）+1RTT（请求7个小图像文件）=4RTT。',
'3', '4', '8', '9'),

(26, '00000000-0000-0000-0000-000000125026', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.307-308,311',
'假设主机通过HTTP/1.1（流水线方式）请求浏览某个Web服务器S上的Web页rfc.html，rfc.html引用了同目录下的3个JPEG小图像（假设只有在收到rfc.html后才能发送对其引用图像的请求），一次请求响应的时间为RTT，忽略其他各种时延，不考虑拥塞控制和流量控制，则从发出HTTP请求报文开始到收到全部内容为止，所耗费的时间是（ ）。',
'A',
'从发出HTTP请求报文开始，所以此时TCP连接已经建立。本题采用了流水线的持续连接。第1个RTT请求并收到html页面，收到html页面后才能发送对其引用小图像的请求，所以第2个RTT请求并收到3幅小图像，合计耗费2RTT。',
'2RTT', '2.5RTT', '4RTT', '4.5RTT'),

(27, '00000000-0000-0000-0000-000000125027', 'CN_APPLICATION', 'CN_WWW_HTTP', 'HARD', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.308,311',
'主机通过超链接http://www.cskaoyan.com/index.html请求浏览Web页index.html，浏览器使用流水线方式的HTTP/1.1协议，该Web页引用了同一网站上的7个小图像文件，假设主机到本地域名服务器和互联网上各服务器的往返时延均为1RTT。本地域名服务器只提供递归查询服务，其他域名服务器只提供迭代查询服务，忽略其他所有时延，则从点击超链接开始到浏览器接收到所有内容为止，所需的往返时间RTT数最多是（ ）。',
'C',
'主机点击超链接获取html页面，大致分为以下过程：①向本地域名服务器发送递归查询请求，若本地域名服务器中有相应的IP地址缓存，则直接向主机返回相应的IP地址，只需1RTT。否则，本地域名服务器还需要依次向根域名服务器、com顶级域名服务器、cskaoyan.com域名服务器发送迭代查询请求，查询到相应的IP地址最多需要4RTT。②建立TCP连接需要1RTT，请求并接收Web页需要1RTT，支持流水线传输方式，因此在收到Web页后可以同时发送7个小图像文件的请求，时间是1RTT（建立连接）+1RTT（请求Web页）+1RTT（请求7个图像文件）=3RTT。综上所述，所需的RTT数最多是4+3=7。',
'5', '6', '7', '8'),

(28, '00000000-0000-0000-0000-000000125028', 'CN_APPLICATION', 'CN_WWW_HTTP', 'HARD', 'MOCK', 2027, '6.5WWW与HTTP', 'pp.308,311-312',
'主机T通过持久的HTTP/1.1协议请求服务器S上的5KB数据，最大段长MSS=1KB，往返时间RTT=50ms，最长报文段寿命MSL=800ms，假设双方的接收窗口都足够大，当T收到来自S的第一个携带数据的报文段后，立即向S发送连接释放报文段（注：连接释放报文段可以携带数据信息或确认信息）。从T请求与S建立TCP连接时刻起，到T进入CLOSED状态为止，所需的时间至少是（ ）。',
'D',
'主机T在建立TCP连接的第3个握手报文段中向服务器S请求数据，初始时S的发送窗口=拥塞窗口=1MSS=1KB。T收到1KB数据后，向S请求释放TCP连接，但S还有4KB数据要发送。因此，S收到T发来的FIN段和确认后，拥塞窗口变为2KB，发送窗口也随之变化，再用1RTT时间S发送2KB数据。最后S向T发送FIN段，这个FIN段携带了最后的2KB数据，T收到FIN段后，向S发送ACK段，并启动时间等待计时器，等待2MSL的时间进入CLOSED状态，整个过程共耗时4RTT+2MSL=200+1600=1800ms。',
'1000ms', '1200ms', '1600ms', '1800ms'),

(29, '00000000-0000-0000-0000-000000125029', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'PAST_EXAM', 2014, '6.5WWW与HTTP', 'pp.308,312',
'【2014统考真题】使用浏览器访问某大学的Web网站主页时，不可能使用到的协议是（ ）。',
'D',
'接入网络时可能会用到PPP；计算机不知道某主机的MAC地址时，用IP地址查询相应的MAC地址会用到ARP；访问Web网站时，若DNS缓冲没有存储相应域名的IP地址，用域名查询相应的IP地址要使用DNS，而DNS是基于UDP的。SMTP只有使用邮件客户端发送邮件，或邮件服务器向其他邮件服务器发送邮件时才会用到，单纯地访问Web网页不可能用到。',
'PPP', 'ARP', 'UDP', 'SMTP'),

(30, '00000000-0000-0000-0000-000000125030', 'CN_APPLICATION', 'CN_WWW_HTTP', 'MEDIUM', 'PAST_EXAM', 2015, '6.5WWW与HTTP', 'pp.308,312',
'【2015统考真题】某浏览器发出的HTTP请求报文如下：' || CHR(10) ||
'GET /index.html HTTP/1.1' || CHR(10) ||
'Host: www.test.edu.cn' || CHR(10) ||
'Connection: Close' || CHR(10) ||
'Cookie: 123456' || CHR(10) ||
'下列叙述中，错误的是（ ）。',
'C',
'Connection: Close表示非持续连接方式，keep-alive表示持续连接方式。Cookie值由服务器产生，HTTP请求报文中有Cookie字段表示曾访问过www.test.edu.cn服务器。',
'该浏览器请求浏览index.html', 'index.html存放在www.test.edu.cn上', '该浏览器请求使用持续连接', '该浏览器曾经浏览过www.test.edu.cn'),

(31, '00000000-0000-0000-0000-000000125031', 'CN_APPLICATION', 'CN_WWW_HTTP', 'HARD', 'PAST_EXAM', 2022, '6.5WWW与HTTP', 'pp.309,312',
'【2022统考真题】假设主机H通过HTTP/1.1请求浏览某Web服务器S上的Web页，图像文件大小为3MSS（最大段长），访问S的往返时间RTT=10ms，忽略HTTP响应报文的首部开销和TCP段传输时延。若H已完成域名解析，则从H请求与S建立TCP连接时刻起，到接收到全部内容止，所需的时间至少是（ ）。',
'B',
'HTTP/1.1默认使用持续连接，所有请求都是连续发送的。要求最少时间，理想的情况是TCP在第3次握手的报文段中捎带了HTTP请求，以及传输过程中的慢开始阶段不考虑拥塞。假设接收端有足够大的缓存空间，即发送窗口等同于拥塞窗口。第1个RTT，进行TCP连接建立的前两次握手；第2个RTT，主机H发送第3次握手报文并捎带了对html文件的HTTP请求，TCP连接刚建立时服务器S的发送窗口=1MSS，服务器S发送大小为1MSS的html文件；第3个RTT，主机H发送对html文件的确认并捎带了对图形文件的HTTP请求，服务器S收到确认后发送窗口变为2MSS，然后服务器S发送大小为2MSS的图像文件；第4个RTT，主机H向服务器发送对收到的部分图像文件的确认，服务器S收到确认后发送窗口变为4MSS，然后服务器S发送剩下的1MSS图像文件，完成传输，共需要4RTT，即40ms。',
'30ms', '40ms', '50ms', '60ms'),

(32, '00000000-0000-0000-0000-000000125032', 'CN_APPLICATION', 'CN_WWW_HTTP', 'HARD', 'PAST_EXAM', 2024, '6.5WWW与HTTP', 'pp.309,312',
'【2024统考真题】若浏览器不支持并行TCP连接，使用非持久的HTTP/1.0协议请求浏览1个Web页，该页中引用同一网站上的7个小图像文件，则从浏览器为传输Web页请求建立TCP连接开始，到接收完所有内容为止，所需要的往返时间RTT数至少是（ ）。',
'D',
'使用非持久的HTTP/1.0且不支持并行连接，每个对象都需要建立独立的TCP连接。首先建立TCP连接获取Web页：1RTT（TCP握手）+1RTT（HTTP请求/响应）=2RTT。然后依次获取7个小图像文件，每个图像文件各需2RTT（1RTT建立连接+1RTT请求/响应），共需14RTT。总RTT数=2+14=16RTT。',
'4', '9', '14', '16');

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
    '原题来自《2027年计算机网络考研复习指导》第6章 应用层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共32道纯文本单选题（6.3第12～14题 + 6.4第1～7、9～12题 + 6.5第1～14、16～19题）。跳过2道图片/表格依赖题：6.4 Q8（2012统考真题，含邮件流图）、6.5 Q15（含NAT表），已记录至backlog。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch6_b_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST('00000000-0000-0000-0001-000000125' || LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch6_b_text_import
UNION ALL
SELECT CAST('00000000-0000-0000-0001-000000125' || LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch6_b_text_import
UNION ALL
SELECT CAST('00000000-0000-0000-0001-000000125' || LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch6_b_text_import
UNION ALL
SELECT CAST('00000000-0000-0000-0001-000000125' || LPAD(CAST((num * 4) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch6_b_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch6_b_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new tags exist
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000125101', '2027计算机网络'),
    ('00000000-0000-0000-0000-000000125102', 'CN-2027-ORIGINAL-CH6-B-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000125103', '第6章应用层'),
    ('00000000-0000-0000-0000-000000125104', '6.3文件传输协议FTP'),
    ('00000000-0000-0000-0000-000000125105', '6.4电子邮件'),
    ('00000000-0000-0000-0000-000000125106', '6.5WWW与HTTP')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch6_b_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机网络',
    'CN-2027-ORIGINAL-CH6-B-TEXT-ONLY',
    '第6章应用层',
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
DROP TABLE cn_2027_original_ch6_b_text_import;
