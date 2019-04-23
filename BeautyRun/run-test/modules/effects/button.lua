-- 创建 按钮 图标
local widget = require( "widget" );

local M = {}

-- 点击函数
local function onClick( event )
    if ( "began" == event.phase ) then
        Runtime:dispatchEvent( { name = "createAttack" , target = "attack" } );
    end
end

-- 创建按钮的函数
function M.new()
    local attackButton = widget.newButton(
        {
            width = 249,
            height = 247,
            defaultFile = "image/button/tap.png",
            overFile = "image/button/tap_over.png",
            label = "attack",
            onEvent = onClick
        }
    )
    attackButton.anchorX = 1;
    attackButton.anchorY = 1;
    attackButton.x = screenXWidth;
    attackButton.y = screenYHeight;
    attackButton:setLabel( "攻击" );
    return attackButton;
end

return M;