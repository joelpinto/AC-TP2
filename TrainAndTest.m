%function [ output_args ] = Interface( input_args )
%INTERFACE Summary of this function goes here
%   Detailed explanation goes here
x = 'TRAIN AND TEST'

load('44202.mat');

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


net = feedforwardnet(11);
net.trainFcn = 'trainlm';
net = train(net,FinalIsolated,FinalTarget,'useparallel','yes','useGPU','yes');
view(net)



%end

