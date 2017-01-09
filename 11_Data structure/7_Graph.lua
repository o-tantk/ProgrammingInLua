local function name2node (graph, name)
    local node = graph[name]
    if not node then
        -- 노드가 없다면 새로 하나 만든다.
        node = {name = name, adj = {}}
        graph[name] = node
    end
    return node
end

local function readgraph (filename)
    if not filename then return {} end
    
    local graph = {}
    for line in io.lines(filename) do
        -- 줄을 이름 두 개로 분리
        local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
        -- 대응하는 노드 찾기
        local from = name2node(graph, namefrom)
        local to = name2node(graph, nameto)
        -- 'from'의 인접 노드 목록에 'to'를 추가
        from.adj[to] = true
    end
    return graph
end

-- 깊이 우선 순회를 이용한 경로 탐색
local function findpath (curr, to, path, visited)
    path = path or {}
    visited = visited or {}

    if visited[curr] then   -- 이미 방문한 노드인가?
        return nil          -- 더 이상의 경로는 없다.
    end
    visited[curr] = true    -- 노드를 '방문함(visited)'으로 표시
    path[#path + 1] = curr  -- 노드를 경로에 추가
    if curr == to then      -- 마지막 노드인가?
        return path
    end

    -- 모든 인접한 노드에 시도
    for node in pairs(curr.adj) do
        local p = findpath(node, to, path, visited)
        if p then return p end
    end
    path[#path] = nil       -- 노드를 경로에서 제거한다.
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
