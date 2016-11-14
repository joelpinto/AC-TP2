

dataset = '44202.mat'
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

net = feedforwardnet(29);
net.trainFcn = 'trainlm';
net = train(net,FinalIsolated,FinalTarget,'useparallel','yes','useGPU','yes');

save 'stats'
