let PLUGIN_INFO =
<VimperatorPlugin>
<name>{NAME}</name>
<description>Save pixiv's image into evernote</description>
<version>0.1</version>
<updateURL>http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/pixivToEvernote.js</updateURL>
<author>celeron1ghz</author>
<license>Creative Commons</license>
<detail><![CDATA[
    == Subject ==
    Post pixiv's big image into evernote. 

    These firefox plugin is required. Install these plugin before using this plugin.
      * Evernote Web Clipper
          https://addons.mozilla.org/ja/firefox/addon/8381/
      * AnkPixiv Tool
          https://addons.mozilla.org/ja/firefox/addon/7614/

    == Commands ==
    :pixivToEvernote
        Post current image into evernote. If you want to check already downloaded, use :performPixivImageSave instead.
    :performPixivImageSave
        Post current image into evernote. No operation if current page's image is already downloaded.


    == Settings ==
    I recommend you below settings on your .vimperatorrc
    And save all big images that you saw in pixiv into evernote :-)

        map ,@ :pixivToEvernote<cr>
        autocmd DOMLoad,LocationChange 'www\.pixiv\.net/member_illust\.php\?mode=medium' :performPixivImageSave<cr>

]]></detail>
</VimperatorPlugin>;

(function(){

function pixivToEvernote(){

    if( !AnkPixiv.inPixiv && !AnkPixiv.inMedium )    {
        liberator.echoerr("There is not image page!");
        return;
    }

    var document = content.document;
    var tags = document.createElement("div");

    for ( var i = 0; i <= AnkPixiv.info.illust.tags.length; i++ )   {
        var val = AnkPixiv.info.illust.tags[i];

        if ( val == "" || val == null)
            continue;

        var a = document.createElement("a");
        a.href = "http://www.pixiv.net/tags.php?tag=" + val;
        a.textContent = " [" + val + "] ";

        tags.appendChild(a);
    }

    var img = document.createElement("img");
    img.src = AnkPixiv.info.path.largeImage;

    var getSingleRet = function(xpath){
        var res = document.evaluate(
            xpath
            ,document
            ,null
            ,7  
            ,null);

        return res.snapshotItem(0);
    }; 

    //var illust_comment = AnkPixiv.info.illust.comment;
    var comment = document.createElement("div");
    var elem = getSingleRet('//div[@class="works_area"]/p');
    var illust_comment = elem == null ? '' : elem.innerHTML;

    if ( illust_comment != null )
        comment.innerHTML = illust_comment;

    img.appendChild(comment);
    img.appendChild(document.createElement("br"));
    img.appendChild(tags);

    Evernote.Overlay.init(img);
    //evernote_performClip(img);
}

function performPixivImageSave()    {
    if ( !!AnkPixiv.enabled && !AnkPixiv.isDownloaded(AnkPixiv.currentImageId) )  {
        AnkPixiv.downloadCurrentImage();
        pixivToEvernote();
    }
}

liberator.modules.commands.addUserCommand(
    ['pixivToEvernote'],
    "Post current pixiv page's big image to evernote",
    pixivToEvernote,
    {},
    true
);

liberator.modules.commands.addUserCommand(
    ['performPixivImageSave'],
    "pixivToEvernote() for auto running",
    performPixivImageSave,
    {},
    true
);

}());
