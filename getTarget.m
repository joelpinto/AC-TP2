function T = getTarget(Trg)
    Trglength = size(Trg);
    T = zeros(Trglength(1,1,1), 4, 'uint32');
    for i = 1 : Trglength(1,1,1)
        if i > 2 && Trg(i, 1) == 1 && Trg(i - 1, 1) == 0%init ictical found
            T(i - 1 - 600 : i - 1, 2) = 1; % preictical points
        end
        if i > 2 && Trg(i, 1) == 0 && Trg(i - 1, 1) == 1 && i > 2%final ictical found
            T(i : i + 300, 4) = 1; % postictical points
        end
        if Trg(i, 1) == 1 % every ictical point
            T(i, 3) = 1;
        else              % every interictical point
            T(i, 1) = 1;
        end
    end
    return
end