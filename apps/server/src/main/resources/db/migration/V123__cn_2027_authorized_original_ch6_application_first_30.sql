-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 6: 应用层 (6.1 网络应用模型 + 6.2 域名系统DNS + 6.3 文件传输协议FTP).
-- Text-only batch: 30 questions with no image/table/code dependencies.
-- Deferred: 6.2 Q14 (2020统考真题, network topology diagram).
-- Batch: CN-2027-ORIGINAL-CH6-A-TEXT-ONLY

-- ============================================================
-- Ensure chapter exists (CN_APPLICATION already seeded earlier)
-- ============================================================
INSERT INTO chapters (id, subject_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000018216',
    s.id,
    'CN_APPLICATION',
    '应用层',
    25
FROM subjects s
WHERE s.code = 'COMPUTER_NETWORK'
  AND NOT EXISTS (SELECT 1 FROM chapters c WHERE c.code = 'CN_APPLICATION');

-- ============================================================
-- Ensure knowledge points exist
-- ============================================================
INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000123301',
    c.id,
    'CN_APP_MODEL',
    '网络应用模型',
    1
FROM chapters c
WHERE c.code = 'CN_APPLICATION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_APP_MODEL');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000123302',
    c.id,
    'CN_DNS',
    '域名系统DNS',
    2
FROM chapters c
WHERE c.code = 'CN_APPLICATION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_DNS');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000123303',
    c.id,
    'CN_FTP',
    '文件传输协议FTP',
    3
FROM chapters c
WHERE c.code = 'CN_APPLICATION'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_FTP');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch6_a_text_import (
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

INSERT INTO cn_2027_original_ch6_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 6.1 网络应用模型: Q1-Q6 (6 questions)
-- Q6: 2019统考真题; others: 模拟题
-- ============================================================

(1, '00000000-0000-0000-0000-000000123001', 'CN_APPLICATION', 'CN_APP_MODEL', 'BASIC', 'MOCK', 2027, '6.1网络应用模型', 'pp.280-281',
'在客户/服务器模型中，客户指的是（ ）。',
'A',
'客户既不是硬件，又不是软件，只是服务的请求方，服务器才是响应方。',
'请求方', '响应方', '硬件', '软件'),

(2, '00000000-0000-0000-0000-000000123002', 'CN_APPLICATION', 'CN_APP_MODEL', 'BASIC', 'MOCK', 2027, '6.1网络应用模型', 'pp.280-281',
'用户提出服务请求，网络将用户请求传送到服务器；服务器执行用户请求，完成所要求的操作并将结果送回用户，这种工作模型称为（ ）。',
'A',
'用户提出服务请求，网络将用户请求传送到服务器；服务器执行用户请求，完成所要求的操作并将结果送回用户，这种工作模型称为客户/服务器模型，即C/S模型。',
'C/S模型', 'P2P模型', 'CSMA/CD模型', '令牌环模型'),

(3, '00000000-0000-0000-0000-000000123003', 'CN_APPLICATION', 'CN_APP_MODEL', 'MEDIUM', 'MOCK', 2027, '6.1网络应用模型', 'pp.280-281',
'下面关于客户/服务器模型的描述，（ ）存在错误。' || CHR(10) ||
'I. 客户端必须提前知道服务器的地址，而服务器则不需要提前知道客户端的地址' || CHR(10) ||
'II. 客户端主要实现如何显示信息与收集用户的输入，而服务器主要实现数据的处理' || CHR(10) ||
'III. 浏览器显示的内容来自服务器' || CHR(10) ||
'IV. 客户端是请求方，即使连接建立后，服务器也不能主动发送数据',
'C',
'在连接未建立前，服务器在某一个端口上监听。客户端是连接的请求方，客户端必须事先知道服务器的地址才能发出连接请求，而服务器则从客户端发来的数据包中获取客户端的地址。一旦连接建立，服务器就能响应客户端请求的内容，服务器也能主动发送数据给客户端，用于一些消息的通知，如一些错误的通知。所以只有说法IV错误。',
'II、IV', 'III、IV', '仅IV', '仅III'),

(4, '00000000-0000-0000-0000-000000123004', 'CN_APPLICATION', 'CN_APP_MODEL', 'BASIC', 'MOCK', 2027, '6.1网络应用模型', 'pp.280-282',
'下列关于客户/服务器模型的说法中，不正确的是（ ）。',
'D',
'客户是面向用户的，服务器是面向任务的。',
'服务器专用于完成某些服务，而客户则作为这些服务的使用者', '客户通常位于前端，服务器通常位于后端', '客户和服务器通过网络实现协同计算任务', '客户是面向任务的，服务器是面向用户的'),

(5, '00000000-0000-0000-0000-000000123005', 'CN_APPLICATION', 'CN_APP_MODEL', 'MEDIUM', 'MOCK', 2027, '6.1网络应用模型', 'pp.280-282',
'以下关于P2P概念的描述中，错误的是（ ）。',
'C',
'P2P可以理解为一种通信模型、一种逻辑网络模型。物理网络是指在网络中由各种设备（主机、交换机等）和介质（双绞线等）连接而形成的网络，它看得见摸得着。而这个网络中所使用的协议，或网络结构，都是靠逻辑网络来划分的。P2P网络是一个构建在IP网络上的覆盖网络，是一种动态的逻辑网络。对等节点之间具有直接通信的能力是P2P的显著特点。',
'P2P是网络节点之间采取对等方式直接交换信息的工作模型', 'P2P通信模式是指P2P网络中对等节点之间的直接通信能力', 'P2P网络是指与互联网并行建设的、由对等节点组成的物理网络', 'P2P实现技术是指为实现对等节点之间直接通信的功能所需设计的协议、软件等'),

(6, '00000000-0000-0000-0000-000000123006', 'CN_APPLICATION', 'CN_APP_MODEL', 'MEDIUM', 'PAST_EXAM', 2019, '6.1网络应用模型', 'pp.280-282',
'【2019统考真题】下列关于网络应用模型的叙述中，错误的是（ ）。',
'B',
'在P2P模型中，每个节点的权利和义务对等，彼此可直接通信。而在C/S模型中，客户是服务发起方，服务器被动接受来自客户的请求，客户之间不能直接通信，例如Web应用中的两个浏览器之间不能直接通信。P2P模型通过将文件分发任务分散到多个节点，允许用户从多个对等方并行下载，从而减轻服务器负担，在向多用户分发文件时，通常比C/S模型所需的时间更短。',
'在P2P模型中，节点之间具有对等关系', '在客户/服务器(C/S)模型中，客户与客户之间可以直接通信', '在C/S模型中，主动发起通信的是客户，被动通信的是服务器', '在向多用户分发一个文件时，P2P模型通常比C/S模型所需的时间短'),

-- ============================================================
-- 6.2 域名系统DNS: Q1-Q13 (13 questions)
-- Q11: 2010统考真题; Q12: 2016统考真题; Q13: 2018统考真题; others: 模拟题
-- Deferred: Q14 (2020统考真题, network topology diagram)
-- ============================================================

(7, '00000000-0000-0000-0000-000000123007', 'CN_APPLICATION', 'CN_DNS', 'BASIC', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-287',
'域名与（ ）具有一一对应的关系。',
'D',
'若一台主机通过两块网卡连接到两个网络（如服务器双线接入），则就具有两个IP地址，每个网卡对应一个MAC地址，显然这两个IP地址可以映射到同一个域名上。此外，多台主机也可以映射到同一个域名上（如负载均衡），一台主机也可以映射到多个域名上（如虚拟主机）。因此，选项A、B和C和域名均不具有一一对应的关系。',
'IP地址', 'MAC地址', '主机', '以上都不对'),

(8, '00000000-0000-0000-0000-000000123008', 'CN_APPLICATION', 'CN_DNS', 'MEDIUM', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-287',
'下列说法错误的是（ ）。',
'A',
'Internet上提供访问的主机一定要有IP地址，而不一定要有域名，选项A错误。域名在不同的时间可以解析出不同的IP地址，因此可以用多台服务器来分担负载，选项B正确。可以把多个域名指向同一台主机的IP地址，选项C正确。IP子网中主机也可以由不同的域名服务器来维护其映射，选项D正确。',
'Internet上提供客户访问的主机一定要有域名', '同一域名在不同时间可能解析出不同的IP地址', '多个域名可以指向同一台主机的IP地址', 'IP子网中的主机可以由不同的域名服务器来维护其映射'),

(9, '00000000-0000-0000-0000-000000123009', 'CN_APPLICATION', 'CN_DNS', 'BASIC', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-287',
'DNS是基于（ ）模型的分布式系统。',
'A',
'DNS是一个基于C/S模型的分布式数据库系统，主要用于域名和IP地址的映射。',
'C/S', 'B/S', 'P2P', '以上均不正确'),

(10, '00000000-0000-0000-0000-000000123010', 'CN_APPLICATION', 'CN_DNS', 'MEDIUM', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-288',
'域名系统(DNS)的组成不包括（ ）。',
'D',
'DNS提供从域名到IP地址或从IP地址到域名的映射服务。它被设计成为一个联机分布式数据库系统，并采用客户/服务器模式。域名的解析是由若干域名服务器程序完成的。从内部IP地址到外部IP地址的映射是由NAT实现的，用于缓解IPv4地址紧缺的问题，与域名系统无关。',
'域名空间', '分布式数据库', '域名服务器', '从内部IP地址到外部IP地址的翻译程序'),

(11, '00000000-0000-0000-0000-000000123011', 'CN_APPLICATION', 'CN_DNS', 'MEDIUM', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-288',
'互联网中域名解析依赖于由域名服务器组成的逻辑树。在域名解析过程中，主机上请求域名解析的软件不需要知道（ ）信息。' || CHR(10) ||
'I. 本地域名服务器的IP' || CHR(10) ||
'II. 本地域名服务器父节点的IP' || CHR(10) ||
'III. 域名服务器树根节点的IP',
'C',
'正常情况下，客户只需把域名解析请求发往本地域名服务器，其他事情都由本地域名服务器完成，并把最后结果返回给客户。所以主机只需要知道本地域名服务器的IP。',
'I和II', 'I和III', 'II和III', 'I、II和III'),

(12, '00000000-0000-0000-0000-000000123012', 'CN_APPLICATION', 'CN_DNS', 'BASIC', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-288',
'在DNS的递归查询中，由（ ）给客户端返回地址。',
'A',
'在递归查询中，每台不包含被请求信息的服务器都转到其他地方去查找，然后它再往回发送结果，所以客户端最开始连接的服务器最终将返回正确的信息。',
'最开始连接的服务器', '最后连接的服务器', '目的地址所在服务器', '不确定'),

(13, '00000000-0000-0000-0000-000000123013', 'CN_APPLICATION', 'CN_DNS', 'BASIC', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-288',
'当本地域名服务器向根域名服务器查询一个域名时，根域名服务器返回一个负责该域名的顶级域名服务器的IP地址，让本地域名服务器再向该域名服务器查询，这种查询方式称为（ ）。',
'B',
'迭代查询是指当一个域名服务器收到本地域名服务器发出的查询请求报文时，要么给出所要查询的IP地址，要么告诉本地服务器："你下一步应当向哪个DNS服务器进行查询。"然后让本地域名服务器进行后续的查询（而不是替本地域名服务器进行后续的查询）。',
'递归查询', '迭代查询', '重定向查询', '广播查询'),

(14, '00000000-0000-0000-0000-000000123014', 'CN_APPLICATION', 'CN_DNS', 'MEDIUM', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-288',
'一台主机要解析www.cskaoyan.com的IP地址，若这台主机配置的域名服务器为202.120.66.68，互联网顶级域名服务器为11.2.8.6，而存储www.cskaoyan.com的IP地址对应关系的域名服务器为202.113.16.10，则这台主机解析该域名通常首先查询（ ）。',
'A',
'当这台主机发出对www.cskaoyan.com的DNS查询报文时，这个查询报文首先被送往该主机的本地域名服务器202.120.66.68。本地域名服务器不能立即回答该查询时，就以DNS客户的身份向某一根域名服务器查询。但不管采用何种查询方式，首先都要查询本地域名服务器。',
'202.120.66.68域名服务器', '11.2.8.6域名服务器', '202.113.16.10域名服务器', '可以从这3个域名服务器中任选一个'),

(15, '00000000-0000-0000-0000-000000123015', 'CN_APPLICATION', 'CN_DNS', 'BASIC', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-288',
'（ ）可以将其管辖的主机名转换为主机的IP地址。',
'C',
'每台主机都必须在权限域名服务器处注册登记，权限域名服务器一定能够将其管辖的主机名转换为该主机的IP地址。',
'本地域名服务器', '根域名服务器', '权限域名服务器', '代理域名服务器'),

(16, '00000000-0000-0000-0000-000000123016', 'CN_APPLICATION', 'CN_DNS', 'MEDIUM', 'MOCK', 2027, '6.2域名系统DNS', 'pp.285-288',
'若本地域名服务器无缓存，用户主机采用递归查询向本地域名服务器查询另一网络某主机域名对应的IP地址，而本地域名服务器采用迭代查询向其他域名服务器进行查询，则用户主机和本地域名服务器发送的域名请求条数分别为（ ）。',
'B',
'用户主机向本地域名服务器采用递归查询，只需发送1条查询请求。本地域名服务器无缓存，因此还要进行后续的查询。本地域名服务器向其他域名服务器采用迭代查询，本地域名服务器分别向根域名服务器、顶级域名服务器、权限域名服务器发送多条查询请求。',
'1条，1条', '1条，多条', '多条，1条', '多条，多条'),

(17, '00000000-0000-0000-0000-000000123017', 'CN_APPLICATION', 'CN_DNS', 'MEDIUM', 'PAST_EXAM', 2010, '6.2域名系统DNS', 'pp.286-288',
'【2010统考真题】若本地域名服务器无缓存，则在采用递归方法解析另一网络某主机域名时，用户主机和本地域名服务器发送的域名请求条数分别为（ ）。',
'A',
'用户主机向本地域名服务器采用递归查询，只需发送1条请求。本地域名服务器无缓存，但因其向其他域名服务器也采用递归查询方式，故只需向根域名服务器发送1条请求，后续查询被询问的服务器代为完成。因此，用户主机和本地域名服务器发送的域名请求条数均为1。',
'1条，1条', '1条，多条', '多条，1条', '多条，多条'),

(18, '00000000-0000-0000-0000-000000123018', 'CN_APPLICATION', 'CN_DNS', 'HARD', 'PAST_EXAM', 2016, '6.2域名系统DNS', 'pp.286-288',
'【2016统考真题】假设所有域名服务器均采用迭代查询方式进行域名解析。当主机访问规范域名为www.abc.xyz.com的网站时，本地域名服务器在完成该域名解析的过程中，可能发出DNS查询的最少和最多次数分别是（ ）。',
'C',
'最少情况：若本地域名服务器已缓存该域名的解析结果，则无须发出任何DNS查询，最少为0次。最多情况：因所有服务器均采用迭代查询，在最坏情况下，本地域名服务器需要依次向根域名服务器、顶级域名服务器(.com)、权限域名服务器(xyz.com)和次级权限域名服务器(abc.xyz.com)发起查询，共4次，因此最多为4次。',
'0,3', '1,3', '0,4', '1,4'),

(19, '00000000-0000-0000-0000-000000123019', 'CN_APPLICATION', 'CN_DNS', 'BASIC', 'PAST_EXAM', 2018, '6.2域名系统DNS', 'pp.286-288',
'【2018统考真题】下列TCP/IP应用层协议中，可以使用传输层无连接服务的是（ ）。',
'B',
'FTP用于文件传输，SMTP用于电子邮件发送，HTTP用于网页传输，三者均要求可靠传输，故在传输层使用有连接的TCP服务。DNS对可靠性的要求相对较低，且追求效率与低开销，因此在传输层通常使用无连接的UDP服务。',
'FTP', 'DNS', 'SMTP', 'HTTP'),

-- ============================================================
-- 6.3 文件传输协议FTP: Q1-Q11 (11 questions)
-- All 模拟题 (MOCK, 2027)
-- Q12-Q14 (including 2009/2017 exam questions) deferred to next batch
-- ============================================================

(20, '00000000-0000-0000-0000-000000123020', 'CN_APPLICATION', 'CN_FTP', 'BASIC', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.290-292',
'文件传输协议(FTP)的一个主要特征是（ ）。',
'C',
'FTP提供交互式访问，允许客户指明文件的类型与格式，并允许文件具有存取权限。',
'允许客户指明文件的类型但不允许指明文件的格式', '不允许客户指明文件的类型但允许指明文件的格式', '允许客户指明文件的类型与格式', '不允许客户指明文件的类型与格式'),

(21, '00000000-0000-0000-0000-000000123021', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'以下关于FTP工作模型的描述中，错误的是（ ）。',
'C',
'在服务器端，控制连接使用TCP的21号端口，数据连接使用TCP的20号端口；而在客户端，控制连接和数据连接的TCP端口号都是由客户端系统自动分配的。当我们说FTP使用20、21号端口时，都是指相应协议的服务器端所使用的端口号，而客户端使用系统自动分配的端口号向这些服务的熟知端口发起连接。',
'FTP使用控制连接、数据连接来完成文件的传输', '用于控制连接的TCP连接在服务器端使用的熟知端口号为21', '用于控制连接的TCP连接在客户端使用的端口号为20', '服务器端由控制进程、数据进程两部分组成'),

(22, '00000000-0000-0000-0000-000000123022', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'控制信息是带外传送的协议是（ ）。',
'C',
'带外传送是指控制信息与数据信息通过不同的逻辑信道传送。例如，FTP使用一个单独的控制连接来传输控制信息，而数据连接用于传送文件。带内传送是指控制信息与数据信息通过同一个逻辑信道传送。例如，HTTP的请求和响应报文都是在同一个TCP连接上进行的。',
'HTTP', 'SMTP', 'FTP', 'POP3'),

(23, '00000000-0000-0000-0000-000000123023', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'下列关于FTP连接的叙述中，正确的是（ ）。',
'C',
'FTP客户首先连接服务器的21号端口，建立控制连接（控制连接在整个会话期间一直保持打开），然后建立数据连接，在数据传送完毕后，数据连接最先释放，控制连接最后释放。',
'控制连接先于数据连接被建立，并先于数据连接被释放', '数据连接先于控制连接被建立，并先于控制连接被释放', '控制连接先于数据连接被建立，并晚于数据连接被释放', '数据连接先于控制连接被建立，并晚于控制连接被释放'),

(24, '00000000-0000-0000-0000-000000123024', 'CN_APPLICATION', 'CN_FTP', 'BASIC', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'FTP客户发起对FTP服务器连接的第一阶段是建立（ ）。',
'D',
'FTP工作时使用两个连接：控制连接和数据连接。FTP客户对FTP服务器发起连接时，首先建立控制连接，即向服务器的21号TCP端口发起连接；然后建立数据连接（20号TCP端口）。FTP并没有传输连接和会话连接的说法。',
'传输连接', '数据连接', '会话连接', '控制连接'),

(25, '00000000-0000-0000-0000-000000123025', 'CN_APPLICATION', 'CN_FTP', 'BASIC', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'FTP中作为服务器一方的进程，通过监听（ ）端口得知有无服务请求。',
'D',
'FTP服务器通过监听熟知端口21（控制端口）得知有无服务请求。',
'53', '80', '20', '21'),

(26, '00000000-0000-0000-0000-000000123026', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'下列关于FTP的叙述中，错误的是（ ）。',
'C',
'因为FTP屏蔽了各计算机系统的细节，所以FTP适用于异构网络中计算机之间的文件传送。当进行文件传输时，FTP客户端和服务器之间需建立两个并行的控制连接和数据连接。FTP服务器主进程在熟知端口21上监听客户端的服务请求。FTP在传输层使用TCP进行可靠传输。',
'FTP可以实现异构网络中计算机之间的文件传送', '在进行文件传输时，FTP客户端和服务器之间需建立两个连接', 'FTP服务器主进程在20端口上监听客户端的连接请求', 'FTP使用TCP进行可靠传输'),

(27, '00000000-0000-0000-0000-000000123027', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'一个FTP用户发送了一个LIST命令来获取服务器的文件列表，这时服务器应通过（ ）端口来传输该列表。',
'B',
'FTP中数据连接的端口是20，而文件的列表是通过数据连接来传输的。',
'21', '20', '22', '19'),

(28, '00000000-0000-0000-0000-000000123028', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'下列关于FTP的叙述中，错误的是（ ）。',
'D',
'控制连接建立后，服务器进程用自己传送数据的熟知端口20与客户进程所提供的端口号建立数据传输连接（默认为PORT模式），即客户进程的端口号是客户进程自己提供的，而非默认使用端口20。',
'FTP可以在不同类型的操作系统之间传送文件', 'FTP并不适合用在两个计算机之间共享读写文件', '控制连接在整个FTP会话期间一直保持', '客户端默认使用端口20与服务器建立数据传输连接'),

(29, '00000000-0000-0000-0000-000000123029', 'CN_APPLICATION', 'CN_FTP', 'MEDIUM', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'当一台计算机从FTP服务器下载文件时，在该FTP服务器上对数据进行封装的5个转换步骤是（ ）。',
'B',
'FTP服务器的数据要经过应用层、传输层、网络层、数据链路层及物理层。因此，对应的封装是数据、数据段、数据报、数据帧，最后是比特。',
'比特，数据帧，数据报，数据段，数据', '数据，数据段，数据报，数据帧，比特', '数据报，数据段，数据，比特，数据帧', '数据段，数据报，数据帧，比特，数据'),

(30, '00000000-0000-0000-0000-000000123030', 'CN_APPLICATION', 'CN_FTP', 'BASIC', 'MOCK', 2027, '6.3文件传输协议FTP', 'pp.291-293',
'FTP支持两种方式的传输：ASCII方式和Binary（二进制）方式。文本文件通常采用（ ）方式，而图像、声音等非文本文件采用（ ）方式传输。',
'A',
'FTP支持ASCII和Binary两种方式的传输，非加密文本文件通常采用ASCII方式传输，而图像、声音等非文本文件采用Binary方式传输。',
'ASCII，Binary', 'Binary，ASCII', 'ASCII，ASCII', 'Binary，Binary');

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
    '原题来自《2027年计算机网络考研复习指导》第6章 应用层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共30道纯文本单选题。跳过1道图片依赖题：6.2 Q14（2020统考真题，含网络拓扑图，已记录至backlog）。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch6_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST('00000000-0000-0000-0001-000000123' || LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch6_a_text_import
UNION ALL
SELECT CAST('00000000-0000-0000-0001-000000123' || LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch6_a_text_import
UNION ALL
SELECT CAST('00000000-0000-0000-0001-000000123' || LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch6_a_text_import
UNION ALL
SELECT CAST('00000000-0000-0000-0001-000000123' || LPAD(CAST((num * 4) AS VARCHAR), 3, '0') AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch6_a_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch6_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new tags exist
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000123101', '2027计算机网络'),
    ('00000000-0000-0000-0000-000000123102', 'CN-2027-ORIGINAL-CH6-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000123103', '第6章应用层'),
    ('00000000-0000-0000-0000-000000123104', '6.1网络应用模型'),
    ('00000000-0000-0000-0000-000000123105', '6.2域名系统DNS'),
    ('00000000-0000-0000-0000-000000123106', '6.3文件传输协议FTP')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch6_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机网络',
    'CN-2027-ORIGINAL-CH6-A-TEXT-ONLY',
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
DROP TABLE cn_2027_original_ch6_a_text_import;
