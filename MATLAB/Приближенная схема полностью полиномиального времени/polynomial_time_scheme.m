%Практика, задача о рюкзаке, "Приближенная схема полностью полиномиального времени"
%Выполнили студенты группы ФН2-41Б
%Сербин Г.Э. и Мелешко Е.Д.
clear
clc


data=dlmread('тесты\test7.txt',' ');


N=data(1,1);
global items;
items=struct('num',0,'weight',0,'price',0);
for i=1:N
    item.num=i;
    item.weight=data(i+1,1);
    item.price=data(i+1,2);
    items(i)=item;
end
capacity = data(N+2,1);

fprintf('Вместимость: %d \n',capacity)  

tic

items_copy=items;
items=sort_by_specific_price(items);

disp('Приближенная схема полностью полиномиального времени:')
global eps;
eps=0.01*input('Укажите погрешность решения в процентах eps=');



p_max=0;
p_max=greedy_price_opt(N, capacity);

	coeff = p_max /( (1 + (1. / eps)) * N);
	items_rounded_price=zeros(1,N);
	for i = 1:length(items) 
		items_rounded_price(i)=round(items(i).price * 1.0 / coeff);
    end

S=0;

	for i =1: length(items_rounded_price) 
		S = S+items_rounded_price(i);
    end
    
    w=struct('item_numbers',[],'weight',0);
for i=1:N+1
    for j=1:S+1
    pseudo_sol=struct('item_numbers',[],'weight',0);
    w(i,j)=pseudo_sol;
    end
end
taken_items=[];

% 	%w(k,p)
% 	%w(N,S)
% 
	for  p = 2:(S+1)
		for k = 2:(N+1)
			w(k,p).weight = capacity+1;
        end
    end
    
    w(1,1).weight = 0;
	w(1,1).item_numbers = [];
	for p = 2:S+1
		w(1,p).weight = -1;
    end
	for k = 2:N+1
		w(k,1).weight = 0;
		w(k,1).item_numbers = [];
    end

    

	best_solution=[];%
	for p = 2: S+1
		for k = 1:N
			w_take=0;
			w_leave=0;
			take_numbers=[];
			if p - items_rounded_price(k) <= 0 
				w_take = w(k,1).weight;
				take_numbers = w(k,1).item_numbers;
			else 
				w_take = w(k,p - items_rounded_price(k)).weight;
				take_numbers = w(k,p - items_rounded_price(k)).item_numbers;
            end

			w_leave = w(k,p).weight;

			if w_take== -1 
				if w_leave == -1 
					w(k + 1,p).weight = -1;
				else 
					w(k + 1,p).weight = w_leave;	
					w(k + 1,p).item_numbers = w(k,p).item_numbers;
                end
            else
				if w_leave == -1 || w_take + items(k).weight <= w_leave 
					w(k + 1,p).weight = w_take + items(k).weight;
					w(k + 1,p).item_numbers = take_numbers;
					w(k + 1,p).item_numbers(length(take_numbers)+1)=k;
                else
					w(k + 1,p).weight = w_leave;
					w(k + 1,p).item_numbers = w(k,p).item_numbers;
                end
            end
        end

		if w(N+1,p).weight <= capacity
			best_solution = w(N+1,p).item_numbers;
		else 
			break;	
        end
   end

    
    
    taken_items=zeros(1,length(best_solution));
	for i=1:length(best_solution)
		taken_items(i)=items(i).num;
    end
    
    
    
    
    
taken_items=sort(taken_items);
disp('Ответ: ')

for i=1:length(taken_items)
    fprintf('%d  ',taken_items(i))  
end

price_opt=0;
weight_opt=0;
for i=1:length(taken_items)
    price_opt=price_opt+items_copy(taken_items(i)).price;
    weight_opt=weight_opt+items_copy(taken_items(i)).weight;
end
fprintf('\nОбщая ценность взятых предметов: %d \n',price_opt) 
fprintf('Общий вес взятых предметов: %d \n',weight_opt)  


%taken_items
toc