% function [newchrom] = blockage_repeat(allchrom,newchrom)
% 
%       siz=size(allchrom);
% sez=size(newchrom);
% g=0;
% newmut=newchrom;
%      for x=1:sez(1)
%         for y=1:siz(1)
%             if strcmp(newchrom(x,:),allchrom(y,:))==1
%                 
%                   newmut(x-g,:)=[];
%                   g=g+1;
%             end
%         end
%      end
% newchrom=newmut;
% end
function [newchrom,objvN ] = blockage_repeat(allchrom,newchrom,objvN)
g=0;
newmut=newchrom;
newob=objvN;
siz=size(newchrom);
sez=size(allchrom);
     for ii=1:siz(1)
        for jj=1:sez(1)
            
                if newchrom(ii,:)==allchrom(jj,:);
                   newmut(ii,:)='q';
                   g=g+1;
                end
            
        end
     end
newchrom=newmut;
newobjv=newob;
nwc=zeros(g-1,siz(2));
count=0;
for k=1:siz(1)
    if (newchrom(k,:)~='q');
        count=count+1;
        nwc(count,:)=newchrom(k,:);
        nwe(count,:)=newob(k,:);
    end
end
newchrom=nwc(1:count,:);
objvN=nwe(1:count,:);
