
%     dataset = '44202.mat';
%     activation = 'purelin';
<<<<<<< HEAD
%     neuralNetwork = 'ddn';
%     trainFunction ='trainscg'; 
%     hiddenValue = 20;
=======
%     neuralNetwork = 'elman';
%     trainFunction ='traincgb'; 
%     hiddenValue = 20;
%     pre = 'B';
>>>>>>> 06753300b0cb654593ea27837fcc4e72d7d58624

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

    inicio = 0;
    fim = size(FinalIsolated);
    fim = fim(1,2,1);
    FinalTargetTest = FinalTarget(1:4, fim * 0.7:fim);
    FinalTargetTrain = FinalTarget(1:4, inicio:fim * 0.7);
    FinalIsolatedTrain = FinalIsolated(1:29, inicio:fim * 0.7);
    FinalIsolatedTest = FinalIsolated(1:29, fim * 0.7:fim);

    
    
    A = FinalIsolatedTrain;
    normA = A - min(A(:));
    normA = normA ./ max(normA(:));
    
    FinalIsolatedTrain = normA;
    
    if(strcmp(neuralNetwork,'feedfo'))
        size(FinalTarget);
        net = feedforwardnet(hiddenValue);
        net.trainFcn = trainFunction;
        net.divideParam.trainRatio=1;
        net.divideParam.testRatio=0;
        net.divideParam.valRatio=0;
        net.layers{1}.transferFcn=activation;
        net.layers{2}.transferFcn=activation;
        net = train(net,FinalIsolatedTrain,FinalTargetTrain);
    elseif(strcmp(neuralNetwork,'recnet'))
        net = layrecnet(1:2,hiddenValue);
        net.divideParam.trainRatio=1;
        net.divideParam.testRatio=0;
        net.divideParam.valRatio=0;
        net.trainFcn = trainFunction;
        net = train(net,FinalIsolatedTrain,FinalTargetTrain);
    elseif(strcmp(neuralNetwork,'elman'))
        net = elmannet(1:2, hiddenValue);
        net.divideParam.trainRatio=1;
        net.divideParam.testRatio=0;
        net.divideParam.valRatio=0;
        net.trainFcn = trainFunction;
        net = train(net,FinalIsolatedTrain,FinalTargetTrain);
    end

    name = strcat('net',neuralNetwork);
    name = strcat(name,'_');
    name = strcat(name,trainFunction);
    name = strcat(name,'_');
    name = strcat(name,num2str(hiddenValue));
    name = strcat(name,'.mat');
    name = char(name);
    save(name,'net');

    outSim = sim(net,FinalIsolatedTest);
    [sensi, speci, PreicPerc, IctalPerc] = calcPerform(outSim, FinalTargetTest);

