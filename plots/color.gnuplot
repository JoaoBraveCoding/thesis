set term postscript color eps enhanced 22
set encoding utf8
set size 1,0.8
set style data boxes
set style line 1 lt 1 lc rgb "orange" lw 3
set style line 2 lt 1 lc rgb "#0066ff" lw 3
set style line 3 lt 1 lc rgb "#009900" lw 3
set style line 4 lt 1 lc rgb "black" lw 3


set boxwidth 0.5
set style fill solid 1.00
set grid y
set ylabel "Messages Sent (%)"
set xlabel "Configuration" 
set grid y
set xtics rotate by 45 right
set key above horizontal width -4.5 maxrows 1
path = 'gnuplotdata/base/over/'
file = path.'results.dat'



set yrange [0:100]
set xrange [0:13] 
set xtics ('Bitcoin' 1, 'M2-A2' 3, 'M2-A1' 5, 'M2-A0' 7, 'M1-A1' 9, 'M1-A0' 11) rotate by 45 right

set output "msg-sent.eps"

plot\
  file every ::0::2 u ($1):($4) w boxes ls 1 fill noborder notitle,\
  file every ::3::11 u ($1-0.27684075):($4) w boxes ls 2 fill noborder title "Initial Push = True",\
  file every ::12::22 u ($1+0.27684075):($4) w boxes ls 3 fill noborder title "Initial Push = False",\

!epstopdf msg-sent.eps
!rm msg-sent.eps

set output "mb-sent.eps"

set ylabel "Amount of information \n sent (%)"

plot\
  file every ::0::2 u ($1):($5) w boxes ls 1 fill noborder notitle,\
  file every ::3::11 u ($1-0.27684075):($5) w boxes ls 2 fill noborder title "Initial Push = True",\
  file every ::12::22 u ($1+0.27684075):($5) w boxes ls 3 fill noborder title "Initial Push = False",\

!epstopdf mb-sent.eps
!rm mb-sent.eps


set output "tx-added.eps"

set ylabel "Amount of transactoins \n added (%)"

plot\
  file every ::0::2 u ($1):($6) w boxes ls 1 fill noborder notitle,\
  file every ::3::11 u ($1-0.27684075):($6) w boxes ls 2 fill noborder title "Initial Push = True",\
  file every ::12::22 u ($1+0.27684075):($6) w boxes ls 3 fill noborder title "Initial Push = False",\

!epstopdf tx-added.eps
!rm tx-added.eps


set output "blocks-gen.eps"

set ylabel "Blocks created"
set xrange [0:15] 
set yrange [0:160]

set label "Frequency of 6 blocks per hour" at 9.5 ,152 font "Helvetica, 15" 


plot\
  file every ::0::2 u ($1):($3) w boxes ls 1 fill noborder notitle,\
  file every ::3::11 u ($1-0.27684075):($3) w boxes ls 2 fill noborder title "Initial Push = True",\
  file every ::12::22 u ($1+0.27684075):($3) w boxes ls 3 fill noborder title "Initial Push= False",\
   144 ls 4 notitle


!epstopdf blocks-gen.eps
!rm blocks-gen.eps


set output "commit-time.eps"

set ylabel "Time (minutes)"
set xrange [0:15] 
set yrange [0:85]

set label "Highest time" at 12,24 font "Helvetica, 12"
set label "Lowest time" at 12,12 font "Helvetica, 12"

plot\
  file every ::0::2 u ($1):($7) w boxes ls 1 fill noborder notitle,\
  file every ::3::11 u ($1-0.27684075):($7) w boxes ls 2 fill noborder title "Initial Push = True",\
  file every ::12::22 u ($1+0.27684075):($7) w boxes ls 3 fill noborder title "Initial Push = False",\
   18 ls 4 notitle,\
   5.883 ls 4 notitle




!epstopdf commit-time.eps
!rm commit-time.eps


reset
set key right bottom
set ylabel "Transactoins added to blocks (%)"
set xlabel "Time (seconds)"
set xrange [0:2000]
set yrange [0:100]
load "styles.inc"
set grid y

set output "cdf_commit.eps"

plot path."time_commited_CDF_Vanilla.gpData" using 2:1 title "Bitcoin" with line ls 1 lc "orange",\
     path."time_commited_CDF_T2R2PT.gpData" using 2:1 title "M2-A2-IpT" with line ls 2,\
     path."time_commited_CDF_T2R2PF.gpData" using 2:1 title "M2-A2-IpF" with line ls 3 lc "#7300e6",\
     path."time_commited_CDF_T2R1PT.gpData" using 2:1 title "M2-A1-IpT" with line ls 4 lc "#b3b300",\
     path."time_commited_CDF_T2R1PF.gpData" using 2:1 title "M2-A1-IpF" with line ls 5 lc "#009933",\
     path."time_commited_CDF_T1R1PT.gpData" using 2:1 title "M1-A1-IpT" with line ls 6 lc "#e60099",\
     path."time_commited_CDF_T1R1PF.gpData" using 2:1 title "M1-A1-IpF" with line ls 7,\

!epstopdf "cdf_commit.eps"
!rm "cdf_commit.eps"


quit
