%%
% 5 meter separation from 0-30 m, aligned with uppermost possible bin depth
% 10 meter separation from 40m down. 


ds = [1 8 15 22 29 36  37:2:61];
dataset.deepadcp.riforwarddepths = [6.37:5.25:35.25 40:10:155];

% ds = [2 9 16 22 29 36 38:4:61];
% dataset.deepadcp.riforwarddepths = [7.5 12.5 17.5 22.5 27.5 35 50 70 90 110 130];
clear riforward sh2forward n2forward shuforward shvforward rifred_sort;
g = 9.82;
rho = 1023;

for i=1:length(ds)-1
    tempdepths(i) = (dataset.deepadcp.fulldepths(ds(i+1)) - dataset.deepadcp.fulldepths(ds(i)))/2 + dataset.deepadcp.fulldepths(ds(i));
    deltaz = dataset.deepadcp.fulldepths(ds(i+1)) - dataset.deepadcp.fulldepths(ds(i));
%     disp(num2str(deltaz));

    if (ds(i) == 36)
        deltaz = 5.25;
        shuforward(:,i) = (dataset.measures.Emmpersecih(:,36) - dataset.measures.Emmpersecih(:,43))./(1000*deltaz);
        shvforward(:,i) = (dataset.measures.Nmmpersecih(:,36) - dataset.measures.Nmmpersecih(:,43))./(1000*deltaz);

        
    else
        shuforward(:,i) = (dataset.deepadcp.fullu(:,ds(i)) - dataset.deepadcp.fullu(:,ds(i+1)))./deltaz;
        shvforward(:,i) = (dataset.deepadcp.fullv(:,ds(i)) - dataset.deepadcp.fullv(:,ds(i+1)))./deltaz;

    end
    n2forwardsort(:,i) = -g/rho * (dataset.density.fulldepth.fulldensitysortedi(:,ds(i)) - dataset.density.fulldepth.fulldensitysortedi(:,ds(i+1)))./deltaz;

    sh2forward(:,i) = shuforward(:,i).^2+shvforward(:,i).^2;
    
    rifred_sort(:,i) = sh2forward(:,i) - 4*n2forwardsort(:,i);
    
end

    dataset.deepadcp.riforwardreduce_sort = rifred_sort;
%     [rifred_sort(:,1:5) rifred_sort(:,7:end)];
    dataset.deepadcp.n2forward_sort = n2forwardsort;
%     [n2forwardsort(:,1:5) n2forwardsort(:,7:end)];

    dataset.deepadcp.sh2forward = sh2forward;
%     [sh2forward(:,1:5) sh2forward(:,7:end)];
