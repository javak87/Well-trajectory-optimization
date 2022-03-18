function [phen,chrom] =blockaglocation_repeat(phen,welnum,chrom,vari)
y=[];
p=[];
g=0;
[row,clum]=size(phen);
for i=1:row
    for j=1:(vari+1):(welnum*vari)-1
        for m=1:((welnum*vari)-j-1)/2
            if phen(i,[j:j+1])==phen(i,[j+(2*m):j+1+(2*m)])
               g=g+1;
                                 
            end
            
        end
        
    end
     if g==0
         y=[y;phen(i,:)];
         p=[p;chrom(i,:)];
        
     end
     g=0;
end
phen=y;
chrom=p;

end

