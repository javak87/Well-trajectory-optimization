function [phen,PHEN,chrom,CHROM,OBJV] =REPEAT(phen,allphen,allobjv,gen,chrom,allchrom)
 if gen>0
  sizphen=size(phen);
  sizall=size(allphen);
  CUM=[];
  NUM=[];
  OBJV=[];
  PHEN=[];
  CHROM=[];
  for R=1:sizphen(1)
      for T=1:sizall(1)
          if phen(R,:)==allphen(T,:)
              CUM=[CUM;T];
              NUM=[NUM;R];
          end
      end
  end
              
 for U=1:length(CUM)
     OBJ=allobjv(CUM(U));
     OBJV=[OBJV;OBJ];
     PHE=allphen(CUM(U),:);
     PHEN=[PHEN;PHE];
     CHR=allchrom(CUM(U),:);
     CHROM=[CHROM;CHR];
end
SIZ=size(PHEN);
B=[];
C=[];
for jj=1:SIZ(1)
    for ii=1:sizphen(1)
        if PHEN(jj,:)==phen(ii,:)
            phen(ii,:)=99999;
            chrom(ii,:)=99999;

        end
    end
end
for mm=1:sizphen(1)
    if phen(mm,:)~=99999
        B=[B;phen(mm,:)];
        C=[C;chrom(mm,:)];
    end
end
phen=B;
chrom=C;
 else
     PHEN=[];
     OBJV=[];
     CHROM=[];

end
