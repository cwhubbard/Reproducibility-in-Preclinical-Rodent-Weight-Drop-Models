 function h = nlp_hist_stair2 (x,s1,s2,sn,nudge) %This plot my favorite kind of histogram in the current graphical axis
 % x is the data set
 % s1 is the first bin
 % s2 is the last bin
 % sn is the increments between bins
 % nudge is the term which shifts the histogram left (-#) or right (+#)
 
 
 
bins = s1:sn:s2;
y    = histc(x,bins);
h    = stairs(bins+nudge,y);

%keyboard;
