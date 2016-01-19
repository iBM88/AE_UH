function [ model ] = Reg_construct( isBias1, isBias2, isTied, p_func1, p_func2, seed, hid, dim, ...
                           p_iter, p_rate, p_momentum, p_decay, p_batch, filename)
%Constructor function for Auto-encoder
    [ model ] = Model_construct( isBias1, isBias2, isTied, p_func1, p_func2, seed, hid, dim, ...
                               p_iter, p_rate, p_momentum, p_decay, p_batch, filename);

end

