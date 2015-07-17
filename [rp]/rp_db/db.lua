local SQL

addEventHandler("onResourceStart", root, function()
	SQL = dbConnect("mysql", "dbname=roleplay;host=195.64.158.16", "root", "neproify.kl[000]cek", "share=1")
	if SQL then
	else
		print("[ERROR]Blad podczas laczenia z baza danych!")
	end
end)

function pobierzTabeleWynikow(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	return rows
end

function pobierzWyniki(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	if not rows then return nil end
	return rows[1]
end

function zapytanie(...)
	local h=dbQuery(SQL,...)
	local result,numrows=dbPoll(h,-1)
	return numrows
end

--[[
function insertID()
	return mysql_insert_id(SQL)
end

function affectedRows()
	return mysql_affected_rows(SQL)
end
]]--

function fetchRows(query)
	local result=mysql_query(SQL,query)
	if (not result) then return nil end
	local tabela={}

	while true do
    	local row = mysql_fetch_row(result)
	    if (not row) then break end
	    table.insert(tabela,row)
	end
	mysql_free_result(result)
	return tabela
end