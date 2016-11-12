i = 2;
load 44202;
T = getTarget(Trg);
T = transpose(T);
T = T(1:4, 8000:10000);
SubFeat = FeatVectSel(9000:10000, 1:29);
SubFeat = transpose(SubFeat);

