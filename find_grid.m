%X , Y , KOP , LHS , TETA , AZ 
% clear
% clc
% phen=[3 4 950 200 50 130 16 13 800 400 30 190 20 1 1050 200 20 200
%       5 10 400 200 45 200 10 11 550 120 65 300 2 3 1000 200 70 200
%       6 7 1100 300 20 300 5 10 1000 150 30 10 4 7 800 100 35 20 ];
limperf=[];
perfor=[];
sumperf=[];
[R,C]=size(phen);
for q=1:R
    for w=1:6:C
TETA=phen(q,w+4);
NX=200;
NY=200;
LHS=phen(q,w+3);
AZ=phen(q,w+5);
TVD=5000;
KOP=phen(q,w+2);
X=phen(q,w);
Y=phen(q,w+1);
locperf=[];                              
Ldev=(TVD-KOP)*tand(TETA);
Ydev=abs(Ldev*cosd(AZ));
Xdev=abs(Ldev*sind(AZ));
if (sind(AZ)>=0) & (cosd(AZ)>=0)
    I=X+round(Xdev/NX);
    J=Y-round(Ydev/NY);
    if (AZ>=0) & (AZ<=45)
        JJ=J-round(LHS/NY);
        II=I;
    else
            II=round(LHS/NX)+I;
            JJ=J;
    end
elseif (sind(AZ)>=0) & (cosd(AZ)<=0)
        I=X+round(Xdev/NX);
        J=Y+round(Ydev/NY);
        if (AZ>90) & (AZ<=135)
            II=round(LHS/NX)+I;
            JJ=J;
        else
            II=I;
            JJ=J+round(LHS/NY);
        end
elseif (sind(AZ)<0) & (cosd(AZ)<0)
        I=X-round(Xdev/NX);
        J=Y+round(Ydev/NY);
        if (AZ>=180) & (AZ<=225)
            II=I;
            JJ=J+round(LHS/NY);
        else
            II=I-round(LHS/NX);
            JJ=J;
        end
        else (sind(AZ)<0) & (cosd(AZ)>0)
        I=X-round(Xdev/NX);
        J=Y-round(Ydev/NY);
        if (AZ>=270) & (AZ<=315)
            II=I-round(LHS/NX);
            JJ=J;
        else
            II=I;
            JJ=J-round(LHS/NY);
        end
        end
        locperf=[X Y I J II JJ];
        perfor=[perfor,locperf];
    end
           if perfor<=60 & perfor>=1
          limperf=[limperf;phen(q,:)];
          sumperf=[sumperf;perfor];
      end
       perfor=[];
end
phen=limperf
% sumperf=[8 7 10 12 10 15 6 13 9 15 11 15 4 3 11 13 15 13 5 7 15 18 18 18
%     10 15 13 14 15 14 8 10 14 16 17 16 13 4 4 5 4 8 4 6 6 8 6 11];
[Q,W]=size(sumperf);
perf=[];
wellpof=[];
               for a=1:Q
                 

                              num=1;
                 for d=1:6:W
                        if sumperf(a,d+2)==sumperf(a,d+4)
                         for f=sumperf(a,d+3):sumperf(a,d+5)
                             perf=[perf;sumperf(a,d+2),f,4,4];
                         end
                     else
                         for f=sumperf(a,d+2):sumperf(a,d+4)
                              perf=[perf;f,sumperf(a,d+3),4,4];
                         end
                     end
                     
                     sizperf=size(perf);
                    
if num==1
    A=perf
else if num==2
        B=perf
        
    else if num==3
        C=perf
        else if num==4
        D=perf
        else if num==5
        E=perf
        else if num==6
        F=perf
        else if num==7
        G=perf
        else if num==8
        H=perf
        else if num==9
        K=perf
        else if num==10
        L=perf
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
                                              

                     wellpof=[wellpof;perf]
     
                    num=num+1;
                   
                perf=[];
                 end
                 sizwellpof=size(wellpof);
              
                 number=0;
                sizwellpof=size(wellpof);
       for ii=1:sizwellpof(1)
        for jj=1:sizwellpof(1)
            if jj>ii
                if wellpof(ii,:)==wellpof(jj,:);
                 number=number+1;
                end
            end
        end
       end
       
       if number==0
           
                                  file=fopen('compdat.m','w');
                                  fprintf(file,'COMPDAT\n');
               sizA=size(A);sizB=size(B);sizC=size(C);
%                sizD=size(D);
               for xx=1:sizA(1)

                  fprintf(file,'A %d %d %d %d %s  0  1* 0.5/\n',A(xx,1),A(xx,2),A(xx,3),A(xx,4),'open');
               end
                
                for yy=1:sizB(1)
                  fprintf(file,'B %d %d %d %d %s  0  1* 0.5/\n',B(yy,1),B(yy,2),B(yy,3),B(yy,4),'open');  
                end
                for zz=1:sizC(1)
                fprintf(file,'C %d %d %d %d %s  0  1* 0.5/\n',C(zz,1),C(zz,2),C(zz,3),C(zz,4),'open'); 
                end
%                 for ww=1:sizD(1)
%                     fprintf(file,'D %d %d %d %d %s  0  1* 0.5/\n',D(ww,1),D(ww,2),D(ww,3),D(ww,4),'open');
%                 end
                fprintf(file,'/\n');
                fclose(file);
                
                
                fid=fopen('location.m','w');
fprintf(fid,'WELSPECS\n');
fprintf(fid,'A G %d %d %d OIL/\n',phen(h,1),phen(h,2),TVD);
fprintf(fid,'B G %d %d %d WATER/\n',phen(h,7),phen(h,8),TVD);
fprintf(fid,'C G %d %d %d WATER/\n',phen(h,13),phen(h,14),TVD);
% fprintf(fid,'D G %d %d %d WATER/\n',phen(19,7),phen(20,8),TVD);
fprintf(fid,'/\n');
fclose(fid);
                                                                     
          
                
       end
       wellpof=[];
       number=0;
               end


      
        
            