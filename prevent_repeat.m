function [chrom ] = repeat(chrom)
g=0;
newmut=chrom;
siz=size(chrom);
DEL=[];
     for ii=1:siz(1)
        for jj=1:siz(1)
            if jj>ii
                if chrom(ii,:)==chrom(jj,:);
                   newmut(jj,:)='q';
                   DEL=[DEL;ii];
                   g=g+1;
                end
            end
        end
     end
newchrom=newmut;
nwc=zeros(g-1,siz(2));
count=0;
for k=1:siz(1)
    if (newchrom(k,:)~='q');
        count=count+1;
        nwc(count,:)=newchrom(k,:);
    end
end
chrom=nwc(1:count,:);
end

