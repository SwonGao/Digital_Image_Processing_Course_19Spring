function [dict] = huff_dict()
%initiate
pro = load('pro.mat');
pro = pro.pro;
pro_origin = pro;
n = length(pro);
for i = 1:length( pro)    % For each probability.
        codeword{i} = '';      % Create an empty codeword.������¼ÿһ����ĸ��Ӧ�ı���
        Symbol{i} = i;        %��Ϊ�˿�ÿһ����������Ӧ����ĸ���ϡ�����0/1ʱҪ�Ըø����µ�������ĸ����
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