clear;clc;clf;format long;
gaspric=1; %1$/Mscf  gas price
watcost=10;  %15$/bbl   water cost
oilpric=100;
DZ=100;
vertcost=200;% 200$/ft vertical cost
horizcost=400;% 400$/ft horizontal cost
opercost=365000;
% NX=200;
% NY=200;
N=200;
LAY=10; % number reservoir layer 
NVAR=15;%input(' please insert number of variable=');
lenvar=[9 9 9 9 9 9 9 9 9 9 9 9 9 9 9];%input(' please insert length of variable=');
ub=[8 14 1200 180 5 22 7  1200  270 5 22 22  1200  360 5];%input('please insert upper bound of variable in form of [...]=')
lb=[1 1  200  90 1 1 1  200  180 1 1 1  200  270 1];%input('please insert lower bound of variable in form of [...]=') 
code= [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];%input('please insert type of variable code( 0 or 1)=');        % for binary coding code(i)=0 and for gray coding code(i)=1
scale=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];%input(' please insert type of scaling(0 or 1)=');             % for arithmetic scaling scale(i)=0 and for logarithmetic scaling scale(i)=1
lbin= [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];%input(' please insert type of bound representing(0 or 1)=');  % for include each bound lbin(i)=1 and for exclude each bound lbin(i)=0
ubin= [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];%input(' please insert type of bound representing(0 or 1)=');  % for include each bound ubin(i)=1 and for exclude each bound ubin(i)=0
value=[];
value2=[];
phen2=[];
sizphen2=size(phen2);
newchrom=[];
vari=5;% number of variable per well
phen=[];
sizphen=size(phen);
cumfld=[];
fitnV=[];
allobjv=[];
allphen=[];
finchr=[];
fitnVF=[];
objvN=[];
objvNF=[];
SFL=[];
allchrom=[];
chrom=[];
welnum=3;CPUTIME=[];N=200;
cumfld=[];NPV=[];BPHEN=[];newchrom=[];BOBJV=[];objvN=[];Elite=[];allchrom=[];allobjv=[];allphen=[];CHROM=[];
Refdepth=6700; % refrence depth for bottom hole pressure
PRECI=lenvar(1);
MAXGEN =40;        % max Number of generations
NIND = 20;           % Number of individuals per subpopulations
GGAP = .8;           % Generation gap, how many new individuals are created
SEL_F = 'sus';       % Name of selection function
XOV_F = 'xovsp';     % Name of recombination function for individuals
MUT_F = 'mut';       % Name of mutation function for individuals
% reset count variables
   gen = 0;
   Best = NaN*ones(MAXGEN,1);
   Bestval = NaN*ones(MAXGEN,NVAR);

%-------------------------------------loop---------------------------------
 for i=1:NVAR
    feildD=[lenvar(1,i);lb(1,i);ub(1,i);code(1,i);scale(1,i);lbin(1,i);ubin(1,i)];
    cumfld=[cumfld,feildD];
 end
      chrom = crtbp(NIND, NVAR*PRECI);
      allchrom=[];
      phen=round(bs2rv(chrom,cumfld));
      allphen=[];
                                  while gen < MAXGEN
             tic
                                      
       [phen,PHEN,chrom,CHROM,OBJV] =REPEAT(phen,allphen,allobjv,gen,chrom,allchrom); 
       [objvN] =SERCH_GRID(phen,chrom,Refdepth,N,gaspric,oilpric,watcost,vari,vertcost,horizcost,DZ,objvN,LAY,opercost);
              
        phen=[phen;PHEN];
       chrom=[chrom;CHROM];
       objvN=[objvN;OBJV];
                                     allphen=[allphen;phen];
                                     allchrom=[allchrom;chrom];
                              
                                    allobjv=[allobjv;objvN];
                                    sizall=size(allchrom);
%  ------------------------------------------------------------------------
 for R=1:sizall(1)
      for T=1:sizall(1)
          if T>R
          if allphen(R,:)==allphen(T,:)
              allphen(T,:)=9999;
          end
          end
      end
  end
  BB=[];
  CC=[];
  DD=[];
for mm=1:sizall(1)
    if allphen(mm,:)~=9999
        BB=[BB;allphen(mm,:)];
        CC=[CC;allchrom(mm,:)];
        DD=[DD;allobjv(mm,:)];
    end
end
allphen=BB;
allchrom=CC;
allobjv=DD;
%--------------------------------------------------------------------------

       FitnV=ranking(objvN);

                             for ii=1:length(objvN)
                                 
                                   if objvN(ii,:)==min(objvN)
                                      BEphen=phen(ii,:);
                                   end

                             end
                                          BOBJV=[BOBJV;min(objvN)];
                                          BPHEN=[BPHEN;BEphen];

                             for jj=1:length(BOBJV)
                                   if BOBJV(jj,:)==min(BOBJV)
                                      BEST=BPHEN(jj,:);
                                   end
                             end
                         
      Elite=[Elite;BEST];
      Best(gen+1) = min(BOBJV);
      NPV=[NPV;-Best(gen+1)]
      
      [a b]=min(objvN);
      dd=bs2rv(chrom, cumfld);
      Bestval(gen+1,:)=dd(b,:);
      plot(-Best)
      
                                   
%------------------- selection funtion ------------------------------------
                   
            SelCh = select(SEL_F, chrom, FitnV, GGAP);
            
            SelCh=recombin(XOV_F, SelCh);
            SelCh=mutate(MUT_F, SelCh);
            chrom = reins(chrom, SelCh);
            phen=round(bs2rv(chrom,cumfld));
     
    

 gen=gen+1;
 TIME=toc;
 CPUTIME=[CPUTIME;TIME];
                                  end
       
       
       
       
       
       
       
       
       
       
       
       