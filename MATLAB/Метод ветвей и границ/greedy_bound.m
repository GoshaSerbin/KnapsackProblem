function[bound]=greedy_bound(backpack,capacity, ind)
global items;
	while length(backpack.remaining_items)>0%тут могут быть проблемы с длиной массива и =[]
		if backpack.weight + backpack.remaining_items(1).weight <= capacity
            backpack.taken_items=[backpack.taken_items,ind];
            backpack.weight=backpack.weight+backpack.remaining_items(1).weight;
            backpack.remaining_items(1)=[];
            ind=ind+1;
        else
            break
        end
    end
    taken_price=0;
    for i=1:length(backpack.taken_items)
       taken_price=taken_price+items(backpack.taken_items(i)).price;
    end
	bound = taken_price;

	if length(backpack.remaining_items)>0
		bound =bound+ double(backpack.remaining_items(1).price) / double(backpack.remaining_items(1).weight) * (capacity - backpack.weight);
    end
end