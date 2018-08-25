set term postscript monochrome eps enhanced 22
set encoding utf8
set size 1,0.8
set style data boxes
set style line 1 lt 1 lc rgb "black" lw 3
set boxwidth 0.5
set style fill solid 1.00
set grid y
set ylabel "Mensagens enviadas (%)"
set xlabel "Configuração" 
set grid y
set xtics rotate by 45 right
set key above horizontal width -4.5 maxrows 1




set yrange [0:100]
set xrange [0:13] 
set xtics ('Bitcoin' 1, 'M2-A2' 3, 'M2-A1' 5, 'M2-A0' 7, 'M1-A1' 9, 'M1-A0' 11) rotate by 45 right

set output "msg-sent.eps"

plot\
  'gnuplotdata/results.dat' every ::0::2 u ($1):($4) w boxes lt 1 fill noborder solid 0.2 notitle,\
  'gnuplotdata/results.dat' every ::3::11 u ($1-0.27684075):($4) w boxes lt 1 fill noborder solid 0.2 title "Push inicial = True",\
  'gnuplotdata/results.dat' every ::12::22 u ($1+0.27684075):($4) w boxes lt 1 fill noborder solid 0.6 title "Push inicial = False",\

!epstopdf msg-sent.eps
!rm msg-sent.eps

set output "mb-sent.eps"

set ylabel "Quantidade de informação \n enviada (%)"

plot\
  'gnuplotdata/results.dat' every ::0::2 u ($1):($5) w boxes lt 1 fill noborder solid 0.2 notitle,\
  'gnuplotdata/results.dat' every ::3::11 u ($1-0.27684075):($5) w boxes lt 1 fill noborder solid 0.2 title "Push inicial = True",\
  'gnuplotdata/results.dat' every ::12::22 u ($1+0.27684075):($5) w boxes lt 1 fill noborder solid 0.6 title "Push inicial = False",\

!epstopdf mb-sent.eps
!rm mb-sent.eps


set output "tx-added.eps"

set ylabel "Quantidade de transações \n adicionadas (%)"

plot\
  'gnuplotdata/results.dat' every ::0::2 u ($1):($6) w boxes lt 1 fill noborder solid 0.2 notitle,\
  'gnuplotdata/results.dat' every ::3::11 u ($1-0.27684075):($6) w boxes lt 1 fill noborder solid 0.2 title "Push inicial = True",\
  'gnuplotdata/results.dat' every ::12::22 u ($1+0.27684075):($6) w boxes lt 1 fill noborder solid 0.6 title "Push inicial = False",\

!epstopdf tx-added.eps
!rm tx-added.eps


set output "blocks-gen.eps"

set ylabel "Blocos gerados"
set xrange [0:15] 
set yrange [0:160]

set label "Frequencia de 6 blocos à hora" at 9.5 ,152 font "Helvetica, 15" 


plot\
  'gnuplotdata/results.dat' every ::0::2 u ($1):($3) w boxes lt 1 fill noborder solid 0.2 notitle,\
  'gnuplotdata/results.dat' every ::3::11 u ($1-0.27684075):($3) w boxes lt 1 fill noborder solid 0.2 title "Push inicial = True",\
  'gnuplotdata/results.dat' every ::12::22 u ($1+0.27684075):($3) w boxes lt 1 fill noborder solid 0.6 title "Push inicial = False",\
   144 ls 1 notitle


!epstopdf blocks-gen.eps
!rm blocks-gen.eps


set output "commit-time.eps"

set ylabel "Tempo (minutos)"
set xrange [0:15] 
set yrange [0:85]

set label "Tempo mais alto" at 12,24 font "Helvetica, 12" 
set label "Tempo mais baixo" at 12,12 font "Helvetica, 12" 


plot\
  'gnuplotdata/results.dat' every ::0::2 u ($1):($7) w boxes lt 1 fill noborder solid 0.2 notitle,\
  'gnuplotdata/results.dat' every ::3::11 u ($1-0.27684075):($7) w boxes lt 1 fill noborder solid 0.2 title "Push inicial = True",\
  'gnuplotdata/results.dat' every ::12::22 u ($1+0.27684075):($7) w boxes lt 1 fill noborder solid 0.6 title "Push inicial = False",\
   18 ls 1 notitle,\
   5.883 ls 1 notitle




!epstopdf commit-time.eps
!rm commit-time.eps


reset
set key right bottom
set ylabel "Transações adicionadas a blocos (%)"
set xlabel "Tempo (segundos)"
set xrange [0:2000]
set yrange [0:100]
load "styles.inc"
set grid y

set output "cdf_commit.eps"

plot "gnuplotdata/time_commited_CDF_Vanilla.gpData" using 2:1 title "Bitcoin" with l ls 1,\
     "gnuplotdata/time_commited_CDF_T2R2PT.gpData" using 2:1 title "M2-A2-piT" with line ls 2,\
     "gnuplotdata/time_commited_CDF_T2R2PF.gpData" using 2:1 title "M2-A2-piF" with line ls 3,\
     "gnuplotdata/time_commited_CDF_T2R1PT.gpData" using 2:1 title "M2-A1-piT" with line ls 4,\
     "gnuplotdata/time_commited_CDF_T2R1PF.gpData" using 2:1 title "M2-A1-piF" with line ls 5,\
     "gnuplotdata/time_commited_CDF_T1R1PT.gpData" using 2:1 title "M1-A1-piT" with line ls 6,\
     "gnuplotdata/time_commited_CDF_T1R1PF.gpData" using 2:1 title "M1-A1-piF" with line ls 7,\

!epstopdf "cdf_commit.eps"
!rm "cdf_commit.eps"


quit