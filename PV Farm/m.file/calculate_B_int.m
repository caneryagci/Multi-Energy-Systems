n=24;
B_ab=zeros(n,1);
alfa =[2.00 2.00 2.00 2.00 4.00 4.00 4.00 4.30 4.50 4.70 5.00 5.00 5.00 6.30 8.00 9.00 9.00 9.00 4.00 3.00 2.00 1.00 1.00 2.00 2.00];
beta =[5.00 5.00 8.00 8.00 8.00 8.00 9.00 9.00 10.00 10.00 9.0 8.00 7.00 6.00 5.00 5.00 3.00 2.00 2.02 2.40 2.50 2.60 2.00 5.00];
syms s;
for i= 1 :1: n
    B_int(s)=s^(alfa(i)-1)*(1-s)^(beta(i)-1);
    B_ab(i)=double(int(B_int(s),0,1));
end

%double(ans);