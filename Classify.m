
    
    if(option == 1)
        if(strcmp(neuralNetwork,'feedfo_1'))
            load('netfeedfo_trainlm_20.mat');
        elseif(strcmp(neuralNetwork,'recnet_1'))
            load('netfeedfo_trainscg_20.mat');
        end
    else
         load(uigetfile('*.mat','Select the MATLAB NN file'));
    end
   
    
    %gpuDevice(1);

    load(dataset);

    
    [TTTarget,BreakingPoints] = getTarget(Trg);
    TTTarget = transpose(TTTarget);

    BreakingPoints = BreakingPoints';

    FinalTarget =[];
    FinalIsolated =[];
    FeatVectSel = FeatVectSel';

    if(strcmp(pre,'A'))
        for iterator = 1:size(BreakingPoints)
            before = BreakingPoints(iterator)-1000;
            after = BreakingPoints(iterator)+ 1000;
            FinalTarget = [FinalTarget,TTTarget(1:4, before:after)];
            FinalIsolated = [FinalIsolated,FeatVectSel(1:29,before:after)];
        end
    elseif(strcmp(pre,'B'))
        for iterator = 1:size(BreakingPoints)
            before = BreakingPoints(iterator)- 730;
            after = BreakingPoints(iterator)+ 430;
            FinalTarget = [FinalTarget,TTTarget(1:4, before:after)];
            FinalIsolated = [FinalIsolated,FeatVectSel(1:29,before:after)];
        end    
    elseif(strcmp(pre,'C'))
        
    end
    A = FinalIsolated;
    normA = A - min(A(:));
    normA = normA ./ max(normA(:));
    
    FinalIsolated = normA;
    

    outSim = sim(net,FinalIsolated);
    [sensi, speci, PreicPerc, IctalPerc] = calcPerform(outSim, FinalTarget);

