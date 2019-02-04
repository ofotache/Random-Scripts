#!/bin/bash
#   This is a shell script which gathers values from vmstat
#   and appends them to a sqlite3 database in order to keep a history
# ---------------------------------------------------------------------------------
# [root@arch ~]# vmstat -V
# vmstat from procps-ng 3.3.15
# 
# [root@arch ~]# vmstat
# procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
#  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
#  1  0      0 173216  61088 610908    0    0    50   115  188  193  1  1 90  8  0
# ---------------------------------------------------------------------------------
# Made by:  https://github.com/ovitedor/
# ---------------------------------------------------------------------------------
# CREATE sqlite3 DB
# [root@arch ~]# sqlite3 monitor.db "CREATE TABLE vmstat('time'DATETIME,'r'num(10),'b'num(10),'swpd'num(10),'free'num(10),'buff'num(10),'cache'num(10),'si'num(10),'so'num(10),'bi'num(10),'bo'num(10),'in'num(10),'cs'num(10),'us'num(10),'sy'num(10),'id'num(10),'wa'num(10),'st'num(10))";
# ---------------------------------------------------------------------------------
# sqlite> select * from vmstat;
# 2019-02-05 00:55:35|1|0|0|105368|62900|671124|0|0|43|92|179|185|1|1|92|7|0
# 2019-02-05 00:55:40|1|0|0|105116|62916|671160|0|0|43|92|178|185|1|1|92|7|0
# 2019-02-05 00:55:45|1|0|0|105148|62932|671192|0|0|43|92|178|185|1|1|92|7|0
#

while true
do

VMSTAT="$(vmstat | awk 'NR==3'; exit;)";
ARRAY_VMSTAT=($VMSTAT);
R=${ARRAY_VMSTAT[0]};    # r: The number of processes waiting for run time.
B=${ARRAY_VMSTAT[1]};    # b: The number of processes in uninterruptible sleep.
SWPD=${ARRAY_VMSTAT[2]};    # swpd: the amount of virtual memory used.
FREE=${ARRAY_VMSTAT[3]};    # free: the amount of idle memory.
BUFF=${ARRAY_VMSTAT[4]};    # buff: the amount of memory used as buffers.
CACHE=${ARRAY_VMSTAT[5]};    # cache: the amount of memory used as cache.
SI=${ARRAY_VMSTAT[6]};    # si: Amount of memory swapped in from disk (/s).
SO=${ARRAY_VMSTAT[7]};    # so: Amount of memory swapped to disk (/s).
BI=${ARRAY_VMSTAT[8]};    # bi: Blocks received from a block device (blocks/s).
BO=${ARRAY_VMSTAT[9]};    # bo: Blocks sent to a block device (blocks/s).
IN=${ARRAY_VMSTAT[10]};   # in: The number of interrupts per second, including the clock.
CS=${ARRAY_VMSTAT[11]};   # cs: The number of context switches per second.
US=${ARRAY_VMSTAT[12]};   # us: Time spent running non-kernel code. (user time, including nice time)
SY=${ARRAY_VMSTAT[13]};   # sy: Time spent running kernel code. (system time)
ID=${ARRAY_VMSTAT[14]};   # id: Time spent idle. Prior to Linux 2.5.41, this includes IO-wait time.
WA=${ARRAY_VMSTAT[15]};   # wa: Time spent waiting for IO. Prior to Linux 2.5.41, included in idle.
ST=${ARRAY_VMSTAT[16]};   # st: Time stolen from a virtual machine. Prior to Linux 2.6.11, unknown.

sqlite3 monitor.db "insert into vmstat ('time','r','b','swpd','free','buff','cache','si','so','bi','bo','in','cs','us','sy','id','wa','st')values(DateTime('now','localtime'),"$R","$B","$SWPD","$FREE","$BUFF","$CACHE","$SI","$SO","$BI","$BO","$IN","$CS","$US","$SY","$ID","$WA","$ST");";

sleep 5;
done

