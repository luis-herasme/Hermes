function r = f(X)
    r = shift(X, 1);
    r(1) = mod(X(end) + X(end - 1), 2);
end
