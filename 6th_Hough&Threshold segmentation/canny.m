function imnew = canny(im,sigma,High)
n = ceil(sigma * 6); %确保它是奇数
[Column,Row] = size(im);
if mod(n,2) == 0
    n = n + 1;
end
x = -floor(n/2) : floor(n/2);
y = x;
[X,Y] = meshgrid(x,y);
G = exp(- (X.^2 + Y.^2) / (2 * sigma^2));
im2 = mat2gray(conv2(im,G,'same'));

gx = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
gy = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
Gx = conv2(im2 , gx, 'same');
Gy = conv2(im2 , gy, 'same');
M = mat2gray(abs(Gx) + abs(Gy));
alpha = atan(Gx./Gy);
%% 2
new = Getalpha(alpha);
Gn = GetGn(M,new);
%% 3
Low = High/3;

Gn = padarray(Gn, [1, 1], 0);

GnH = Gn .* (Gn > High);
GnL = Gn .* (Gn > Low) - GnH;

gl_sel = (Gn > High);
for i = 2:Column+1
    for j = 2:Row+1
        if( GnH(i,j) > 0 )
            tmp = GnL(i - 1: i + 1, j - 1: j + 1) > 0;
                gl_sel(i - 1: i + 1, j - 1: j + 1) = gl_sel(i - 1: i + 1, j - 1: j + 1) | tmp;
        end
    end
end
Gn = Gn.* gl_sel;
n = graythresh(Gn);
imnew = im2bw(Gn(2:Column+1,2:Row+1),n);

%%

function new = Getalpha(alpha)
[m,n] = size(alpha); %边缘方向
for i = 1:m
    for j = 1:n
        a = (alpha(i,j));
        if ( a >= -0.125*pi && a < 0.125*pi ) || (a <= pi && a >= 0.875*pi) || (a < -0.875*pi && a >= -pi)
            new(i,j) = 1; % 0
            %67.5 = 0.375*pi  22.5 = 0.125*pi
            %112.5 = 0.625*pi 157.5 = 0.875*pi
        elseif (a >= 0.125*pi && a < 0.375*pi) || ( a >= -0.875*pi && a < -0.625*pi)
            new(i,j) = 2; % -45
        elseif (a >= 0.375*pi && a < 0.625*pi) || ( a >= -0.625*pi && a < -0.375*pi)
            new(i,j) = 3; % 90
        elseif (a >= 0.625*pi && a < 0.875*pi) || ( a >= -0.375*pi && a < -0.125*pi)
            new(i,j) = 4; % 45
        end
    end
end
end

function Gn = GetGn(M,new)
[m,n] = size(new);
Mnew = ones(m+2,n+2) * Inf;
Mnew(2:m+1,2:n+1)= M;
Gn = zeros(m,n);
for i = 1:m
    for j = 1:n
        if new(i,j) == 1
            if Mnew(i+1,j+1)>=Mnew(i+1,j) && Mnew(i+1,j+1)>=Mnew(i+1,j+2)
                Gn(i,j) = M(i,j);
            end
        elseif new(i,j) == 2
            if Mnew(i+1,j+1)>=Mnew(i+2,j+2) && Mnew(i+1,j+1)>=Mnew(i,j)
                Gn(i,j) = M(i,j);
            end
        elseif new(i,j) == 3
            if Mnew(i+1,j+1)>=Mnew(i,j+1) && Mnew(i+1,j+1)>=Mnew(i+2,j+1)
                Gn(i,j) = M(i,j);
            end
        elseif new(i,j) == 4
            if Mnew(i+1,j+1)>=Mnew(i,j+2) && Mnew(i+1,j+1)>=Mnew(i+2,j)
                Gn(i,j) = M(i,j);
            end
        end
    end
end
end

end

