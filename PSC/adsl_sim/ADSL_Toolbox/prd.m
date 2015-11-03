%PRD pseudo random binary number generator.
%
% X = PRD(M) returns M binary numbers in X. M has to be greater than
% 0 and smaller than 512.



function x = prd(M)

if M < 0 | M > 512
   M = 512;
end

for n = 1:512

   if n>=1 & n<=9
      y(n) = 1;
   else
      y(n) = xor(y(n-4),y(n-9));
   end
end

x = y(1:M); 
