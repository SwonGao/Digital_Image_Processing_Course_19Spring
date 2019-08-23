function im_syn = merge( w_d,w_row,w_col,w_hor)
    [M,N] = size( w_d );
    im_syn(1:M,1:N) = w_d;
    im_syn(1:M,N+1:N+N) = w_row;
    im_syn(M+1:M+M,1:N) = w_col;
    im_syn(M+1:M+M,N+1:N+N) = w_hor;
end