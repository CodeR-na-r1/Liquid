Mover = {}
Mover.__index = Mover

function Mover:create(location, size, velocity, weight)
    local mover = {}
    setmetatable(mover, Mover)

    mover.location = location
    mover.size = size or Vector:create(10, 10)

    mover.weight = weight or 1

    mover.velocity = velocity
    mover.acceleration = Vector:create(0, 0)

    mover.square = mover.size.x * mover.size.y

    return mover
end

function Mover:apply_force(force)
    self.acceleration:add(force * self.weight)
end

function Mover:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.size.x, self.size.y)
end

function Mover:update()
    self.velocity:add(self.acceleration)
    self.location:add(self.velocity)
    self.acceleration:mul(0)
end

function Mover:check_boundaries()
    if self.location.x + self.size.x > width then
        self.location.x = width - self.size.x
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < 0 then
        self.location.x = 0
        self.velocity.x = -1 * self.velocity.x
    end
    if self.location.y + self.size.y > height then
        self.location.y = height - self.size.y
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < 0 then
        self.location.y = 0
        self.velocity.y = -1 * self.velocity.y
    end
end