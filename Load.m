
    load(uigetfile('*.mat','Select the MATLAB NN file'));

    
    %gpuDevice(1);

    load(dataset);

    
    [TTTarget,BreakingPoints] = getTarget(Trg);
    TTTarget = transpose(TTTarget);

    BreakingPoints = BreakingPoints';

    FinalTarget =[];
    FinalIsolated =[];
    FeatVectSel = FeatVectSel';


    for iterator = 1:size(BreakingPoints)
        before = BreakingPoints(iterator)-1000;
        after = BreakingPoints(iterator)+ 1000;
        FinalTarget = [FinalTarget,TTTarget(1:4, before:after)];
        FinalIsolated = [FinalIsolated,FeatVectSel(1:29,before:after)];
    end

    A = FinalIsolatedTrain;
    normA = A - min(A(:))
    normA = normA ./ max(normA(:))
    
    FinalIsolatedTrain = normA;
    
    
    outSim = sim(net,FinalIsolated);
    [sensi, speci, PreicPerc, IctalPerc] = calcPerform(outSim, FinalTarget);




