set term postscript monochrome eps enhanced 22
set encoding utf8
set size 1,0.8
set style data boxes
set style line 1 lt 1 lc rgb "black" lw 3
set boxwidth 0.5
set style fill solid 1.00
set grid y
set ylabel "Messages sent (%)"
set xlabel "Configuration" 
set grid y
set xtics rotate by 45 right
set key above horizontal width -4.5 maxrows 1
path = 'gnuplotdata/base/imp/'
file = path.'results.dat'
path2 = 'gnuplotdata/newalg/'




set yrange [0:100]
set xrange [0:13] 
set xtics ('Bitcoin' 1, 'T2-R2' 3, 'T2-R1' 5, 'T2-R0' 7, 'T1-R1' 9, 'T1-R0' 11) rotate by 45 right

set output "msg-sent.eps"

plot\
  file every ::0::2 u ($1):($4) w boxes lt 1 fill noborder solid 0.2 notitle,\
  file every ::3::11 u ($1-0.27684075):($4) w boxes lt 1 fill noborder solid 0.2 title "Initial push = True",\
  file every ::12::22 u ($1+0.27684075):($4) w boxes lt 1 fill noborder solid 0.6 title "Initial push = False",\

!epstopdf msg-sent.eps
!rm msg-sent.eps

set output "mb-sent.eps"

set ylabel "Amount of information \n sent (%)"

plot\
  file every ::0::2 u ($1):($5) w boxes lt 1 fill noborder solid 0.2 notitle,\
  file every ::3::11 u ($1-0.27684075):($5) w boxes lt 1 fill noborder solid 0.2 title "Initial push = True",\
  file every ::12::22 u ($1+0.27684075):($5) w boxes lt 1 fill noborder solid 0.6 title "Initial push = False",\

!epstopdf mb-sent.eps
!rm mb-sent.eps


set output "tx-added.eps"

set ylabel "Amount of transactoins \n added (%)"

plot\
  file every ::0::2 u ($1):($6) w boxes lt 1 fill noborder solid 0.2 notitle,\
  file every ::3::11 u ($1-0.27684075):($6) w boxes lt 1 fill noborder solid 0.2 title "Initial push = True",\
  file every ::12::22 u ($1+0.27684075):($6) w boxes lt 1 fill noborder solid 0.6 title "Initial push = False",\

!epstopdf tx-added.eps
!rm tx-added.eps


set output "blocks-gen.eps"

set ylabel "Blocks generated"
set xrange [0:15] 
set yrange [0:160]

set label "Frequency of 6 blocks per hour" at 9.5 ,152 font "Helvetica, 15" 


plot\
  file every ::0::2 u ($1):($3) w boxes lt 1 fill noborder solid 0.2 notitle,\
  file every ::3::11 u ($1-0.27684075):($3) w boxes lt 1 fill noborder solid 0.2 title "Initial push = True",\
  file every ::12::22 u ($1+0.27684075):($3) w boxes lt 1 fill noborder solid 0.6 title "Initial push = False",\
   144 ls 1 notitle


!epstopdf blocks-gen.eps
!rm blocks-gen.eps


set ylabel "Nodes (%)"
set xlabel "Configuration"
set xrange [0:20] 
set yrange [0:100]

set output "nodes_per_config.eps"
set xtics ('1' 1, '2' 3, '3' 5, '4' 7, '5' 9, '6' 11, '7' 13, '8' 15, '9' 17, '10' 19)


plot path2."node_per_config.dat" every ::0::19 u ($1):($2) w boxes lt 1 fill noborder solid 0.2 title "Same miners",\
     path2."node_per_config.dat" every ::19::38 u ($1-0.5):($2) w boxes lt 1 fill noborder solid 0.5 title "Two different miners",\
     path2."node_per_config.dat" every ::38::57 u ($1+0.5):($2) w boxes lt 1 fill noborder solid 0.8 title "Different miners",\


!epstopdf "nodes_per_config.eps"
!rm "nodes_per_config.eps"


set output "commit-time.eps"

set ylabel "Time (minutes)"
set xrange [0:15] 
set yrange [0:85]

set label "Highest time" at 12,35.5 font "Helvetica, 12"
set label "Lowest time" at 12,7.5 font "Helvetica, 12"
set xtics ('Bitcoin' 1, 'T2-R2' 3, 'T2-R1' 5, 'T2-R0' 7, 'T1-R1' 9, 'T1-R0' 11) rotate by 45 right


plot\
  file every ::0::2 u ($1):($7) w boxes lt 1 fill noborder solid 0.2 notitle,\
  file every ::3::11 u ($1-0.27684075):($7) w boxes lt 1 fill noborder solid 0.2 title "Initial push = True",\
  file every ::12::22 u ($1+0.27684075):($7) w boxes lt 1 fill noborder solid 0.6 title "Initial push = False",\
   33 ls 1 notitle,\
   5.7 ls 1 notitle


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

plot path."time_commited_CDF_Vanilla.gpData" using 2:1 title "Bitcoin" with l ls 1,\
     path."time_commited_CDF_T2R2PT.gpData" using 2:1 title "M2-A2-IpT" with line ls 2,\
     path."time_commited_CDF_T2R2PF.gpData" using 2:1 title "M2-A2-IpF" with line ls 3,\
     path."time_commited_CDF_T2R1PT.gpData" using 2:1 title "M2-A1-IpT" with line ls 4,\
     path."time_commited_CDF_T2R1PF.gpData" using 2:1 title "M2-A1-IpF" with line ls 5,\
     path."time_commited_CDF_T1R1PT.gpData" using 2:1 title "M1-A1-IpT" with line ls 6,\
     path."time_commited_CDF_T1R1PF.gpData" using 2:1 title "M1-A1-IpF" with line ls 7,\

!epstopdf "cdf_commit.eps"
!rm "cdf_commit.eps"

reset
set key right top
set ylabel "Average commit time (minutes)"
set xlabel "Time (hours)"
set xrange [1:48]
set yrange [0:50]
load "styles.inc"
set grid y
set xtics ('5' 5, '10' 10, '12' 12, '15' 15, '20' 20, '25' 25, '30' 30, '35' 35, '40' 40, '45' 45)


set label "Highest time" at 5,35 font "Helvetica, 12"
set label "Lowest time" at 5,4 font "Helvetica, 12"
set arrow from 12,0 to 12,50 nohead ls 1

set output "commit_over_time.eps"

plot path2."commits.dat" using 1:2 title "Same miners" with line ls 1,\
     path2."commits.dat" using 1:3 title "Two different miners" with line ls 2,\
     path2."commits.dat" using 1:4 title "Different miners" with line ls 4,\
      33 ls 1 notitle,\
      5.7 ls 1 notitle

!epstopdf "commit_over_time.eps"
!rm "commit_over_time.eps"


quit
