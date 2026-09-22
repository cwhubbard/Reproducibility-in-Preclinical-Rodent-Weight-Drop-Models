function [ApproxCohenD] = ApproxCohen(group1mean,group1SE, group1N, group2mean, group2SE, group2N, isSD)
%ApproxCohen by Cody Weston Hubbard updated 3/4/25
%updated 9/19/2025
%takes two group means and their SE or SD and computes a rough estimate of
%cohen's D, when compared to Matlab's builtin version, effects are inflated
%at the first or second decimal (when samples are less than 20).
%The location to cite is still in the works, so please include
%me for my work in developing this function.

%if isSD = 1 then the values were already in SD no need to convert
if isSD == 1
    if group1mean >= group2mean
        g1SD = group1SE;
        g2SD = group2SE;
        differ_in_groups = (group1mean - group2mean);
        %averagedpooledstd = mean([g1SD,g2SD])
        pooledSD = sqrt(((group1N-1)*g1SD^2 +(group2N-1)*g2SD^2)/(group1N+group2N-2));
        %numeratorofPSD = sqrt(((group1N-1)*g1SD^2 +(group2N-1)*g2SD^2))
        %denomenatorofPSD = sqrt(group1N+group2N-2)
        %pooledSD = numeratorofPSD/denomenatorofPSD

        ApproxCohenD = differ_in_groups/pooledSD;

    elseif group1mean < group2mean
        g1SD = group1SE;
        g2SD = group2SE;
        differ_in_groups = (group2mean - group1mean);
        %averagedpooledstd = mean([g1SD,g2SD])
        pooledSD = sqrt(((group2N-1)*g2SD^2 +(group1N-1)*g1SD^2)/(group2N+group1N-2));
        %numeratorofPSD = sqrt(((group1N-1)*g1SD^2 +(group2N-1)*g2SD^2))
        %denomenatorofPSD = sqrt(group1N+group2N-2)
        %pooledSD = numeratorofPSD/denomenatorofPSD

        ApproxCohenD = differ_in_groups/pooledSD;
    end
    
elseif isSD == 0 %if sd not provided, need to convert
    if group1mean >= group2mean
        g1SD = group1SE * sqrt(group1N);%converts into SD
        g2SD = group2SE * sqrt(group2N);


        differ_in_groups = (group1mean - group2mean);
        % averagedpooledstd = mean([g1SD,g2SD])
        pooledSD = sqrt(((group1N-1)*g1SD^2 +(group2N-1)*g2SD^2)/(group1N+group2N-2));

        ApproxCohenD = differ_in_groups/pooledSD;

    elseif group1mean < group2mean
        g1SD = group1SE * sqrt(group1N);%converts into SD
        g2SD = group2SE * sqrt(group2N);


        differ_in_groups = (group2mean - group1mean);
        % averagedpooledstd = mean([g1SD,g2SD])
        pooledSD = sqrt(((group2N-1)*g2SD^2 +(group1N-1)*g1SD^2)/(group2N+group1N-2));

        ApproxCohenD = differ_in_groups/pooledSD;

    end
end
end