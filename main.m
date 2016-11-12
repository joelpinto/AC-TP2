i = 1;
load 44202;
inicio = 9000;
fim = 12000;
T = getTarget(Trg);
T = transpose(T);
T = T(1:4, inicio:fim);
SubFeat = FeatVectSel(inicio:fim, 1:29);
SubFeat = transpose(SubFeat);
Test = FeatVectSel(fim + 1:(fim - inicio) * 2, 1:29);
Test = transpose(Test);

if i == 1
    net = newlrn(SubFeat, T, 25);
    net.divideParam.trainRatio=1;
    net.divideParam.testRatio=0;
    net.divideParam.valRatio=0;
    net.trainFcn = 'trainlm';
    net = train(net,SubFeat,T);
    outSim = sim(net,Test);
end
if i == 2
    net = newff(SubFeat, T, 10);
    net.trainFcn='trainlm';
    net.trainParam.epochs = 100;
    net.trainParam.goal = 0.00001;
    net.divideParam.trainRatio=1;
    net.divideParam.testRatio=0;
    net.divideParam.valRatio=0;
    net = train(net,SubFeat,T);
    outSim = sim(net,Test);
end