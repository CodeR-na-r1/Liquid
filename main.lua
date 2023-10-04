require "vector"
require "mover"
require "liquid"

function love.load()
    love.window.setTitle("Acceleration")

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    maxSquare = width * height

    love.graphics.setBackgroundColor(150 / 255, 150 / 255, 150 / 255)

    mover1 = Mover:create(Vector:create(250, height/4), Vector:create(80, 50), Vector:create(0, 0), 1)
    mover2 = Mover:create(Vector:create(450, height/4), Vector:create(150, 100), Vector:create(0, 0), 3)

    water = Liquid:create(150, height-300, width-300, 300, 0.25)
    gravity = Vector:create(0, 0.01)
end

function love.update(dt)
    mover1:apply_force(gravity)
    mover2:apply_force(gravity)

    -- friction1 = (mover1.velocity * -1):norm()
    -- if friction1 then
    --     friction:mul(0.003)
    --     mover:apply_force(friction)
    -- end

    if water:is_inside(mover1) then
        mag = mover1.velocity:mag()

        local drag = 0.5 * water.c * mag * mag * (mover1.square / maxSquare)
        local drag_vec = (mover1.velocity * -1):norm()

        drag_vec:mul(drag)

        mover1:apply_force(drag_vec)
    end
    if water:is_inside(mover2) then
        mag = mover2.velocity:mag()
        
        local drag = 0.5 * water.c * mag * mag * (mover2.square / maxSquare)
        local drag_vec = (mover2.velocity * -1):norm()

        drag_vec:mul(drag)
        
        mover2:apply_force(drag_vec)
    end

    mover1:update()
    mover1:check_boundaries()
    mover2:update()
    mover2:check_boundaries()
end

function love.draw()
    mover1:draw()
    mover2:draw()
    -- print(mover2.location)
    water:draw()
end