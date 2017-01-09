Queue = {}

function Queue.new ()
    return {first = 0, last = 0}
end

function Queue.push_back (queue, value)
    queue.last = queue.last + 1
    queue[queue.last - 1] = value
end

function Queue.push_front (queue, value)
    queue.first = queue.first - 1
    queue[queue.first] = value
end

function Queue.pop_back (queue)
    if not (queue.first < queue.last) then 
        error("Queue is empty")
    end

    local value = queue[queue.last]
    queue[queue.last] = nil
    queue.last = queue.last - 1

    if queue.first == queue.last then
        queue.first = 0
        queue.last = 0
    end

    return value
end

function Queue.pop_front (queue)
    if not (queue.first < queue.last) then
        error("Queue is empty")
    end

    local value = queue[queue.first]
    queue[queue.first] = nil
    queue.first = queue.first + 1

    if queue.first == queue.last then
        queue.first = 0
        queue.last = 0
    end

    return value
end

function Queue.print_all (queue)
    if queue.first > queue.last then return end

    io.write("[", queue.first, ", ", queue.last, "] ")
    for i = queue.first, queue.last - 1 do
        io.write(queue[i], " ")
    end
    io.write("\n")
end

local q = Queue.new()
Queue.push_front(q, "Hello");   Queue.print_all(q)
Queue.push_back(q, "world");    Queue.print_all(q)
Queue.push_back(q, "A");        Queue.print_all(q)
Queue.push_back(q, "B");        Queue.print_all(q)
Queue.push_back(q, "C");        Queue.print_all(q)
Queue.pop_front(q);             Queue.print_all(q)
Queue.pop_front(q);             Queue.print_all(q)
Queue.pop_front(q);             Queue.print_all(q)
Queue.pop_back(q);              Queue.print_all(q)
Queue.pop_back(q);              Queue.print_all(q)
Queue.push_back(q, "Bye");      Queue.print_all(q)
