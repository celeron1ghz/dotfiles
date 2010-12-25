(function(){

function pixivToChecklist(){

    if( !AnkPixiv.inPixiv && !AnkPixiv.inMedium )    {
        liberator.echoerr("There is not image page!");
        return;
    }

    var document     = content.document;
    var getSingleRet = function(xpath){
        var res = document.evaluate(
            xpath
            ,document
            ,null
            ,7
            ,null);

        return res.snapshotItem(0);
    };

    var exhibitionName = getSingleRet('//p[@class="worksListOthersTitle"]//a').innerHTML;
    var circleName     = getSingleRet('//table[@class="ws_table"]//tr[3]//td[2]').innerHTML;
    var circlePlace    = getSingleRet('//table[@class="ws_table"]//tr[6]//td[2]').innerHTML;
    var circleImage    = getSingleRet('//div[@class="worksListOthersImg linkStyleWorks"]//img').src;

    exhibitionName = exhibitionName.replace('（', '');
    exhibitionName = exhibitionName.replace('）', '');
    circlePlace    = circlePlace.replace(/\s/g, '');
    circleImage    = circleImage.replace('_s.jpg', '_m.jpg');

    if ( !circlePlace.match(/\d\d/) )    {
        circlePlace = circlePlace.replace(/(\d)/, "0$1");
    }

    var img = document.createElement("img");
    img.src = circleImage;

    var newTitle = exhibitionName + '@' + circlePlace + ' ' + circleName;

    document.title = newTitle;
    Evernote.Overlay.init(img);
}

liberator.modules.commands.addUserCommand(
    ['pixivToChecklist'],
    "Post current pixiv page's big image to evernote",
    pixivToChecklist,
    {},
    true
);

liberator.modules.commands.addUserCommand(
    ['moveComiketPage'],
    "Post current pixiv page's big image to evernote",
    function(){
        var id  = AnkPixiv.info.member.id;
        var url = "http://www.pixiv.net/member_event.php?id=" + id + "&event_id=805";
        content.location.href = url;
    },
    {},
    true
);

}());
