%Практика, задача о рюкзаке, "Метод ветвей и границ"
%Выполнил студент группы ФН2-41Б
%Сербин Г.Э.

clear
clc

data=dlmread('тесты\50_0.txt',' ');


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

disp('Метод ветвей и границ:')
global possible_solution;
possible_solution=struct('item_numbers',[],'total_price',0);

backpack=struct('weight',0,'remaining_items',items,'taken_items',[]);

	best_solution = find_best(backpack, 1, capacity);

	taken_items=zeros(1,length(best_solution.item_numbers));
	for i=1:length(best_solution.item_numbers)
        taken_items(i)=items(best_solution.item_numbers(i)).num;
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
