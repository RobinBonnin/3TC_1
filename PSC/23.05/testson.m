load gong.mat
plot(y)
length(y)
sound(y)
q=quantizer([16 14]);
for i=1:10
    b = [b num2bin(q,y(i))] ;
end
y
b
b(i)
c =[]
for i=0:9
    for j=1:16
        d = b((j+(i*16)):(j+15+(i*16)))
        c = [c bin2num(q, d)];
    end
end
c