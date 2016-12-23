function [muDash,sigmaDash] = GaussianApprox(mu,Ymax,hist)
num1 = 0;
deno = 0;
num2 = 0;
for y=mu:Ymax
    num1 = num1 + hist(y+1)*double(y);
    deno = deno + hist(y+1);
end
muDash = (num1/deno);
for y=mu:Ymax
    num2 = num2 + hist(y+1)*double((y-muDash)^2);
end
sigmaDash = (sqrt(num2/deno));

end