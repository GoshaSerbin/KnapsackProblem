function[total_price]=greedy_price_opt(N,capacity)
global items;
total_price=0;
total_weight=0;
i=1;
while i<=N
    while total_weight+items(i).weight<=capacity
        total_weight=total_weight+items(i).weight;
        total_price=total_price+items(i).price;
        i=i+1;
        if i>N 
            break;
        end
    end
    if total_price==0 && i<=N
        i=i+1;
    else
        break;
    end
    
end

end