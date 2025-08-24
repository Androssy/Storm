local ltn12 = {}

function ltn12.source_string(str)
	local i = 1
	return function()
		if i > #str then
			return nil
		end
		local chunk = str:sub(i, i + 8191)
		i = i + 8192
		return chunk
	end
end

function ltn12.sink_table(tbl)
	tbl = tbl or {}
	return function(chunk)
		if chunk then
			table.insert(tbl, chunk)
		end
		return 1
	end, tbl
end

ltn12.source = { string = ltn12.source_string }
ltn12.sink = { table = ltn12.sink_table }

return ltn12
