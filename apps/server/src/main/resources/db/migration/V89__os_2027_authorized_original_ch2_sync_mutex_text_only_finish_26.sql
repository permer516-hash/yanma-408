-- Authorized original operating-system single-choice import based on:
-- /Users/permer/Documents/408资料/2027操作系统-高清带书签.pdf
-- Chapter 2: section 2.3 synchronization and mutual exclusion finish.
-- Text-only batch: questions whose stem/options/explanation can be rendered without images or tables.
-- Batch: OS-2027-ORIGINAL-CH2-G-TEXT-ONLY

CREATE TABLE os_2027_original_ch2_g_text_import (
    num INTEGER PRIMARY KEY,
    id VARCHAR(36) NOT NULL,
    difficulty VARCHAR(16) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    section_tag VARCHAR(64) NOT NULL,
    kp_code VARCHAR(64) NOT NULL,
    source_pages VARCHAR(64) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL
);

INSERT INTO os_2027_original_ch2_g_text_import (
    num, id, difficulty, source_type, source_year, section_tag, kp_code, source_pages,
    stem, answer, explanation, option_a, option_b, option_c, option_d
) VALUES
(1, '00000000-0000-0000-0000-000000089001', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.117,129',
'对信号量 S 执行 P 操作后，使该进程进入资源等待队列的条件是（ ）。', 'A',
'记录型信号量中，S.value>0 表示某类可用资源数量；每次 P 操作表示请求一个单位资源。S.value<0 表示该类资源已无可用，且存在因请求该资源而被阻塞的进程，S.value 的绝对值表示等待进程数量。题目问的是执行 P 操作后进入资源等待队列的条件，因此为 S.value<0。', 'S.value < 0', 'S.value <= 0', 'S.value > 0', 'S.value >= 0'),
(2, '00000000-0000-0000-0000-000000089002', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.117,129',
'有一个计数信号量 S：
1）假如若干进程对 S 进行 28 次 P 操作和 18 次 V 操作后，信号量 S 的值为 0。
2）假如若干进程对信号量 S 进行了 15 次 P 操作和 2 次 V 操作。请问此时有多少个进程等待在信号量 S 的队列中？（ ）', 'B',
'对 S 进行了 28 次 P 操作和 18 次 V 操作，即 S-28+18=0，得信号量初值为 10。然后对信号量 S 进行了 15 次 P 操作和 2 次 V 操作，即 S-15+2=10-15+2=-3。信号量为负值时，其绝对值表示等待队列中的进程数，所以有 3 个进程等待在信号量 S 的队列中。', '2', '3', '5', '7'),
(3, '00000000-0000-0000-0000-000000089003', 'MEDIUM', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.117,129-130',
'有两个并发进程 P1 和 P2，其程序代码如下：
P1() {
  x=1;      //A1
  y=2;
  z=x+y;
  print z; //A2
}

P2() {
  x=-3;    //B1
  c=x*x;
  print c; //B2
}
可能打印出的 z 值有（ ），可能打印出的 c 值有（ ）（其中 x 为 P1、P2 的共享变量）。', 'B',
'输出语句 A2、B2 中读取的 x 的值不同。由于 A1、B1 执行有先后问题，使得在执行 A2、B2 前，x 的可能取值有两个，即 1、-3。这样，输出 z 的值可能是 1+2=3 或 (-3)+2=-1；输出 c 的值可能是 1×1=1 或 (-3)×(-3)=9。', 'z=1,-3；c=-1,9', 'z=-1,3；c=1,9', 'z=-1,3,1；c=9', 'z=3；c=1,9'),
(4, '00000000-0000-0000-0000-000000089004', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.117,130',
'并发进程之间的关系是（ ）。', 'D',
'并发进程之间的关系没有必然要求，只有执行时间上的偶然重合，可能无关，也可能有交往。', '无关的', '相关的', '可能相关的', '可能是无关的，也可能是有交往的'),
(5, '00000000-0000-0000-0000-000000089005', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.117,130',
'若系统中有 4 个进程共享 3 台打印机，采用信号量机制控制打印机的共享使用，则信号量的取值范围是（ ）。', 'C',
'信号量的初值表示该类资源总数，因此初值取 3。每分配一个资源，信号量减 1；当信号量等于 0 时，表示该类资源刚好被分完；当信号量小于 0 时，表示还有进程正在等待该类资源，信号量的绝对值就是等待进程数量。因此没有进程使用时信号量最大为 3；当 3 个进程正在使用并有 1 个进程等待时，信号量最小为 -1。', '[-1,4]', '[-2,2]', '[-1,3]', '[-3,2]'),
(6, '00000000-0000-0000-0000-000000089006', 'MEDIUM', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.117,130',
'两个进程 P0、P1 互斥的 Peterson 算法描述如下：
进程 P0：
flag[0]=1;
(1);
while(flag[1]&&turn==1);
临界区;
flag[0]=0;
其余代码;

进程 P1：
flag[1]=1;
(2);
while(flag[0]&&turn==0);
临界区;
flag[1]=0;
其余代码;
其中，(1) 和 (2) 处的代码分别为（ ）。', 'C',
'根据 Peterson 算法的原理，进程在设置自身 flag 后应将 turn 置为对方编号，表示谦让对方。因此 (1) 和 (2) 处分别为 turn=1 和 turn=0。', 'turn=0, turn=0', 'turn=0, turn=1', 'turn=1, turn=0', 'turn=1, turn=1'),
(7, '00000000-0000-0000-0000-000000089007', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'在 Peterson 算法中，flag 数组的作用是（ ）。', 'A',
'flag 数组用于标记各个线程想进入临界区的意愿。当一个线程想要进入临界区时，它将自己对应的 flag 值置为 true；当线程退出临界区时，它将自己对应的 flag 值置为 false。', '表示每个线程是否想进入临界区', '表示每个线程是否已进入临界区', '表示每个线程是否已退出临界区', '表示每个线程是否已完成任务'),
(8, '00000000-0000-0000-0000-000000089008', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'在 Peterson 算法中，turn 变量的作用是（ ）。', 'A',
'turn 变量用于指示允许进入临界区的线程编号。当一个线程想进入临界区时，它将 turn 置为对方编号，表示优先让对方进入；若 turn 等于自己编号，则可进入，若 turn 等于对方编号，则需等待对方退出。', '表示轮到哪个线程进入临界区', '表示哪个线程先发出访问请求', '表示哪个线程后发出访问请求', '表示哪个线程已进入临界区'),
(9, '00000000-0000-0000-0000-000000089009', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'生产者-消费者问题用于解决（ ）。', 'B',
'进程并发带来的问题不仅包括同步互斥问题，还包括死锁等其他问题。生产者-消费者问题用于解决进程之间的同步和互斥问题。共享一个数据对象仅涉及互斥访问问题。', '多个进程共享一个数据对象的问题', '多个进程之间的同步和互斥问题', '多个进程共享资源的死锁与饥饿问题', '利用信号量实现多个进程并发的问题'),
(10, '00000000-0000-0000-0000-000000089010', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'所有的消费者必须等待生产者先运行的前提条件是（ ）。', 'A',
'当缓冲区为空时，消费者进程取产品会被阻塞，此时需等待生产者进程生产新产品。', '缓冲区空', '缓冲区满', '缓冲区不可用', '缓冲区半空'),
(11, '00000000-0000-0000-0000-000000089011', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'下列关于生产者-消费者问题的唤醒操作的说法中，正确的是（ ）。
I. 生产者唤醒其他生产者
II. 生产者唤醒消费者
III. 消费者唤醒其他消费者
IV. 消费者唤醒生产者', 'D',
'生产者和消费者共享缓冲区，每次只允许一个生产者或消费者进入缓冲区。当有一个生产者或消费者进入缓冲区时，其他生产者或消费者就必须阻塞等待。因此，生产者可能唤醒其他生产者或消费者，消费者也可能唤醒其他生产者或消费者，四个选项均正确。', 'I 和 II', 'III 和 IV', 'II 和 III', 'I、II、III 和 IV'),
(12, '00000000-0000-0000-0000-000000089012', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'在 9 个生产者、6 个消费者共享容量为 8 的缓冲区的生产者-消费者问题中，互斥使用缓冲区的信号量初始值为（ ）。', 'A',
'所谓互斥使用临界资源，是指在同一时间段只允许一个进程使用此资源，所以互斥信号量的初值为 1。', '1', '6', '8', '9'),
(13, '00000000-0000-0000-0000-000000089013', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'消费者进程阻塞在 wait(m)（m 是互斥信号量）的条件是（ ）。
I. 没有空缓冲区
II. 没有满缓冲区
III. 有其他生产者已进入临界区
IV. 有其他消费者已进入临界区', 'B',
'在生产者-消费者问题中，每次只能有一个生产者或消费者进入缓冲区，需要用互斥信号量控制。当有一个生产者或消费者进入缓冲区时，其他申请进入缓冲区的消费者会被阻塞。因此消费者进程阻塞在互斥信号量 m 上的条件是已有其他生产者或其他消费者进入临界区。', 'I 和 II', 'III 和 IV', 'I 和 III', 'II 和 IV'),
(14, '00000000-0000-0000-0000-000000089014', 'BASIC', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'在读者-写者问题中，能同时执行的是（ ）。', 'C',
'在读者-写者问题中，写者和写者之间、写者和读者之间必须互斥访问共享对象，读者和读者之间则可以同时访问。', '读者和写者', '不同的写者', '不同的读者', '都不能'),
(15, '00000000-0000-0000-0000-000000089015', 'MEDIUM', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118,130',
'哲学家就餐问题的解决方案如下：
semaphore *chopstick[5];
semaphore *seat;
哲学家 i:
...
P(seat);
P(chopStick[i]);
P(chopStick[(i+1)%5]);
吃饭
V(chopStick[i]);
V(chopStick[(i+1)%5]);
V(seat)
其中，信号量 seat 的初值最大为（ ）。', 'C',
'信号量 seat 表示桌子上可以坐下的位置数。因为只有 5 个位置，所以每次只允许 4 位哲学家同时拿起左边的餐叉，才能保证不会发生死锁，因此 seat 的初值应为 4。', '0', '1', '4', '5'),
(16, '00000000-0000-0000-0000-000000089016', 'MEDIUM', 'MOCK', 2027, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.118-119,131',
'有两个优先级相同的并发程序 P1 和 P2，它们的执行过程如下所示。假设当前信号量 s1=0，s2=0，当前 z=2，进程运行结束后，x、y 和 z 的值分别是（ ）。
进程 P1：
...
y:=1;
y:=y+2;
z:=y+1;
V(s1);
P(s2);
y:=z+y;
...

进程 P2：
...
x:=1;
x:=x+1;
P(s1);
x:=x+y;
z:=x+z;
V(s2);
...', 'C',
'进程并发执行具有不确定性。在 P1、P2 执行到第一个 P/V 操作前相互无关。考虑对 s1 的 P/V 操作，P2 必须等待 P1 执行完 V(s1) 后才能继续，此时 x、y、z 分别为 2、3、4。P1 随后在 P(s2) 上阻塞，P2 运行直到 V(s2)，此时 x、y、z 分别为 5、3、9。P1 继续运行到结束，最终 x、y、z 分别为 5、12、9。', '5,9,9', '5,9,4', '5,12,9', '5,12,4'),
(17, '00000000-0000-0000-0000-000000089017', 'BASIC', 'PAST_EXAM', 2010, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.119,131',
'【2010 统考真题】设与某资源关联的信号量初值为 3，当前值为 1。若 M 表示该资源的可用个数，N 表示等待该资源的进程数，则 M、N 分别是（ ）。', 'B',
'信号量表示相关资源的当前可用数量。当信号量 K>0 时，表示还有 K 个相关资源可用，所以该资源的可用个数是 1；当信号量 K<0 时，表示有 |K| 个进程在等待该资源。因为资源有剩余，可见没有其他进程等待使用该资源，所以等待进程数为 0。', '0,1', '1,0', '1,2', '2,0'),
(18, '00000000-0000-0000-0000-000000089018', 'MEDIUM', 'PAST_EXAM', 2010, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.119,131',
'【2010 统考真题】进程 P0 和进程 P1 的共享变量定义及其初值为：
boolean flag[2];
int turn=0;
flag[0]=false; flag[1]=false;
若进程 P0 和进程 P1 访问临界资源的类 C 代码实现如下：
void P0() {
  while(true) {
    flag[0]=true; turn=1;
    while(flag[1] && (turn==1));
    临界区;
    flag[0]=false;
  }
}

void P1() {
  while(true) {
    flag[1]=true; turn=0;
    while(flag[0] && (turn==0));
    临界区;
    flag[1]=false;
  }
}
则并发执行进程 P0 和进程 P1 时产生的情况是（ ）。', 'D',
'这是 Peterson 算法的实际实现，能保证进入临界区的进程合理安全。该算法通过 flag 表示进程是否想进入临界区，通过 turn 表示允许进入临界区的编号；当两个进程同时要求进入临界区时，只允许一个进程进入，保存较晚一次 turn 赋值的进程等待，较早的进程进入，从而保证互斥且不会饥饿。', '不能保证进程互斥进入临界区，会出现“饥饿”现象', '不能保证进程互斥进入临界区，不会出现“饥饿”现象', '能保证进程互斥进入临界区，会出现“饥饿”现象', '能保证进程互斥进入临界区，不会出现“饥饿”现象'),
(19, '00000000-0000-0000-0000-000000089019', 'MEDIUM', 'PAST_EXAM', 2011, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.119,131',
'【2011 统考真题】有两个并发执行的进程 P1 和 P2，共享初值为 1 的变量 x。P1 对 x 加 1，P2 对 x 减 1。加 1 和减 1 操作的指令序列分别如下：
加 1 操作：
load R1,x
inc R1
store x,R1

减 1 操作：
load R2,x
dec R2
store x,R2
两个操作完成后，x 的值（ ）。', 'C',
'x 的最终值取决于最后哪个进程对 x 进行写操作。P1 最初取到的 x 值可能是 1，也可能是 P2 完成后更新得到的 0，因此 P1 最终写入 x 的值可能是 2 或 1。P2 最初取到的 x 值可能是 1，也可能是 P1 完成后更新得到的 2，因此 P2 最终写入 x 的值可能是 0 或 1。因此最终 x 的值可能是 0、1 或 2。', '可能为 -1 或 3', '只能为 1', '可能为 0、1 或 2', '可能为 -1、0、1 或 2'),
(20, '00000000-0000-0000-0000-000000089020', 'MEDIUM', 'PAST_EXAM', 2016, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.119-120,131',
'【2016 统考真题】进程 P1 和 P2 均包含并发执行的线程，部分伪代码描述如下所示。
进程 P1：
int x=0;
Thread1() { int a; a=1; x+=1; }
Thread2() { int a; a=2; x+=2; }

进程 P2：
int x=0;
Thread3() { int a; a=x; x+=3; }
Thread4() { int b; b=x; x+=4; }
下列选项中，需要互斥执行的操作是（ ）。', 'C',
'需要进行互斥的操作是对临界资源的访问。不同线程对同一个进程内部共享变量的访问才有可能需要互斥；不同进程的线程、代码段或变量不存在互斥访问问题，同一线程内部的局部变量也不存在互斥访问问题。选项 C 是不同线程对同一进程内部共享变量的写操作，需要互斥访问。', 'a=1 与 a=2', 'a=x 与 b=x', 'x+=1 与 x+=2', 'x+=1 与 x+=3'),
(21, '00000000-0000-0000-0000-000000089021', 'MEDIUM', 'PAST_EXAM', 2016, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.120,131-132',
'【2016 统考真题】使用 TSL（Test and Set Lock）指令实现进程互斥的伪代码如下所示。
do {
  ...
  while(TSL(&lock));
  critical section;
  lock=FALSE;
  ...
} while(TRUE);
下列与该实现机制相关的叙述中，正确的是（ ）。', 'B',
'使用 TSL 指令实现进程互斥时，并没有阻塞态进程。等待进入临界区的进程一直停留在执行 while(TSL(&lock)) 的循环中，不会主动放弃 CPU，一直处于运行态，直到时间片用完转为就绪态。TSL 指令本身是原子操作，不需要关中断来保证其不被打断。', '退出临界区的进程负责唤醒阻塞态进程', '等待进入临界区的进程不会主动放弃 CPU', '上述伪代码满足“让权等待”的同步准则', 'while(TSL(&lock)) 语句应在关中断状态下执行'),
(22, '00000000-0000-0000-0000-000000089022', 'BASIC', 'PAST_EXAM', 2016, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.120,132',
'【2016 统考真题】下列关于管程的叙述中，错误的是（ ）。', 'A',
'管程是由一组数据及定义在这组数据之上的操作组成的软件模块，这组操作能初始化并改变管程中的数据和同步进程。管程不仅能实现进程间的互斥，还能实现进程间的同步，因此“只能用于实现进程的互斥”错误。', '管程只能用于实现进程的互斥', '管程是由编程语言支持的进程同步机制', '任何时候只能有一个进程在管程中执行', '管程中定义的变量只能被管程内的过程访问'),
(23, '00000000-0000-0000-0000-000000089023', 'MEDIUM', 'PAST_EXAM', 2018, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.120,132',
'【2018 统考真题】属于同一进程的两个线程 thread1 和 thread2 并发执行，共享初值为 0 的全局变量 x。thread1 和 thread2 实现对全局变量 x 加 1 的机器级代码描述如下：
thread1:
mov R1,x
inc R1
mov x,R1

thread2:
mov R2,x
inc R2
mov x,R2
在所有可能的指令执行序列中，使 x 的值为 2 的序列个数是（ ）。', 'B',
'两个线程均对 x 进行加 1 操作，x 初始值为 0。若要使最终 x=2，只能先完整执行 thread1 再完整执行 thread2，或先完整执行 thread2 再完整执行 thread1，因此仅有 2 种可能。', '1', '2', '3', '4'),
(24, '00000000-0000-0000-0000-000000089024', 'BASIC', 'PAST_EXAM', 2018, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.120,132',
'【2018 统考真题】若 x 是管程内的条件变量，则当进程执行 x.wait() 时所做的工作是（ ）。', 'D',
'条件变量是管程内部说明和使用的一种特殊变量，用于实现进程同步。在同一时刻，管程中只能有一个进程执行。若进程执行 x.wait() 操作，则该进程会阻塞，并挂到条件变量 x 对应的阻塞队列上，同时释放管程使用权。', '实现对变量 x 的互斥访问', '唤醒一个在 x 上阻塞的进程', '根据 x 的值判断该进程是否进入阻塞态', '阻塞该进程，并将之插入 x 的阻塞队列中'),
(25, '00000000-0000-0000-0000-000000089025', 'BASIC', 'PAST_EXAM', 2018, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.120,132',
'【2018 统考真题】在下列同步机制中，可以实现让权等待的是（ ）。', 'C',
'硬件方法实现进程同步时不能实现让权等待；Peterson 算法满足有限等待但不满足让权等待。记录型信号量由于引入阻塞机制，消除了不让权等待的情况，因此信号量方法可以实现让权等待。', 'Peterson 方法', 'swap 指令', '信号量方法', 'TestAndSet 指令'),
(26, '00000000-0000-0000-0000-000000089026', 'BASIC', 'PAST_EXAM', 2020, '2.3同步与互斥', 'OS_SYNC_MUTEX', 'pp.120,132',
'【2020 统考真题】下列准则中，实现临界区互斥机制必须遵循的是（ ）。
I. 两个进程不能同时进入临界区
II. 允许进程访问空闲的临界资源
III. 进程等待进入临界区的时间是有限的
IV. 不能进入临界区的执行态进程立即放弃 CPU', 'C',
'实现临界区互斥需满足多个准则。“忙则等待”准则，即两个进程不能同时访问临界区，I 正确；“空闲让进”准则，即临界区空闲时允许其他进程访问，II 正确；“有限等待”准则，即进程应在有限时间内访问临界区，III 正确。IV 是“让权等待”准则，不一定必须实现，如 Peterson 算法。', '仅 I、IV', '仅 II、III', '仅 I、II、III', '仅 I、III、IV');

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
    '授权原题导入：/Users/permer/Documents/408资料/2027操作系统-高清带书签.pdf，第 2 章 2.3.8/2.3.9 本节习题精选及答案解析；本批仅导入题干与答案解析均可完整文本呈现的单选题，参考页：' || q.source_pages || '。',
    'PLAIN_TEXT',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM os_2027_original_ch2_g_text_import q
JOIN subjects s ON s.code = 'OPERATING_SYSTEM'
JOIN chapters c ON c.code = 'OS_PROCESS';

INSERT INTO question_options (id, question_id, label, content, sort_order)
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000189', LPAD(CAST((num * 4 - 3) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'A', option_a, 1
FROM os_2027_original_ch2_g_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000189', LPAD(CAST((num * 4 - 2) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'B', option_b, 2
FROM os_2027_original_ch2_g_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000189', LPAD(CAST((num * 4 - 1) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'C', option_c, 3
FROM os_2027_original_ch2_g_text_import
UNION ALL
SELECT CAST(CONCAT('00000000-0000-0000-0000-000000189', LPAD(CAST((num * 4) AS VARCHAR), 3, '0')) AS UUID), CAST(id AS UUID), 'D', option_d, 4
FROM os_2027_original_ch2_g_text_import;

INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
SELECT CAST(q.id AS UUID), kp.id
FROM os_2027_original_ch2_g_text_import q
JOIN knowledge_points kp ON kp.code = q.kp_code;

INSERT INTO question_tags (id, name, created_at)
SELECT CAST(tag.id AS UUID), tag.name, CURRENT_TIMESTAMP
FROM (
    VALUES
    ('00000000-0000-0000-0000-000000089701', 'OS-2027-ORIGINAL-CH2-G-TEXT-ONLY')
) AS tag(id, name)
WHERE NOT EXISTS (SELECT 1 FROM question_tags existing WHERE existing.name = tag.name);

INSERT INTO question_tag_relations (question_id, tag_id)
SELECT CAST(q.id AS UUID), tag.id
FROM os_2027_original_ch2_g_text_import q
JOIN question_tags tag ON tag.name IN (
    '2027操作系统',
    'OS-2027-ORIGINAL-CH2-G-TEXT-ONLY',
    '第2章进程与线程',
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

DROP TABLE os_2027_original_ch2_g_text_import;
