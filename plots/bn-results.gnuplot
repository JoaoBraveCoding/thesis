set term postscript monochrome eps enhanced 22
set encoding utf8
set size 1,0.8
set style data boxes
set style line 1 lt 1 lc rgb "black" lw 3
set boxwidth 0.5
set style fill solid 1.00
set grid y
set ylabel "Transações commited (%)"
set xlabel "Nós Bizantinos (%)" 
set grid y
set xtics rotate by 45 right
set key above horizontal width -1.5 maxrows 1



set yrange [0:100]
set xrange [0:65] 
set xtics ('0' 1, '5' 4, '10' 7, '15' 10, '20' 13, '25' 16, '30' 19, '35' 22, '40' 25, '45' 28, '50' 31, '55' 34, '60' 37, '65' 40, '70' 43, '75' 46, '80' 49, '85' 52, '90' 55, '95' 58, '100' 61)

set output "transactions-commited.eps"

plot\
  'gnuplotdata/bad-nodes-results.dat' every ::1::61 u ($1-0.67684075):($3) w boxes lt 1 fill noborder solid 0.2 title "Bitcoin",\
  'gnuplotdata/bad-nodes-results.dat' every ::122::183 u ($1):($3) w boxes lt 1 fill noborder solid 0.4 title "Basic M1-A1",\
  'gnuplotdata/bad-nodes-results.dat' every ::61::122 u ($1+0.67684075):($3) w boxes lt 1 fill noborder solid 0.6 title "M1-A1",\

!epstopdf transactions-commited.eps
!rm transactions-commited.eps

quit
