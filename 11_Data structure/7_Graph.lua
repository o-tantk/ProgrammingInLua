local function name2node (graph, name)
    local node = graph[name]
    if not node then
        -- ��尡 ���ٸ� ���� �ϳ� �����.
        node = {name = name, adj = {}}
        graph[name] = node
    end
    return node
end

local function readgraph (filename)
    if not filename then return {} end
    
    local graph = {}
    for line in io.lines(filename) do
        -- ���� �̸� �� ���� �и�
        local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
        -- �����ϴ� ��� ã��
        local from = name2node(graph, namefrom)
        local to = name2node(graph, nameto)
        -- 'from'�� ���� ��� ��Ͽ� 'to'�� �߰�
        from.adj[to] = true
    end
    return graph
end

-- ���� �켱 ��ȸ�� �̿��� ��� Ž��
local function findpath (curr, to, path, visited)
    path = path or {}
    visited = visited or {}

    if visited[curr] then   -- �̹� �湮�� ����ΰ�?
        return nil          -- �� �̻��� ��δ� ����.
    end
    visited[curr] = true    -- ��带 '�湮��(visited)'���� ǥ��
    path[#path + 1] = curr  -- ��带 ��ο� �߰�
    if curr == to then      -- ������ ����ΰ�?
        return path
    end

    -- ��� ������ ��忡 �õ�
    for node in pairs(curr.adj) do
        local p = findpath(node, to, path, visited)
        if p then return p end
    end
    path[#path] = nil       -- ��带 ��ο��� �����Ѵ�.
end

local function printpath (path)
    for i = 1, #path do
        print(path[i].name)
    end
end

local g = readgraph()
local a = name2node(g, "a")
local b = name2node(g, "b")
a.adj[b] = true
local p = findpath(a, b)
if p then printpath(p) end
