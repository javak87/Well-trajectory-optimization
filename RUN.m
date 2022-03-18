function [objvN] =RUN(A,B,C,limperf,Refdepth,phen,gaspric,watcost,q,vertcost,horizcost,DZ,objvN,LAY,opercost)  
            
        REAL=limperf;
        sumvercost=0;
        sumhorzcost=0;
      TOP=6000;  
   for P=5:5:(length(REAL))
              sumvercost=TOP+(DZ*REAL(P))+sumvercost;
   end
   for L=3:5:(length(REAL))
             sumhorzcost=REAL(L)+sumhorzcost;
   end
   COST=(sumhorzcost*horizcost)+(sumvercost*vertcost)+(opercost*(length(REAL)/5));
   
       sizA=size(A);sizB=size(B);
       sizC=size(C);
%        sizD=size(D);
% sizE=size(E); 
       
           
               file=fopen('compdat.m','w');
               fprintf(file,'COMPDAT\n');

                                         
               for xx=1:sizA(1)

                  fprintf(file,'A %d %d %d %d %s   2* 0.5/\n',A(xx,1),A(xx,2),A(xx,3),A(xx,4),'open');
               end
                
                for yy=1:sizB(1)
                  fprintf(file,'B %d %d %d %d %s  2* 0.5/\n',B(yy,1),B(yy,2),B(yy,3),B(yy,4),'open');  
                end
                for zz=1:sizC(1)
                fprintf(file,'C %d %d %d %d %s  2* 0.5/\n',C(zz,1),C(zz,2),C(zz,3),C(zz,4),'open'); 
                end
%                 for ww=1:sizD(1)
%                     fprintf(file,'D %d %d %d %d %s   2* 0.5/\n',D(ww,1),D(ww,2),D(ww,3),D(ww,4),'open');
%                 end
%                 for cc=1:sizE(1)
%                     fprintf(file,'E %d %d %d %d %s   2* 0.5/\n',E(cc,1),E(cc,2),E(cc,3),E(cc,4),'open');
%                 end
                fprintf(file,'/\n');
                fclose(file);
      
                
fid=fopen('location.m','w');
fprintf(fid,'WELSPECS\n');
fprintf(fid,'A G %d %d %d GAS/\n',A(1,1),A(1,2),Refdepth);
fprintf(fid,'B G %d %d %d GAS/\n',B(1,1),B(1,2),Refdepth);
fprintf(fid,'C G %d %d %d GAS/\n',C(1,1),C(1,2),Refdepth);
% fprintf(fid,'D G %d %d %d OIL/\n',D(1,1),D(1,2),Refdepth);
% fprintf(fid,'E G %d %d %d OIL/\n',E(1,1),E(1,2),Refdepth);
fprintf(fid,'/\n');
fclose(fid);
npv=fopen('NPV.m','w');
fprintf(npv,'UDQ\n');
fprintf(npv,'DEFINE FUCOST %d/\n',COST);
fprintf(npv,'DEFINE FUNPV (FGPT*1)-(FWPT*10)-(FUCOST)/\n');
fprintf(npv,'/\n');
[STATUS RESULTS]=dos('$eclipse ANALIZ');
%----------------------------- reading RPT file ---------------------------
fou=fopen('ANALIZ.RSM','r');
C = textscan(fou, '%s',4,'whitespace','\n');
STRING=C{1};
POS=STRING{4};
if POS(57)~=' '
    CNPV=1000;
else
   CNPV=1;
end
fclose(fou);
fou=fopen('ANALIZ.RSM','r');
C = textscan(fou, '%s %s %s %s %s %s %s %s %s');
nNPV=C{5};
y=size(nNPV);
FUNVP=str2num(nNPV{y(1)})*CNPV;
fclose(fou);
objv=-FUNVP;

      objvN=[objvN;objv];
          
       



end
       
