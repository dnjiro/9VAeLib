//
//  qvaeDef.h
//  qvaeLib
//
//  Created by Danjiro Daiwa on 2017/09/03.
//  Copyright © 2017 Danjiro Daiwa All rights reserved.
//

/* Menu command to 9VAe */
typedef enum {
    //"File menu"
    qVAnNEWi20 = 691,		//"New"
    qVAnELDi20 = 615,		//"Open..."
    qVAnAPDi20 = 781,		//"Append..."
    qVAnECLi20 = 630,		//"Close"
    qVAnESVi20 = 662,		//"Save"
    qVAnESVi22 = 664,		//"Save as..."
    qVAnQUTi20 = 640,		//"Quit"
    qVAnGIFi20 = 7026,		//"Animated GIF Export...(Input Name)"
    qVAnGIFi21 = 7027,		//AnimeGIF(size,rate)
    qVAnRBXi20 = 7038,		//"Sequential Images/APNG Export..."
    qVAnASVi22s = 7019,		//Save SVG
    
    //"Edit menu"
    qVAnUNDi30 = 1473,		//"Undo"
    qVAnREDi30 = 1474,		//"Redo"
    qVAnCUTi20 = 85,		//"Cut"
    qVAnCPYi20 = 91,		//"Copy"
    qVAnPDPi30 = 1184,		//"Paste"
    qVAnDELi20 = 901,		//"Delete"
    qVAnDUPi20 = 991,		//"Duplicate"
    
    //"Select menu"
    qVAnSAAi20 = 791,		//"All = ,		//"<control>A"
    qVAnSALi20 = 794,		//"Connected to other Pages = ,		//"<alt>S"
    qVAnSECi30 = 1151,		//"Same Color and Same type = ,		//"<shift><alt>S"
    qVAnSLDi30 = 787,		//"Small Dust",   GCALLBACK(cbaction)
    qVAnKJWi40 = 1680,		//"Base Frame"
    
    qVAnNCPi20 = 861,		//"Copy to Next Page"
    qVAnPCPi20 = 862,		//"Copy to Previous Page"
    
    //"Effect menu"
    qVAnBIGi40 = 2561,		//"Balloon"
    qVAnCSHi40 = 2562,		//"Crush"
    qVAnBRKi41 = 2564,		//"Shake"
    qVAnROTi42 = 2566,		//"Spiral clockwize"
    qVAnROTi43 = 2567,		//"Spiral reverse"
    qVAnCOLi40 = 2571,		//"Color"
    qVAnCOLi42 = 2569,		//"Transparent"
    qVAnDLPi40 = 2559,		//"Decrease points"
    qVAnSPTi11 = 552,		//"Copy Atributes"
    qVAnSETi10 = 551,		//"Paste Atributes"
    
    //"Page menu"
    qVAnMPGi52 = 1214,		//"Add Final Page"
    qVAnPGEi33N = 1203,		//"Add Empty Page"
    qVAnPBKi33P = 1201,		//"Add Background Page"
    qVAnPGSi40 = 1481,		//"Select Page From"
    qVAnPGDi40 = 1483,		//"Select Page To"
    qVAnPGDi41 = 1482,		//"Reset Page Selection"
    qVAnPGCi40 = 1513,		//"Copy Selected Page"
    qVAnPGKi40 = 1514,		//"Delete Selected Page"
    qVAnSIZi20 = 992,		//"Page Size..."
    
    //"View menu"
    qVAnPLYi25 = 331,		//"Play"
    qVAnPLYi26 = 325,		//"Play in Window Size"
    qVAnSTPi21 = 334,		//"Stop"
    qVAnRPTi20 = 833,		//"Repeat"
    qVAnKUPi41 = 1665,		//"Zoom In"
    qVAnBDNi30 = 1462,		//"Zoom Out"
    qVAnBALi30 = 1454,		//"Zoom to fit page"
    qVAnBMDi20 = 855,		//"Show Background"
    qVAnSDOi20 = 895,		//"Show Onion Skin"
    qVAnGRDi66 = 2380,		//"Show Grid"
    qVAnAALi20 = 851,		//"Smoothing Line"
    
    //"Object menu"
    qVAnTCHi20 = 792,		//"Change text..."
    
    //"Text Align"
    qVAnARGi31 = 145,		//"Left"
    qVAnARGi30 = 144,		//"Center"
    qVAnARGi32 = 151,		//"Right"
    qVAnTXSi20 = 2505,		//"Edit All Texts..."
    
    //"Align Objects"
    qVAnONPi30 = 2295,		//"Points on 1 point"
    qVAnGRSi20 = 882,		//"Points on Grid"
    qVAnARLi22 = 2530,		//"Align Left Edges"
    qVAnARRi22 = 2531,		//"Align Right Edges"
    qVAnARTi22 = 2532,		//"Align Top Edges"
    qVAnARBi22 = 2533,		//"Align Bottom Edges"
    qVAnARMi22 = 2534,		//"Align Vertical axis"
    qVAnARHi22 = 2535,		//"Align Horizontal axis"
    qVAnARCi22 = 2542,		//"Align Center point"
    qVAnAMMi22 = 2540,		//"Same Horizontal gaps"
    qVAnAMHi22 = 2541,		//"Same Vertical gaps"
    
    //"Stacking Order"
    qVAnOUPi30 = 1515,		//"Raise"
    qVAnODWi30 = 1521,		//"Lower"
    qVAnOUPi31 = 1522,		//"Raise to Top"
    qVAnODWi31 = 1523,		//"Lower to Bottom"
    
    //"Stroke Style"
    qVAnCLOi30 = 64,		//"Closed Stroke"
    qVAnCLOi31 = 63,		//"Open Stroke"
    
    //"Corner"
    qVAnCRVi30 = 54,		//"Round"
    qVAnCRVi31 = 53,		//"Sharp"
    
    qVAnGRPi30 = 1445,		//"Group"
    qVAnUNGi30 = 1451,		//"Ungroup"
    qVAnVEDi30 = 1344,		//"Visible"
    qVAnVEDi31 = 1345,		//"Invisivle"
    qVAnLENi20 = 1581,		//"Stroke Order"
    qVAnGSTi20 = 941,		//"In-Between Shape"
    qVAnWIDi30 = 1555,		//"Narrow"
    qVAnWIDi31 = 1554,		//"Wide"
    
    //"Input menu"
    qVAnTXIi20 = 723,		//"Text..."
    qVAnXLDi20 = 770,		//"Sound/Music..."
    qVAnBMPi20 = 761,		//"Image/Photo..."
    qVAnURLi40 = 2525   ,	//"SVG from URL "URLからSVG入力
    qVAnURMi40 = 2526   ,	//URL入力 Music
    qVAnURSi40 = 2527   ,	//URL入力 Sound
    qVAnURXi40 = 2528   ,	//URL入力 Music or Sound
    qVAnAMWi30 = 2522,		//"9VA Anime..."
    qVAnPASi20 = 555,		//"Pause Button"
    qVAnTRNi20 = 583,		//"Turn"
    qVAnLOPi20 = 581,		//"Loop"
    qVAnVIWi20 = 603,		//"Zoom Frame"
    qVAnVIRi20 = 604,		//"No Zoom"
    qVAnAMXi40 = 1673,		//"Optimize AnimeCasts..."
    
    //  "Help menu"
    //"Play with face (Training)"
    qVAnHLSi41 = 2794,		//waraemon Sample1 (Waraemon)
    qVAnHLSi42 = 2794+1,	//waraemon Sample2(Nakinosuke)
    qVAnHLSi43 = 2794+2,	//waraemon Sample3(Animekko)
    qVAnHLSi44 = 2794+3,	//waraemon Sample4(Waraemon Parts)
    qVAnHLSi45 = 2794+4,	//waraemon Sample5(Munch)
    qVAnHLSi46 = 2794+5,	//waraemon Sample6(Transform)

    qVAnLNGi21 = 702,		//"--> Japanese",
    qVAnLNGi23 = 704,		//"--> English",	  
} QVACommand;

/* 9VAe's message to get data from OS */
typedef enum {
    qVAcSTRinp  =  1,		// Input Text(1 line)
    qVAcTXTinp  =  2 ,      // Input Text(Multiple lines)
    qVAc2STRinp = 11  ,     // Input 2 texts
    qVAcFLDinp =  16 ,      // Open File
    qVAcFSVinp =  17 ,      // Save File
    qVAcILDinp =  18 ,      // Input Image file from Album
    qVAcSLDinp =  19,		// Input Sound file from URL
    qVAcMLDinp =  20 ,      // Input Music file from URL
    
    qVAcWPTinp =  29 ,      // Input Time
    qVAcDEGinp =  65,		// Input Angle
    qVAcANNinp =  70,		// Input AnimeCast's name (Duplicate and Edit)
    //qVAcGIFinp =  72,		// Export Animated GIF1 (File name)
    qVAcGF2inp =  73,		// Export Animated GIF2 (Size, rate...)
    //qVAcRBXinp =  76 ,      // Export Sequential image1(png apng)
    //qVAcRB2inp =  77 ,      // Export Sequential image2(png apng)
    qVAcFONinp =  78 ,      // Input Font name
    qVAcPMSCinp =  80 ,     // Play Music
    qVAcPSNDinp =  81 ,     // Play Sound
    qVAcFOSinp =  82 ,      // Input Font List
    qVAcURLinp =  83 ,      // Input SVG from URL
    qVAcSSVinp =  84 ,      // Save SVG
    
    qVAcYSNOinp = 240,      //Yes No Alert（ios）
    qVAcYSOKinp = 241,      //OK Can Alert（ios）
    qVAcYSNCinp = 242,      //YesNoCan Alert（ios）
    qVAcALRTinp = 252,      //YesOnly Alert（ios）
} QVAioType;

/* Ask or setup 9VAe */
typedef enum {
    qVAnLANGask	= 6,        //Language（0=Kanji 1=Hiragana 2=English））
    qVAnKANJset	= 33,       //Set Language to Kanji(Japanese)
    qVAnHIRAset	= 34,       //Set Language to Hiragana(Japanese)
    qVAnENGLISHset = 35,	//Set Language to English
    qVAnMENUOUTset = 36,	//Put half of the menu outside.(for iphone)
    qVAnMENUINset = 37,     //Normal menu (for ipad)
} QVAaskType;

/* Play command */
typedef enum {
    qVAavPLAY       = 'P',      // Play
    qVAavPLAYloop	= 'R',   // Loop play
    qVAavPLAYfrom	= 'F',   // Play from the middle
    qVAavPLAYfromLoop = 'G',   // Loop Play from the middle
    qVAavSTOP       = 'S',   // Stop（Reset）
    qVAavPAUSE      = 'a',   // Pause
    qVAavRESUME     = 'r',   // Resume
} QVAplayMode;



/* Menu string */
#define QVAmnFile @"New",@"Open",@"Close",@"Save",@"Save as",@"Animation GIF Export",@"Page Size",@"Cancel",nil
#define QVAmnFileJp    @"新規作成",@"開く",@"閉じる",@"上書き保存",@"名前を付けて保存",@"アニメGIF出力",@"ページ設定",@"キャンセル",nil
#define QVAcmdFile qVAnNEWi20,qVAnELDi20,qVAnECLi20,qVAnESVi20,qVAnASVi22s,qVAnGIFi21,qVAnSIZi20,0,0

#define QVAmnEdit @"Undo",@"Redo",@"Cut",@"Copy",@"Paste",@"Delete",@"Duprecate",@"Select All",@"Decrese Points",@"Copy Attributes",@"Paste Attributes",@"Cancel",nil
#define QVAmnEditJp @"元にもどす",@"やり直す",@"切り取り",@"コピー",@"貼り付け",@"消去",@"複製",@"すべて選択",@"点を減らす",@"色・種類を記憶",@"記憶した色・種類に設定",@"キャンセル",nil
#define QVAcmdEdit qVAnUNDi30,qVAnREDi30,qVAnCUTi20,qVAnCPYi20,qVAnPDPi30,qVAnDELi20,qVAnDUPi20,qVAnSAAi20,qVAnDLPi40,qVAnSPTi11,qVAnSETi10,0,0


#define QVAmnView   @"Play",@"Play in Window Size",@"Stop",@"Show Background",@"Show Onion Skin",@"Show Grid",@"Cancel",nil
#define QVAmnViewJp @"再生",@"大きいサイズで再生",@"停止",@"背景を重ねて表示",@"前後のページを重ねて表示",@"グリッドを表示する",@"キャンセル",nil
#define QVAcmdView  qVAnPLYi25,qVAnPLYi26,qVAnSTPi21,qVAnBMDi20,qVAnSDOi20,qVAnGRDi66,0,0

#define QVAmnAlign  @"Points on 1 point",@"Points on Grid",@"Left Edges",@"Right Edges",@"Top Edges",@"Bottom Edges",@"Vertical axis",@"Horizontal axis",@"Center point",@"Same Horizontal gaps",@"Same Vertical gaps",@"Cancel",nil
#define QVAmnAlignJp    @"１点に集める",@"点をグリッド上に配置",@"左に寄せる",@"右に寄せる",@"上に寄せる",@"下に寄せる",@"縦軸を合わせる",@"横軸を合わせる",@"中心を合わせる",@"左右のすきまを均等に",@"上下のすきまを均等に",@"キャンセル",nil
#define QVAcmdAlign qVAnONPi30,qVAnGRSi20,qVAnARLi22,qVAnARRi22,qVAnARTi22,qVAnARBi22,qVAnARMi22,qVAnARHi22,qVAnARCi22,qVAnAMMi22,qVAnAMHi22,0,0

#define QVAmnObject @"Raise to Top",@"Lower to Bottom",@"Group",@"Ungroup",@"Stroke Order",@"Visible",@"InVisible",@"In-Between Shape",@"Cancel",nil
#define QVAmnObjectJp   @"最も上に",@"最も下に",@"グループ化",@"グループ解除",@"書き順",@"次ページまで表示",@"このページで消える",@"あいだの形にする",@"キャンセル",nil
#define QVAcmdObject    qVAnOUPi31,qVAnODWi31,qVAnGRPi30,qVAnUNGi30,qVAnLENi20,qVAnVEDi30,qVAnVEDi31,qVAnGSTi20,0,0


#define QVAmnInput  @"Text...",@"Image/Photo...",@"9VA Anime...",@"SVG Download...",@"Sound/Music Download...",@"Pause Button",@"Turn",@"Loop",@"Optimize AnimeCasts",@"Cancel",nil
#define QVAmnInputJp    @"文字を入れる...",@"絵・写真を入れる...",@"9VAアニメを入れる...",@"SVGをダウンロード...",@"音・音楽をダウンロード...",@"クリックで進むボタン",@"往復",@"繰り返し",@"アニメキャストの整理",@"キャンセル",nil
#define QVAcmdInput qVAnTXIi20,qVAnBMPi20,qVAnAMWi30,qVAnURLi40,qVAnURXi40,qVAnPASi20,qVAnTRNi20,qVAnLOPi20,qVAnAMXi40,0,0



#define QVAmnHelp   @"Waraemon",@"Animekko",@"Waraemon Parts",@"Munch",@"Transform",@"日本語",@"Cancel",nil
#define QVAmnHelpJp @"わらえもん",@"アニメっこ",@"わらえもんパーツ",@"さけび",@"変身",@"English",@"キャンセル",nil
#define QVAcmdHelp  qVAnHLSi41,qVAnHLSi43,qVAnHLSi44,qVAnHLSi45,qVAnHLSi46,qVAnLNGi23,0,0








