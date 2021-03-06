function [sensi, speci, PreicPerc, IctalPerc, AC] = calcPerform(outSim, Target)
    i = 1;
    Trglength = size(Target);
    TP = 0; % true positives
    FN = 0; % false negatives
    TN = 0; % true negatives
    FP = 0; % false positives
    
    TotalTruePreic = 0; % total true Preictal points
    TruePreic = 0;      % ture Preictal points found
    TotalTrueIctal = 0; % total true Ictal points
    TrueIctal = 0;      % true Ictal points found
    AC = 0;
    
    while i < Trglength(1,2,1)
        if outSim(1,i) > outSim(2,i) && outSim(1,i) > outSim(3,i) && outSim(1,i) > outSim(4,i) && Target(1,i) == 1
            AC = AC + 1;
        end
        if outSim(4,i) > outSim(1,i) && outSim(4,i) > outSim(3,i) && outSim(4,i) > outSim(2,i) && Target(4,i) == 1
            AC = AC + 1;
        end
        if outSim(3,i) > outSim(1,i) && outSim(3,i) > outSim(2,i) && outSim(3,i) > outSim(4,i) && Target(3,i) == 1
            TP = TP + 1;
        elseif outSim(2,i) > outSim(1,i) && outSim(2,i) > outSim(3,i) && outSim(2,i) > outSim(4,i) && Target(2,i) == 1
            TP = TP + 1;
        elseif (outSim(3,i) < outSim(1,i) || outSim(3,i) < outSim(2, i) || outSim(3,i) < outSim(4,i)) && Target(3,i) ~= 1
            TN = TN + 1;
        elseif (outSim(2,i) < outSim(1,i) || outSim(2,i) < outSim(3, i) || outSim(2,i) < outSim(4,i)) && Target(2,i) ~= 1
            TN = TN + 1;
        end
        if outSim(3,i) > outSim(1,i) && outSim(3,i) > outSim(2,i) && outSim(3,i) > outSim(4,i) && Target(3,i) ~= 1
            FP = FP + 1;
        elseif outSim(2,i) > outSim(1,i) && outSim(2,i) > outSim(3,i) && outSim(2,i) > outSim(4,i) && Target(2,i) ~= 1
            FP = FP + 1;
        elseif (outSim(3,i) < outSim(1,i) && outSim(3,i) < outSim(2,i) && outSim(3,i) < outSim(4,i)) && Target(3,i) ==1
            FN = FN + 1;
        elseif (outSim(2,i) < outSim(1,i) && outSim(2,i) < outSim(3,i) && outSim(2,i) < outSim(4,i)) && Target(2,i) ==1
            FN = FN + 1;
        end
        if Target(2, i) == 1
            if outSim(2,i) > outSim(1,i) && outSim(2,i) > outSim(3, i) && outSim(2,i) > outSim(4, i)
                TruePreic = TruePreic + 1;
            end
            TotalTruePreic = TotalTruePreic + 1;
        end
        if Target(3, i) == 1
            if outSim(3,i) > outSim(1,i) && outSim(3,i) > outSim(2, i) && outSim(3,i) > outSim(4, i)
                TrueIctal = TrueIctal + 1;
            end
            TotalTrueIctal = TotalTrueIctal + 1;
        end
        i = i + 1;
    end
    AC = AC + TP;
    AC = AC / Trglength(1,2,1);
    AC = AC * 100;
    sensi = TP / (TP + FN);
    speci = TN / (TN + FP);
    PreicPerc = (TruePreic / TotalTruePreic) * 100;
    IctalPerc = (TrueIctal / TotalTrueIctal) * 100;
    return
end
