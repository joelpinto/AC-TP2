i = 2;
load 44202;
inicio = 1;
fim = 614300;
T = getTarget(Trg);
T = transpose(T);
T = T(1:4, inicio:fim * 0.7);
SubFeat = FeatVectSel(inicio:fim * 0.7, 1:29);
SubFeat = transpose(SubFeat);
Test = FeatVectSel(fim * 0.7:fim, 1:29);
Test = transpose(Test);

if i == 1
    net = newlrn(SubFeat, T, 2);
    net.divideParam.trainRatio=1;
    net.divideParam.testRatio=0;
    net.divideParam.valRatio=0;
    net.trainFcn = 'trainlm';
    net = train(net,SubFeat,T);
    outSim = sim(net,Test);
end
if i == 2
    net = newff(SubFeat, T, 3);
    net.trainFcn='trainlm';
    net.trainParam.epochs = 100;
    net.trainParam.goal = 0.00001;
    net.divideParam.trainRatio=1;
    net.divideParam.testRatio=0;
    net.divideParam.valRatio=0;
    net = train(net,SubFeat,T);
    outSim = sim(net,Test);
end
