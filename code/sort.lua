function sort_bubble(table, comp)
	local flag = true
	for i = 1, #table do
		if flag == false then
			break;
		end
		flag = false
		for j = #table, i + 1 , -1 do
			if comp(table[j - 1], table[j]) then
				table[j - 1], table[j] = table[j], table[j - 1]
				flag = true
			end
		end
	end
end
--每次找到最小的位置
function sort_select(table, comp)
	local min;
	for i = 1, #table -1 do
		min = i
		for j = i + 1, #table do
			if comp(table[min], table[j]) then
				min = j
			end
		end
		if min ~= i then
			table[i], table[min] = table[min], table[i]
		end
	end
end
--与前面的比较
function sort_insert(table, comp)
	local temp, j
	for i = 2, #table do
		temp = table[i]
		j = i

		while  j > 1 and comp(table[j - 1], temp)  do
			table[j] = table[j-1]
			j = j - 1
		end

		if i ~= j then
			table[j] = temp
		end

	end
end

--插入排序的增强
function sort_shell(table, cmp)
	gap = #table
	repeat
		gap = math.floor(gap/3) + 1
		for i = 1 + gap, #table, gap do

			local temp = table[i]
			local j = i

			while j > 1 and cmp(table[j - gap], temp) do
				table[j] = table[j - gap]
				j = j - gap
			end

			if i ~=  j then
				table[j] = temp
			end

		end
	until gap == 1
end

--先比较最右边
function sort_quick(table, comp)
	local function swap(table, left, right)
		table[left], table[right] = table[right], table[left]
	end

	local function partition(table, low, high, comp)
		local mid = low + math.floor((high - low) / 2)
		local point

		if comp(table[low], table[high]) then
			swap(table, low, high)
		end

		if comp(table[mid], table[high]) then
			swap(table, mid, high)
		end

		if comp(table[mid], table[low]) then
			swap(table, low, mid)
		end

		point = table[low]
		while low < high do
			while low < high and (comp(table[high], point) or point == table[high]) do
				high = high - 1
			end
			table[low] = table[high]

			while low < high and (comp(point, table[low]) or point == table[low]) do
				low = low + 1
			end
			table[high] = table[low]
		end

		table[low] = point
		return low
	end

	local function sort_quick_helper(table, low, high)
		while (low < high) do
			local point = partition(table, low, high, comp)
			if (point - low < high - point) then
				sort_quick_helper(table, low, point - 1)
				low = point + 1
			else
				sort_quick_helper(table, point + 1, high)
				high = point - 1
			end
		end
	end

	sort_quick_helper(table, 1, #table)

end


function sort_heap(table, comp)
	local function adjust_heap(table, p, n, comp)
		temp = table[p]
		i = p * 2
		while i <= n do
			if i < n and comp(table[i], table[i + 1]) then
				i = i + 1
			end

			if comp(table[i], temp) then
				break;
			end

			table[i], table[p] = table[p], table[i]
			p = i
			i = i * 2
		end

		table[p] = temp
	end

	n = #table
	for i = math.floor(n /2), 1, -1 do
		adjust_heap(table, i, n, comp)
	end

	for i = n, 1, -1 do
		table[1], table[i] = table[i], table[1]
		adjust_heap(table, 1, i - 1, comp)
	end

end