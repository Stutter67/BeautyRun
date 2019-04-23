-------------------------------------------------------------------------
-------------              跑酷游戏               ------------------------
-------------     CoronaSDK version 2017.3184    ------------------------
-------------        [初学CoronaSDK入门练习]      ------------------------
-------------------------------------------------------------------------

-- 初始化设置
display.setStatusBar( display.HiddenStatusBar ); -- 隐藏状态栏

-- 设置composer
local composer = require( "composer" );

-- 设置自动清除场景
composer.recycleOnSceneChange = true;

-- 初始化完后直接跳转到游戏画面
composer.gotoScene(  "game" );

