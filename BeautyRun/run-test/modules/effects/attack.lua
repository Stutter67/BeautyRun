-- 创建 攻击 函数
local M = {}
function M.new()
    local attackOptions =
    {
        width = 220,
        height = 88,
        numFrames = 4,
        sheetContentWidth = 880,
        sheetContentHeight = 88
    }
    local attackSheet = graphics.newImageSheet( "image/skill/attack.png", attackOptions );
    local attackSprite = { { start = 1, count = 4, time = 200 } };
    local Attack = display.newSprite( attackSheet, attackSprite );
    Attack.name = "attack";
    Attack.anchorX = 0.5;
    Attack.anchorY = 0.5;
    Attack.height = 52
    Attack.yScale = 0.6;
    Attack.alpha = 0;
    Attack:play();
    return Attack;
end

-- 攻击击中动画效果
function M.newHit()
    local options =
    {
        width = 195,
        height = 195,
        numFrames = 3,
        sheetContentWidth = 585,
        sheetContentHeight = 195
    };
    local hitSheet = graphics.newImageSheet( "image/skill/bossHit.png", options );
    local hitSprite = { { start = 1, count = 3, time = 1000, loopCount = 1 } };
    local hit = display.newSprite( hitSheet, hitSprite );
    hit.anchorX = 0.5;
    hit.anchorY = 1;
    hit.alpha = 0;
    hit.name = "hit"
    hit.x = screenXWidth * 0.85;
    hit.y = screenYHeight * 0.35;
    hit:play();
    return hit;
end

return M;