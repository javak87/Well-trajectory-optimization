function [PHEN,CHROM,objvN] =SERCH_GRID(phen,chrom,UB,LB,TVD,N,oilpric,watcost,vari,vertcost,horizcost,DZ,objvN)
%X , Y , LHS , AZ 
limperf=[];
perfor=[];
SUMPERF=[];
CHROM=[];
PHEN=[];
[R1,R2]=size(phen);
a=50;
for q=1:R1
    sumperf=[];
    num=0;
    
    for w=1:(vari):R2
        LHS=phen(q,w+2);
        Ldev=(LHS/a);
         


AZ=phen(q,w+3);

X=phen(q,w);
Y=phen(q,w+1);
LAYER=phen(q,w+4);
LOG=[];
for S=1:a
locperf=[];                              

Ydev=abs(S*Ldev*cosd(AZ));
Xdev=abs(S*Ldev*sind(AZ));

if (sind(AZ)>=0) & (cosd(AZ)>=0);
    I=X+round(Xdev/N);
    J=Y-round(Ydev/N);
   
elseif (sind(AZ)>=0) & (cosd(AZ)<=0);
        I=X+round(Xdev/N);
        J=Y+round(Ydev/N);
       
elseif (sind(AZ)<0) & (cosd(AZ)<0);
        I=X-round(Xdev/N);
        J=Y+round(Ydev/N);
        
        else 
        I=X-round(Xdev/N);
        J=Y-round(Ydev/N);
        
        end
        locperf=[I J LAYER LAYER];
              
        LOG=[LOG;locperf];
        [LOG] = prevent_repeat(LOG);

end

    num=num+1;
%--------------------------------------------------------------------------
            if num==1
    A=LOG;
else if num==2
        B=LOG;
        
    else if num==3
        C=LOG;
        else if num==4
        D=LOG;
        else if num==5
        E=LOG;
        else if num==6
        F=LOG;
        else if num==7
        G=LOG;
        else if num==8
        H=LOG;
        else if num==9
        K=LOG;
        else if num==10
        L=LOG;
            end
            end
            end
            end
            end
            end
            end
        end
    end
    
end
%--------------------------------------------------------------------------

               
    SUMPERF=[SUMPERF;LOG];
   LOG=[];
    end
          
     SIZSUM=size(SUMPERF);
     [SUMPERF] = prevent_repeat(SUMPERF);
     sizsum=size(SUMPERF);
     if SIZSUM(1)==sizsum(1)
     if SUMPERF<=UB & SUMPERF>=LB
          limperf=phen(q,:);
          CHR=chrom(q,:);
          [objvN] =RUN(A,B,C,D,E,limperf,TVD,phen,oilpric,watcost,q,vertcost,horizcost,DZ,objvN);
          PHEN=[PHEN;limperf];
          CHROM=[CHROM;CHR];
     end
     end

        SUMPERF=[];   
  
end

end


