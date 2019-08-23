function [dict] = huff_dict()
%initiate
pro = load('pro.mat');
pro = pro.pro;
pro_origin = pro;
n = length(pro);
for i = 1:length( pro)    % For each probability.
        codeword{i} = '';      % Create an empty codeword.用来记录每一个字母对应的编码
        Symbol{i} = i;        %其为此刻每一个概率所对应的字母集合。分配0/1时要对该概率下的所有字母分配
end
while n > 1
    n = n-1;
    [~,index] = sort(pro);
    last = index(1);
    last2 = index(2);
    left_set = Symbol{last};
    right_set = Symbol{last2};
    left_pro = pro(last);
    right_pro = pro(last2);
    
    % update the symbol and pro
    pro(index(1:2)) = '';
    Symbol(index(1:2)) = '';
    new_pro = left_pro+right_pro;
    merge_Symbol = [left_set, right_set];
    pro = [pro, new_pro];
    Symbol = [Symbol, merge_Symbol];
    % update the coedword
    codeword = append_code(codeword, left_set, '0');
    codeword = append_code(codeword, right_set, '1');
end
dict.codewords = codeword;
ave = 0 ; 
for i = 1:length(pro_origin)
    ave = ave + pro_origin(i)*length(codeword{i});
end
dict.ave = ave;
save dict;
end

function [codeword] = append_code(codeword, set, input_code)
    for i = 1:length(set)
        codeword{set(i)} = strcat(input_code,codeword{set(i)});
    end
end