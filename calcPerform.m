function [sensi, speci] = calcPerform(outSim, Target)
    i = 1;
    Trglength = size(Target);
    TP = 0; % true positives
    FN = 0; % false negatives
    TN = 0; % true negatives
    FP = 0; % false positives
    
    while i < Trglength(1,2,1)
        if outSim(3,i) > outSim(1,i) && outSim(3,i) > outSim(2, i) && outSim(3,i) > outSim(4, i) && Target(3,i) == 1
            TP = TP + 1;
        elseif outSim(3,i) < outSim(1,i) && outSim(3,i) < outSim(2, i) &&outSim(3,i) < outSim(4, i) && Target(3,i) ~= 1
            TN = TN + 1;
        end
        if outSim(3,i) > outSim(1,i) && outSim(3,i) > outSim(2, i) && outSim(3,i) > outSim(4, i) && Target(3,i) ~= 1
            FP = FP + 1;
        elseif outSim(3,i) < outSim(1,i) && outSim(3,i) < outSim(2, i) && outSim(3,i) < outSim(4, i) && Target(3,i) ==1
            FN = FN + 1;
        end
        i = i + 1;
    end
    sensi = TP / (TP + FN);
    speci = TN / (TN + FP);
    return
end
