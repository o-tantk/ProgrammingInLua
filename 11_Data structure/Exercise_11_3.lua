Graph = {}

function Graph.name2node (graph, name)
    local node = graph[name]
    if not node then
        -- 노드가 없다면 새로 하나 만든다.
        node = {name = name, edges = {}}
        graph[name] = node
    end
    return node
end

function Graph.bridge (label, node1, node2)
    node1.edges[#node1.edges + 1] = {["label"] = label, ["destination"] = node2}
end

function Graph.read (filename)
    if not filename then return {} end
    
    local graph = {}
    for line in io.lines(filename) do
        -- 줄을 이름 두 개로 분리
        local namefrom, label, nameto = string.match(line, "(%S+)%-(%d+)%-(%S+)")
        -- 대응하는 노드 찾기
        local from = Graph.name2node(graph, namefrom)
        local to = Graph.name2node(graph, nameto)
       
        Graph.bridge(label, from, to)
    end
    return graph
end

-- 깊이 우선 순회를 이용한 경로 탐색
function Graph.findpath (curr, to, path, visited)
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
    for _, edge in pairs(curr.edges) do
        local p = Graph.findpath(edge.destination, to, path, visited)
        if p then return p end
    end
    path[#path] = nil       -- 노드를 경로에서 제거한다.
end

function Graph.printpath (path)
    if not path then return end

    for i = 1, #path do
        print(path[i].name)
    end
end

local g = Graph.read("11_Data structure\\graph.txt")
--local a = Graph.name2node(g, "a")
--local b = Graph.name2node(g, "b")
--Graph.bridge(1, a, b)

local a = g["a"]
local b = g["b"]

local p = Graph.findpath(a, b)
Graph.printpath(p)