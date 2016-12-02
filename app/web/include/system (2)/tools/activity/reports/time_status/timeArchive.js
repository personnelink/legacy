document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

function catcalc(cal) {
    var date = cal.date;
    var time = date.getTime()
    var field = cal.params.inputField
}

Calendar.setup({
    // onUpdate      : catcalc,
    // onSelect      : catcalc,
    inputField: "slct_we_" + trigger_images[i].substring(0, trigger_images[i].indexOf("\"")),
    button: "calBtn" + trigger_images[i].substring(0, trigger_images[i].indexOf("\"")),
    align: "B1"
});