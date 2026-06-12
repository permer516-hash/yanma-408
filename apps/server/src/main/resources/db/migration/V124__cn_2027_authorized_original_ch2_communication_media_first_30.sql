-- Authorized original computer-network single-choice import based on:
-- /Users/permer/Documents/408资料/2027计算机网络_高清带书签版.pdf
-- Chapter 2: 物理层 (2.1 通信基础 + 2.2 传输介质, first batch).
-- Text-only batch: 30 pure-text questions (20 from 2.1, 10 from 2.2).
-- Deferred: Q8 (Manchester waveform), Q20 (10Base-T waveform), Q22 (encoding comparison diagram),
--          Q23 (network topology diagram), Q25 (differential Manchester waveform).
-- Batch: CN-2027-ORIGINAL-CH2-A-TEXT-ONLY

-- ============================================================
-- Ensure chapter exists (CN_PHYSICAL from V18)
-- ============================================================
INSERT INTO chapters (id, subject_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000018213',
    s.id,
    'CN_PHYSICAL',
    '物理层',
    22
FROM subjects s
WHERE s.code = 'COMPUTER_NETWORK'
  AND NOT EXISTS (SELECT 1 FROM chapters c WHERE c.code = 'CN_PHYSICAL');

-- ============================================================
-- Ensure knowledge points exist
-- ============================================================
INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000124301',
    c.id,
    'CN_PHYSICAL_COMMUNICATION',
    '通信基础',
    1
FROM chapters c
WHERE c.code = 'CN_PHYSICAL'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_PHYSICAL_COMMUNICATION');

INSERT INTO knowledge_points (id, chapter_id, code, name, sort_order)
SELECT
    '00000000-0000-0000-0000-000000124302',
    c.id,
    'CN_PHYSICAL_MEDIA',
    '传输介质',
    2
FROM chapters c
WHERE c.code = 'CN_PHYSICAL'
  AND NOT EXISTS (SELECT 1 FROM knowledge_points kp WHERE kp.code = 'CN_PHYSICAL_MEDIA');

-- ============================================================
-- Temporary import table
-- ============================================================
CREATE TABLE cn_2027_original_ch2_a_text_import (
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

INSERT INTO cn_2027_original_ch2_a_text_import (
    num, id, chapter_code, kp_code, difficulty, source_type, source_year, section_tag, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
-- ============================================================
-- 2.1 通信基础 Q1-Q7, Q9-Q19, Q21, Q24 (20 questions)
-- Q1-Q7, Q9-Q17: 模拟题 (MOCK, 2027)
-- Q18-Q19, Q21, Q24: 统考真题 (PAST_EXAM)
-- Deferred: Q8 (Manchester waveform), Q20 (10Base-T waveform), Q22 (encoding diagram), Q23 (network diagram), Q25 (differential Manchester waveform)
-- ============================================================

(1, '00000000-0000-0000-0000-000000124001', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,50',
'下列说法正确的是（ ）。',
'D',
'信道不等于通信电路，一条可双向通信的电路往往包含两个信道，一个是发送信道，一个是接收信道。另外，多个通信用户共用通信电路时，每个用户在该通信电路都有一个信道，因此选项A错误。调制是将数据转换为模拟信号的过程，选项B错误。选项C明显错误。"比特率"在数值上和"波特率"的关系如下：波特率=比特率/每符号所含的比特数，选项D正确。',
'一条可双向通信的电路包含一个信道', '调制是将模拟数据转换为数字信号的过程', '一条通信电路上只允许一个信道', '比特率在数值上可能与波特率不同'),

(2, '00000000-0000-0000-0000-000000124002', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,50',
'影响信道最大传输速率的因素主要有（ ）。',
'A',
'根据香农定理，影响信道最大传输速率的因素主要有信道带宽和信噪比，而信噪比与信道内所传输的平均信号功率和噪声功率有关，数值上等于二者之比。',
'信道带宽和信噪比', '码元传输速率和噪声功率', '频率特性和带宽', '发送功率和噪声功率'),

(3, '00000000-0000-0000-0000-000000124003', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,50',
'（ ）被用于计算机内部的数据传输。',
'B',
'并行传输的特点：距离短、速度快。串行传输的特点：距离长、速度慢。因此，在计算机内部（距离短）传输时应选择并行传输。同步、异步传输是通信方式，而不是传输方式。',
'串行传输', '并行传输', '同步传输', '异步传输'),

(4, '00000000-0000-0000-0000-000000124004', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,50-51',
'下列有关曼彻斯特编码的叙述中，正确的是（ ）。',
'B',
'曼彻斯特编码将时钟和数据包含在信号中，在传输数据的同时，也将时钟信号一起传输给对方，码元中间的跳变作为时钟信号，不同的跳变方式作为数据信号，选项A错误、选项B正确。每个码元的中间都发生电平跳变，选项D错误。曼彻斯特编码最适合传输二进制数字信号，选项C错误。',
'每个信号起始边界作为时钟信号有利于同步', '将时钟与数据取值都包含在信号中', '这种编码机制特别适合传输模拟数据', '每位中间不跳变表示信号的取值为0'),

(5, '00000000-0000-0000-0000-000000124005', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,51',
'在数据通信中使用曼彻斯特编码的主要原因是（ ）。',
'B',
'曼彻斯特编码用码元中间的电平跳变来表示每个比特，可方便收发双方根据跳变来同步时钟，而不需要额外的时钟信号，选项B正确。',
'实现对通信过程中传输错误的恢复', '实现对通信过程中收发双方的数据同步', '提高对数据的有效传输速率', '提高传输信号的抗干扰能力'),

(6, '00000000-0000-0000-0000-000000124006', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,51',
'不含同步信息的编码是（ ）。
I. 非归零编码
II. 曼彻斯特编码
III. 差分曼彻斯特编码',
'A',
'非归零编码是最简单的一种编码方式，它用低电平表示0，用高电平表示1，或者采用相反的表示方式。因为各个码元之间并没有间隔标志，所以不包含同步信息。曼彻斯特编码和差分曼彻斯特编码都将每个码元分成两个相等的时间间隔，码元的中间跳变也作为收发双方的同步信息，因此不需要额外的同步信息，实际应用较多，但它们所占的频带宽度是原始基带宽度的2倍。',
'仅I', '仅II', '仅II、III', 'I、II、III'),

(7, '00000000-0000-0000-0000-000000124007', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,51',
'若信道的波特率为1000Baud，若令其数据传输速率达到4kb/s，则一个信号码元所取的有效离散值个数为（ ）。',
'D',
'比特率=波特率×log₂N，若一个码元含有n比特的信息量，则表示该码元所需的不同离散值为N=2ⁿ个。波特率数值上等于比特率/每符号所含的比特数，因此每码元所含比特数=4000/1000=4，有效离散值的个数为2⁴=16。',
'2', '4', '8', '16'),

(8, '00000000-0000-0000-0000-000000124008', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,51',
'已知某信道的信息传输速率为64kb/s，一个载波信号码元有4个有效离散值，则该信道的波特率为（ ）。',
'B',
'一个码元若取2ⁿ个不同的离散值，则含有n比特的信息量。本题中，一个码元所含的信息量为2比特，因为数值上波特率=比特率/每符号所含的比特数，所以波特率为64/2=32kBaud。',
'16kBaud', '32kBaud', '64kBaud', '128kBaud'),

(9, '00000000-0000-0000-0000-000000124009', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,51',
'有一个无噪声的8kHz信道，每个信号包含8级，每秒采样24k次，那么可以获得的最大传输速率是（ ）。',
'C',
'无噪声的信号应该满足奈奎斯特定理，即最大数据传输速率=2Wlog₂N比特/秒。将题中的数据代入，得到答案是48kb/s。注意题中给出的每秒采样24kHz是无意义的，因为超过了波特率的上限2W=16kBaud，所以选项D是错误答案。',
'24kb/s', '32kb/s', '48kb/s', '72kb/s'),

(10, '00000000-0000-0000-0000-000000124010', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,51',
'对于某带宽为4000Hz的低通信道，采用16种不同的物理状态来表示数据。按照奈奎斯特定理，信道的最大传输速率是（ ）。',
'D',
'根据奈奎斯特定理，题中W=4000Hz，最大码元传输速率=2W=8000Baud，16种不同的物理状态可以表示log₂16=4比特的数据，因此信道的最大传输速率=8000×4=32kb/s。',
'4kb/s', '8kb/s', '16kb/s', '32kb/s'),

(11, '00000000-0000-0000-0000-000000124011', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,51-52',
'二进制信号在信噪比为127:1的4kHz信道上传输，最大数据传输速率可以达到（ ）。',
'B',
'根据香农定理，最大数据率=Wlog₂(1+S/N)=4000×log₂(1+127)=28000b/s，容易误选A。注意题中"二进制信号"的限制后，依据奈奎斯特定理，最大数据传输速率=2Wlog₂N=2×4000×log₂2=8000b/s，两个上限中取小者，因此答案为B。',
'28000b/s', '8000b/s', '4000b/s', '无限大'),

(12, '00000000-0000-0000-0000-000000124012', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,52',
'电话系统的典型参数是信道带宽为3000Hz，信噪比为30dB，该系统的最大数据传输速率为（ ）。',
'C',
'信噪比SN常用分贝(dB)表示，数值上等于10log₁₀(S/N)dB。依题意有30=10log₁₀(S/N)，解出S/N=1000。根据香农定理，最大数据传输速率=3000log₂(1+S/N)≈30kb/s。',
'3kb/s', '6kb/s', '30kb/s', '64kb/s'),

(13, '00000000-0000-0000-0000-000000124013', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.47,52',
'一个信道的信号功率是0.14W，噪声功率是0.02W，频率范围为3.5～3.9MHz，则该信道的最高数据传输速率是（ ）。',
'A',
'带宽受限且有噪声的信道应使用香农定理。最高数据传输速率=Wlog₂(1+S/N)，其中，信道带宽W=3.9-3.5=0.4MHz，信号功率S=0.14W，噪声功率N=0.02W，代入得12Mb/s。',
'12Mb/s', '2.4Mb/s', '11.7Mb/s', '23.4Mb/s'),

(14, '00000000-0000-0000-0000-000000124014', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.48,52',
'采用8种相位，每种相位各有两种幅度的QAM调制方法，在1200Baud的信号传输速率下能达到的数据传输速率为（ ）。',
'D',
'每个信号有8×2=16种变化，每个码元携带log₂16=4比特信息，则信息传输速率为1200×4=4800b/s。',
'2400b/s', '3600b/s', '9600b/s', '4800b/s'),

(15, '00000000-0000-0000-0000-000000124015', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.48,52',
'一个信道每1/8s采样一次，传输信号共有16种变化状态，最大数据传输速率是（ ）。',
'B',
'由题意知采样率为8Hz。有16种变化状态的信号可携带4比特的数据，因此最大数据传输速率为8×4=32b/s。',
'16b/s', '32b/s', '48b/s', '64b/s'),

(16, '00000000-0000-0000-0000-000000124016', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'MOCK', 2027, '2.1通信基础', 'pp.48,52',
'某信道的带宽为10MHz，信噪比为30dB，采用QAM-32调制方案。若将带宽提高到20MHz，信噪比提高到40dB，则信道的极限数据传输速率大约提高到原来的（ ）倍。',
'A',
'本题给出了信道带宽、信噪比和编码方式，需要综合奈氏准则与香农定理的限制。在原始条件下：香农定理的极限速率为10×log₂1001≈100Mb/s，奈氏准则的极限速率为2×10×log₂32=100Mb/s。带宽和信噪比提升后：香农定理的极限速率为20×log₂10001≈260Mb/s，奈氏准则的极限速率为2×20×log₂32=200Mb/s。由于实际速率受限于二者中的较小值，故提升后的极限速率为200Mb/s，约为原来的2倍。',
'2', '2.2', '2.4', '2.6'),

(17, '00000000-0000-0000-0000-000000124017', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'PAST_EXAM', 2009, '2.1通信基础', 'pp.48,52',
'【2009统考真题】在无噪声的情况下，若某通信链路的带宽为3kHz，采用4个相位，每个相位具有4种幅度的QAM调制技术，则该通信链路的最大数据传输速率是（ ）。',
'B',
'采用4个相位，每个相位有4种幅度的QAM调制，共有16种信号状态，每个码元可携带log₂16=4比特信息。根据奈奎斯特定理，最大传输速率为2W×log₂N=2×3k×4=24kb/s。',
'12kb/s', '24kb/s', '48kb/s', '96kb/s'),

(18, '00000000-0000-0000-0000-000000124018', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'PAST_EXAM', 2011, '2.1通信基础', 'pp.48,52',
'【2011统考真题】若某通信链路的数据传输速率为2400b/s，采用4个相位调制，则该链路的波特率是（ ）。',
'B',
'波特率(B)与数据传输速率(C)的关系为C=B×log₂N，其中N为码元可取的离散值个数。采用4种相位调制，即N=4，每个码元携带log₂N=log₂4=2比特信息。因此，波特率=数据传输速率/每个码元所含的比特数=2400/2=1200波特。',
'600Baud', '1200Baud', '4800Baud', '9600Baud'),

(19, '00000000-0000-0000-0000-000000124019', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'PAST_EXAM', 2014, '2.1通信基础', 'pp.48,52',
'【2014统考真题】在下列因素中，不影响信道数据传输速率的是（ ）。',
'D',
'由香农定理可知，信道极限数据传输速率受信噪比和频率带宽限制；调制速率（波特率）也直接影响数据速率。而信号传播速率仅决定传播时延，与传输速率无关，不影响信道数据传输速率。',
'信噪比', '频率带宽', '调制速率', '信号传播速度'),

(20, '00000000-0000-0000-0000-000000124020', 'CN_PHYSICAL', 'CN_PHYSICAL_COMMUNICATION', 'BASIC', 'PAST_EXAM', 2017, '2.1通信基础', 'pp.48,52',
'【2017统考真题】若信道在无噪声情况下的极限数据传输速率不小于信噪比为30dB条件下的极限数据传输速率，则信号状态数至少是（ ）。',
'D',
'设信号状态数为N。无噪声信道的极限速率（奈奎斯特定理）为2Wlog₂N；有噪声信道的极限速率（香农定理）为Wlog₂(1+S/N)。已知信噪比为30dB，可得S/N=1000，要求：2Wlog₂N≥Wlog₂(1+1000)≈W×10，化简得log₂N≥5，求得N≥32。因此，信号状态数至少为32。',
'4', '8', '16', '32'),

-- ============================================================
-- 2.2 传输介质 Q1-Q10 (10 questions)
-- Q1-Q10: 模拟题 (MOCK, 2027)
-- ============================================================

(21, '00000000-0000-0000-0000-000000124021', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'双绞线由两根相互绝缘、按一定规则绞合在一起的铜导线组成，绞合可（ ）。',
'A',
'绞合可以减少两根导线相互的电磁干扰。',
'减少两根导线相互的电磁干扰', '提高数据传输速率', '增加传输距离', '降低制造成本'),

(22, '00000000-0000-0000-0000-000000124022', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'屏蔽双绞线（STP）在双绞线外加了一层金属丝编织的屏蔽层，屏蔽层的主要作用是（ ）。',
'B',
'屏蔽层的主要作用是提高电缆的抗干扰能力。',
'增加电缆的机械强度', '提高电缆的抗干扰能力', '降低信号衰减', '提高数据传输速率'),

(23, '00000000-0000-0000-0000-000000124023', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'传统以太网采用广播的方式发送信息，同一时间只允许一台主机发送信息，否则各主机之间就形成冲突，因此主机间的通信方式是（ ）。',
'B',
'传统以太网采用广播的方式发送信息，同一时间只允许一台主机发送信息，否则各主机之间就形成冲突，因此主机间的通信方式是半双工。全双工是指通信双方可同时发送和接收信息。单工是指只有一个方向的通信而没有反方向的交互。',
'单工', '半双工', '全双工', '以上都不对'),

(24, '00000000-0000-0000-0000-000000124024', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'同轴电缆以外导体为屏蔽层，使得它比双绞线具有更高的带宽和更好的抗噪性。同轴电缆的带宽更高，得益于它的（ ）。',
'C',
'同轴电缆以硬铜线为芯，外面包一层绝缘材料，绝缘材料的外面再包一层密织的网状导体，导体的外面又覆盖一层保护性的塑料外壳。这种结构使得它具有更高的屏蔽性，从而既有很高的带宽，又有很好的抗噪性。因此，同轴电缆的带宽更高，得益于它的高屏蔽性。',
'更大的导体直径', '更好的绝缘材料', '高屏蔽性', '更长的传输距离'),

(25, '00000000-0000-0000-0000-000000124025', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'在下列传输介质中，抗雷电和电磁干扰性能最好的是（ ）。',
'C',
'光纤的抗雷电和电磁干扰性能好，无串音干扰，保密性好。',
'双绞线', '同轴电缆', '光纤', '无线传输介质'),

(26, '00000000-0000-0000-0000-000000124026', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'多模光纤传输光信号的原理是（ ）。',
'C',
'多模光纤传输光信号的原理是光的全反射特性。',
'光的折射', '光的衍射', '光的全反射', '光的直线传播'),

(27, '00000000-0000-0000-0000-000000124027', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'光纤的直径减小到与光线的一个波长相同时，光纤就如同一个波导，光在其中没有反射，而沿直线传播，这就是（ ）。',
'B',
'光纤的直径减小到与光线的一个波长相同时，光纤就如同一个波导，光在其中没有反射，而沿直线传播，这就是单模光纤。',
'多模光纤', '单模光纤', '屏蔽双绞线', '同轴电缆'),

(28, '00000000-0000-0000-0000-000000124028', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'下列关于卫星通信的说法中，错误的是（ ）。',
'C',
'卫星通信有成本高、传播时延长、受气候影响大、保密性差、误码率较高的特点。选项C"卫星通信的好处在于不受气候的影响，误码率很低"是错误的。',
'卫星通信的距离长，覆盖的范围广', '使用卫星通信易于实现广播通信和多址通信', '卫星通信的好处在于不受气候的影响，误码率很低', '通信费用高、延时较大是卫星通信的不足之处'),

(29, '00000000-0000-0000-0000-000000124029', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'某网络在物理层规定，信号的电平用+10V～+15V表示二进制0，用-10V～-15V表示二进制1，电线长度限于15m以内，这体现了物理层接口的（ ）。',
'C',
'本题易误选功能特性。规定各条线上的电压范围，以及电缆长度的限制，属于电气特性。而功能特性指明某条线上出现的某一电平的电压表示何种意义，以及每条线的功能（数据线、控制线、时钟线）。例如，数据线上的电压+11V表示二进制1，就属于功能特性。',
'机械特性', '功能特性', '电气特性', '规程特性'),

(30, '00000000-0000-0000-0000-000000124030', 'CN_PHYSICAL', 'CN_PHYSICAL_MEDIA', 'BASIC', 'MOCK', 2027, '2.2传输介质', 'pp.56,57',
'当描述一个物理层接口引脚处于高电平时的含义时，该描述属于（ ）。',
'C',
'物理层的功能特性指明某条线上出现的某一电平的电压表示何种意义，以及每条线的功能。',
'机械特性', '电气特性', '功能特性', '规程特性');

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
    '原题来自《2027年计算机网络考研复习指导》第2章 物理层 ' || q.section_tag || ' 本节试题精选。原始页码：' || q.source_pages || '。本批共30道纯文本单选题，含4道统考真题。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM cn_2027_original_ch2_a_text_import q
JOIN subjects s ON s.code = 'COMPUTER_NETWORK'
JOIN chapters c ON c.code = q.chapter_code;

-- ============================================================
-- Insert into question_options
-- ============================================================
INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000124', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM cn_2027_original_ch2_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000124', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM cn_2027_original_ch2_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000124', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM cn_2027_original_ch2_a_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0001-000000124', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM cn_2027_original_ch2_a_text_import;

-- ============================================================
-- Insert into question_knowledge_points
-- ============================================================
INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM cn_2027_original_ch2_a_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

-- ============================================================
-- Tags and tag relations
-- ============================================================

-- Ensure new tags exist
INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000124101', 'CN-2027-ORIGINAL-CH2-A-TEXT-ONLY'),
    ('00000000-0000-0000-0000-000000124102', '第2章物理层'),
    ('00000000-0000-0000-0000-000000124103', '2.1通信基础'),
    ('00000000-0000-0000-0000-000000124104', '2.2传输介质')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

-- Bind tags
INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM cn_2027_original_ch2_a_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027计算机网络',
    'CN-2027-ORIGINAL-CH2-A-TEXT-ONLY',
    '第2章物理层',
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
DROP TABLE cn_2027_original_ch2_a_text_import;
