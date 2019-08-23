function [img_2] = myNearest(img_1, n)
size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 = zeros(h_2, w_2);

for i = 1 : h_2
   for j = 1 : w_2
      cen = [i,j]/n;
      sid1 = floor(cen);
      if sid1(1) == 0
          sid1(1) = 1;
      end
      if sid1(2) == 0
          sid1(2) = 1;
      end
      %if sid1(1) > h_1
      %    sid1(1)= h_1;
      %end
      %if sid1(2) > h_1
      %    sid1(2) = h_1;
      %end
      if sid1 == floor(sid1)
          img_2(i,j) = img_1(sid1(1), sid1(2));
          continue;
      end
      %Edge condition
      sq1 = (sid1 - cen) * (sid1 - cen)';
      sid2 = sid1 + [0 1];
      sq2 = (sid2 - cen) * (sid2 - cen)';
      sid3 = sid1 + [1 1];
      sq3 = (sid3 - cen) * (sid3 - cen)';
      sid4 = sid1 + [0 1];
      sq4 = (sid4 - cen) * (sid4 - cen)';
      % clockwise
      [row, column] = find( [sq1 sq2; sq4 sq3] == min(min([sq1 sq2; sq4 sq3])));
      img_2(i,j) = img_1(sid1(1)+row(1)-1, sid1(2)+column(1)-1);
      %多个最近邻点时选择左上角
   end
end
%img_2 = uint8(img_2);
end


