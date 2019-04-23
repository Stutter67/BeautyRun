local M = {};
-- 将以下图片的锚点设置为左上角而不是图片的中心(因为hub栏始终在左上角)
display.setDefault( "anchorX", 0 );
display.setDefault( "anchorY", 0 );
display.setDefault( "fillColor" , 1, 222/255, 180/255 );

-- 角色信息栏
-- 设置角色栏容器(方便将以下图标做为整体进行调整)
local hudBarGroup = display.newGroup();

-- 头像框
local headBackground = display.newImageRect( hudBarGroup, "image/other/headBg.png", screenXWidth * 0.12, screenYHeight * 0.16 );
-- 血量槽
local bloodBarBox = display.newImageRect( hudBarGroup, "image/other/barBox.png", screenXWidth * 0.3, screenYHeight * 0.05 );
bloodBarBox.x = headBackground.x + headBackground.contentWidth;
-- 法力槽
local magicBarBox = display.newImageRect( hudBarGroup, "image/other/barBox.png", screenXWidth * 0.3, screenYHeight * 0.05 );
magicBarBox.x = bloodBarBox.x;
magicBarBox.y = bloodBarBox.y + bloodBarBox.contentHeight;
-- 金币图标
local goldIcon = display.newImageRect(hudBarGroup, "image/prop/gold.png", screenXWidth * 0.042, screenYHeight * 0.055 );
goldIcon.x = magicBarBox.x + screenXWidth * 0.01;
goldIcon.y = magicBarBox.y + magicBarBox.contentHeight + screenXWidth * 0.005;
-- 距离图标
local distanceIcon = display.newImageRect(hudBarGroup, "image/other/distance.png", screenXWidth * 0.042, screenYHeight * 0.055 );
distanceIcon.x = goldIcon.x + screenXWidth * 0.16;
distanceIcon.y = goldIcon.y;
-- 头像
local roleHead = display.newImageRect( hudBarGroup, "image/role/roleHead.png" , screenXWidth * 0.10 , screenYHeight *0.14  );
roleHead.x = headBackground.x + screenXWidth * 0.01;
roleHead.y = headBackground.y + screenYHeight * 0.005;

-- 将hub栏始终置顶
hudBarGroup:toFront();
-- 恢复默认锚点设置
display.setDefault( "anchorX", 0.5 );
display.setDefault( "anchorY", 0.5 );

-- 血量条
function M.showBloodStrip()
    local bloodStrip = display.newImageRect(hudBarGroup, "image/other/bloodBar.png", screenXWidth * 0.28, screenYHeight * 0.033);
    bloodStrip.anchorX = 0;
    bloodStrip.anchorY = 0;
    bloodStrip.x = bloodBarBox.x + screenXWidth * 0.009;
    bloodStrip.y = bloodBarBox.y + screenYHeight * 0.009;
    return bloodStrip;
end

-- 法力条
function M.showMagicStrip()
    local magicStrip = display.newImageRect(hudBarGroup ,"image/other/magicBar.png",screenXWidth * 0.278, screenYHeight * 0.033) ;
    magicStrip.anchorX = 0;
    magicStrip.anchorY = 0;
    magicStrip.x = magicBarBox.x + screenXWidth * 0.009;
    magicStrip.y = magicBarBox.y + screenYHeight * 0.009;
    return magicStrip;
end

-- 血量文本
function M.showBloodText()
    local bloodText = display.newText( hudBarGroup, 500 ,0, 0, "Arial", 20 );
    bloodText.anchorX = 0.5;
    bloodText.anchorY = 0.5;
    bloodText.x = bloodBarBox.x + bloodBarBox.contentWidth * 0.5;
    bloodText.y = bloodBarBox.y + bloodBarBox.contentHeight * 0.5;
    return bloodText;
end

-- 法力文本
function M.showMagicText()
    local magicText = display.newText( hudBarGroup, 100 ,0, 0, "Arial", 20 );
    magicText.anchorX = 0.5;
    magicText.anchorY = 0.5;
    magicText.x = magicBarBox.x + magicBarBox.contentWidth * 0.5;
    magicText.y = magicBarBox.y + magicBarBox.contentHeight * 0.5;
    return magicText;
end

-- 距离文本
function M.showDistanceText()
    local distanceText = display.newText( hudBarGroup, 0 ,0, 0, "Arial", 24 );
    distanceText.anchorX = 0;
    distanceText.anchorY = 0;
    distanceText.x = distanceIcon.x + screenXWidth * 0.06;
    distanceText.y = distanceIcon.y + screenYHeight * 0.01;
    return distanceText;
end

-- 金币文本
function M.showGoldText()
    local goldText = display.newText( hudBarGroup, 0, 0, 0, "Arial", 24 );
    goldText.anchorX = 0;
    goldText.anchorY = 0;
    goldText.x = goldIcon.x + screenXWidth * 0.06;
    goldText.y = goldIcon.y + screenYHeight * 0.01;
    return goldText;
end

-- 创建伤害提示
function M.createText( hurtText , x , y )
    local options =
    {
        text = hurtText,
        x = x + 60,
        y = y,
        width = 120,
        font = native.systemFont,
        fontSize = 20;
    }
    local hurt = display.newText( options );
    hurt:setFillColor( 1, 0, 0 )
    transition.to( hurt , { x = x + 60 , y = y - 150, time = 1500, alpha = 0, onComplete = function()
        transition.cancel( hurt );
        display.remove( hurt );
    end } );
    return hurt;
end

return M;