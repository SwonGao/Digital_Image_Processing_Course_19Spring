function [output] = huff_test(dict)
for i = 1:5
    IM{i} = '';
    Codes{i} = '';
    C = '';
end
IM{1} = rgb2gray(imread('test\baby_GT.bmp'));
IM{2} = rgb2gray(imread('test\bird_GT.bmp'));
IM{3} = rgb2gray(imread('test\butterfly_GT.bmp'));
IM{4} = rgb2gray(imread('test\head_GT.bmp'));
IM{5} = rgb2gray(imread('test\woman_GT.bmp'));
pixelsum = 0;
sum = 0;
for i = 1:5
    [M,N] = size(IM{i});
    pixel = 0;
    for j = 1:M
        for k = 1:N
            Code{i}{j,k} = '';
        end
    end
    for j = 1:M
        for k = 1:N
           Codes{i}{j,k} = dict.codewords{IM{i}(j,k) + 1};
           pixel = pixel + length(Codes{i}{j,k});
           pixelsum = pixelsum+length(Codes{i}{j,k});
        end
    end
    C{i} = pixel/(8*M*N);
    sum = sum + 8*M*N;
end
output.Codes = Codes;
output.Crate = C;
output.C_all = pixelsum/sum;

end