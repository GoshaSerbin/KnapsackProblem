function[items]=sort_by_specific_price(items)

N=length(items);
for i=1:N
    max_y=double(items(i).price)/double(items(i).weight);
    max_ind=i;
    for j=i:N
        if max_y<double(items(j).price)/double(items(j).weight)
            max_ind = j;
            max_y = items(j).price / items(j).weight;
        end
    end
    copy_item=items(i);
    items(i)=items(max_ind);
	items(max_ind) = copy_item;
end
end