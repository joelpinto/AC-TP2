i = 2;
load 54802;
[T,BreakingPoints] = getTarget(Trg);
T = T';
BreakingPoints = BreakingPoints';
FeatVectSel = FeatVectSel';
FinalTarget =[];
FinalIsolated =[];
for iterator = 1:size(BreakingPoints)
    before = BreakingPoints(iterator)-1000;
    after = BreakingPoints(iterator)+ 1000;
    FinalTarget = [FinalTarget,T(1:4, before:after)];
    FinalIsolated = [FinalIsolated,FeatVectSel(1:29,before:after)];
end
inicio = 0;
fim = size(FinalIsolated);
fim = fim(1,2,1);
TT = FinalTarget(1:4, fim * 0.7:fim);
T = FinalTarget(1:4, inicio:fim * 0.7);
SubFeat = FinalIsolated(1:29, inicio:fim * 0.7);
Test = FinalIsolated(1:29, fim * 0.7:fim);

if i == 1
    net = layrecnet();
    net.divideParam.trainRatio=1;
    net.divideParam.testRatio=0;
    net.divideParam.valRatio=0;
    net.trainFcn = 'trainlm';
    net = train(net,SubFeat,T);
    outSim = sim(net,Test);
end
if i == 2
    net = feedforwardnet(29, 'trainlm');
    net.trainFcn='trainlm';
    net.trainParam.epochs = 100;
    net.trainParam.goal = 0.00001;
    net.divideParam.trainRatio=1;
    net.divideParam.testRatio=0;
    net.divideParam.valRatio=0;
    net = train(net,SubFeat,T);
    outSim = sim(net,Test);
    [sensi, speci] = calcPerform(outSim, TT);
end
