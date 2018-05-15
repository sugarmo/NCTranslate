//function removeHeader()
//{
//    var style = document.createElement("style");
//    document.getElementsByTagName("head")[0].appendChild(style);
//    var sheet = style.sheet;
//    sheet.insertRule("header" + "{display:none !important;height:0px !important;}",sheet.cssRules.length);
//}

function removeHeader()
{
    var styleTag = document.createElement("style");
    styleTag.textContent = 'header {display:none !important} .gp-footer {display:none !important}';
    document.documentElement.appendChild(styleTag);
}

removeHeader();
