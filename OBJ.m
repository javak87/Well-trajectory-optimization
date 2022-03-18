function [OBJV] =OBJ(REAL,FOPT,FWPT,watcost,gaspric,Refdepth,vertcost,horizcost,DZ,LAY,opercost)
        sumvercost=0;
        sumhorzcost=0;
      TOP=(Refdepth-DZ*LAY);  
   for P=5:5:(length(REAL))
              sumvercost=TOP+(DZ*REAL(P))+sumvercost;
   end
   for L=3:5:(length(REAL))
             sumhorzcost=REAL(L)+sumhorzcost;
   end
   DRICOST=(sumhorzcost*horizcost)+(sumvercost*vertcost);
   (sumhorzcost*horizcost)
OBJV=(FOPT*gaspric)-(FWPT*watcost)-(sumvercost*vertcost)
%  (DRICOST)-opercost
end