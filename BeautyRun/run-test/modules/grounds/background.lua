local M = {}

-- 创建背景容器
local backGroup = display.newGroup();
-- 远端背景图
local background = display.newImageRect( backGroup, "image/background/sun.jpg", screenXWidth, screenYHeight );
background.x = screenXCenter;
background.y = screenYCenter - 20;
-- 中层云雾图
local medBackground1 = display.newImageRect( backGroup, "image/scroll/doubleStone.png", screenXWidth, screenYHeight );
medBackground1.x = screenXCenter;
medBackground1.y = screenYCenter;
local medBackground2 = display.newImageRect( backGroup, "image/scroll/singleStone.png", screenXWidth, screenYHeight );
medBackground2.x = medBackground1.x + medBackground1.contentWidth;
medBackground2.y = screenYCenter;
local medBackground3 = display.newImageRect( backGroup, "image/scroll/doubleStone.png", screenXWidth * 1.1, screenYHeight );
medBackground3.x = medBackground2.x + medBackground2.contentWidth - 10;
medBackground3.y = screenYCenter;
backGroup:toBack();

-- 移动中层背景
function M.updateMedBackground( levelSpeed )
    medBackground1:translate( -levelSpeed , 0 );
    medBackground2:translate( -levelSpeed, 0 );
    medBackground3:translate( -levelSpeed, 0 );
    if ( -screenXWidth > medBackground1.x ) then
        medBackground1.x = screenXWidth * 2  ;
    end
    if ( -screenXWidth > medBackground2.x ) then
        medBackground2.x = screenXWidth * 2;
    end
    if ( -screenXWidth > medBackground3.x ) then
        medBackground3.x = screenXWidth * 2;
    end
end

return M;