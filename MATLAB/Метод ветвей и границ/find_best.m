function[solution]=find_best(backpack, i, capacity)
global items;
global possible_solution;
solution=struct('item_numbers',[],'total_price',0);
    if i<=length(items)
       
        if greedy_bound(backpack,capacity, i)<possible_solution.total_price
            1+1;%return solution;
        else
            bp_copy=backpack;
            %берем
            result_take=solution;
            if backpack.weight + items(i).weight <=capacity
            
                bp_copy.taken_items=[bp_copy.taken_items,i];
                bp_copy.weight=bp_copy.weight+bp_copy.remaining_items(1).weight;
                bp_copy.remaining_items(1)=[];
            
            
                result_take = find_best(bp_copy, i + 1, capacity);
                bp_copy = backpack;%возвращаем копию в исходное состояние
            end

            %не берем вещь
            result_leave=solution;
            bp_copy.remaining_items(1)=[];
            result_leave = find_best(bp_copy, i + 1, capacity);

            if result_take.total_price > result_leave.total_price
                solution = result_take;
            else
                solution = result_leave;
            end

        end
    else
    
    
    		%находим сумму
		total_price = 0;
		for i =1:length(backpack.taken_items) 
			total_price =total_price+ items(backpack.taken_items(i)).price;
        end
		if total_price > possible_solution.total_price 
			possible_solution.item_numbers = backpack.taken_items;
            possible_solution.total_price= total_price;
            solution=possible_solution;
        end
    end
end