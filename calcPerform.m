function [sensi, speci] = calcPerform(outSim, Target)
    i = 1;
    Trglength = size(Trg);
    TP = 0; % true positives
    FN = 0; % false negatives
    TN = 0; % true negatives
    FP = 0; % false positives
    
    while i < Trglength(1,1,1)
        if outSim(3,i) == Target(3,i) && Target(3,i) == 1
            TP = TP + 1;
        elseif outSim(1,i) == Target(1,i) && Target(3,i) == 1
            TN = TN + 1;
        end
        if outSim(3,i) ~= Target(3,i) && Target(3,i) == 1
            FP = FP + 1;
        elseif outSim(1,i) ~= Target(1,i) && Target(3,i) == 1
            FN = FN + 1;
        end
    end
    sensi = TP / (TP + FN);
    speci = TN / (TN + FP);
    return
end
